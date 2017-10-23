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

#if os(iOS)
import UIKit
#else
import AppKit
#endif
import CoreGraphics
import QuartzCore

fileprivate func convert(_ value: UInt32) -> CGFloat {
    return CGFloat(value) / CGFloat(255.0)
}

fileprivate func hexColor<T>(_ value: UInt32, creator: (CGFloat, CGFloat, CGFloat, CGFloat) -> T) -> T {
    let value = value < 0xFFFFFFFF ? value : 0xFFFFFFFF
    var a: UInt32 = 0xFF
    if value > 0x00FFFFFF {
        a = (value & 0xFF000000) >> 24
    }
    let r = (value & 0x00FF0000) >> 16
    let g = (value & 0x0000FF00) >> 8
    let b = (value & 0x000000FF)
    return creator(convert(r), convert(g), convert(b), convert(a))
}

#if os(iOS)
public extension UIColor {
    public static func hex(_ value: UInt32) -> UIColor {
        return hexColor(value, creator: UIColor.init(red:green:blue:alpha:))
    }
}
#else
public extension NSColor {
    public static func hex(value: UInt32) -> NSColor {
        return hexColor(hex, creator: NSColor.init(red:green:blue:alpha:))
    }
}

public extension CGColor {
    public static func hex(value: UInt32) -> CGColor {
        return hexColor(hex, creator: CGColor.init(red:green:blue:alpha:))
    }
}
#endif

#if os(iOS) && DEBUG
extension UIView {
    public func randomBackgroundColor() {
        let color = arc4random_uniform(0xFFFFFF)
        backgroundColor = UIColor.hex(color)
    }
}

extension CALayer {
    public func randomBackgroundColor() {
        let color = arc4random_uniform(0xFFFFFF)
        backgroundColor = UIColor.hex(color).cgColor
    }
}
#endif
