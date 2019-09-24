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

#if os(iOS)
import UIKit
#else
import AppKit
#endif
import CoreGraphics
import QuartzCore

@inline(__always)
fileprivate func convert(_ value: UInt32) -> CGFloat {
    return CGFloat(value) / CGFloat(255.0)
}

@inline(__always)
fileprivate func hexColor<T>(_ value: UInt32, creator: (CGFloat, CGFloat, CGFloat, CGFloat) -> T) -> T {
    let value = value < 0xFFFFFFFF ? value : 0xFFFFFFFF
    let a: UInt32 = (value > 0x00FFFFFF) ? ((value & 0xFF000000) >> 24) : 0xFF
    let r = (value & 0x00FF0000) >> 16
    let g = (value & 0x0000FF00) >> 8
    let b = (value & 0x000000FF)
    return creator(convert(r), convert(g), convert(b), convert(a))
}

@inline(__always)
fileprivate func hexColor<T>(_ value: UInt32, alpha: CGFloat, creator: (CGFloat, CGFloat, CGFloat, CGFloat) -> T) -> T {
    let value = value < 0xFFFFFF ? value : 0xFFFFFF
    let r = (value & 0x00FF0000) >> 16
    let g = (value & 0x0000FF00) >> 8
    let b = (value & 0x000000FF)
    return creator(convert(r), convert(g), convert(b), alpha)
}

#if os(iOS)
extension UIColor {
    public static func hex(_ value: UInt32) -> UIColor {
        return hexColor(value, creator: UIColor.init(red:green:blue:alpha:))
    }

    public static func hex(_ value: UInt32, alpha: CGFloat) -> UIColor {
        return hexColor(value, alpha: alpha, creator: UIColor.init(red:green:blue:alpha:))
    }

#if DEBUG
    public static var random: UIColor {
        return UIColor.hex(arc4random_uniform(0xFFFFFF))
    }
#endif
}
#else
extension NSColor {
    public static func hex(value: UInt32) -> NSColor {
        return hexColor(hex, creator: NSColor.init(red:green:blue:alpha:))
    }

    public static func hex(_ value: UInt32, alpha: CGFloat) -> UIColor {
        return hexColor(value, alpha: alpha, creator: NSColor.init(red:green:blue:alpha:))
    }
}

extension CGColor {
    public static func hex(value: UInt32) -> CGColor {
        return hexColor(hex, creator: CGColor.init(red:green:blue:alpha:))
    }

    public static func hex(_ value: UInt32, alpha: CGFloat) -> UIColor {
        return hexColor(value, alpha: alpha, creator: CGColor.init(red:green:blue:alpha:))
    }
}
#endif

#if os(iOS) && DEBUG
extension UIView {
    public func randomBackgroundColor() {
        backgroundColor = UIColor.random
    }
}

extension CALayer {
    public func randomBackgroundColor() {
        backgroundColor = UIColor.random.cgColor
    }
}
#endif
