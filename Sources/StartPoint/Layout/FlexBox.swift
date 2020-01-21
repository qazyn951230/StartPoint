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

import Darwin.C

final class FlexBox {
    // gCurrentGenerationCount
    static var totalGeneration: Int64 = 0

    var position: LayoutPosition = LayoutPosition.zero

    // dimensions
    var width: Double = Double.nan
    var height: Double = Double.nan

    var margin: LayoutInsets = LayoutInsets.zero
    var padding: LayoutInsets = LayoutInsets.zero
    var border: LayoutInsets = LayoutInsets.zero

    var direction: Direction = Direction.inherit

    // generationCount
    var generation: Int64 = 0
    var computedFlexBasis: Double = Double.nan
    var hasOverflow = false

    // measuredDimensions
    var measuredWidth: Double = Double.nan
    var measuredHeight: Double = Double.nan

    // resolvedDimensions
    var resolvedWidth: StyleValue = StyleValue.auto
    var resolvedHeight: StyleValue = StyleValue.auto

    var top: Double {
        return position.top
    }

    var bottom: Double {
        return position.bottom
    }

    var left: Double {
        return position.left
    }

    var right: Double {
        return position.right
    }

    func invalidate() {
        position = .zero
        margin = .zero
        padding = .zero
        border = .zero
        direction = .inherit

        width = Double.nan
        height = Double.nan
        measuredWidth = Double.nan
        measuredHeight = Double.nan
        resolvedWidth = .auto
        resolvedHeight = .auto

        hasOverflow = false
        generation = 0
    }

    func copy(from box: FlexBox) {
        position = box.position
        margin = box.margin
        padding = box.padding
        border = box.border

        width = box.width
        height = box.height
        measuredWidth = box.measuredWidth
        measuredHeight = box.measuredHeight
        resolvedWidth = box.resolvedWidth
        resolvedHeight = box.resolvedHeight

        hasOverflow = box.hasOverflow
        generation = box.generation
    }

    func computedDimension(by direction: FlexDirection) -> StyleValue {
        return direction.isRow ? resolvedWidth : resolvedHeight
    }

    // YGNodeIsStyleDimDefined
    func isDimensionDefined(for direction: FlexDirection, size: Double) -> Bool {
        return computedDimension(by: direction)
            .isDefined(size: size)
    }

    // YGNodeIsLayoutDimDefined
    func isLayoutDimensionDefined(for direction: FlexDirection) -> Bool {
        return measuredDimension(for: direction) >= 0.0
    }

    func setLeadingPosition(for direction: FlexDirection, size: Double) {
        switch direction {
        case .column:
            position.top = size
        case .columnReverse:
            position.bottom = size
        case .row:
            position.left = size
        case .rowReverse:
            position.right = size
        }
    }

    func setTrailingPosition(for direction: FlexDirection, size: Double) {
        switch direction {
        case .column:
            position.bottom = size
        case .columnReverse:
            position.top = size
        case .row:
            position.right = size
        case .rowReverse:
            position.left = size
        }
    }

    // YGRoundToPixelGrid
    func roundPosition(scale: Double, left absoluteLeft: Double, top absoluteTop: Double, textLayout: Bool) -> (Double, Double) {
        let nodeLeft = left
        let nodeTop = top
        let nodeWidth = width
        let nodeHeight = height

        let absoluteLeft = absoluteLeft + nodeLeft
        let absoluteTop = absoluteTop + nodeTop
        let absoluteRight = absoluteLeft + nodeWidth
        let absoluteBottom = absoluteTop + nodeHeight

        position.left = FlexBox.round(nodeLeft, scale: scale, ceil: false, floor: textLayout)
        position.top = FlexBox.round(nodeTop, scale: scale, ceil: false, floor: textLayout)

        let fractionalWidth = !(fmod(nodeWidth * scale, 1.0) ~~ 0) && !(fmod(nodeWidth * scale, 1.0) ~~ 1.0)
        let fractionalHeight = !(fmod(nodeHeight * scale, 1.0) ~~ 0) && !(fmod(nodeHeight * scale, 1.0) ~~ 1.0)

        width = FlexBox.round(absoluteRight, scale: scale, ceil: (textLayout && fractionalWidth),
            floor: (textLayout && !fractionalWidth)) -
            FlexBox.round(absoluteLeft, scale: scale, ceil: false, floor: textLayout)
        height = FlexBox.round(absoluteBottom, scale: scale, ceil: (textLayout && fractionalHeight),
            floor: (textLayout && !fractionalHeight)) -
            FlexBox.round(absoluteTop, scale: scale, ceil: false, floor: textLayout)
        return (absoluteLeft, absoluteTop)
    }

    func measuredDimension(for direction: FlexDirection) -> Double {
        return direction.isRow ? measuredWidth : measuredHeight
    }

    func setMeasuredDimension(for direction: FlexDirection, size: Double) {
        if direction.isRow {
            measuredWidth = size
        } else {
            measuredHeight = size
        }
    }

    // YGRoundValueToPixelGrid
    static func round(_ value: Double, scale: Double, ceil: Bool, floor: Bool) -> Double {
        var value = value * scale
        var mod = fmod(value, 1.0) // fractial
        if mod < 0 {
            // This branch is for handling negative numbers for `value`.
            //
            // Regarding `floor` and `ceil`. Note that for a number x, `floor(x) <= x <=
            // ceil(x)` even for negative numbers. Here are a couple of examples:
            //   - x =  2.2: floor( 2.2) =  2, ceil( 2.2) =  3
            //   - x = -2.2: floor(-2.2) = -3, ceil(-2.2) = -2
            //
            // Regarding `fmodf`. For fractional negative numbers, `fmodf` returns a
            // negative number. For example, `fmodf(-2.2) = -0.2`. However, we want
            // `fractial` to be the number such that subtracting it from `value` will
            // give us `floor(value)`. In the case of negative numbers, adding 1 to
            // `fmodf(value)` gives us this. Let's continue the example from above:
            //   - fractial = fmodf(-2.2) = -0.2
            //   - Add 1 to the fraction: fractial2 = fractial + 1 = -0.2 + 1 = 0.8
            //   - Finding the `floor`: -2.2 - fractial2 = -2.2 - 0.8 = -3
            mod += 1.0
        }
        if mod ~~ 0.0 {
            value = value - mod
        } else if mod ~~ 1.0 || ceil {
            value = value - mod + 1.0
        } else if floor {
            value = value - mod
        } else {
            value = value - mod + ((!mod.isNaN && (mod > 0.5 || mod ~~ 0.5)) ? 1.0 : 0.0)
        }
        return value / scale
    }
}
