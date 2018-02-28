// MIT License
//
// Copyright (c) 2017 qazyn951230 qazyn951230@gmail.com
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

public typealias ViewComponent = Component<UIView>

open class Component<View: UIView>: BasicComponent {
    public internal(set) var view: View?
    public internal(set) var creator: (() -> View)?

    override var frame: CGRect {
        didSet {
            if mainThread(), let view = self.view {
                view.frame = frame
            } else {
                pendingState.frame = frame
            }
        }
    }

    public init(children: [BasicComponent] = []) {
        super.init(framed: true, children: children)
    }

    public init(children: [BasicComponent], creator: @escaping () -> View) {
        self.creator = creator
        super.init(framed: true, children: children)
    }

    deinit {
        creator = nil
        if let view = self.view {
            if mainThread() {
                view.removeFromSuperview()
            } else {
                DispatchQueue.main.async {
                    view.removeFromSuperview()
                }
            }
        }
    }

    @discardableResult
    open func buildView(in view: UIView?) -> View {
        assertMainThread()
        let this = _buildView()
        view?.addSubview(this)
        children.forEach {
            $0.build(in: this)
        }
        return this
    }

    public override func build(in view: UIView) {
        assertMainThread()
        let this = _buildView()
        if let superview = this.superview {
            if superview != view {
                this.removeFromSuperview()
                view.addSubview(this)
            }
        } else {
            view.addSubview(this)
        }
        children.forEach {
            $0.build(in: this)
        }
    }

    func _createView() -> View {
        assertMainThread()
        if let view = self.view {
            return view
        }
        let this = creator?() ?? View.init(frame: .zero)
//        if let container = this as? ComponentContainer {
//            container.component = self
//        } else {
//            this._component = self
//        }
        self.view = this
        return this
    }

    func _buildView() -> View {
        let this = _createView()
        _pendingState?.apply(view: this)
        return this
    }

    override func buildView() -> UIView {
        return _buildView()
    }

#if DEBUG
    public override func debugMode() {
        backgroundColor(UIColor.random)
        super.debugMode()
    }
#endif

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
}
