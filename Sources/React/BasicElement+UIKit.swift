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

import CoreGraphics
import UIKit

extension BasicElement {
    // MARK: - Get the Bounds and Frame Rectangles
    public var frame: CGRect {
        return _frame.cgRect
    }

    public var bounds: CGRect {
        return _bounds.cgRect
    }

    public var center: CGPoint {
        return _center.cgPoint
    }

    // MARK: - Managing the Element’s flex layout
    @discardableResult
    public func style(_ method: (FlexLayout) -> Void) -> Self {
        method(layout)
        return self
    }

    @discardableResult
    public func hidden(_ value: Bool) -> Self {
        layout.display(value ? Display.none : Display.flex)
        return self
    }

    // MARK: - Measuring in Flex Layout
    public func layout(width: CGFloat, height: CGFloat) {
        layout(width: Double(width), height: Double(height))
    }

    public func layout(width: Int, height: Int) {
        layout(width: Double(width), height: Double(height))
    }

    // TODO: layout within a `UIViewController` or use safe area.
    public func layout(within view: UIView) {
        layout(width: Double(view.frame.width), height: Double(view.frame.height))
    }

    // MARK: - Hit Testing in a Element
    public func hitTest(point: CGPoint, event: UIEvent?) -> BasicElement? {
        return hitTest(point: Point(cgPoint: point), event: event)
    }

    public func pointInside(_ point: CGPoint, event: UIEvent?) -> Bool {
        return pointInside(Point(cgPoint: point), event: event)
    }

    // MARK: - Register the Tap Callback
    public func tap<T>(target: T, _ method: @escaping (T) -> Void) where T: AnyObject {
        self.tap(ElementAction.action(target, method))
    }

    public func tap<T>(target: T, method: @escaping (T) -> () -> Void) where T: AnyObject {
        let action: ElementAction.Action = { [weak target] in
            if let _target = target {
                method(_target)()
            }
        }
        self.tap(action)
    }

    public func tap<T, Value>(target: T, any value: Value, _ method: @escaping (T) -> (Value) -> Void)
        where T: AnyObject {
        let action: ElementAction.Action = { [weak target] in
            if let _target = target {
                method(_target)(value)
            }
        }
        self.tap(action)
    }
}
