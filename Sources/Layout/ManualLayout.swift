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

public enum LayoutEdge {
    case left
    case right
    case top
    case bottom

    internal func xValue(_ frame: CGRect) -> CGFloat {
        let base: CGFloat
        switch self {
        case .left:
            base = frame.minX
        case .right:
            base = frame.maxX
        default:
            base = 0
        }
        return base
    }

    internal func yValue(_ frame: CGRect) -> CGFloat {
        let base: CGFloat
        switch self {
        case .top:
            base = frame.minY
        case .bottom:
            base = frame.maxY
        default:
            base = 0
        }
        return base
    }
}

public class Layout {
    let view: UIView
    var containerSize: CGSize
    var _left: CGFloat = CGFloat.nan
    var _top: CGFloat = CGFloat.nan
    var _right: CGFloat = CGFloat.nan
    var _bottom: CGFloat = CGFloat.nan
    var _width: CGFloat = CGFloat.nan
    var _height: CGFloat = CGFloat.nan

    var computedX: CGFloat {
        let size = _left.isNaN ? (containerSize.width - _right - _width) : _left
        return size > 0 ? size : 0
    }

    var computedY: CGFloat {
        let size = _top.isNaN ? (containerSize.height - _bottom - _height) : _top
        return size > 0 ? size : 0
    }

    var computedWidth: CGFloat {
        let size = _width.isNaN ? (containerSize.width - _right - _left) : _width
        return size > 0 ? size : 0
    }

    var computedHeight: CGFloat {
        let size = _height.isNaN ? (containerSize.height - _bottom - _top) : _height
        return size > 0 ? size : 0
    }

    public init(for view: UIView, container: CGSize? = nil) {
        self.view = view
        containerSize = container ?? view.superview?.bounds.size ?? CGSize.zero
    }

    public init(for view: UIView, containerWidth: CGFloat) {
        self.view = view
        let h = view.superview?.bounds.height ?? 0
        containerSize = CGSize(width: containerWidth, height: h)
    }

    public init(for view: UIView, containerHeight: CGFloat) {
        self.view = view
        let w = view.superview?.bounds.width ?? 0
        containerSize = CGSize(width: w, height: containerHeight)
    }

    public func update() -> Layout {
        let frame = view.frame
        _left = frame.minX
        _top = frame.minY
        _right = frame.maxX
        _bottom = frame.maxY
        _width = frame.width
        _height = frame.height
        return self
    }

    public func origin(_ value: CGPoint) -> Layout {
        _left = value.x
        _top = value.y
        return self
    }

    public func origin(_ value: LayoutValue) -> Layout {
        _left = value.value
        _top = _left
        return self
    }

    public func origin(x: LayoutValue, y: LayoutValue) -> Layout {
        _left = x.value
        _top = y.value
        return self
    }

    public func size(_ value: CGSize) -> Layout {
        _width = value.width
        _height = value.height
        return self
    }

    public func size(_ value: LayoutValue) -> Layout {
        _width = value.value
        _height = _width
        return self
    }

    public func size(width: LayoutValue, height: LayoutValue) -> Layout {
        _width = width.value
        _height = height.value
        return self
    }

    public func addTo(view: UIView, container: CGSize? = nil) -> Layout {
        view.addSubview(self.view)
        containerSize = container ?? containerSize
        return self
    }

    public func addTo(view: UIView, above subview: UIView, container: CGSize? = nil) -> Layout {
        view.insertSubview(self.view, aboveSubview: subview)
        containerSize = container ?? containerSize
        return self
    }

    public func addTo(view: UIView, below subview: UIView, container: CGSize? = nil) -> Layout {
        view.insertSubview(self.view, belowSubview: subview)
        containerSize = container ?? containerSize
        return self
    }

    public func apply() {
        view.frame = CGRect(x: computedX, y: computedY, width: computedWidth, height: computedHeight)
            .ceiled
    }
}

public extension Layout {
    public func left(_ value: LayoutValue = 0) -> Layout {
        _left = value.value
        return self
    }

    public func left(percent value: LayoutValue) -> Layout {
        _left = containerSize.width * value.value
        return self
    }

    public func left(_ value: LayoutValue = 0, to view: UIView, edge: LayoutEdge) -> Layout {
        _left = value.value + edge.xValue(view.frame)
        return self
    }

    public func left(percent value: LayoutValue, to view: UIView, edge: LayoutEdge) -> Layout {
        _left = value.value * edge.xValue(view.frame)
        return self
    }

    public func right(_ value: LayoutValue = 0) -> Layout {
        _right = value.value
        return self
    }

    public func right(percent value: LayoutValue) -> Layout {
        _right = containerSize.width * value.value
        return self
    }

    public func right(_ value: LayoutValue = 0, to view: UIView, edge: LayoutEdge) -> Layout {
        _right = edge.xValue(view.frame) - value.value
        return self
    }

    public func right(percent value: LayoutValue, to view: UIView, edge: LayoutEdge) -> Layout {
        _right = value.value * edge.xValue(view.frame)
        return self
    }

    public func top(_ value: LayoutValue = 0) -> Layout {
        _top = value.value
        return self
    }

    public func top(percent value: LayoutValue) -> Layout {
        _top = containerSize.height * value.value
        return self
    }

    public func top(_ value: LayoutValue = 0, to view: UIView, edge: LayoutEdge) -> Layout {
        _top = value.value + edge.yValue(view.frame)
        return self
    }

    public func top(percent value: LayoutValue, to view: UIView, edge: LayoutEdge) -> Layout {
        _top = value.value * edge.yValue(view.frame)
        return self
    }

    public func bottom(_ value: LayoutValue = 0) -> Layout {
        _bottom = value.value
        return self
    }

    public func bottom(percent value: LayoutValue) -> Layout {
        _bottom = containerSize.height * value.value
        return self
    }

    public func bottom(_ value: LayoutValue = 0, to view: UIView, edge: LayoutEdge) -> Layout {
        _bottom = edge.yValue(view.frame) - value.value
        return self
    }

    public func bottom(percent value: LayoutValue, to view: UIView, edge: LayoutEdge) -> Layout {
        _bottom = value.value * edge.yValue(view.frame)
        return self
    }

    public func width(_ value: LayoutValue) -> Layout {
        _width = value.value
        return self
    }

    public func width(percent value: LayoutValue) -> Layout {
        _width = containerSize.height * value.value
        return self
    }

    public func width(_ value: LayoutValue, to view: UIView, edge: LayoutEdge) -> Layout {
        _width = value.value + edge.xValue(view.frame) - _left
        return self
    }

    public func width(percent value: LayoutValue, to view: UIView, edge: LayoutEdge) -> Layout {
        _width = value.value * edge.xValue(view.frame)
        return self
    }

    public func height(_ value: LayoutValue) -> Layout {
        _height = value.value
        return self
    }

    public func height(percent value: LayoutValue) -> Layout {
        _height = containerSize.height * value.value
        return self
    }

    public func height(_ value: LayoutValue, to view: UIView, edge: LayoutEdge) -> Layout {
        _height = value.value + edge.yValue(view.frame)
        return self
    }

    public func height(percent value: LayoutValue, to view: UIView, edge: LayoutEdge) -> Layout {
        _height = value.value * edge.yValue(view.frame)
        return self
    }

    public func centerX(offset: LayoutValue? = nil) -> Layout {
        _left = (containerSize.width - computedWidth) / 2 + (offset?.value ?? 0)
        return self
    }

    public func centerY(offset: LayoutValue? = nil) -> Layout {
        _top = (containerSize.height - computedHeight) / 2 + (offset?.value ?? 0)
        return self
    }

    public func center(offset: LayoutValue? = nil) -> Layout {
        _left = (containerSize.width - computedWidth) / 2 + (offset?.value ?? 0)
        _top = (containerSize.height - computedHeight) / 2 + (offset?.value ?? 0)
        return self
    }
}
