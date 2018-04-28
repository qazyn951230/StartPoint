// MIT License
//
// Copyright (c) 2017-present qazyn951230 qazyn951230@gmail.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import QuartzCore

public typealias ViewComponent = Component<ComponentView>

open class Component<View: UIView>: BasicComponent {
    public internal(set) var view: View?
    public internal(set) var creator: (() -> View)?

    var _loaded: [(Component<View>, View) -> Void]?
    var tapChildren: [BasicComponent]?

    public init(children: [BasicComponent] = []) {
        super.init(framed: true, children: children)
    }

    // TODO: convenience init?
    public init(children: [BasicComponent], creator: @escaping () -> View) {
        super.init(framed: true, children: children)
        self.creator = creator
    }

    open override var overrideTouches: Bool {
        return super.overrideTouches || tapChildren != nil
    }

    override var _frame: Rect {
        didSet {
            if mainThread(), let view = self.view {
                view.frame = _frame.cgRect
            } else {
                pendingState.frame = _frame.cgRect
            }
        }
    }

    deinit {
        creator = nil
        if let view = self.view {
            runOnMain {
                view.removeFromSuperview()
            }
        }
    }

    public func loaded(then method: @escaping (Component<View>, View) -> Void) {
        if mainThread(), let view = self.view {
            method(self, view)
        } else {
            _loaded = _loaded ?? []
            _loaded?.append(method)
        }
    }

    open override func build(in view: UIView) {
        assertMainThread()
        let this = buildView()
        if let superview = this.superview {
            if superview != view {
                this.removeFromSuperview()
                view.addSubview(this)
            }
        } else {
            view.addSubview(this)
        }
    }

    open func buildView() -> View {
        assertMainThread()
        if let v = self.view {
            return v
        }
        let this = _createView()
        applyState(to: this)
        buildChildren(in: this)
        if let methods = _loaded {
            methods.forEach {
                $0(self, this)
            }
        }
        _loaded = nil
        return this
    }

    func _createView() -> View {
        assertMainThread()
        if let view = self.view {
            return view
        }
        let this = creator?() ?? View.init(frame: .zero)
        creator = nil
        if let container = this as? ComponentContainer {
            container.component = self
        } else {
            this._component = self
        }
        self.view = this
        return this
    }

    open func applyState(to view: View) {
        assertMainThread()
        _pendingState?.apply(view: view)
    }

    open func buildChildren(in view: UIView) {
        if children.isEmpty {
            return
        }
        children.forEach {
            $0.build(in: view)
        }
    }

#if DEBUG
    public override func debugMode() {
        backgroundColor(UIColor.random)
        super.debugMode()
    }
#endif

    func registerTap(for child: BasicComponent) {
        tapChildren = tapChildren ?? []
        tapChildren?.append(child)
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        assertMainThread()
        if let taps = tapChildren, let touch = touches.first {
            // FIXME: children touch event
            let point = touch.location(in: view)
            let component = taps.first { component in
                return component.frame.contains(point)
            }
            if let this = component, let tap = this._tap {
                DispatchQueue.main.async {
                    tap(this)
                }
                return
            }
        }
        super.touchesEnded(touches, with: event)
    }

    @discardableResult
    public func backgroundColor(_ value: UIColor?) -> Self {
        if mainThread(), let view = view {
            view.backgroundColor = value
        } else {
            pendingState.backgroundColor = value
        }
        return self
    }

    @discardableResult
    public func backgroundColor(hex: UInt32) -> Self {
        let value = UIColor.hex(hex)
        if mainThread(), let view = view {
            view.backgroundColor = value
        } else {
            pendingState.backgroundColor = value
        }
        return self
    }

    @discardableResult
    public func tintColor(_ value: UIColor) -> Self {
        if mainThread(), let view = view {
            view.tintColor = value
        } else {
            pendingState.tintColor = value
        }
        return self
    }

    @discardableResult
    public func tintColor(hex: UInt32) -> Self {
        let value = UIColor.hex(hex)
        if mainThread(), let view = view {
            view.tintColor = value
        } else {
            pendingState.tintColor = value
        }
        return self
    }

    @discardableResult
    public func cornerRadius(_ value: CGFloat) -> Self {
        if mainThread(), let view = view {
            view.layer.cornerRadius = value
        } else {
            pendingState.cornerRadius = value
        }
        return self
    }

    @discardableResult
    public func borderColor(cgColor value: CGColor?) -> Self {
        if mainThread(), let view = view {
            view.layer.borderColor = value
        } else {
            pendingState.borderColor = value
        }
        return self
    }

    @discardableResult
    public func borderColor(_ value: UIColor?) -> Self {
        return borderColor(cgColor: value?.cgColor)
    }

    @discardableResult
    public func borderColor(hex value: UInt32) -> Self {
        return borderColor(cgColor: UIColor.hex(value).cgColor)
    }

    @discardableResult
    public func borderWidth(_ value: CGFloat) -> Self {
        if mainThread(), let view = view {
            view.layer.borderWidth = value
        } else {
            pendingState.borderWidth = value
        }
        return self
    }

    @discardableResult
    public func border(color: UIColor?, width: CGFloat) -> Self {
        if mainThread(), let view = view {
            let layer = view.layer
            layer.borderColor = color?.cgColor
            layer.borderWidth = width
        } else {
            let state = pendingState
            state.borderColor = color?.cgColor
            state.borderWidth = width
        }
        return self
    }

    @discardableResult
    public func border(hex value: UInt32, width: CGFloat) -> Self {
        let color = UIColor.hex(value).cgColor
        if mainThread(), let view = view {
            let layer = view.layer
            layer.borderColor = color
            layer.borderWidth = width
        } else {
            let state = pendingState
            state.borderColor = color
            state.borderWidth = width
        }
        return self
    }

    @discardableResult
    public func shadow(opacity: Float, radius: CGFloat, offset: CGSize, color: CGColor?) -> Self {
        if mainThread(), let view = view {
            let layer = view.layer
            layer.shadowOpacity = opacity
            layer.shadowRadius = radius
            layer.shadowOffset = offset
            layer.shadowColor = color
        } else {
            let state = pendingState
            state.shadowOpacity = opacity
            state.shadowRadius = radius
            state.shadowOffset = offset
            state.shadowColor = color
        }
        return self
    }

    @discardableResult
    public func shadow(alpha: Float, blur: CGFloat, x: CGFloat, y: CGFloat, color: UIColor) -> Self {
        if mainThread(), let view = view {
            let layer = view.layer
            layer.shadowOpacity = alpha
            layer.shadowRadius = blur
            layer.shadowOffset = CGSize(width: x, height: y)
            layer.shadowColor = color.cgColor
        } else {
            let state = pendingState
            state.shadowOpacity = alpha
            state.shadowRadius = blur
            state.shadowOffset = CGSize(width: x, height: y)
            state.shadowColor = color.cgColor
        }
        return self
    }

    @discardableResult
    public func shadow(alpha: Float, blur: CGFloat, x: CGFloat, y: CGFloat, hex: UInt32) -> Self {
        if mainThread(), let view = view {
            let layer = view.layer
            layer.shadowOpacity = alpha
            layer.shadowRadius = blur
            layer.shadowOffset = CGSize(width: x, height: y)
            layer.shadowColor = UIColor.hex(hex).cgColor
        } else {
            let state = pendingState
            state.shadowOpacity = alpha
            state.shadowRadius = blur
            state.shadowOffset = CGSize(width: x, height: y)
            state.shadowColor = UIColor.hex(hex).cgColor
        }
        return self
    }

    @discardableResult
    public func shadowPath(_ value: CGPath?) -> Self {
        if mainThread(), let view = view {
            let layer = view.layer
            layer.shadowPath = value
        } else {
            let state = pendingState
            state.shadowPath = value
        }
        return self
    }
}
