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

public protocol LayoutValue {
    var value: CGFloat { get }
}

public extension LayoutValue {
    public var ceiled: CGFloat {
        return ceil(value)
    }

    public var floored: CGFloat {
        return floor(value)
    }

    public var rounded: CGFloat {
        return round(value)
    }
}

extension CGFloat: LayoutValue {
    public var value: CGFloat {
        return self
    }
}

extension Int: LayoutValue {
    public var value: CGFloat {
        return CGFloat(self)
    }
}

extension Double: LayoutValue {
    public var value: CGFloat {
        return CGFloat(self)
    }
}

public struct Size: Equatable {
    public let width: Double
    public let height: Double

    public init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    public static var zero = Size(width: 0, height: 0)

    public static func ==(lhs: Size, rhs: Size) -> Bool {
        return lhs.width ~~ rhs.width && lhs.height ~~ rhs.height
    }
}

public struct Rect: Equatable {
    public let x: Double
    public let y: Double
    public let width: Double
    public let height: Double

    public init(x: Double, y: Double, width: Double, height: Double) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }

    public static let zero = Rect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)

    public static func ==(lhs: Rect, rhs: Rect) -> Bool {
        return lhs.x ~~ rhs.x && lhs.y ~~ rhs.y &&
            lhs.width ~~ rhs.width && lhs.height ~~ rhs.height
    }
}

