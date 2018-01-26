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
import UIKit

public enum StyleValue: Equatable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    case length(Double)
    case percentage(Double)
    case auto

    internal var valid: Bool {
        switch self {
        case .length(let l), .percentage(let l):
            return !l.isNaN
        default:
            return true
        }
    }

    public static var match: StyleValue {
        return StyleValue.percentage(100)
    }

    // ExpressibleByIntegerLiteral
    public init(integerLiteral value: Int) {
        self = StyleValue.length(Double(value))
    }

    // ExpressibleByFloatLiteral
    public init(floatLiteral value: Double) {
        if value.isNaN {
            self = StyleValue.auto
        } else if value < 1 && value > -1 && value != 0 {
            self = StyleValue.percentage(value * 100)
        } else {
            self = StyleValue.length(value)
        }
    }

    // YGNodeResolveFlexBasisPtr
    func resolve(by value: Double) -> Double {
        switch self {
        case .auto:
            return Double.nan
        case .length(let l):
            return l
        case .percentage(let p):
            return p * value / 100
        }
    }

    func isDefined(size: Double) -> Bool {
        switch self {
        case .auto:
            return false
        case .length(let l):
            return l >= 0.0
        case .percentage(let p):
            return !size.isNaN && p >= 0.0
        }
    }

    static func makeLength(_ value: Double?) -> StyleValue? {
        guard let v = value else {
            return nil
        }
        return StyleValue.length(v)
    }

    // MARK: Equatable
    public static func ==(lhs: StyleValue, rhs: StyleValue) -> Bool {
        switch (lhs, rhs) {
        case (.auto, .auto):
            return true
        case (.length(let a), .length(let b)), (.percentage(let a), .percentage(let b)):
            return equal(a, b)
        default:
            return false
        }
    }

    public static func +(lhs: StyleValue, rhs: StyleValue) -> StyleValue {
        switch (lhs, rhs) {
        case (.auto, .auto):
            return .auto
        case (.length(let a), .length(let b)):
            return .length(a + b)
        case (.percentage(let a), .percentage(let b)):
            return .percentage(a + b)
        default: // error
            return .length(0)
        }
    }

    public static func -(lhs: StyleValue, rhs: StyleValue) -> StyleValue {
        switch (lhs, rhs) {
        case (.auto, .auto):
            return .auto
        case (.length(let a), .length(let b)):
            return .length(a - b)
        case (.percentage(let a), .percentage(let b)):
            return .percentage(a - b)
        default: // error
            return .length(0)
        }
    }
}

public struct StyleInsets: Equatable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public static let zero: StyleInsets = StyleInsets(0)

    public var top: StyleValue
    public var bottom: StyleValue
    public var left: StyleValue
    public var right: StyleValue
    public var leading: StyleValue?
    public var trailing: StyleValue?

    public init(_ value: StyleValue) {
        top = value
        bottom = value
        left = value
        right = value
        leading = nil
        trailing = nil
    }

    public init(vertical: StyleValue, horizontal: StyleValue) {
        top = vertical
        bottom = vertical
        left = horizontal
        right = horizontal
        leading = horizontal
        trailing = horizontal
    }

    public init(top: StyleValue, left: StyleValue, bottom: StyleValue, right: StyleValue) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
        leading = nil
        trailing = nil
    }

    public init(top: StyleValue, bottom: StyleValue, leading: StyleValue?, trailing: StyleValue?) {
        self.top = top
        self.bottom = bottom
        self.leading = leading
        self.trailing = trailing
        left = 0
        right = 0
    }

    // ExpressibleByFloatLiteral
    public init(floatLiteral value: Double) {
        self.init(StyleValue(floatLiteral: value))
    }

    // ExpressibleByIntegerLiteral
    public init(integerLiteral value: Int) {
        self.init(StyleValue(integerLiteral: value))
    }

    // YGMarginLeadingValue
    public func leading(direction: FlexDirection) -> StyleValue {
        switch direction {
        case .row:
            return self.leading ?? left
        case .rowReverse:
            return self.leading ?? right
        case .column:
            return top
        case .columnReverse:
            return bottom
        }
    }

    // YGMarginTrailingValue
    public func trailing(direction: FlexDirection) -> StyleValue {
        switch direction {
        case .row:
            return self.trailing ?? right
        case .rowReverse:
            return self.trailing ?? left
        case .column:
            return bottom
        case .columnReverse:
            return top
        }
    }

    public func total(direction: FlexDirection) -> StyleValue {
        switch direction {
        case .row:
            return (leading ?? left) + (trailing ?? right)
        case .rowReverse:
            return (leading ?? right) + (trailing ?? left)
        case .column, .columnReverse:
            return top + bottom
        }
    }

    // FIXME: leading != left
    public var edgeInsets: UIEdgeInsets {
        return UIEdgeInsets.zero //(top: CGFloat(top), left: CGFloat(leading ?? left),
        // bottom: CGFloat(bottom), right: CGFloat(trailing ?? right))
    }

    public static func ==(lhs: StyleInsets, rhs: StyleInsets) -> Bool {
        return lhs.left == rhs.left && lhs.right == rhs.right &&
            lhs.top == rhs.top && lhs.bottom == rhs.bottom &&
            lhs.leading == rhs.leading && lhs.trailing == rhs.trailing
    }
}

struct LayoutInsets {
    static let zero: LayoutInsets = LayoutInsets(0)

    var top: Double
    var bottom: Double
    var left: Double
    var right: Double

    init(_ value: Double) {
        top = value
        bottom = value
        left = value
        right = value
    }

    init(top: Double, left: Double, bottom: Double, right: Double) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
}

public struct Position: Equatable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public static let zero: Position = Position(StyleValue.auto)

    var top: StyleValue
    var bottom: StyleValue
    var left: StyleValue
    var right: StyleValue
    var leading: StyleValue?
    var trailing: StyleValue?

    public init(_ value: StyleValue) {
        top = value
        bottom = value
        left = value
        right = value
        leading = nil
        trailing = nil
    }

    public init(vertical: StyleValue, horizontal: StyleValue) {
        top = vertical
        bottom = vertical
        left = horizontal
        right = horizontal
        leading = horizontal
        trailing = horizontal
    }

    public init(top: StyleValue, left: StyleValue, bottom: StyleValue, right: StyleValue) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
        leading = nil
        trailing = nil
    }

    public init(top: StyleValue, bottom: StyleValue, leading: StyleValue?, trailing: StyleValue?) {
        self.top = top
        self.bottom = bottom
        self.leading = leading
        self.trailing = trailing
        left = StyleValue.auto
        right = StyleValue.auto
    }

    // ExpressibleByFloatLiteral
    public init(floatLiteral value: Double) {
        self.init(StyleValue(floatLiteral: value))
    }

    // ExpressibleByIntegerLiteral
    public init(integerLiteral value: Int) {
        self.init(StyleValue(integerLiteral: value))
    }

    public func leading(direction: FlexDirection) -> StyleValue {
        switch direction {
        case .row:
            return self.leading ?? left
        case .rowReverse:
            return self.leading ?? right
        case .column:
            return top
        case .columnReverse:
            return bottom
        }
    }

    public func trailing(direction: FlexDirection) -> StyleValue {
        switch direction {
        case .row:
            return self.trailing ?? right
        case .rowReverse:
            return self.trailing ?? left
        case .column:
            return bottom
        case .columnReverse:
            return top
        }
    }

    public func total(direction: FlexDirection) -> StyleValue {
        switch direction {
        case .row:
            return (leading ?? left) + (trailing ?? right)
        case .rowReverse:
            return (leading ?? right) + (trailing ?? left)
        case .column, .columnReverse:
            return top + bottom
        }
    }

    public static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs.left == rhs.left && lhs.right == rhs.right &&
            lhs.top == rhs.top && lhs.bottom == rhs.bottom &&
            lhs.leading == rhs.leading && lhs.trailing == rhs.trailing
    }
}

public enum Direction {
    case inherit
    case ltr
    case rtl
}

public enum Display {
    case flex // default
    case none
}

public enum PositionType {
    case relative // default
    case absolute
}

public enum Overflow {
    case visible // default
    case hidden
    case scroll

    var scrolled: Bool {
        return self == Overflow.scroll
    }
}

public enum FlexDirection {
    case row // default
    case column
    case rowReverse
    case columnReverse

    var isRow: Bool {
        return self == FlexDirection.row || self == FlexDirection.rowReverse
    }

    var isColumn: Bool {
        return self == FlexDirection.column || self == FlexDirection.columnReverse
    }

    var reversed: Bool {
        return self == FlexDirection.rowReverse || self == FlexDirection.columnReverse
    }

    // YGResolveFlexDirection
    func resolve(by direction: Direction) -> FlexDirection {
        if direction == Direction.rtl {
            if self == .row {
                return .rowReverse
            } else if self == .rowReverse {
                return .row
            }
        }
        return self
    }

    func cross(by direction: Direction) -> FlexDirection {
        return isColumn ? FlexDirection.row.resolve(by: direction) : .column
    }
}

public enum FlexWrap {
    case nowrap // default
    case wrap
    case wrapReverse
}

// No support with FlexBasis.Content
public typealias FlexBasis = StyleValue

public struct Flex: Equatable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public static let none: Flex = Flex(grow: 0, shrink: 0, basis: .auto)
    public static let `default`: Flex = Flex(grow: 0, shrink: 1, basis: .auto)
    public static let auto: Flex = Flex(grow: 1, shrink: 1, basis: .auto)

    public var grow: Double
    public var shrink: Double
    public var basis: FlexBasis

    public init(grow: Double, shrink: Double = 1, basis: FlexBasis = .auto) {
        self.grow = grow
        self.shrink = shrink
        self.basis = basis
    }

    // ExpressibleByFloatLiteral
    public init(floatLiteral value: Double) {
        if value < 0 {
            // TODO: https://www.w3.org/TR/css-flexbox-1/#flex-common
            // web => default/none; yoga => -value
            self.init(grow: 0, shrink: -value, basis: .auto)
            // self.init(grow: 0, shrink: 0, basis: .auto) // none
        } else {
            self.init(grow: value, shrink: 1, basis: .length(0))
        }
    }

    // ExpressibleByIntegerLiteral
    public init(integerLiteral value: Int) {
        self.init(floatLiteral: Double(value))
    }

    public static func ==(lhs: Flex, rhs: Flex) -> Bool {
        return equal(lhs.grow, rhs.grow) &&
            equal(lhs.shrink, rhs.shrink) &&
            lhs.basis == rhs.basis
    }
}

public enum JustifyContent {
    case flexStart // default
    case flexEnd
    case center
    case spaceBetween
    case spaceAround
    case spaceEvenly
}

public enum AlignItems {
    case flexStart
    case flexEnd
    case center
    case baseline
    case stretch // default
}

public enum AlignSelf {
    case auto // default
    case flexStart
    case flexEnd
    case center
    case baseline
    case stretch

    var alignItems: AlignItems? {
        switch self {
        case .auto:
            return nil
        case .flexStart:
            return .flexStart
        case .flexEnd:
            return .flexEnd
        case .center:
            return .center
        case .baseline:
            return .baseline
        case .stretch:
            return .stretch
        }
    }
}

public enum AlignContent {
    case flexStart
    case flexEnd
    case center
    case spaceBetween
    case spaceAround
    case stretch // default
}

public enum LayoutType {
    case `default`
    case text
}

public enum MeasureMode {
    case undefined
    case exactly
    case atMost

    public var isExactly: Bool {
        return self == MeasureMode.exactly
    }

    public var isUndefined: Bool {
        return self == MeasureMode.undefined
    }

    public var isAtMost: Bool {
        return self == MeasureMode.atMost
    }

    public func resolve<T: FloatingPoint>(_ value: T) -> T {
        return isUndefined ? T.greatestFiniteMagnitude : value
    }
}

struct LayoutPosition {
    static let zero: LayoutPosition = LayoutPosition(top: 0, left: 0, bottom: 0, right: 0)

    var top: Double
    var left: Double
    var bottom: Double
    var right: Double

    subscript(direction: FlexDirection) -> Double {
        get {
            switch direction {
            case .column:
                return top
            case .row:
                return left
            case .rowReverse:
                return right
            case .columnReverse:
                return bottom
            }
        }
        set {
            switch direction {
            case .column:
                top = newValue
            case .row:
                left = newValue
            case .rowReverse:
                right = newValue
            case .columnReverse:
                bottom = newValue
            }
        }
    }

    func leading(direction: FlexDirection) -> Double {
        switch direction {
        case .column:
            return top
        case .row:
            return left
        case .rowReverse:
            return right
        case .columnReverse:
            return bottom
        }
    }

    mutating func setLeading(direction: FlexDirection, size: Double) {
        switch direction {
        case .column:
            top = size
        case .row:
            left = size
        case .rowReverse:
            right = size
        case .columnReverse:
            bottom = size
        }
    }

    func trailing(direction: FlexDirection) -> Double {
        switch direction {
        case .column:
            return bottom
        case .row:
            return right
        case .rowReverse:
            return left
        case .columnReverse:
            return top
        }
    }

    mutating func setTrailing(direction: FlexDirection, size: Double) {
        switch direction {
        case .column:
            bottom = size
        case .row:
            right = size
        case .rowReverse:
            left = size
        case .columnReverse:
            top = size
        }
    }
}

struct LayoutCache {
    let width: Double
    let height: Double
    let computedWidth: Double
    let computedHeight: Double
    let widthMode: MeasureMode
    let heightMode: MeasureMode

    func isEqual(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode) -> Bool {
        return equal(self.width, width) && equal(self.height, height) &&
            self.widthMode == widthMode && self.heightMode == heightMode
    }

    func validate(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode,
                  marginRow: Double, marginColumn: Double, scale: Double) -> Bool {
        if computedWidth < 0 || computedHeight < 0 {
            return false
        }
        let rounded = scale != 0
        let _width = rounded ? FlexBox.round(width, scale: scale, ceil: false, floor: false) : width
        let _height = rounded ? FlexBox.round(height, scale: scale, ceil: false, floor: false) : height
        let lastWidth = rounded ? FlexBox.round(self.width, scale: scale, ceil: false, floor: false) : self.width
        let lastHeight = rounded ? FlexBox.round(self.height, scale: scale, ceil: false, floor: false) : self.height

        let sameWidth = self.widthMode == widthMode && equal(_width, lastWidth)
        let sameWidth2 = LayoutCache.validateSize(mode: widthMode, size: width - marginRow,
            lastMode: self.widthMode, lastSize: self.width, computedSize: self.computedWidth)
        let sameHeight = self.heightMode == heightMode && equal(_height, lastHeight)
        let sameHeight2 = LayoutCache.validateSize(mode: heightMode, size: height - marginColumn,
            lastMode: self.heightMode, lastSize: self.height, computedSize: self.computedHeight)
        return (sameWidth || sameWidth2) && (sameHeight || sameHeight2)
    }

    static func validateSize(mode: MeasureMode, size: Double, lastMode: MeasureMode,
                             lastSize: Double, computedSize: Double) -> Bool {
        switch mode {
        case .exactly:
            return equal(size, computedSize)
        case .atMost:
            switch lastMode {
            case .undefined:
                return (size >= computedSize || equal(size, computedSize))
            case .atMost:
                return (lastSize > size && (computedSize <= size || equal(size, computedSize)))
            case .exactly:
                return false
            }
        case .undefined:
            return false
        }
    }
}

func inner<T: Comparable>(_ value: T, min: T, max: T) -> T {
    return Swift.max(Swift.min(value, max), min)
}

func inner<T: Comparable>(_ value: T, min: T?, max: T?) -> T {
    var r = value
    if let max = max {
        r = Swift.min(r, max)
    }
    if let min = min {
        r = Swift.max(r, min)
    }
    return r
}

func equal(_ lhs: Double, _ rhs: Double) -> Bool {
    if lhs.isNaN {
        return rhs.isNaN
    }
    return abs(lhs - rhs) < 0.0001
}
