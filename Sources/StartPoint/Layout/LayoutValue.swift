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

public struct Size: Equatable {
    public let width: Double
    public let height: Double

    public init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    public init(cgSize: CGSize) {
        self.init(width: Double(cgSize.width), height: Double(cgSize.height))
    }

    public var ceiled: Size {
        return Size(width: ceil(width), height: ceil(height))
    }

    public var floored: Size {
        return Size(width: floor(width), height: floor(height))
    }

    public var rounded: Size {
        return Size(width: round(width), height: round(height))
    }

    var isZero: Bool {
        return width == 0 && height == 0
    }

    public static var zero = Size(width: 0, height: 0)

    public static func ==(lhs: Size, rhs: Size) -> Bool {
        return lhs.width ~~ rhs.width && lhs.height ~~ rhs.height
    }
}

public struct Point: Equatable {
    public let x: Double
    public let y: Double

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    public init(cgPoint: CGPoint) {
        self.init(x: Double(cgPoint.x), y: Double(cgPoint.y))
    }

    public var cgPoint: CGPoint {
        return CGPoint(x: x, y: y)
    }

    public static var zero = Point(x: 0, y: 0)

    public static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.x ~~ rhs.x && lhs.y ~~ rhs.y
    }
}

public struct Rect: Equatable {
    public let x: Double
    public let y: Double
    public let width: Double
    public let height: Double

    public var size: Size {
        return Size(width: width, height: height)
    }

    public var cgSize: CGSize {
        return CGSize(width: width, height: height)
    }

    public var cgRect: CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }

    var valid: Rect {
        return Rect(x: x.isNaN ? 0 : x, y: y.isNaN ? 0 : y,
            width: width.isNaN ? 0 : width, height: height.isNaN ? 0 : height)
    }

    public init(x: Double, y: Double, width: Double, height: Double) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }

    public init(origin: Point, size: Size) {
        self.init(x: origin.x, y: origin.y, width: size.width, height: size.height)
    }

    public var minX: Double {
        return x
    }

    public var midX: Double {
        return x + width / 2
    }

    public var maxX: Double {
        return x + width
    }

    public var minY: Double {
        return y
    }

    public var midY: Double {
        return y + width / 2
    }

    public var maxY: Double {
        return y + width
    }

    public func contains(point: Point) -> Bool {
        guard width > 0 && height > 0 else {
            return false
        }
        let px = point.x
        let py = point.y
        let maxX = x + width
        let maxY = y + height
        return x <= px && px <= maxX && y <= py && py <= maxY
    }

    public func contains(point: CGPoint) -> Bool {
        guard width > 0 && height > 0 else {
            return false
        }
        let px = Double(point.x)
        let py = Double(point.y)
        let maxX = x + width
        let maxY = y + height
        return x <= px && px <= maxX && y <= py && py <= maxY
    }

    public func setSize(_ value: Size) -> Rect {
        return Rect(x: x, y: y, width: value.width, height: value.height)
    }

    public func setSize(width: Double, height: Double) -> Rect {
        return Rect(x: x, y: y, width: width, height: height)
    }

    public func setOrigin(_ value: Point) -> Rect {
        return Rect(x: value.x, y: value.y, width: width, height: height)
    }

    public func setOrigin(x: Double, y: Double) -> Rect {
        return Rect(x: x, y: y, width: width, height: height)
    }

    public func setWidth(_ value: Double) -> Rect {
        return Rect(x: x, y: y, width: value, height: height)
    }

    public func setHeight(_ value: Double) -> Rect {
        return Rect(x: x, y: y, width: width, height: value)
    }

    public func setX(_ value: Double) -> Rect {
        return Rect(x: value, y: y, width: width, height: height)
    }

    public func setY(_ value: Double) -> Rect {
        return Rect(x: x, y: value, width: width, height: height)
    }

    public static let zero = Rect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)

    public static func ==(lhs: Rect, rhs: Rect) -> Bool {
        return lhs.x ~~ rhs.x && lhs.y ~~ rhs.y &&
            lhs.width ~~ rhs.width && lhs.height ~~ rhs.height
    }
}

