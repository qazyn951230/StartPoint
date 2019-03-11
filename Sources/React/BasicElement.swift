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
import CoreGraphics

open class BasicElement: Hashable, CustomStringConvertible {
    // MARK: - Public properties
    public let layout = FlexLayout()
    public var zIndex: Int = 0
    public private(set) weak var owner: BasicElement?
    public internal(set) var children: [BasicElement]
    public let lock = MutexLock(recursive: true)

    let actions = ElementAction()
    let framed: Bool
    var _frame: Rect = Rect.zero {
        didSet {
            _bounds = _frame.setOrigin(.zero)
        }
    }
    var _bounds: Rect = Rect.zero
    var _center: Point = Point.zero
    var _pendingState: ElementState?
    var registered = false

    // MARK: - Configuring the Event-Related Behavior
    public var interactive: Bool = true
    public var alpha: Double = 1.0

    init(framed: Bool, children: [BasicElement]) {
        self.framed = framed
        self.children = children
        for child in children {
            child.owner = self
            layout.append(child.layout)
        }
    }

    public convenience init(children: [BasicElement] = []) {
        self.init(framed: false, children: children)
    }

    public var loaded: Bool {
        return children.first(where: { $0.framed })?.loaded ?? false
    }

    // MARK: CustomStringConvertible
    public var description: String {
        return String(describing: type(of: self))
    }

    // MARK: - Managing the elements hierarchy
    var root: BasicElement {
        var parent = owner
        while parent != nil {
            parent = parent?.owner
        }
        return owner ?? self
    }

    // MARK: insert
    public func addElement(_ element: BasicElement) {
        assertFalse(loaded, "Current only support add child before it create a view")
        if element == self || element.owner == self {
            return
        }
        assertEqual(children.count, layout.children.count, "Children array not synchronized with layout array")
        children.append(element)
        layout.append(element.layout)
        element.owner = self
    }

    public func insertElement(_ element: BasicElement, at index: Int) {
        assertFalse(loaded, "Current only support add child before it create a view")
        if element == self || element.owner == self {
            return
        }
        guard index > -1 && index <= children.count else {
            assertFail("Cannot insert a element at index \(index). Count is \(children.count)")
            return
        }
        assertEqual(children.count, layout.children.count, "Children array not synchronized with layout array")
        children.insert(element, at: index)
        layout.insert(element.layout, at: index)
        element.owner = self
    }

    // MARK: Remove
    func removeFromOwner() {
        owner?.removeElement(self)
        owner = nil
    }

    func removeElement(_ element: BasicElement) {
        guard element != self, element.owner == self else {
            return
        }
#if DEBUG
        if let index = children.index(of: element) {
            children.remove(at: index)
        } else {
            assertFail("\(self) own \(element), but doesn't contain in children array")
        }
#else
        if let index = children.index(of: element) {
            children.remove(at: index)
        }
#endif
        layout.remove(element.layout)
    }

    // MARK: - Observing Element-Related Changes
    public func loaded(then method: @escaping () -> Void) {
        if Runner.isMain(), loaded {
            method()
        } else {
            actions.load.append(method)
        }
    }

    func onLoaded() {
        assertMainThread()
        let methods = actions.load
        actions.load.removeAll()
        for method in methods {
            method()
        }
    }

    // MARK: - Create a View Object
    /// Every element can build itself in a UIView, even if it has not a backed UIView or CALayer.
    /// Default implantation is build children in the view (via `buildChildren(in:)`)
    /// Then call loaded callback.
    public func build(in view: UIView) {
        assertMainThread()
#if DEBUG
        if debug {
            let _view: UIView = debugBuildView()
            if let superview = _view.superview {
                if superview != _view {
                    _view.removeFromSuperview()
                    view.addSubview(_view)
                }
            } else {
                view.addSubview(_view)
            }
        } else {
            buildChildren(in: view)
        }
#else
        buildChildren(in: view)
#endif
        onLoaded()
    }

    // For layer element
    func build(in layer: CALayer) {
        // Do nothing.
    }

    func buildChildren(in view: UIView) {
        if children.isEmpty {
            return
        }
        // TODO: Use ordered list
        let sorted = children.sorted(by: BasicElement.sortZIndex)
        sorted.forEach { child in
            child.build(in: view)
        }
    }

    // MARK: - Manage pending state
    public var pendingState: ElementState {
        let state = _pendingState ?? ElementState()
        if _pendingState == nil {
            _pendingState = state
        }
        return state
    }

    func applyState() {
        // Needs by PendingStateManager
    }

    public func registerPendingState() {
        if registered {
            return
        }
        PendingStateManager.share.register(element: self)
    }

    // MARK: - Measuring in Flex Layout
    public func layout(width: Double = Double.nan, height: Double = Double.nan) {
        layout.calculate(width: width, height: height, direction: .ltr)
        calculateFrame(left: 0, top: 0)
    }

    func calculateFrame(left: Double, top: Double) {
        // TODO: Ensure flex layout algorithm return a valid rect
        _frame = Rect(x: left + layout.box.left, y: top + layout.box.top,
            width: layout.box.width, height: layout.box.height).valid
        let _left = framed ? 0 : _frame.x
        let _top = framed ? 0 : _frame.y
        children.forEach { child in
            child.calculateFrame(left: _left, top: _top)
        }
    }

    // MARK: - Debugging Flex Layout
#if DEBUG
    var debug = false
    var debugView: UIView?

    public func debugMode() {
        debug = true
        children.forEach { child in
            child.debugMode()
        }
    }

    func debugBuildView() -> UIView {
        assertMainThread()
        if let v = debugView {
            return v
        }
        let this = UIView()
        _pendingState?.apply(view: this)
        this.randomBackgroundColor()
        buildChildren(in: this)
        return this
    }
#endif

    // FIXME: Remove or rename this method
    public func build(to view: UIScrollView) {
        assertMainThread()
        build(in: view)
        view.contentSize = _frame.cgSize
    }

    // MARK: - Converting Between Element Coordinate Systems
    public func convert(_ point: CGPoint, from element: BasicElement?) -> CGPoint {
        guard let root = element ?? element?.root else {
            return CGPoint.zero
        }
        let transform = BasicElement.transform(from: root, to: self)
        let transform2 = CATransform3DGetAffineTransform(transform)
        assertTrue(CATransform3DIsAffine(transform))
        return point.applying(transform2)
    }

    public func convert(_ point: CGPoint, to element: BasicElement?) -> CGPoint {
        let root = element ?? self.root
        let transform = BasicElement.transform(from: self, to: root)
        let transform2 = CATransform3DGetAffineTransform(transform)
        assertTrue(CATransform3DIsAffine(transform))
        return point.applying(transform2)
    }

    func transform(to ancestor: BasicElement) -> CATransform3D {
        var transform = CATransform3DIdentity
        var current: BasicElement? = self
        while current?.owner != nil {
            if current == ancestor {
                let bounds = self.bounds
                let x = CGFloat(_frame.x)
                let y = CGFloat(_frame.y)
                transform = CATransform3DTranslate(transform, x, y, 0)
                transform = CATransform3DTranslate(transform, -bounds.origin.x, -bounds.origin.y, 0)
                return transform
            }
            current = current?.owner
        }
        return transform
    }

    static func transform(from: BasicElement, to: BasicElement) -> CATransform3D {
        let ancestor = commonAncestor(from, to)
        let one = from.transform(to: ancestor)
        let two = CATransform3DInvert(to.transform(to: ancestor))
        return CATransform3DConcat(one, two)
    }

    static func commonAncestor(_ one: BasicElement, _ two: BasicElement) -> BasicElement {
        let ancestor: BasicElement? = one
        while ancestor != nil {
            if isAncestor(ancestor, descendant: two) {
                break
            }
        }
        return ancestor ?? one
    }

    static func isAncestor(_ ancestor: BasicElement?, descendant: BasicElement) -> Bool {
        var parent: BasicElement? = descendant
        while parent != nil {
            if parent == ancestor {
                return true
            }
            parent = parent?.owner
        }
        return false
    }

    // MARK: - Hit Testing in a Element
    public var enableHitTest: Bool {
        return interactive && alpha > 0.01
    }

    public func hitTest(point: Point, event: UIEvent?) -> BasicElement? {
        guard enableHitTest && pointInside(point, event: event) else {
            return nil
        }
        for child in children {
            let p: Point
            if framed {
                p = Point(x: point.x - child._frame.x,
                    y: point.y - child._frame.y)
            } else {
                p = Point(x: point.x - child._frame.x - _frame.x,
                    y: point.y - child._frame.y - _frame.y)
            }
            if let c = child.hitTest(point: p, event: event) {
                return c
            }
        }
        return self
    }

    public func pointInside(_ point: Point, event: UIEvent?) -> Bool {
        return _bounds.contains(point: point)
    }

    // MARK: - Managing the Responder Chain
    // Required by dispatchTouchEvent(:)
    public var next: BasicElement? {
        return owner
    }

    // MARK: - Responding to Touch Events
    // When `ElementView` receive a touch event, it will call this method.
    func dispatchTouchEvent(_ event: TouchEvent) -> Bool {
        if let element = hitTest(point: event.location, event: nil) {
            if element.onTouchEvent(event) {
                return true
            } else {
                var next = element.next
                while next != nil {
                    if next?.onTouchEvent(event) == true {
                        return true
                    }
                    next = next?.next
                }
            }
        }
        return false
    }

    func onTouchEvent(_ event: TouchEvent) -> Bool {
        guard let tap = actions.tap else {
            return false
        }
        switch event.action {
        case .touchUp:
            Runner.main(async: tap)
        default:
            break
        }
        return true
    }

    // MARK: - Register the Tap Callback
    public func tap(_ method: @escaping () -> Void) {
        actions.tap = method
        interactive = true
    }

    func accept(visitor: ElementVisitor) {
        visitor.visit(basic: self)
    }

    // MARK: - Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(address(of: self))
    }

    public static func ==(lhs: BasicElement, rhs: BasicElement) -> Bool {
        return lhs === rhs
    }

    static func sortZIndex(lhs: BasicElement, rhs: BasicElement) -> Bool {
        return lhs.zIndex < rhs.zIndex
    }
}
