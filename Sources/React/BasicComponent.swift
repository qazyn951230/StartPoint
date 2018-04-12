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
    public let children: [BasicComponent]
    public let layout = FlexLayout()

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
        return String(describing: type(of: self)) + ":" + stringAddress(self)
    }

    // CustomDebugStringConvertible
    open var debugDescription: String { // "BasicComponent:0xffffff"
#if DEBUG
        return String(describing: type(of: self)) + "->" + name
#else
        return description
#endif
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

    public func layout(width: Double = .nan, height: Double = .nan) {
        layout.calculate(width: width, height: height, direction: .ltr)
        apply(left: 0, top: 0)
    }

    public func layout(within view: UIView) {
        layout(width: Double(view.frame.width), height: Double(view.frame.height))
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

    // MARK: - Touch
    open func tap(_ method: @escaping (BasicComponent) -> Void) {
        _tap = method
    }

    open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tap = _tap
        let this = self
        DispatchQueue.main.async {
            tap?(this)
        }
    }

    open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    // MARK: - Hashable
    public var hashValue: Int {
        return stringAddress(self).hashValue
    }

    public static func ==(lhs: BasicComponent, rhs: BasicComponent) -> Bool {
        return lhs === rhs
    }
}
