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

import CoreGraphics

public extension CGRect {
    public init(x: LayoutValue, y: LayoutValue, size: CGSize) {
        let point = CGPoint(x: x.value, y: y.value)
        self.init(origin: point, size: size)
    }

    public init(origin: CGPoint, width: LayoutValue, height: LayoutValue) {
        let size = CGSize(width: width.value, height: height.value)
        self.init(origin: origin, size: size)
    }

    public var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }

    public var topLeft: CGPoint {
        return origin
    }

    public var topRight: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y)
    }

    public var bottomLeft: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + height)
    }

    public var bottomRight: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y + height)
    }

    public var ceiled: CGRect {
        return CGRect(origin: origin.ceiled, size: size.ceiled)
    }

    public var floored: CGRect {
        return CGRect(origin: origin.floored, size: size.floored)
    }

    public var rounded: CGRect {
        return CGRect(origin: origin.rounded, size: size.rounded)
    }

    public func setSize(_ value: CGSize) -> CGRect {
        return CGRect(origin: origin, size: value)
    }

    public func setSize(width: LayoutValue, height: LayoutValue) -> CGRect {
        return CGRect(x: origin.x, y: origin.y, width: width.value, height: height.value)
    }

    public func setOrigin(_ value: CGPoint) -> CGRect {
        return CGRect(origin: value, size: size)
    }

    public func setOrigin(x: LayoutValue, y: LayoutValue) -> CGRect {
        return CGRect(x: x.value, y: y.value, width: width, height: height)
    }
}
