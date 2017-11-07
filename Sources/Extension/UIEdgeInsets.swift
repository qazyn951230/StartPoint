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

import UIKit

public extension UIEdgeInsets {
    public var horizontal: CGFloat {
        return left + right
    }

    public var vertical: CGFloat {
        return top + bottom
    }

    public init(horizontal: CGFloat) {
        self.init(top: 0, left: horizontal, bottom: 0, right: horizontal)
    }

    public init(vertical: CGFloat) {
        self.init(top: vertical, left: 0, bottom: vertical, right: 0)
    }

    static func +(lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: lhs.top + rhs.top, left: lhs.left + rhs.left,
            bottom: lhs.bottom + rhs.bottom, right: lhs.right + rhs.right)
    }

    static func +=(lhs: inout UIEdgeInsets, rhs: UIEdgeInsets) {
        lhs = UIEdgeInsets(top: lhs.top + rhs.top, left: lhs.left + rhs.left,
            bottom: lhs.bottom + rhs.bottom, right: lhs.right + rhs.right)
    }

    static func -(lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: lhs.top - rhs.top, left: lhs.left - rhs.left,
            bottom: lhs.bottom - rhs.bottom, right: lhs.right - rhs.right)
    }

    static func -=(lhs: inout UIEdgeInsets, rhs: UIEdgeInsets) {
        lhs = UIEdgeInsets(top: lhs.top + rhs.top, left: lhs.left + rhs.left,
            bottom: lhs.bottom + rhs.bottom, right: lhs.right + rhs.right)
    }

    prefix static func +(x: UIEdgeInsets) -> UIEdgeInsets {
        return x
    }

    prefix static func -(x: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: -x.top, left: -x.left, bottom: -x.bottom, right: -x.right)
    }
}
