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

public enum FontWeight {
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black

    @available(iOS 8.2, *)
    public var weight: UIFont.Weight {
        switch self {
        case .ultraLight:
            return UIFont.Weight.ultraLight
        case .thin:
            return UIFont.Weight.thin
        case .light:
            return UIFont.Weight.light
        case .regular:
            return UIFont.Weight.regular
        case .medium:
            return UIFont.Weight.medium
        case .semibold:
            return UIFont.Weight.semibold
        case .bold:
            return UIFont.Weight.bold
        case .heavy:
            return UIFont.Weight.heavy
        case .black:
            return UIFont.Weight.black
        }
    }
}
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
    public private(set) var attributes: [NSAttributedStringKey: Any]
    public private(set) var wholeRange: NSRange

    public init(_ string: String) {
        self.string = NSMutableAttributedString(string: string)
        wholeRange = NSRange(location: 0, length: string.count)
        attributes = [:]
    }

    public convenience init?(any: String?) {
        guard let value = any else {
            return nil
        }
        self.init(value)
    }

    public func setAttribute(key: NSAttributedStringKey, value: Any?,
                             range: NSRange? = nil) -> AttributedString {
        attributes[key] = value
        if let value = value {
            string.addAttribute(key, value: value, range: range ?? wholeRange)
        } else {
            string.removeAttribute(key, range: range ?? wholeRange)
        }
        return self
    }

    public func append(_ attrString: NSAttributedString) -> AttributedString {
        string.append(attrString)
        wholeRange = NSRange(location: 0, length: string.length)
        return self
    }

    public func append(_ attrString: AttributedString) -> AttributedString {
        string.append(attrString.done())
        wholeRange = NSRange(location: 0, length: string.length)
        return self
    }

    public func done() -> NSMutableAttributedString {
        return string
    }

    public func build(_ string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string, attributes: attributes)
    }

    public static func template(_ string: String?) -> AttributedString {
        return AttributedString(String.empty)
    }
}

#if os(iOS)
extension AttributedString {
    @discardableResult
    public func font(_ value: UIFont, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.font, value: value, range: range)
    }

    @discardableResult
    public func systemFont(_ size: LayoutValue, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: size.value), range: range)
    }

    @discardableResult
    public func systemFont(_ size: LayoutValue, weight: FontWeight, range: NSRange? = nil) -> AttributedString {
        if #available(iOS 8.2, *) {
            return setAttribute(key: NSAttributedStringKey.font,
                value: UIFont.systemFont(ofSize: size.value, weight: weight.weight),
                range: range)
        } else {
            return systemFont(size, range: range)
        }
    }

    @discardableResult
    public func paragraphStyle(_ value: NSParagraphStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.paragraphStyle, value: value, range: range)
    }

    @discardableResult
    public func color(_ value: UIColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.foregroundColor, value: value, range: range)
    }

    @discardableResult
    public func color(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.foregroundColor, value: UIColor.hex(hex), range: range)
    }

    @discardableResult
    public func backgroundColor(_ value: UIColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.backgroundColor, value: value, range: range)
    }

    @discardableResult
    public func backgroundColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.backgroundColor, value: UIColor.hex(hex), range: range)
    }

    @discardableResult
    public func ligature(_ value: LigatureLevel, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.ligature, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func kern(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.kern, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func strikethroughStyle(_ value: NSUnderlineStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strikethroughStyle, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func underlineStyle(_ value: NSUnderlineStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.underlineStyle, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func strokeColor(_ value: UIColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strokeColor, value: value, range: range)
    }

    @discardableResult
    public func strokeColor(_ hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strokeColor, value: UIColor.hex(hex), range: range)
    }

    @discardableResult
    public func strokeWidth(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strokeWidth, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func shadow(_ value: NSShadow, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.shadow, value: value, range: range)
    }

    @discardableResult
    public func shadow(offset: CGSize, radius: LayoutValue, color: UIColor, range: NSRange? = nil) -> AttributedString {
        let t = NSShadow()
        t.shadowOffset = offset
        t.shadowBlurRadius = radius.value
        t.shadowColor = color
        return setAttribute(key: NSAttributedStringKey.shadow, value: t, range: range)
    }

    @discardableResult
    public func shadow(alpha: CGFloat, blur: CGFloat, x: CGFloat, y: CGFloat, color: UIColor, range: NSRange? = nil)
            -> AttributedString {
        let t = NSShadow()
        t.shadowOffset = CGSize(width: x, height: y)
        t.shadowBlurRadius = blur
        t.shadowColor = color.withAlphaComponent(alpha)
        return setAttribute(key: NSAttributedStringKey.shadow, value: t, range: range)
    }

    @discardableResult
    public func shadow(alpha: CGFloat, blur: CGFloat, x: CGFloat, y: CGFloat, hex: UInt32, range: NSRange? = nil)
            -> AttributedString {
        let t = NSShadow()
        t.shadowOffset = CGSize(width: x, height: y)
        t.shadowBlurRadius = blur
        t.shadowColor = UIColor.hex(hex).withAlphaComponent(alpha)
        return setAttribute(key: NSAttributedStringKey.shadow, value: t, range: range)
    }

    @discardableResult
    public func textEffect(_ value: NSAttributedString.TextEffectStyle = NSAttributedString.TextEffectStyle.letterpressStyle,
                           range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.textEffect, value: value, range: range)
    }

    @discardableResult
    public func attachment(_ value: NSTextAttachment, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.attachment, value: value, range: range)
    }

    @discardableResult
    public func link(url: URL, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.link, value: url, range: range)
    }

    @discardableResult
    public func link(_ value: String, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.link, value: URL(string: value), range: range)
    }

    @discardableResult
    public func baselineOffset(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.baselineOffset, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func underlineColor(_ value: UIColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.underlineColor, value: value, range: range)
    }

    @discardableResult
    public func underlineColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.underlineColor, value: UIColor.hex(hex), range: range)
    }

    @discardableResult
    public func strikethroughColor(_ value: UIColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strikethroughColor, value: value, range: range)
    }

    @discardableResult
    public func strikethroughColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strikethroughColor, value: UIColor.hex(hex), range: range)
    }

    @discardableResult
    public func obliqueness(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.obliqueness, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func expansion(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.expansion, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func writingDirection(_ writingDirection: NSWritingDirection,
                                 text textWritingDirection: NSWritingDirectionFormatType,
                                 range: NSRange? = nil) -> AttributedString {
        // TODO: NSWritingDirectionFormatType iOS 9 test
        return setAttribute(key: NSAttributedStringKey.writingDirection,
            value: [writingDirection.rawValue | textWritingDirection.rawValue],
            range: range)
    }
}
#elseif os(macOS)
extension AttributedString {
    @discardableResult
    public func font(_ value: NSFont, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.font, value: value, range: range)
    }

    @discardableResult
    public func systemFont(_ size: LayoutValue, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.font, value: NSFont.systemFont(ofSize: size.value), range: range)
    }

    @discardableResult
    public func systemFont(_ size: LayoutValue, weight: NSFont.Weight, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.font,
            value: NSFont.systemFont(ofSize: size.value, weight: weight),
            range: range)
    }

    @discardableResult
    public func paragraphStyle(_ value: NSParagraphStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.paragraphStyle, value: value, range: range)
    }

    @discardableResult
    public func color(_ value: NSColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.foregroundColor, value: value, range: range)
    }

    @discardableResult
    public func color(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.foregroundColor, value: NSColor.hex(hex), range: range)
    }

    @discardableResult
    public func backgroundColor(_ value: NSColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.backgroundColor, value: value, range: range)
    }

    @discardableResult
    public func backgroundColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.backgroundColor, value: NSColor.hex(hex), range: range)
    }

    @discardableResult
    public func ligature(_ value: LigatureLevel, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.ligature, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func kern(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.kern, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func strikethroughStyle(_ value: NSUnderlineStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strikethroughStyle, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func underlineStyle(_ value: NSUnderlineStyle, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.underlineStyle, value: NSNumber(value: value.rawValue), range: range)
    }

    @discardableResult
    public func strokeColor(_ value: NSColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strokeColor, value: value, range: range)
    }

    @discardableResult
    public func strokeColor(_ hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strokeColor, value: NSColor.hex(hex), range: range)
    }

    @discardableResult
    public func strokeWidth(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strokeWidth, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func shadow(_ value: NSShadow, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.shadow, value: value, range: range)
    }

    @discardableResult
    public func shadow(offset: CGSize, radius: LayoutValue, color: NSColor, range: NSRange? = nil) -> AttributedString {
        let t = NSShadow()
        t.shadowOffset = offset
        t.shadowBlurRadius = radius.value
        t.shadowColor = color
        return setAttribute(key: NSAttributedStringKey.shadow, value: t, range: range)
    }

    @discardableResult
    public func shadow(alpha: CGFloat, blur: CGFloat, x: CGFloat, y: CGFloat, color: NSColor, range: NSRange? = nil)
            -> AttributedString {
        let t = NSShadow()
        t.shadowOffset = CGSize(width: x, height: y)
        t.shadowBlurRadius = blur
        t.shadowColor = color.withAlphaComponent(alpha)
        return setAttribute(key: NSAttributedStringKey.shadow, value: t, range: range)
    }

    @discardableResult
    public func shadow(alpha: CGFloat, blur: CGFloat, x: CGFloat, y: CGFloat, hex: UInt32, range: NSRange? = nil)
            -> AttributedString {
        let t = NSShadow()
        t.shadowOffset = CGSize(width: x, height: y)
        t.shadowBlurRadius = blur
        t.shadowColor = NSColor.hex(hex).withAlphaComponent(alpha)
        return setAttribute(key: NSAttributedStringKey.shadow, value: t, range: range)
    }

    @discardableResult
    public func textEffect(_ value: NSAttributedString.TextEffectStyle = NSAttributedString.TextEffectStyle.letterpressStyle,
                           range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.textEffect, value: value, range: range)
    }

    @discardableResult
    public func attachment(_ value: NSTextAttachment, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.attachment, value: value, range: range)
    }

    @discardableResult
    public func link(url: URL, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.link, value: url, range: range)
    }

    @discardableResult
    public func link(_ value: String, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.link, value: URL(string: value), range: range)
    }

    @discardableResult
    public func baselineOffset(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.baselineOffset, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func underlineColor(_ value: NSColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.underlineColor, value: value, range: range)
    }

    @discardableResult
    public func underlineColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.underlineColor, value: NSColor.hex(hex), range: range)
    }

    @discardableResult
    public func strikethroughColor(_ value: NSColor, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strikethroughColor, value: value, range: range)
    }

    @discardableResult
    public func strikethroughColor(hex: UInt32, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.strikethroughColor, value: NSColor.hex(hex), range: range)
    }

    @discardableResult
    public func obliqueness(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.obliqueness, value: NSNumber(value: value), range: range)
    }

    @discardableResult
    public func expansion(_ value: Double, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.expansion, value: NSNumber(value: value), range: range)
    }

//    @discardableResult
//    public func writingDirection(_ writingDirection: NSWritingDirection,
//                                 text textWritingDirection: NSTextWritingDirection,
//                                 range: NSRange? = nil) -> AttributedString {
//        return setAttribute(key: NSAttributedStringKey.writingDirection,
//            value: [writingDirection.rawValue | textWritingDirection.rawValue],
//            range: range)
//    }

    @discardableResult
    public func verticalGlyphForm(_ value: Int, range: NSRange? = nil) -> AttributedString {
        return setAttribute(key: NSAttributedStringKey.verticalGlyphForm, value: NSNumber(value: value), range: range)
    }
}
#endif
