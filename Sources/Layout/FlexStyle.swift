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

public class FlexStyle {
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

    // YGResolveFlexDirection
    func resolveDirection(by layoutDirection: Direction) -> FlexDirection {
        if layoutDirection == Direction.rtl {
            if flexDirection == FlexDirection.row {
                return FlexDirection.rowReverse
            } else if flexDirection == FlexDirection.rowReverse {
                return FlexDirection.row
            }
        }
        return flexDirection
    }

    // YGNodeIsLeadingPosDefined
    func isLeadingPositionDefined(for direction: FlexDirection) -> Bool {
        return (direction.isRow && position.leading != nil) ||
            (position.leading(direction: direction) != nil)
    }

    // YGNodeIsTrailingPosDefined
    func isTrailingPositionDefined(for direction: FlexDirection) -> Bool {
        return (direction.isRow && position.trailing != nil) ||
            (position.trailing(direction: direction) != nil)
    }

    // YGNodeLeadingPosition
    func leadingPosition(for direction: FlexDirection) -> Double {
        if direction.isRow, let leading = position.leading {
            return leading
        }
        return position.leading(direction: direction) ?? 0
    }

    // YGNodeTrailingPosition
    func trailingPosition(for direction: FlexDirection) -> Double {
        if direction.isRow, let leading = position.trailing {
            return leading
        }
        return position.trailing(direction: direction) ?? 0
    }

    // YGNodeRelativePosition
    func relativePosition(for direction: FlexDirection, size: Double) -> Double {
        if isLeadingPositionDefined(for: direction) {
            return leadingPosition(for: direction)
        } else {
            return 0 - trailingPosition(for: direction)
        }
    }

    func totalInnerSize(for direction: FlexDirection) -> Double {
        return padding.total(direction: direction) + border.total(direction: direction)
    }

    func totalLeadingSize(for direction: FlexDirection) -> Double {
        return padding.leading(direction: direction) + border.leading(direction: direction)
    }

    func totalTrailingSize(for direction: FlexDirection) -> Double {
        return padding.trailing(direction: direction) + border.trailing(direction: direction)
    }

    func totalOuterSize(for direction: FlexDirection) -> Double {
        return margin.total(direction: direction)
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

    // YGNodeBoundAxis
    func bound(axis direction: FlexDirection, value: Double, axisSize: Double, width: Double) -> Double {
        return fmax(bound(axis: direction, value: value, axisSize: axisSize), totalInnerSize(for: direction))
    }

    // YGConstrainMaxSizeForMode
    func constrainMaxSize(axis: FlexDirection, parentAxisSize: Double, parentWidth: Double, mode: MeasureMode, size: Double) -> (MeasureMode, Double) {
        let maxSize = maxDimension(by: axis).resolve(by: parentAxisSize) + margin.total(direction: axis)
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
    func resolveLayoutDirection(by direction: Direction) -> Direction {
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
