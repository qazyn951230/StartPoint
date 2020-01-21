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

import Foundation
#if canImport(Cocoa)
import Cocoa
#endif
#if canImport(UIKit)
import UIKit
#endif // canImport(UIKit)

public enum LigatureLevel: Int {
    case none = 0
    case first = 1
#if os(macOS)
    case second = 2 // Value 2 is unsupported on iOS.
#endif
}

public final class AttributedString {
    let string: NSMutableAttributedString
    public private(set) var attributes: [NSAttributedString.Key: Any]
    public private(set) var wholeRange: NSRange

    public init(_ string: String) {
        self.string = NSMutableAttributedString(string: string)
        wholeRange = NSRange(location: 0, length: self.string.length)
        attributes = [:]
    }

    public convenience init?(any: String?) {
        guard let value = any else {
            return nil
        }
        self.init(value)
    }

    // Note: If `range != nil`, we can't store it in `attributes`.
    // Apply partial attributes will cause ERROR.
    public func setAttribute(key: NSAttributedString.Key, value: Any?,
                             range: NSRange? = nil) -> AttributedString {
        if range == nil {
            attributes[key] = value
        }
        if let value = value {
            string.addAttribute(key, value: value, range: range ?? wholeRange)
        } else {
            string.removeAttribute(key, range: range ?? wholeRange)
        }
        return self
    }

    public func append(_ other: NSAttributedString) -> AttributedString {
        string.append(other)
        wholeRange = NSRange(location: 0, length: string.length)
        return self
    }

    public func append(_ other: AttributedString) -> AttributedString {
        string.append(other.done())
        wholeRange = NSRange(location: 0, length: string.length)
        return self
    }

    public func done() -> NSMutableAttributedString {
        return string
    }

    public func build(_ string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string, attributes: attributes)
    }

    public static func template() -> AttributedString {
        return AttributedString(String.empty)
    }
}

#if os(iOS)
extension AttributedString {
    @discardableResult
    public func font(_ value: UIFont, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.font, value: value, range: range)
    }

    @discardableResult
    public func systemFont(_ size: CGFloat, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: size), range: range)
    }

    @discardableResult
    public func systemFont(_ size: CGFloat, weight: UIFont.Weight, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: size, weight: weight),
            range: range)
    }

    @discardableResult
    public func paragraphStyle(_ value: NSParagraphStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.paragraphStyle, value: value, range: range)
    }

    @discardableResult
    public func color(_ value: UIColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.foregroundColor, value: value, range: range)
    }

    @discardableResult
    public func color(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.foregroundColor, value: UIColor.hex(hex), range: range)
    }

    @discardableResult
    public func backgroundColor(_ value: UIColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.backgroundColor, value: value, range: range)
    }

    @discardableResult
    public func backgroundColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.backgroundColor, value: UIColor.hex(hex), range: range)
    }

    @discardableResult
    public func ligature(_ value: LigatureLevel, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.ligature, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func kern(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.kern, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func strikethroughStyle(_ value: NSUnderlineStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func underlineStyle(_ value: NSUnderlineStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.underlineStyle, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func strokeColor(_ value: UIColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strokeColor, value: value, range: range)
    }

    @discardableResult
    public func strokeColor(_ hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strokeColor, value: UIColor.hex(hex), range: range)
    }

    @discardableResult
    public func strokeWidth(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strokeWidth, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func shadow(_ value: NSShadow, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.shadow, value: value, range: range)
    }

    @discardableResult
    public func shadow(offset: CGSize, radius: CGFloat, color: UIColor, range: NSRange? = nil) -> AttributedString {
        let value = NSShadow()
        value.shadowOffset = offset
        value.shadowBlurRadius = radius
        value.shadowColor = color
        return setAttribute(key: NSAttributedString.Key.shadow, value: value, range: range)
    }

    @discardableResult
    public func shadow(alpha: CGFloat, blur: CGFloat, x: CGFloat, y: CGFloat, color: UIColor, range: NSRange? = nil)
            -> AttributedString {
        let value = NSShadow()
        value.shadowOffset = CGSize(width: x, height: y)
        value.shadowBlurRadius = blur
        value.shadowColor = color.withAlphaComponent(alpha)
        return setAttribute(key: NSAttributedString.Key.shadow, value: value, range: range)
    }

    @discardableResult
    public func shadow(alpha: CGFloat, blur: CGFloat, x: CGFloat, y: CGFloat, hex: UInt32, range: NSRange? = nil)
            -> AttributedString {
        let value = NSShadow()
        value.shadowOffset = CGSize(width: x, height: y)
        value.shadowBlurRadius = blur
        value.shadowColor = UIColor.hex(hex).withAlphaComponent(alpha)
        return setAttribute(key: NSAttributedString.Key.shadow, value: value, range: range)
    }

    @discardableResult
    public func textEffect(_ value: NSAttributedString.TextEffectStyle = NSAttributedString.TextEffectStyle.letterpressStyle,
                           range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.textEffect, value: value, range: range)
    }

    @discardableResult
    public func attachment(_ value: NSTextAttachment, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.attachment, value: value, range: range)
    }

    @discardableResult
    public func link(url: URL, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.link, value: url, range: range)
    }

    @discardableResult
    public func link(_ value: String, range: NSRange? = nil) -> AttributedString {
        guard let url = URL(string: value) else {
            Log.error("\(value) is not valid URL")
            return self
        }
        return setAttribute(key: NSAttributedString.Key.link, value: url, range: range)
    }

    @discardableResult
    public func baselineOffset(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.baselineOffset, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func underlineColor(_ value: UIColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.underlineColor, value: value, range: range)
    }

    @discardableResult
    public func underlineColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.underlineColor, value: UIColor.hex(hex), range: range)
    }

    @discardableResult
    public func strikethroughColor(_ value: UIColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strikethroughColor, value: value, range: range)
    }

    @discardableResult
    public func strikethroughColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strikethroughColor, value: UIColor.hex(hex), range: range)
    }

    @discardableResult
    public func obliqueness(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.obliqueness, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func expansion(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.expansion, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func writingDirection(_ writingDirection: NSWritingDirection,
                                 text textWritingDirection: NSWritingDirectionFormatType,
                                 range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.writingDirection,
            value: [writingDirection.rawValue | textWritingDirection.rawValue],
            range: range)
    }
}
#elseif os(macOS)
extension AttributedString {
    @discardableResult
    public func font(_ value: NSFont, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.font, value: value, range: range)
    }

    @discardableResult
    public func systemFont(_ size: CGFloat, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.font, value: NSFont.systemFont(ofSize: size), range: range)
    }

    @discardableResult
    public func systemFont(_ size: CGFloat, weight: NSFont.Weight, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.font,
            value: NSFont.systemFont(ofSize: size, weight: weight),
            range: range)
    }

    @discardableResult
    public func paragraphStyle(_ value: NSParagraphStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.paragraphStyle, value: value, range: range)
    }

    @discardableResult
    public func color(_ value: NSColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.foregroundColor, value: value, range: range)
    }

    @discardableResult
    public func color(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.foregroundColor, value: NSColor.hex(hex), range: range)
    }

    @discardableResult
    public func backgroundColor(_ value: NSColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.backgroundColor, value: value, range: range)
    }

    @discardableResult
    public func backgroundColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.backgroundColor, value: NSColor.hex(hex), range: range)
    }

    @discardableResult
    public func ligature(_ value: LigatureLevel, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.ligature, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func kern(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.kern, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func strikethroughStyle(_ value: NSUnderlineStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func underlineStyle(_ value: NSUnderlineStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.underlineStyle, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func strokeColor(_ value: NSColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strokeColor, value: value, range: range)
    }

    @discardableResult
    public func strokeColor(_ hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strokeColor, value: NSColor.hex(hex), range: range)
    }

    @discardableResult
    public func strokeWidth(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strokeWidth, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func shadow(_ value: NSShadow, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.shadow, value: value, range: range)
    }

    @discardableResult
    public func shadow(offset: CGSize, radius: CGFloat, color: NSColor, range: NSRange? = nil) -> AttributedString {
        let value = NSShadow()
        value.shadowOffset = offset
        value.shadowBlurRadius = radius
        value.shadowColor = color
        return setAttribute(key: NSAttributedString.Key.shadow, value: value, range: range)
    }

    @discardableResult
    public func shadow(alpha: CGFloat, blur: CGFloat, x: CGFloat, y: CGFloat, color: NSColor, range: NSRange? = nil)
            -> AttributedString {
        let value = NSShadow()
        value.shadowOffset = CGSize(width: x, height: y)
        value.shadowBlurRadius = blur
        value.shadowColor = color.withAlphaComponent(alpha)
        return setAttribute(key: NSAttributedString.Key.shadow, value: value, range: range)
    }

    @discardableResult
    public func shadow(alpha: CGFloat, blur: CGFloat, x: CGFloat, y: CGFloat, hex: UInt32, range: NSRange? = nil)
            -> AttributedString {
        let value = NSShadow()
        value.shadowOffset = CGSize(width: x, height: y)
        value.shadowBlurRadius = blur
        value.shadowColor = NSColor.hex(hex).withAlphaComponent(alpha)
        return setAttribute(key: NSAttributedString.Key.shadow, value: value, range: range)
    }

    @discardableResult
    public func textEffect(_ value: NSAttributedString.TextEffectStyle = NSAttributedString.TextEffectStyle.letterpressStyle,
                           range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.textEffect, value: value, range: range)
    }

    @discardableResult
    public func attachment(_ value: NSTextAttachment, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.attachment, value: value, range: range)
    }

    @discardableResult
    public func link(url: URL, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.link, value: url, range: range)
    }

    @discardableResult
    public func link(_ value: String, range: NSRange? = nil) -> AttributedString {
        guard let url = URL(string: value) else {
            Log.error("\(value) is not valid URL")
            return self
        }
        return setAttribute(key: NSAttributedString.Key.link, value: url, range: range)
    }

    @discardableResult
    public func baselineOffset(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.baselineOffset, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func underlineColor(_ value: NSColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.underlineColor, value: value, range: range)
    }

    @discardableResult
    public func underlineColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.underlineColor, value: NSColor.hex(hex), range: range)
    }

    @discardableResult
    public func strikethroughColor(_ value: NSColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strikethroughColor, value: value, range: range)
    }

    @discardableResult
    public func strikethroughColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.strikethroughColor, value: NSColor.hex(hex), range: range)
    }

    @discardableResult
    public func obliqueness(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.obliqueness, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func expansion(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.expansion, value: NSNumber(value: value), range: range)
    }

//    @discardableResult
//    public func writingDirection(_ writingDirection: NSWritingDirection,
//                                 text textWritingDirection: NSTextWritingDirection,
//                                 range: NSRange? = nil) -> AttributedString {
//        return setAttribute(key: NSAttributedString.Key.writingDirection,
//            value: [writingDirection.rawValue | textWritingDirection.rawValue],
//            range: range)
//    }

    @discardableResult
    public func verticalGlyphForm(_ value: Int, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedString.Key.verticalGlyphForm, value: NSNumber(value: value), range: range)
    }
}
#endif
