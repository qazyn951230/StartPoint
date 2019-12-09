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

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

import CoreGraphics
import QuartzCore

@inline(__always)
fileprivate func convert(_ value: UInt32) -> CGFloat {
    CGFloat(value) / CGFloat(255.0)
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
fileprivate func hexColor<T>(_ value: UInt32, alpha: CGFloat,
                             creator: (CGFloat, CGFloat, CGFloat, CGFloat) -> T) -> T {
    let value = value < 0xFFFFFF ? value : 0xFFFFFF
    let r = (value & 0x00FF0000) >> 16
    let g = (value & 0x0000FF00) >> 8
    let b = (value & 0x000000FF)
    return creator(convert(r), convert(g), convert(b), alpha)
}

#if canImport(UIKit)

public extension UIColor {
    @inlinable
    static func hex(_ value: UInt32) -> UIColor {
        hexColor(value, creator: UIColor.init(red:green:blue:alpha:))
    }

    @inlinable
    static func hex(_ value: UInt32, alpha: CGFloat) -> UIColor {
        hexColor(value, alpha: alpha, creator: UIColor.init(red:green:blue:alpha:))
    }

    @inlinable
    func rgba() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        _  = self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }

    @inlinable
    func rgbaHex() -> UInt32 {
        let (r, g, b, a) = self.rgba()
        var value: UInt32 = UInt32(a * 255) << 24
        value += UInt32(r * 255) << 16
        value += UInt32(g * 255) << 8
        value += UInt32(b * 255)
        return value
    }

    @inlinable
    static var random: UIColor {
        UIColor.hex(UInt32.random(in: 0...0xFFFFFF))
    }
}

public extension CGColor {
    @inlinable
    static func hex(_ value: UInt32) -> CGColor {
        UIColor.hex(value).cgColor
    }

    @inlinable
    static func hex(_ value: UInt32, alpha: CGFloat) -> CGColor {
        UIColor.hex(value, alpha: alpha).cgColor
    }
}


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

extension Element {
    @discardableResult
    public func randomBackgroundColor() -> Self {
        backgroundColor(UIColor.random)
    }
}

extension BasicLayerElement {
    @discardableResult
    public func randomBackgroundColor() -> Self {
        backgroundColor(UIColor.random)
    }
}

#endif // canImport(UIKit)

#if canImport(AppKit)

public extension NSColor {
    static func hex(_ value: UInt32) -> NSColor {
        hexColor(value, creator: NSColor.init(red:green:blue:alpha:))
    }

    static func hex(_ value: UInt32, alpha: CGFloat) -> NSColor {
        hexColor(value, alpha: alpha, creator: NSColor.init(red:green:blue:alpha:))
    }

    static var random: NSColor {
        NSColor.hex(UInt32.random(in: 0...0xFFFFFF))
    }
}

public extension CGColor {
    static func hex(_ value: UInt32) -> CGColor {
        hexColor(value, creator: CGColor.init(red:green:blue:alpha:))
    }

    static func hex(_ value: UInt32, alpha: CGFloat) -> CGColor {
        hexColor(value, alpha: alpha, creator: CGColor.init(red:green:blue:alpha:))
    }

    static var random: CGColor {
        CGColor.hex(UInt32.random(in: 0...0xFFFFFF))
    }
}

#endif // canImport(AppKit)
