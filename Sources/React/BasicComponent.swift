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

open class BasicComponent: Hashable, CustomStringConvertible, CustomDebugStringConvertible {
    public internal(set) var children: [BasicComponent]
    public let layout = FlexLayout()
    public private(set) weak var owner: BasicComponent?

    let framed: Bool
    var _frame: Rect = Rect.zero
    var _tap: ((BasicComponent) -> Void)?
    var _pendingState: ComponentState?

#if DEBUG
    public var name = String.empty
    var _debug = false
#endif

    init(framed: Bool, children: [BasicComponent]) {
        self.framed = framed
        self.children = children
        for child in children {
            child.owner = self
            layout.append(child.layout)
        }
    }

    open var overrideTouches: Bool {
        return _tap != nil
    }

    public var frame: CGRect {
        return _frame.cgRect
    }

    public var bounds: CGRect {
        return CGRect(origin: CGPoint.zero, size: _frame.cgSize)
    }

    public var pendingState: ComponentState {
        let state = _pendingState ?? ComponentState()
        if _pendingState == nil {
            _pendingState = state
        }
        return state
    }

    // CustomStringConvertible
    open var description: String { // "BasicComponent:0xffffff"
        return String(describing: type(of: self)) + ":" + address(of: self)
    }

    // CustomDebugStringConvertible
    open var debugDescription: String { // "BasicComponent:0xffffff"
#if DEBUG
        return String(describing: type(of: self)) + "->" + name
#else
        return description
#endif
    }

    var closestViewComponent: ViewComponent? {
        var parent = owner
        while parent != nil {
            if let component = parent as? ViewComponent {
                return component
            }
            parent = parent?.owner
        }
        return nil
    }

    var rootComponent: BasicComponent {
        var parent = owner
        while parent != nil {
            parent = parent?.owner
        }
        return owner ?? self
    }

    @discardableResult
    public func then(_ method: (BasicComponent) -> Void) -> Self {
        method(self)
        return self
    }

    @discardableResult
    public func layout(_ method: (FlexLayout) -> Void) -> Self {
        method(layout)
        return self
    }

//    open func prepareLayout() {
//        for child in children {
//            layout.append(child.layout)
//            child.prepareLayout()
//        }
//    }

    public func layout(width: Double = .nan, height: Double = .nan) {
//        prepareLayout()
        layout.calculate(width: width, height: height, direction: .ltr)
        applyLayout()
    }

    public func layout(within view: UIView) {
        layout(width: Double(view.frame.width), height: Double(view.frame.height))
    }

    open func applyLayout() {
        apply(left: 0, top: 0)
    }

    func apply(left: Double, top: Double) {
        // TODO: Flatten children
        var left = left
        var top = top
        let frame = Rect(x: left + layout.box.left, y: top + layout.box.top,
            width: layout.box.width, height: layout.box.height)
        self._frame = frame
        if framed {
            left = 0
            top = 0
        } else {
            left += layout.box.left
            top += layout.box.top
        }
        children.forEach {
            $0.apply(left: left, top: top)
        }
    }

    open func build(in view: UIView) {
        assertMainThread()
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

#if DEBUG
    public func debugMode() {
        _debug = true
        children.forEach {
            $0.debugMode()
        }
    }
#endif

    open var interactive: Bool {
        return true
    }

    open var alpha: Double {
        return 1.0
    }

    var enableHitTest: Bool {
        return interactive && alpha > 0.01
    }

    public func dispatchTouchEvent(_ event: MotionEvent) -> Bool {
        if let component = _hitTest(point: event.location, event: nil) {
            if component.onTouchEvent(event) {
                return true
            } else {
                var next = component.nextTarget
                while next != nil {
                    if next?.onTouchEvent(event) == true {
                        return true
                    }
                    next = component.nextTarget
                }
            }
        }
        return false
    }

    open var nextTarget: BasicComponent? {
        return owner
    }

    public func onTouchEvent(_ event: MotionEvent) -> Bool {
        Log.debug("foobar")
        return _tap != nil
//        return false
    }

    func _hitTest(point: CGPoint, event: UIEvent?) -> BasicComponent? {
        guard enableHitTest else {
            return nil
        }
        return hitTest(point: point, event: event)
    }

    open func hitTest(point: CGPoint, event: UIEvent?) -> BasicComponent? {
        guard pointInside(point, event: event) else {
            return nil
        }
        for child in children {
            let p = convert(point, to: child)
            if let c = child.hitTest(point: p, event: event) {
                return c
            }
        }
        return self
    }

    open func pointInside(_ point: CGPoint, event: UIEvent?) -> Bool {
        return _frame.contains(point: point)
    }

    public func convert(_ point: CGPoint, from component: BasicComponent?) -> CGPoint {
        guard let root = component ?? component?.rootComponent else {
            return CGPoint.zero
        }
        let transform = BasicComponent.transform(from: root, to: self)
        let transform2 = CATransform3DGetAffineTransform(transform)
        assertTrue(CATransform3DIsAffine(transform))
        return point.applying(transform2)
    }

    public func convert(_ point: CGPoint, to component: BasicComponent?) -> CGPoint {
        let root = component ?? self.rootComponent
        let transform = BasicComponent.transform(from: self, to: root)
        let transform2 = CATransform3DGetAffineTransform(transform)
        assertTrue(CATransform3DIsAffine(transform))
        return point.applying(transform2)
    }

    func transform(to ancestor: BasicComponent) -> CATransform3D {
        var transform = CATransform3DIdentity
        var current: BasicComponent? = self
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

    static func transform(from: BasicComponent, to: BasicComponent) -> CATransform3D {
        let ancestor = commonAncestor(from, to)
        let one = from.transform(to: ancestor)
        let two = CATransform3DInvert(to.transform(to: ancestor))
        return CATransform3DConcat(one, two)
    }

    static func commonAncestor(_ one: BasicComponent, _ two: BasicComponent) -> BasicComponent {
        let ancestor: BasicComponent? = one
        while ancestor != nil {
            if isAncestor(ancestor, descendant: two) {
                break
            }
        }
        return ancestor ?? one
    }

    static func isAncestor(_ ancestor: BasicComponent?, descendant: BasicComponent) -> Bool {
        var parent: BasicComponent? = descendant
        while parent != nil {
            if parent == ancestor {
                return true
            }
            parent = parent?.owner
        }
        return false
    }

    // MARK: - Touch
    open func tap(_ method: @escaping (BasicComponent) -> Void) {
        _tap = method
    }

    open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        assertMainThread()
    }

    open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        assertMainThread()
    }

    open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        assertMainThread()
        let tap = _tap
        let this = self
        DispatchQueue.main.async {
            tap?(this)
        }
    }

    open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        assertMainThread()
    }

    // MARK: - Hashable
    open var hashValue: Int {
        return address(of: self).hashValue
    }

    public static func ==(lhs: BasicComponent, rhs: BasicComponent) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
