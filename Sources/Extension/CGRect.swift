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

public extension CGRect {
    var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }

    var topLeft: CGPoint {
        return origin
    }

    var topRight: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y)
    }

    var bottomLeft: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + height)
    }

    var bottomRight: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y + height)
    }

    var ceiled: CGRect {
        return CGRect(origin: origin.ceiled, size: size.ceiled)
    }

    var floored: CGRect {
        return CGRect(origin: origin.floored, size: size.floored)
    }

    var rounded: CGRect {
        return CGRect(origin: origin.rounded, size: size.rounded)
    }

    func setSize(_ value: CGSize) -> CGRect {
        return CGRect(origin: origin, size: value)
    }

    func setSize(width: CGFloat, height: CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: origin.y, width: width, height: height)
    }

    func setOrigin(_ value: CGPoint) -> CGRect {
        return CGRect(origin: value, size: size)
    }

    func setOrigin(x: CGFloat, y: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }

    func setWidth(_ value: CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: origin.y, width: value, height: size.height)
    }

    func setHeight(_ value: CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: origin.y, width: size.width, height: value)
    }

    func setX(_ value: CGFloat) -> CGRect {
        return CGRect(x: value, y: origin.y, width: size.width, height: size.height)
    }

    func setY(_ value: CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: value, width: size.width, height: size.height)
    }
}
