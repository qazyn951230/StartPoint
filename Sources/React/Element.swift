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

    override var _view: UIView? {
        return view
    }

    var layer: CALayer? {
        return view?.layer
    }

    var layersCount: Int {
        return view?.layer.sublayers?.count ?? 0
    }

    override var _frame: Rect {
        didSet {
            if Runner.isMain(), let view = self.view {
                view.frame = _frame.cgRect
            } else {
                pendingState.frame = _frame.cgRect
                registerPendingState()
            }
        }
    }

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
        if let view = self.view {
            Runner.onMain {
                view.removeFromSuperview()
            }
        }
    }

    public override func addChild(_ element: BasicElement) {
        assertThreadAffinity(for: self)
        if let old = element.owner, old == self {
            return
        }
        let index = children.count
        let layerIndex = layersCount
        insertChild(element, at: index, at: layerIndex, remove: nil)
    }

    public override func insertChild(_ element: BasicElement, at index: Int) {
        assertThreadAffinity(for: self)
        guard index > -1 && index < children.count else {
            assertFail("Insert index illegal: \(index)")
            return
        }
        let index = children.count
        let layerIndex: Int?
        if let layer = self.layer, let slayer = element._layer,
           let i = layer.sublayers?.index(of: slayer) {
            layerIndex = i + 1
        } else {
            layerIndex = nil
        }
        insertChild(element, at: index, at: layerIndex, remove: nil)
    }

    // FIXME: insert view
//    override func insertChild(_ element: BasicElement, at index: Int, at layerIndex: Int?,
//                              remove oldElement: BasicElement?) {
//    }

    override func _removeFromOwner() {
        super._removeFromOwner()
        view?.removeFromSuperview()
    }

    public func viewLoaded(_ method: @escaping (Element<View>) -> Void) {
        if Runner.isMain(), loaded {
            method(self)
        } else {
            actions.loadAction(self, method)
        }
    }

    public func bind<T>(target: T, _ method: @escaping (T) -> Void) where T: AnyObject {
        if Runner.isMain(), loaded {
            method(target)
        } else {
            actions.loadAction(target, method)
        }
    }

    public func bind<T>(target: T, source method: @escaping (T) -> (Element<View>) -> Void) where T: AnyObject {
        if Runner.isMain(), loaded {
            method(target)(self)
        } else {
            let action: ElementAction.Action = { [weak target, weak self] in
                if let _target = target, let this = self {
                    method(_target)(this)
                }
            }
            actions.load.append(action)
        }
    }

    public func tap<T>(target: T, source method: @escaping (T) -> (Element<View>) -> Void) where T: AnyObject {
        let action: ElementAction.Action = { [weak target, weak self] in
            if let _target = target, let this = self {
                method(_target)(this)
            }
        }
        super.tap(action)
    }

    public override func build(in view: UIView) {
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
        onLoaded()
    }

    public func buildView() -> View {
        assertMainThread()
        if let v = self.view {
            return v
        }
        let this = _createView()
        applyState(to: this)
        buildChildren()
        return this
    }

    func _createView() -> View {
        assertMainThread()
        if let view = self.view {
            return view
        }
        let this = creator?() ?? View.init(frame: .zero)
        creator = nil
        if let container = this as? ElementContainer {
            container.element = self
        } else {
            this._element = self
        }
        self.view = this
        return this
    }

    public override func apply() {
        if let view = self.view {
            applyState(to: view)
        }
    }

    public func applyState(to view: View) {
        assertMainThread()
        _pendingState?.apply(view: view)
    }

    public override func registerPendingState() {
        if view == nil {
            return
        }
        super.registerPendingState()
    }

    public override func buildChildren(in view: UIView) {
        if children.isEmpty {
            return
        }
        let sorted = children.sorted(by: BasicElement.sortZIndex)
        sorted.forEach { child in
            child.build(in: view)
        }
    }

    public func buildChildren() {
        if let view = self.view {
            buildChildren(in: view)
        }
    }

#if DEBUG
    public override func debugMode() {
        backgroundColor(UIColor.random)
        super.debugMode()
    }
#endif

    override func removeFromSuperView() {
        assertMainThread()
        view?.removeFromSuperview()
    }

    // MARK: - Configuring a Element’s Visual Appearance
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
