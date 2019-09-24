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

extension CGSize {
    public init(_ width: LayoutValue, _ height: LayoutValue) {
        self.init(width: width.value, height: height.value)
    }

    public var ceiled: CGSize {
        return CGSize(width: ceil(width), height: ceil(height))
    }

    public var floored: CGSize {
        return CGSize(width: floor(width), height: floor(height))
    }

    public var rounded: CGSize {
        return CGSize(width: round(width), height: round(height))
    }

    public static func max(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
        let w = width ?? CGFloat.greatestFiniteMagnitude
        let h = height ?? CGFloat.greatestFiniteMagnitude
        return CGSize(width: w, height: h)
    }

    public func setWidth(_ width: LayoutValue) -> CGSize {
        return CGSize(width: width.value, height: height)
    }

    public func setHeight(_ height: LayoutValue) -> CGSize {
        return CGSize(width: width, height: height.value)
    }
}
