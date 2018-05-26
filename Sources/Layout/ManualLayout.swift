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
import CoreGraphics

public enum LayoutAttribute {
    case left
    case right
    case top
    case bottom
    case width
    case height
}

public protocol LayoutView: class {
    var frame: CGRect { get set }
    var bounds: CGRect { get }
    var parent: LayoutView? { get }
    func sizeThatFits(_ size: CGSize) -> CGSize
    func sizeToFit()
}

extension LayoutView {
    func resolve(edge: LayoutAttribute) -> Double {
        let value: CGFloat
        switch edge {
        case .left:
            value = frame.minX
        case .right:
            value = frame.maxX
        case .top:
            value = frame.minY
        case .bottom:
            value = frame.maxY
        case .width:
            value = frame.width
        case .height:
            value = frame.height
        }
        return Double(value)
    }
}

extension UIView: LayoutView {
    public var parent: LayoutView? {
        return superview
    }
}

extension CALayer: LayoutView {
    public var parent: LayoutView? {
        return superlayer
    }

    public func sizeThatFits(_ size: CGSize) -> CGSize {
        return preferredFrameSize()
    }

    public func sizeToFit() {
        // Do nothing.
    }
}

public class Layout {
    let view: LayoutView
    var parentSize: Size

    var left = StyleValue.auto
    var top = StyleValue.auto

    var right = StyleValue.auto
    var bottom = StyleValue.auto

    var width = StyleValue.auto
    var height = StyleValue.auto

    public init(view: LayoutView, parentSize: CGSize? = nil) {
        self.view = view
        let size = parentSize ?? view.parent?.bounds.size ?? CGSize.zero
        self.parentSize = Size(cgSize: size)
    }

    public func left(_ value: StyleValue) -> Layout {
        self.left = value
        return self
    }

    public func right(_ value: StyleValue) -> Layout {
        self.right = value
        return self
    }

    public func top(_ value: StyleValue) -> Layout {
        self.top = value
        return self
    }

    public func bottom(_ value: StyleValue) -> Layout {
        self.bottom = value
        return self
    }

    public func width(_ value: StyleValue) -> Layout {
        self.width = value
        return self
    }

    public func height(_ value: StyleValue) -> Layout {
        self.height = value
        return self
    }

    public func vertical(_ value: StyleValue) -> Layout {
        top = value
        bottom = value
        return self
    }

    public func horizontal(_ value: StyleValue) -> Layout {
        left = value
        right = value
        return self
    }

    public func allEdge(_ value: StyleValue) -> Layout {
        top = value
        bottom = value
        left = value
        right = value
        return self
    }

    public func left(float value: CGFloat = 0) -> Layout {
        self.left = .length(Double(value))
        return self
    }

    public func right(float value: CGFloat = 0) -> Layout {
        self.right = .length(Double(value))
        return self
    }

    public func top(float value: CGFloat = 0) -> Layout {
        self.top = .length(Double(value))
        return self
    }

    public func bottom(float value: CGFloat = 0) -> Layout {
        self.bottom = .length(Double(value))
        return self
    }

    public func vertical(float value: CGFloat) -> Layout {
        let object: StyleValue = .length(Double(value))
        top = object
        bottom = object
        return self
    }

    public func horizontal(float value: CGFloat) -> Layout {
        let object: StyleValue = .length(Double(value))
        left = object
        right = object
        return self
    }

    public func allEdge(float value: CGFloat) -> Layout {
        let object: StyleValue = .length(Double(value))
        top = object
        bottom = object
        left = object
        right = object
        return self
    }

    public func allEdge(_ value: UIEdgeInsets) -> Layout {
        top = .length(Double(value.top))
        bottom = .length(Double(value.bottom))
        left = .length(Double(value.left))
        right = .length(Double(value.right))
        return self
    }

    public func width(float value: CGFloat) -> Layout {
        self.width = .length(Double(value))
        return self
    }

    public func height(float value: CGFloat) -> Layout {
        self.height = .length(Double(value))
        return self
    }

    public func left(_ value: StyleValue, to view: LayoutView, edge: LayoutAttribute) -> Layout {
        switch value {
        case .auto:
            if case width = StyleValue.auto {
                self.left = .length(view.resolve(edge: edge))
            } else {
                self.left = .auto
            }
        case let .length(length):
            let value: Double = view.resolve(edge: edge)
            self.left = .length(value - length)
        case let .percentage(percentage):
            let value: Double = view.resolve(edge: edge)
            self.left = .length(value * percentage / 100)
        }
        return self
    }

    public func right(_ value: StyleValue, to view: LayoutView, edge: LayoutAttribute) -> Layout {
        switch value {
        case .auto:
            if case width = StyleValue.auto {
                self.right = .length(view.resolve(edge: edge))
            } else {
                self.right = .auto
            }
        case let .length(length):
            let value: Double = view.resolve(edge: edge)
            self.right = .length(parentSize.width - value + length)
        case let .percentage(percentage):
            let value: Double = view.resolve(edge: edge)
            self.right = .length(value * percentage / 100)
        }
        return self
    }

    public func top(_ value: StyleValue, to view: LayoutView, edge: LayoutAttribute) -> Layout {
        switch value {
        case .auto:
            if case height = StyleValue.auto {
                self.top = .length(view.resolve(edge: edge))
            } else {
                self.top = .auto
            }
        case let .length(length):
            let value: Double = view.resolve(edge: edge)
            self.top = .length(value - length)
        case let .percentage(percentage):
            let value: Double = view.resolve(edge: edge)
            self.top = .length(value * percentage / 100)
        }
        return self
    }

    public func bottom(_ value: StyleValue, to view: LayoutView, edge: LayoutAttribute) -> Layout {
        switch value {
        case .auto:
            if case height = StyleValue.auto {
                self.bottom = .length(view.resolve(edge: edge))
            } else {
                self.bottom = .auto
            }
        case let .length(length):
            let value: Double = view.resolve(edge: edge)
            self.bottom = .length(parentSize.height - value + length)
        case let .percentage(percentage):
            let value: Double = view.resolve(edge: edge)
            self.bottom = .length(value * percentage / 100)
        }
        return self
    }

    public func left(_ value: StyleValue, from view: LayoutView, edge: LayoutAttribute) -> Layout {
        switch value {
        case .auto:
            if case width = StyleValue.auto {
                self.left = .length(view.resolve(edge: edge))
            } else {
                self.left = .auto
            }
        case let .length(length):
            let value: Double = view.resolve(edge: edge)
            self.left = .length(value + length)
        case let .percentage(percentage):
            let value: Double = view.resolve(edge: edge)
            self.left = .length(value * percentage / 100)
        }
        return self
    }

    public func right(_ value: StyleValue, from view: LayoutView, edge: LayoutAttribute) -> Layout {
        switch value {
        case .auto:
            if case width = StyleValue.auto {
                self.right = .length(view.resolve(edge: edge))
            } else {
                self.right = .auto
            }
        case let .length(length):
            let value: Double = view.resolve(edge: edge)
            self.right = .length(parentSize.width - value - length)
        case let .percentage(percentage):
            let value: Double = view.resolve(edge: edge)
            self.right = .length(value * percentage / 100)
        }
        return self
    }

    public func top(_ value: StyleValue, from view: LayoutView, edge: LayoutAttribute) -> Layout {
        switch value {
        case .auto:
            if case height = StyleValue.auto {
                self.top = .length(view.resolve(edge: edge))
            } else {
                self.top = .auto
            }
        case let .length(length):
            let value: Double = view.resolve(edge: edge)
            self.top = .length(value + length)
        case let .percentage(percentage):
            let value: Double = view.resolve(edge: edge)
            self.top = .length(value * percentage / 100)
        }
        return self
    }

    public func bottom(_ value: StyleValue, from view: LayoutView, edge: LayoutAttribute) -> Layout {
        switch value {
        case .auto:
            if case height = StyleValue.auto {
                self.bottom = .length(view.resolve(edge: edge))
            } else {
                self.bottom = .auto
            }
        case let .length(length):
            let value: Double = view.resolve(edge: edge)
            self.bottom = .length(parentSize.height - value - length)
        case let .percentage(percentage):
            let value: Double = view.resolve(edge: edge)
            self.bottom = .length(value * percentage / 100)
        }
        return self
    }

    public func width(_ value: StyleValue, view: LayoutView, edge: LayoutAttribute) -> Layout {
        switch value {
        case .auto:
            self.width = .auto
        case let .length(length):
            let value: Double = view.resolve(edge: edge)
            self.width = .length(value + length)
        case let .percentage(percentage):
            let value: Double = view.resolve(edge: edge)
            self.width = .length(value * percentage / 100)
        }
        return self
    }

    public func height(_ value: StyleValue, view: LayoutView, edge: LayoutAttribute) -> Layout {
        switch value {
        case .auto:
            self.height = .auto
        case let .length(length):
            let value: Double = view.resolve(edge: edge)
            self.height = .length(value + length)
        case let .percentage(percentage):
            let value: Double = view.resolve(edge: edge)
            self.height = .length(value * percentage / 100)
        }
        return self
    }

    public func size(_ value: CGSize) -> Layout {
        width = .length(Double(value.width))
        height = .length(Double(value.height))
        return self
    }

    public func fitSize(_ value: CGSize? = nil) -> Layout {
        if let size = value {
            return self.size(view.sizeThatFits(size))
        } else {
            view.sizeToFit()
            return size(view.frame.size)
        }
    }

    public func apply() {
        let pWidth = parentSize.width
        let pHeight = parentSize.height
        var _left: Double = left.resolve(by: pWidth)
        var _top: Double = top.resolve(by: pHeight)
        var _width: Double = width.resolve(by: pWidth)
        var _height: Double = height.resolve(by: pHeight)

        let _right: Double = right.resolve(by: pWidth)
        let _bottom: Double = bottom.resolve(by: pHeight)

        if _width.isNaN {
            _width = pWidth
            if !_left.isNaN {
                _width -= _left
            }
            if !_right.isNaN {
                _width -= _right
            }
        }
        if _left.isNaN {
            _left = pWidth - _width - _right
        }
        if _height.isNaN {
            _height = pHeight
            if !_top.isNaN {
                _height -= _top
            }
            if !_bottom.isNaN {
                _height -= _bottom
            }
        }
        if _top.isNaN {
            _top = pHeight - _height - _bottom
        }

        _left = _left.isNaN ? 0 : _left
        _top = _top.isNaN ? 0 : _top
        _width = _width.isNaN || _width < 0 ? 0 : _width
        _height = _height.isNaN || _height < 0 ? 0 : _height

        view.frame = CGRect(x: _left.ceiled, y: _top.ceiled,
            width: _width.ceiled, height: _height.ceiled)
    }
}
