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

infix operator ~~: ComparisonPrecedence
infix operator <~: ComparisonPrecedence
infix operator >~: ComparisonPrecedence

public protocol Approximate {
    static func ~~(lhs: Self, rhs: Self) -> Bool
    static func <~(lhs: Self, rhs: Self) -> Bool
    static func >~(lhs: Self, rhs: Self) -> Bool
}

public extension Approximate where Self: Comparable {
    public static func <~(lhs: Self, rhs: Self) -> Bool {
        return lhs < rhs || lhs ~~ rhs
    }

    public static func >~(lhs: Self, rhs: Self) -> Bool {
        return lhs > rhs || lhs ~~ rhs
    }
}

extension Double: Approximate {
    public static func ~~(lhs: Double, rhs: Double) -> Bool {
        if lhs.isNaN {
            return rhs.isNaN
        }
        return abs(lhs - rhs) < 0.0001
    }
}

extension CGFloat: Approximate {
    public static func ~~(lhs: CGFloat, rhs: CGFloat) -> Bool {
        if lhs.isNaN {
            return rhs.isNaN
        }
        return abs(lhs - rhs) < 0.0001
    }
}
