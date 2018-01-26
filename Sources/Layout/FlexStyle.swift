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

// gYGNodeStyleDefaults
public class FlexStyle: Equatable {
    public init() {
        // Do nothing
    }

    public internal(set) var direction: Direction = .inherit
    public internal(set) var flexDirection: FlexDirection = .column
    public internal(set) var justifyContent: JustifyContent = .flexStart
    public internal(set) var alignContent: AlignContent = .flexStart
    public internal(set) var alignItems: AlignItems = .stretch
    public internal(set) var alignSelf: AlignSelf = .auto
    public internal(set) var flexWrap: FlexWrap = .nowrap
    public internal(set) var overflow: Overflow = .visible
    public internal(set) var display: Display = .flex

    public internal(set) var flex: Flex = .none
    public internal(set) var flexGrow: Double {
        get {
            return flex.grow
        }
        set {
            flex.grow = newValue
        }
    }
    public internal(set) var flexShrink: Double {
        get {
            return flex.shrink
        }
        set {
            flex.shrink = newValue
        }
    }
    public internal(set) var flexBasis: FlexBasis {
        get {
            return flex.basis
        }
        set {
            flex.basis = newValue
        }
    }

    public internal(set) var positionType: PositionType = .relative
    public internal(set) var position: Position = .zero

    public internal(set) var margin: StyleInsets = .zero
    public internal(set) var padding: StyleInsets = .zero
    public internal(set) var border: StyleInsets = .zero

    public internal(set) var width: StyleValue = .auto
    public internal(set) var height: StyleValue = .auto

    public internal(set) var minWidth: StyleValue = .length(0)
    public internal(set) var minHeight: StyleValue = .length(0)

    public internal(set) var maxWidth: StyleValue? = nil
    public internal(set) var maxHeight: StyleValue? = nil

    var computedMaxWidth: StyleValue {
        return maxWidth ?? StyleValue.auto
    }
    var computedMaxHeight: StyleValue {
        return maxHeight ?? StyleValue.auto
    }

    public internal(set) var aspectRatio: Double = Double.nan
    public static var scale: Double = Double(UIScreen.main.scale)
    var absoluteLayout: Bool {
        return positionType == PositionType.absolute
    }
    var relativeLayout: Bool {
        return positionType == PositionType.relative
    }
    var wrapped: Bool {
        return flexWrap != FlexWrap.nowrap
    }
    var hidden: Bool {
        return display == Display.none
    }

    // Equatable
    public static func ==(lhs: FlexStyle, rhs: FlexStyle) -> Bool {
        var _equal = true
        _equal = lhs.direction == rhs.direction
        if !_equal {
            return false
        }
        _equal = lhs.flexDirection == rhs.flexDirection
        if !_equal {
            return false
        }
        _equal = lhs.direction == rhs.direction
        if !_equal {
            return false
        }
        _equal = lhs.justifyContent == rhs.justifyContent
        if !_equal {
            return false
        }
        _equal = lhs.alignContent == rhs.alignContent
        if !_equal {
            return false
        }
        _equal = lhs.alignItems == rhs.alignItems
        if !_equal {
            return false
        }
        _equal = lhs.alignSelf == rhs.alignSelf
        if !_equal {
            return false
        }
        _equal = lhs.flexWrap == rhs.flexWrap
        if !_equal {
            return false
        }
        _equal = lhs.display == rhs.display
        if !_equal {
            return false
        }
        _equal = lhs.flex == rhs.flex
        if !_equal {
            return false
        }
        _equal = lhs.positionType == rhs.positionType
        if !_equal {
            return false
        }
        _equal = lhs.position == rhs.position
        if !_equal {
            return false
        }
        _equal = lhs.margin == rhs.margin
        if !_equal {
            return false
        }
        _equal = lhs.padding == rhs.padding
        if !_equal {
            return false
        }
        _equal = lhs.border == rhs.border
        if !_equal {
            return false
        }
        _equal = lhs.width == rhs.width
        if !_equal {
            return false
        }
        _equal = lhs.height == rhs.height
        if !_equal {
            return false
        }
        _equal = lhs.minWidth == rhs.minWidth
        if !_equal {
            return false
        }
        _equal = lhs.minHeight == rhs.minHeight
        if !_equal {
            return false
        }
        _equal = lhs.maxWidth == rhs.maxWidth
        if !_equal {
            return false
        }
        _equal = lhs.maxHeight == rhs.maxHeight
        if !_equal {
            return false
        }
        _equal = equal(lhs.aspectRatio, rhs.aspectRatio)
        if !_equal {
            return false
        }
        return true
    }

    public func copy(from style: FlexStyle) {
        direction = style.direction
        flexDirection = style.flexDirection
        direction = style.direction
        justifyContent = style.justifyContent
        alignContent = style.alignContent
        alignItems = style.alignItems
        alignSelf = style.alignSelf
        flexWrap = style.flexWrap
        display = style.display
        flex = style.flex
        positionType = style.positionType
        position = style.position
        margin = style.margin
        padding = style.padding
        border = style.border
        width = style.width
        height = style.height
        minWidth = style.minWidth
        minHeight = style.minHeight
        maxWidth = style.maxWidth
        maxHeight = style.maxHeight
        aspectRatio = style.aspectRatio
    }

    // YGResolveFlexDirection
    func resolveFlexDirection(by direction: Direction) -> FlexDirection {
        return flexDirection.resolve(by: direction)
    }

    // YGNodeIsLeadingPosDefined
    func isLeadingPositionDefined(for direction: FlexDirection) -> Bool {
        return position.leading(direction: direction) != StyleValue.auto
    }

    // YGNodeIsTrailingPosDefined
    func isTrailingPositionDefined(for direction: FlexDirection) -> Bool {
        return position.trailing(direction: direction) != StyleValue.auto
    }

    // YGNodeLeadingPosition
    func leadingPosition(for direction: FlexDirection, size: Double) -> Double {
        let value = position.leading(direction: direction)
        return value == StyleValue.auto ? 0.0 : value.resolve(by: size)
    }

    // YGNodeTrailingPosition
    func trailingPosition(for direction: FlexDirection, size: Double) -> Double {
        let value = position.trailing(direction: direction)
        return value == StyleValue.auto ? 0.0 : value.resolve(by: size)
    }

    // YGNodeRelativePosition
    func relativePosition(for direction: FlexDirection, size: Double) -> Double {
        if isLeadingPositionDefined(for: direction) {
            return leadingPosition(for: direction, size: size)
        } else {
            return 0 - trailingPosition(for: direction, size: size)
        }
    }

    // YGNodeLeadingMargin
    @inline(__always)
    func leadingMargin(for direction: FlexDirection, width: Double) -> Double {
        let value = margin.leading(direction: direction)
        let result = value.resolve(by: width)
        return result > 0 ? result : 0
    }

    // YGNodeTrailingMargin
    @inline(__always)
    func trailingMargin(for direction: FlexDirection, width: Double) -> Double {
        let value = margin.trailing(direction: direction)
        let result = value.resolve(by: width)
        return result > 0 ? result : 0
    }

    // YGNodeLeadingPadding
    @inline(__always)
    func leadingPadding(for direction: FlexDirection, width: Double) -> Double {
        let value = padding.leading(direction: direction)
        let result = value.resolve(by: width)
        return result > 0 ? result : 0
    }

    // YGNodeTrailingPadding
    @inline(__always)
    func trailingPadding(for direction: FlexDirection, width: Double) -> Double {
        let value = padding.trailing(direction: direction)
        let result = value.resolve(by: width)
        return result > 0 ? result : 0
    }

    // YGNodeLeadingBorder
    @inline(__always)
    func leadingBorder(for direction: FlexDirection) -> Double {
        let value = border.leading(direction: direction)
        let result = value.resolve(by: 0)
        return result > 0 ? result : 0
    }

    // YGNodeTrailingBorder
    @inline(__always)
    func trailingBorder(for direction: FlexDirection) -> Double {
        let value = border.trailing(direction: direction)
        let result = value.resolve(by: 0)
        return result > 0 ? result : 0
    }

    // YGNodePaddingAndBorderForAxis
    @inline(__always)
    func totalInnerSize(for direction: FlexDirection, width: Double) -> Double {
        return totalLeadingSize(for: direction, width: width) + totalTrailingSize(for: direction, width: width)
    }

    // YGNodeLeadingPaddingAndBorder
    @inline(__always)
    func totalLeadingSize(for direction: FlexDirection, width: Double) -> Double {
        return leadingPadding(for: direction, width: width) + leadingBorder(for: direction)
    }

    // YGNodeTrailingPaddingAndBorder
    @inline(__always)
    func totalTrailingSize(for direction: FlexDirection, width: Double) -> Double {
        return trailingPadding(for: direction, width: width) + trailingBorder(for: direction)
    }

    // YGNodeMarginForAxis
    @inline(__always)
    func totalOuterSize(for direction: FlexDirection, width: Double) -> Double {
        return leadingMargin(for: direction, width: width) + trailingMargin(for: direction, width: width)
    }

    @inline(__always)
    func totalPadding(for direction: FlexDirection, width: Double) -> Double {
        return leadingPadding(for: direction, width: width) + trailingPadding(for: direction, width: width)
    }

    @inline(__always)
    func totalBorder(for direction: FlexDirection) -> Double {
        return leadingBorder(for: direction) + trailingBorder(for: direction)
    }

    // YGNodeBoundAxisWithinMinAndMax
    func bound(axis direction: FlexDirection, value: Double, axisSize: Double) -> Double {
        let min: Double
        let max: Double
        if direction.isColumn {
            min = minHeight.resolve(by: axisSize)
            max = computedMaxHeight.resolve(by: axisSize)
        } else {
            min = minWidth.resolve(by: axisSize)
            max = computedMaxWidth.resolve(by: axisSize)
        }
        var bound = value
        if max >= 0.0 && bound > max {
            bound = max
        }
        if min >= 0.0 && bound < min {
            bound = min
        }
        return bound
    }

    // YGNodeBoundAxis(node, axis, value, axisSize, widthSize)
    // TODO: Rename method and parameters
    func bound(axis direction: FlexDirection, value: Double, axisSize: Double, width: Double) -> Double {
        return fmax(bound(axis: direction, value: value, axisSize: axisSize),
            totalInnerSize(for: direction, width: width))
    }

    // YGConstrainMaxSizeForMode(axis, parentAxisSize, parentWidth, mode, size)
    // TODO: Rename method and parameters
    func constrainMaxSize(axis: FlexDirection, parentAxisSize: Double, parentWidth: Double, mode: MeasureMode,
                          size: Double) -> (MeasureMode, Double) {
        let maxSize = maxDimension(by: axis).resolve(by: parentAxisSize) + totalOuterSize(for: axis, width: parentWidth)
        switch mode {
        case .exactly, .atMost:
            let s: Double = (maxSize.isNaN || size < maxSize) ? size : maxSize
            return (mode, s)
        case .undefined:
            if maxSize.isNaN {
                return (mode, size)
            } else {
                return (MeasureMode.atMost, maxSize)
            }
        }
    }

    // YGNodeResolveDirection
    func resolveDirection(by direction: Direction) -> Direction {
        if self.direction == Direction.inherit {
            return direction != Direction.inherit ? direction : .ltr
        } else {
            return self.direction
        }
    }

    func dimension(by direction: FlexDirection) -> StyleValue {
        return direction.isRow ? width : height
    }

    func minDimension(by direction: FlexDirection) -> StyleValue {
        return direction.isRow ? minWidth : minHeight
    }

    func maxDimension(by direction: FlexDirection) -> StyleValue {
        return direction.isRow ? computedMaxWidth : computedMaxHeight
    }
}
