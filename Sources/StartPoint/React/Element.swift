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

#if os(iOS)
import UIKit
import QuartzCore

public typealias ViewElement = Element<ElementView>

open class Element<View: UIView>: BasicElement {
    public internal(set) var view: View?
    public internal(set) var creator: (() -> View)?

    public init(children: [BasicElement] = []) {
        super.init(framed: true, children: children)
    }

    public convenience init(children: [BasicElement], creator: @escaping () -> View) {
        self.init(children: children)
        self.creator = creator
    }

    public override var loaded: Bool {
        return view != nil
    }

//    override var _frame: Rect {
//        didSet {
//            if Runner.isMain(), let view = self.view {
//                view.frame = _frame.cgRect
//            } else {
//                pendingState.frame = _frame.cgRect
//                registerPendingState()
//            }
//        }
//    }

    public override var interactive: Bool {
        didSet {
            self.interactive(interactive)
        }
    }

    public override var alpha: Double {
        didSet {
            self.alpha(alpha)
        }
    }

    deinit {
        creator = nil
    }

    // MARK: - Managing the elements hierarchy
    override func removeFromOwner() {
        assertThreadAffinity(for: self)
        super.removeFromOwner()
        view?.removeFromSuperview()
    }

    // MARK: - Create a View Object
    public override func build(in view: UIView) {
        assertMainThread()
        // 1. build itself and children, then call loaded callback
        let this = buildView()
        // 2. check superview
        // FIXME: Do we need this check?
        if let superview = this.superview {
            if superview != view {
                this.removeFromSuperview()
                view.addSubview(this)
            }
        } else {
            view.addSubview(this)
        }
    }

    final override func _buildView() -> UIView {
        return buildView()
    }

    public func buildView() -> View {
        assertMainThread()
        let _view = createView()
        self.view = _view
        self._view = _view
        _layer = _view.layer
        layered = false
        if let container = _view as? ElementContainer {
            container.element = self
        } else {
            _view._element = self
        }
        applyState(to: _view)
        buildChildren(in: _view)
        onLoaded()
        return _view
    }

    // Only do view create
    func createView() -> View {
        if let oldView = self.view {
            return oldView
        }
        let _view: View = creator?() ?? View.init(frame: .zero)
        creator = nil
        return _view
    }

    // MARK: - Manage pending state
    override func applyState() {
        assertMainThread()
        if let view = self.view {
            applyState(to: view)
        }
    }

    func applyState(to view: View) {
        _pendingState?.apply(view: view)
    }

    public override func registerPendingState() {
        if view == nil {
            return
        }
        super.registerPendingState()
    }

    // MARK: - Debugging Flex Layout
#if DEBUG
    public override func debugMode() {
        backgroundColor(UIColor.random)
        super.debugMode()
    }
#endif

    override func accept(visitor: ElementVisitor) {
        visitor.visit(view: self)
    }

    @discardableResult
    public func backgroundColor(_ value: UIColor?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.backgroundColor = value
        } else {
            pendingState.backgroundColor = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func backgroundColor(hex value: UInt32) -> Self {
        let value = UIColor.hex(value)
        if Runner.isMain(), let view = self.view {
            view.backgroundColor = value
        } else {
            pendingState.backgroundColor = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func backgroundColor(hex value: UInt32, alpha: CGFloat) -> Self {
        let value = UIColor.hex(value, alpha: alpha)
        if Runner.isMain(), let view = self.view {
            view.backgroundColor = value
        } else {
            pendingState.backgroundColor = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func tintColor(_ value: UIColor) -> Self {
        if Runner.isMain(), let view = self.view {
            view.tintColor = value
        } else {
            pendingState.tintColor = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func tintColor(hex: UInt32) -> Self {
        let value = UIColor.hex(hex)
        if Runner.isMain(), let view = self.view {
            view.tintColor = value
        } else {
            pendingState.tintColor = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func cornerRadius(_ value: CGFloat) -> Self {
        if Runner.isMain(), let view = self.view {
            view.layer.cornerRadius = value
        } else {
            pendingState.cornerRadius = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func borderColor(cgColor value: CGColor?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.layer.borderColor = value
        } else {
            pendingState.borderColor = value
            registerPendingState()
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
        if Runner.isMain(), let view = self.view {
            view.layer.borderWidth = value
        } else {
            pendingState.borderWidth = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func border(color: UIColor?, width: CGFloat) -> Self {
        if Runner.isMain(), let view = self.view {
            let layer = view.layer
            layer.borderColor = color?.cgColor
            layer.borderWidth = width
        } else {
            let state = pendingState
            state.borderColor = color?.cgColor
            state.borderWidth = width
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func border(hex value: UInt32, width: CGFloat) -> Self {
        let color = UIColor.hex(value).cgColor
        if Runner.isMain(), let view = self.view {
            let layer = view.layer
            layer.borderColor = color
            layer.borderWidth = width
        } else {
            let state = pendingState
            state.borderColor = color
            state.borderWidth = width
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func shadow(opacity: Float, radius: CGFloat, offset: CGSize, color: CGColor?) -> Self {
        if Runner.isMain(), let view = self.view {
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
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func shadow(alpha: Float, blur: CGFloat, x: CGFloat, y: CGFloat, color: UIColor) -> Self {
        if Runner.isMain(), let view = self.view {
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
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func shadow(alpha: Float, blur: CGFloat, x: CGFloat, y: CGFloat, hex: UInt32) -> Self {
        if Runner.isMain(), let view = self.view {
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
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func shadowPath(_ value: CGPath?) -> Self {
        if Runner.isMain(), let view = self.view {
            let layer = view.layer
            layer.shadowPath = value
        } else {
            let state = pendingState
            state.shadowPath = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func shadowPath(_ method: @escaping (Element<View>) -> UIBezierPath) -> Self {
        self.viewLoaded { (e: Element<View>) in
            let path = method(e)
            e.shadowPath(path.cgPath)
        }
        return self
    }

    @discardableResult
    public func interactive(_ value: Bool) -> Self {
        if Runner.isMain(), let view = self.view {
            view.isUserInteractionEnabled = value
        } else {
            pendingState.interactive = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func alpha(_ value: Double) -> Self {
        if Runner.isMain(), let view = self.view {
            view.alpha = CGFloat(value)
        } else {
            pendingState.alpha = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func contentMode(_ value: UIView.ContentMode) -> Self {
        if Runner.isMain(), let view = self.view {
            view.contentMode = value
        } else {
            pendingState.contentMode = value
            registerPendingState()
        }
        return self
    }
}
#endif // #if os(iOS)
