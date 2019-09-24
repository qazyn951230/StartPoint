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
import Dispatch
import RxSwift

open class BasicElement: Hashable, CustomStringConvertible, CustomDebugStringConvertible {
    public let layout = FlexLayout()

    let framed: Bool
    var _frame: Rect = Rect.zero {
        didSet {
            _bounds = _frame.setOrigin(.zero)
        }
    }
    var _bounds: Rect = Rect.zero
    var _center: Point = Point.zero

    var _tap: ((BasicElement) -> Void)?
    var _pendingState: ElementState?
    var registered = false
    var _onLoaded: [(BasicElement) -> Void] = []

    public var zIndex: Int = 0

#if DEBUG
    public var name = String.empty
    var debug = false
    var debugView: UIView?
#endif

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
    
    deinit {
        owner = nil
    }

    public var frame: CGRect {
        return _frame.cgRect
    }

    public var bounds: CGRect {
        return _bounds.cgRect
    }

    public var center: CGPoint {
        return _center.cgPoint
    }

    public var pendingState: ElementState {
        let state = _pendingState ?? ElementState()
        if _pendingState == nil {
            _pendingState = state
        }
        return state
    }

    public var loaded: Bool {
        return children.first(where: { $0.framed })?.loaded ?? false
    }

    // For convenience
    var _view: UIView? {
        return nil
    }

    // For convenience
    var _layer: CALayer? {
        return nil
    }

    var layered: Bool {
        return false
    }

    // CustomStringConvertible
    open var description: String { // "BasicElement:0xffffff"
        return String(describing: type(of: self)) + ":" + address(of: self)
    }

    // CustomDebugStringConvertible
    open var debugDescription: String { // "BasicElement:0xffffff"
        return String(describing: type(of: self)) + ":" + address(of: self)
    }

    // MARK: - Managing the Responder Chain
    open var next: BasicElement? {
        return owner
    }

    public func onLoaded(then method: @escaping (BasicElement) -> Void) {
        if Runner.isMain(), loaded {
            method(self)
        } else {
            _onLoaded.append(method)
        }
    }

    // MARK: - Responding to Touch Events
    open func dispatchTouchEvent(_ event: TouchEvent) -> Bool {
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

    open func onTouchEvent(_ event: TouchEvent) -> Bool {
        guard let tap = _tap else {
            return false
        }
        switch event.action {
        case .touchUp:
            let sender = self
            DispatchQueue.main.async {
                tap(sender)
            }
        default:
            break
        }
        return true
    }

    // MARK: - Create a View Object
    open func build(in view: UIView) {
        assertMainThread()
#if DEBUG
        if debug {
            let this = debugBuildView()
            if let superview = this.superview {
                if superview != view {
                    this.removeFromSuperview()
                    view.addSubview(this)
                }
            } else {
                view.addSubview(this)
            }
        } else {
            buildChildren(in: view)
        }
#else
        buildChildren(in: view)
#endif
        let methods = _onLoaded
        _onLoaded.removeAll()
        methods.forEach { $0(self) }
    }

#if DEBUG
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

    open func buildChildren(in view: UIView) {
        let sorted = children.sorted(by: BasicElement.sortZIndex)
        sorted.forEach { child in
            child.build(in: view)
        }
    }

    internal static func sortZIndex(lhs: BasicElement, rhs: BasicElement) -> Bool {
        return lhs.zIndex < rhs.zIndex
    }

    open func build(in layer: CALayer) {
        assertMainThread()
    }

    // FIXME: Remove or rename this method
    public func build(to view: UIScrollView) {
        assertMainThread()
        build(in: view)
        view.contentSize = _frame.cgSize
    }

    // MARK: - Configuring the Event-Related Behavior
    public var interactive: Bool = true
    public var alpha: Double = 1.0

    // MARK: - Managing the Element Hierarchy
    public private(set) weak var owner: BasicElement?
    public internal(set) var children: [BasicElement]
    var root: BasicElement {
        var parent = owner
        while parent != nil {
            parent = parent?.owner
        }
        return owner ?? self
    }

    public func addChild(_ element: BasicElement) {
        if let old = element.owner, old == self {
            return
        }
        let index = children.count
        insertChild(element, at: index, at: nil, remove: nil)
    }

    public func insertChild(_ element: BasicElement, at index: Int) {
        guard index > -1 && index < children.count else {
            assertFail("Insert index illegal: \(index)")
            return
        }
        let index = children.count
        insertChild(element, at: index, at: nil, remove: nil)
    }

    // layered ✔， element.layered ✔ => ✔
    // layered ✔， element.layered ✘ => ✘
    // layered ✘， element.layered ✔ => ✔
    // layered ✘， element.layered ✘ => ✔
    func insertChild(_ element: BasicElement, at index: Int, at layerIndex: Int?, remove oldElement: BasicElement?) {
        assertFalse(layered && !element.layered, "A layer element cannot add a view element as subelement")
        assertEqual(children.count, layout.children.count)
        guard element != self else {
            return
        }
        let count = children.count
        guard index > -1 && index <= count else {
            assertFail("Insert index illegal: \(index)")
            return
        }
        element.removeFromOwner()
        oldElement?.removeFromOwner()
        children.insert(element, at: index)
        layout.insert(element.layout, at: index)
        element.owner = self
    }

    func removeElement(_ element: BasicElement) {
        guard element != self, element.owner == self else {
            return
        }
#if DEBUG
        if let index = children.firstIndex(of: element) {
            children.remove(at: index)
        } else {
            assertFail("\(self) own \(element), but doesn't contain in children array")
        }
#else
        if let index = children.firstIndex(of: element) {
            children.remove(at: index)
        }
#endif
        layout.remove(element.layout)
        element._removeFromOwner()
    }

    public func removeFromOwner() {
        owner?.removeElement(self)
    }

    // MARK: - Observing Element-Related Changes
    func _removeFromOwner() { // For remove element directly
        owner = nil
    }

    // MARK: - Measuring in Flex Layout
    @discardableResult
    public func style(_ method: (FlexLayout) -> Void) -> Self {
        method(layout)
        return self
    }

    public func layout(width: Double = .nan, height: Double = .nan) {
        layout.calculate(width: width, height: height, direction: .ltr)
        calculateFrame(left: 0, top: 0)
    }

    public func layout(width: CGFloat, height: CGFloat) {
        layout(width: Double(width), height: Double(height))
    }

    public func layout(width: Int, height: Int) {
        layout(width: Double(width), height: Double(height))
    }

    public func layout(within view: UIView) {
        layout(width: Double(view.frame.width), height: Double(view.frame.height))
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
    open var enableHitTest: Bool {
        return interactive && alpha > 0.01
    }

    open func hitTest(point: CGPoint, event: UIEvent?) -> BasicElement? {
        guard enableHitTest && pointInside(point, event: event) else {
            return nil
        }
        for child in children {
            let p: CGPoint
            if framed {
                p = CGPoint(x: point.x - CGFloat(child._frame.x), y: point.y - CGFloat(child._frame.y))
            } else {
                p = CGPoint(x: point.x - CGFloat(child._frame.x - _frame.x), y: point.y - CGFloat(child._frame.y - _frame.y))
            }
            if let c = child.hitTest(point: p, event: event) {
                return c
            }
        }
        return self
    }

    open func pointInside(_ point: CGPoint, event: UIEvent?) -> Bool {
        return _bounds.contains(point: point)
    }

    public func apply() {
        // Do nothing.
    }

    public func registerPendingState() {
        if registered {
            return
        }
        PendingStateManager.share.register(element: self)
    }

    func calculateFrame(left: Double, top: Double) {
        var left = left
        var top = top
        let frame = Rect(x: left + layout.box.left, y: top + layout.box.top,
            width: layout.box.width, height: layout.box.height)
        if _frame != frame {
            _frame = frame
        }
        if framed {
            left = 0
            top = 0
        } else {
            left += layout.box.left
            top += layout.box.top
        }
        children.forEach {
            $0.calculateFrame(left: left, top: top)
        }
    }

#if DEBUG
    public func debugMode() {
        debug = true
        children.forEach {
            $0.debugMode()
        }
    }
#endif

    // MARK: - Touch
    open func tap(_ method: @escaping (BasicElement) -> Void) {
        _tap = method
        interactive = true
    }

    // MARK: - Hashable
    open func hash(into hasher: inout Hasher) {
        hasher.combine(address(of: self))
    }

    public static func ==(lhs: BasicElement, rhs: BasicElement) -> Bool {
        return lhs === rhs
    }
}
