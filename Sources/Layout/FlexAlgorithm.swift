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

import Foundation
import CoreGraphics

extension FlexLayout {
    // YGResolveDimensions
    func resolveDimensions() {
        if let maxWidth = style.maxWidth {
            box.resolvedWidth = (maxWidth == style.minWidth) ? maxWidth : style.width
        } else {
            box.resolvedWidth = style.width
        }
        if let maxHeight = style.maxHeight {
            box.resolvedHeight = (maxHeight == style.minHeight) ? maxHeight : style.height
        } else {
            box.resolvedHeight = style.height
        }
    }

    // YGNodeCalculateLayout
    func calculate(width: Double = .nan, height: Double = .nan, direction: Direction = .ltr) {
        FlexBox.totalGeneration += 1
        resolveDimensions()
        let (_width, widthMode) = layoutMode(size: width, resolvedSize: box.resolvedWidth,
            maxSize: style.computedMaxWidth, direction: .row)
        let (_height, heightMode) = layoutMode(size: height, resolvedSize: box.resolvedHeight,
            maxSize: style.computedMaxHeight, direction: .column)
        let success = layoutInternal(width: _width, height: _height, widthMode: widthMode, heightMode: heightMode,
            parentWidth: width, parentHeight: height, direction: direction, layout: true, reason: "initial")
        if success {
            setPosition(direction: style.direction, mainSize: width, crossSize: height, parentWidth: width)
            roundPosition(scale: FlexStyle.scale, absoluteLeft: 0, absoluteTop: 0)
        }
    }

    func layoutMode(size: Double, resolvedSize: StyleValue, maxSize: StyleValue, direction: FlexDirection) -> (Double, MeasureMode) {
        let result: Double
        let mode: MeasureMode
        if box.isDimensionDefined(for: direction, size: size) {
            result = resolvedSize.resolve(by: size) + style.totalOuterSize(for: direction, width: size)
            mode = .exactly
        } else if maxSize.resolve(by: size) >= 0.0 {
            result = maxSize.resolve(by: size)
            mode = .atMost
        } else {
            result = size
            mode = result.isNaN ? .undefined : .exactly
        }
        return (result, mode)
    }

    // YGNodeSetPosition
    func setPosition(direction: Direction, mainSize: Double, crossSize: Double, parentWidth: Double) {
        let direction = parent != nil ? direction : Direction.ltr
        let mainDirection = style.resolveFlexDirection(by: direction)
        let crossDirection = mainDirection.cross(by: direction)
        let mainPosition = style.relativePosition(for: mainDirection, size: mainSize)
        let crossPosition = style.relativePosition(for: crossDirection, size: crossSize)
        box.setLeadingPosition(for: mainDirection,
            size: style.leadingMargin(for: mainDirection, width: parentWidth) + mainPosition)
        box.setTrailingPosition(for: mainDirection,
            size: style.leadingMargin(for: mainDirection, width: parentWidth) + mainPosition)
        box.setLeadingPosition(for: crossDirection,
            size: style.leadingMargin(for: crossDirection, width: parentWidth) + crossPosition)
        box.setTrailingPosition(for: crossDirection,
            size: style.leadingMargin(for: crossDirection, width: parentWidth) + crossPosition)
    }

    // YGRoundToPixelGrid
    func roundPosition(scale: Double, absoluteLeft left: Double, absoluteTop top: Double) {
        guard scale != 0.0 else {
            return
        }

        func fn(layout: FlexLayout, scale: Double, left: Double, top: Double) {
            let textLayout = layout.layoutType == LayoutType.text
            let (_Left, _Top) = layout.box.roundPosition(scale: scale, left: left, top: top, textLayout: textLayout)
            for child in layout.children {
                fn(layout: child, scale: scale, left: _Left, top: _Top)
            }
        }

        fn(layout: self, scale: scale, left: left, top: top)
    }

    @inline(__always)
    func findFlexChild() -> FlexLayout? {
        var result: FlexLayout? = nil
        for child in children {
            if result != nil {
                if child.flexed {
                    // There is already a flexible child, abort.
                    result = nil
                    break
                }
            } else if (child.computedFlexGrow > 0.0 && child.computedFlexShrink > 0.0) {
                result = child
            }
        }
        return result
    }

    // YGZeroOutLayoutRecursivly
    func zeroLayout() {
        box.width = 0
        box.height = 0
        box.position = .zero
        cachedLayout = nil
        children.forEach {
            $0.zeroLayout()
        }
    }

    // YGNodeAlignItem
    func computedAlignItem(child: FlexLayout) -> AlignItems {
        let align = child.style.alignSelf.alignItems ?? style.alignItems
        if align == AlignItems.baseline && style.flexDirection.isColumn {
            return AlignItems.flexStart
        }
        return align
    }

    // YGNodeSetChildTrailingPosition
    func setChildTrailingPosition(child: FlexLayout, direction: FlexDirection) {
        let size = child.box.measuredDimension(for: direction)
        child.box.setTrailingPosition(for: direction, size: box.measuredDimension(for: direction) -
            size - child.box.position[direction])
    }

    // YGNodeDimWithMargin
    @inline(__always)
    func dimensionWithMargin(for direction: FlexDirection, width: Double) -> Double {
        return box.measuredDimension(for: direction) + style.totalOuterSize(for: direction, width: width)
    }

    func measure(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> (Double, Double) {
        let size = measure(width: CGFloat(width), widthMode: widthMode, height: CGFloat(height), heightMode: heightMode)
        return (Double(size.width), Double(size.height))
    }

    // YGNodeComputeFlexBasisForChild
    func resolveFlexBasis(for child: FlexLayout, width: Double, widthMode: MeasureMode, height: Double,
                          heightMode: MeasureMode, parentWidth: Double, parentHeight: Double, direction: Direction) {
        let mainDirection = style.resolveFlexDirection(by: direction)
        let isMainAxisRow = mainDirection.isRow
        let mainDirectionSize = isMainAxisRow ? width : height
        let mainDirectionParentSize = isMainAxisRow ? parentWidth : parentHeight
        var childWidth = 0.0
        var childHeight = 0.0
        var childWidthMeasureMode = MeasureMode.undefined
        var childHeightMeasureMode = MeasureMode.undefined
        let resolvedFlexBasis = child.style.flexBasis.resolve(by: mainDirectionParentSize)
        let isRowStyleDimDefined = child.box.isDimensionDefined(for: .row, size: parentWidth)
        let isColumnStyleDimDefined = child.box.isDimensionDefined(for: .column, size: parentHeight)
        if !(resolvedFlexBasis.isNaN || mainDirectionSize.isNaN) {
            if child.computedFlexBasis.isNaN {
                child.computedFlexBasis = fmax(resolvedFlexBasis,
                    child.style.totalInnerSize(for: mainDirection, width: parentWidth))
            }
        } else if isMainAxisRow && isRowStyleDimDefined {
            // The width is definite, so use that as the flex basis.
            child.computedFlexBasis = fmax(child.box.resolvedWidth.resolve(by: parentWidth),
                child.style.totalInnerSize(for: .row, width: parentWidth))
        } else if !isMainAxisRow && isColumnStyleDimDefined {
            // The height is definite, so use that as the flex basis.
            child.computedFlexBasis = fmax(child.box.resolvedHeight.resolve(by: parentHeight),
                child.style.totalInnerSize(for: .column, width: parentWidth))
        } else {
            // Compute the flex basis and hypothetical main size (i.e. the clamped flex basis).
            childWidth = Double.nan
            childHeight = Double.nan
            let marginRow: Double = child.style.totalOuterSize(for: .row, width: parentWidth)
            let marginColumn: Double = child.style.totalOuterSize(for: .column, width: parentWidth)
            if isRowStyleDimDefined {
                childWidth = child.box.resolvedWidth.resolve(by: parentWidth) + marginRow
                childWidthMeasureMode = .exactly
            }
            if isColumnStyleDimDefined {
                childHeight = child.box.resolvedHeight.resolve(by: parentWidth) + marginColumn
                childHeightMeasureMode = .exactly
            }
            // The W3C spec doesn't say anything about the 'overflow' property,
            // but all major browsers appear to implement the following logic.
            if !isMainAxisRow && style.overflow.scrolled || !style.overflow.scrolled {
                if childWidth.isNaN && !width.isNaN {
                    childWidth = width
                    childWidthMeasureMode = .atMost
                }
            }
            if isMainAxisRow && style.overflow.scrolled || !style.overflow.scrolled {
                if childHeight.isNaN && !height.isNaN {
                    childHeight = height
                    childHeightMeasureMode = .atMost
                }
            }
            if !child.style.aspectRatio.isNaN {
                if !isMainAxisRow && childWidthMeasureMode.isExactly {
                    childHeight = (childWidth - marginRow) / child.style.aspectRatio
                    childHeightMeasureMode = .exactly
                } else if isMainAxisRow && childHeightMeasureMode.isExactly {
                    childWidth = (childHeight - marginColumn) * child.style.aspectRatio
                    childWidthMeasureMode = .exactly
                }
            }
            // If child has no defined size in the cross axis and is set to stretch, set the cross axis to be measured
            // exactly with the available inner width
            let hasExactWidth: Bool = !width.isNaN && widthMode.isExactly
            let childWidthStretch: Bool = computedAlignItem(child: child) == AlignItems.stretch && !childWidthMeasureMode.isExactly
            if !isMainAxisRow && !isRowStyleDimDefined && hasExactWidth && childWidthStretch {
                childWidth = width
                childWidthMeasureMode = .exactly
                if !child.style.aspectRatio.isNaN {
                    childHeight = (childWidth - marginRow) / child.style.aspectRatio
                    childHeightMeasureMode = .exactly
                }
            }
            let hasExactHeight: Bool = !height.isNaN && heightMode.isExactly
            let childHeightStretch: Bool = computedAlignItem(child: child) == AlignItems.stretch && !childHeightMeasureMode.isExactly
            if isMainAxisRow && !isColumnStyleDimDefined && hasExactHeight && childHeightStretch {
                childHeight = height
                childHeightMeasureMode = .exactly
                if !child.style.aspectRatio.isNaN {
                    childWidth = (childHeight - marginColumn) * child.style.aspectRatio
                    childWidthMeasureMode = .exactly
                }
            }
            (childWidthMeasureMode, childWidth) = child.style.constrainMaxSize(axis: .row, parentAxisSize: parentWidth, parentWidth: parentWidth, mode: childWidthMeasureMode, size: childWidth)
            (childHeightMeasureMode, childHeight) = child.style.constrainMaxSize(axis: .column, parentAxisSize: parentHeight, parentWidth: parentWidth, mode: childHeightMeasureMode, size: childHeight)
            // Measure the child
            _ = child.layoutInternal(width: childWidth, height: childHeight, widthMode: childWidthMeasureMode, heightMode: childHeightMeasureMode, parentWidth: parentWidth, parentHeight: parentHeight, direction: direction, layout: false, reason: "measure")
            child.computedFlexBasis = max(child.box.measuredDimension(for: mainDirection), child.style.totalInnerSize(for: mainDirection, width: parentWidth))
        }
    }

    // YGLayoutNodeInternal
    internal func layoutInternal(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode,
                                 parentWidth: Double, parentHeight: Double, direction: Direction,
                                 layout: Bool, reason: String) -> Bool {
        let layoutNeeded: Bool
        if let lastParentDirection = self.lastParentDirection {
            layoutNeeded = (dirty && box.generation != FlexBox.totalGeneration) || lastParentDirection != direction
        } else {
            layoutNeeded = true
        }
        if layoutNeeded {
            cachedLayout = nil
            cachedMeasurements.removeAll()
        }
        var cachedResult: LayoutCache? = nil
        if children.count < 1 && measureSelf {
            let marginRow = style.totalOuterSize(for: .row, width: parentWidth)
            let marginColumn = style.totalOuterSize(for: .column, width: parentWidth)
            if let layout = cachedLayout, layout.validate(width: width, height: height, widthMode: widthMode,
                heightMode: heightMode, marginRow: marginRow, marginColumn: marginColumn, scale: FlexStyle.scale) {
                cachedResult = layout
            } else {
                cachedResult = cachedMeasurements.first { cache in
                    return cache.validate(width: width, height: height, widthMode: widthMode, heightMode: heightMode,
                        marginRow: marginRow, marginColumn: marginColumn, scale: FlexStyle.scale)
                }
            }
        } else if layout {
            if let layout = cachedLayout,
               layout.isEqual(width: width, height: height, widthMode: widthMode, heightMode: heightMode) {
                cachedResult = layout
            }
        } else {
            cachedResult = cachedMeasurements.first { cache in
                return cache.isEqual(width: width, height: height, widthMode: widthMode, heightMode: heightMode)
            }
        }
        if let result = cachedResult, !layoutNeeded {
            box.measuredWidth = result.computedWidth
            box.measuredHeight = result.computedHeight
        } else {
            layoutImplement(width: width, height: height, widthMode: widthMode, heightMode: heightMode,
                direction: direction, parentWidth: parentWidth, parentHeight: parentHeight, layout: layout)
            lastParentDirection = direction
            if cachedResult == nil {
                if cachedMeasurements.count > 20 {
                    cachedMeasurements.removeFirst(10)
                }
                let result = LayoutCache(width: width, height: height, computedWidth: box.measuredWidth,
                    computedHeight: box.measuredHeight, widthMode: widthMode, heightMode: heightMode)
                if layout {
                    cachedLayout = result
                } else {
                    cachedMeasurements.append(result)
                }
            }
        }
        if layout {
            box.width = box.measuredWidth
            box.height = box.measuredHeight
            dirty = false
        }
        box.generation = FlexBox.totalGeneration
        return (layoutNeeded || cachedResult == nil)
    }

    // YGNodelayoutImpl
    func layoutImplement(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode,
                         direction: Direction, parentWidth: Double, parentHeight: Double, layout: Bool) {
        // TODO: Give a waring.
        let widthMode: MeasureMode = width.isNaN ? .undefined : widthMode
        let heightMode: MeasureMode = height.isNaN ? .undefined : heightMode
        layoutBox(by: direction, width: parentWidth)

        if children.count > 0 {
            flexLayout(width: width, height: height, direction: direction, widthMode: widthMode,
                heightMode: heightMode, parentWidth: parentWidth, parentHeight: parentHeight, layout: layout)
        } else {
            if measureSelf {
                measureLayout(width: width, height: height, widthMode: widthMode, heightMode: heightMode,
                    parentWidth: parentWidth, parentHeight: parentHeight)
            } else {
                emptyLayout(width: width, height: height, widthMode: widthMode, heightMode: heightMode,
                    parentWidth: parentWidth, parentHeight: parentHeight)
            }
        }
    }

    // YGNodelayoutImpl
    func layoutBox(by direction: Direction, width: Double) {
        let rowDirection = FlexDirection.row.resolve(by: direction)
        let columnDirection = FlexDirection.column.resolve(by: direction)

        box.margin.top = style.leadingMargin(for: columnDirection, width: width)
        box.margin.bottom = style.trailingMargin(for: columnDirection, width: width)
        box.padding.top = style.leadingPadding(for: columnDirection, width: width)
        box.padding.bottom = style.trailingPadding(for: columnDirection, width: width)
        box.border.top = style.leadingBorder(for: columnDirection)
        box.border.bottom = style.trailingBorder(for: columnDirection)

        if direction == Direction.ltr {
            box.margin.left = style.leadingMargin(for: rowDirection, width: width)
            box.margin.right = style.trailingMargin(for: rowDirection, width: width)
            box.padding.left = style.leadingPadding(for: rowDirection, width: width)
            box.padding.right = style.trailingPadding(for: rowDirection, width: width)
            box.border.left = style.leadingBorder(for: rowDirection)
            box.border.right = style.trailingBorder(for: rowDirection)
        } else {
            box.margin.right = style.leadingMargin(for: rowDirection, width: width)
            box.margin.left = style.trailingMargin(for: rowDirection, width: width)
            box.padding.right = style.leadingPadding(for: rowDirection, width: width)
            box.padding.left = style.trailingPadding(for: rowDirection, width: width)
            box.border.right = style.leadingBorder(for: rowDirection)
            box.border.left = style.trailingBorder(for: rowDirection)
        }
    }

    // YGNodeWithMeasureFuncSetMeasuredDimensions
    func measureLayout(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode,
                       parentWidth: Double, parentHeight: Double) {
        let marginRow = style.totalOuterSize(for: .row, width: width)
        let marginColumn = style.totalOuterSize(for: .column, width: width)
        if widthMode.isExactly && heightMode.isExactly {
            box.measuredWidth = style.bound(axis: .row, value: width - marginRow,
                axisSize: parentWidth, width: parentWidth)
            box.measuredHeight = style.bound(axis: .column, value: height - marginColumn,
                axisSize: parentHeight, width: parentWidth)
        } else {
            // paddingAndBorderAxisRow
            let innerSizeRow = style.totalInnerSize(for: .row, width: width)
            // paddingAndBorderAxisColumn
            let innerSizeColumn = style.totalInnerSize(for: .column, width: width)
            let innerWidth = width.isNaN ? width : fmax(0, width - innerSizeRow - marginRow)
            let innerHeight = height.isNaN ? height : fmax(0, height - innerSizeColumn - marginColumn)
            let (width1, height1) = measure(width: innerWidth, widthMode: widthMode, height: innerHeight, heightMode: heightMode)
            let width2 = !widthMode.isExactly ? (width1 + innerSizeRow) : (width - marginRow)
            let height2 = !heightMode.isExactly ? (height1 + innerSizeColumn) : (height - marginColumn)
            box.measuredWidth = style.bound(axis: .row, value: width2, axisSize: parentWidth, width: parentWidth)
            box.measuredHeight = style.bound(axis: .column, value: height2, axisSize: parentHeight, width: parentWidth)
        }
    }

    // YGNodeEmptyContainerSetMeasuredDimensions
    func emptyLayout(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode,
                     parentWidth: Double, parentHeight: Double) {
        // paddingAndBorderAxisRow
        let innerRow = style.totalInnerSize(for: .row, width: parentWidth)
        // paddingAndBorderAxisColumn
        let innerColumn = style.totalInnerSize(for: .column, width: parentWidth)
        // marginAxisRow
        let outerRow = style.totalOuterSize(for: .row, width: parentWidth)
        // marginAxisColumn
        let outerColumn = style.totalOuterSize(for: .column, width: parentWidth)
        let width: Double = (!widthMode.isExactly) ? innerRow : (width - outerRow)
        box.measuredWidth = style.bound(axis: .row, value: width, axisSize: parentWidth, width: parentWidth)
        let height: Double = (!heightMode.isExactly) ? innerColumn : (height - outerColumn)
        box.measuredHeight = style.bound(axis: .column, value: height, axisSize: parentHeight, width: parentWidth)
    }

    // YGNodeFixedSizeSetMeasuredDimensions
    func fixedLayout(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode,
                     parentWidth: Double, parentHeight: Double) -> Bool {
        guard (widthMode.isAtMost && width <= 0) || (heightMode.isAtMost && height <= 0) ||
                  (widthMode.isExactly && heightMode.isExactly) else {
            return false
        }
        let marginAxisColumn = style.totalOuterSize(for: .column, width: parentWidth)
        let marginAxisRow = style.totalOuterSize(for: .row, width: parentWidth)
        let width: Double = (width.isNaN || (widthMode.isAtMost && width <= 0)) ? 0.0 : width - marginAxisRow
        box.measuredWidth = style.bound(axis: .row, value: width, axisSize: parentWidth, width: parentHeight)
        let height: Double = (height.isNaN || (heightMode.isAtMost && height <= 0)) ? 0.0 : height - marginAxisColumn
        box.measuredHeight = style.bound(axis: .column, value: height, axisSize: parentHeight, width: parentWidth)
        return true
    }

    // YGNodelayoutImpl
    func flexLayout(width: Double, height: Double, direction: Direction, widthMode: MeasureMode, heightMode: MeasureMode, parentWidth: Double, parentHeight: Double, layout performLayout: Bool) {
        // If we're not being asked to perform a full layout we can skip the algorithm if we already know the size
        if !performLayout && fixedLayout(width: width, height: height, widthMode: widthMode, heightMode: heightMode, parentWidth: parentWidth, parentHeight: parentHeight) {
            return
        }
        // Reset layout flags, as they could have changed.
        box.hasOverflow = false
        let direction = style.resolveDirection(by: direction)
        // STEP 1: CALCULATE VALUES FOR REMAINDER OF ALGORITHM
        let mainAxis = style.flexDirection.resolve(by: direction)
        let crossAxis = mainAxis.cross(by: direction)
        let isMainAxisRow = mainAxis.isRow
        let paddingAndBorderAxisMain = style.totalInnerSize(for: mainAxis, width: parentWidth)
        let paddingAndBorderAxisCross = style.totalInnerSize(for: crossAxis, width: parentWidth)
        let paddingAndBorderAxisRow = isMainAxisRow ? paddingAndBorderAxisMain : paddingAndBorderAxisCross
        let paddingAndBorderAxisColumn = isMainAxisRow ? paddingAndBorderAxisCross : paddingAndBorderAxisMain
        let marginAxisRow: Double = style.totalOuterSize(for: .row, width: parentWidth)
        let marginAxisColumn: Double = style.totalOuterSize(for: .column, width: parentWidth)
        // STEP 2: DETERMINE AVAILABLE SIZE IN MAIN AND CROSS DIRECTIONS
        let minInnerWidth = style.minWidth.resolve(by: width) - paddingAndBorderAxisRow
        let maxInnerWidth = style.computedMaxWidth.resolve(by: width) - paddingAndBorderAxisRow
        let minInnerHeight = style.minHeight.resolve(by: height) - paddingAndBorderAxisColumn
        let maxInnerHeight = style.computedMaxHeight.resolve(by: height) - paddingAndBorderAxisColumn
        let minInnerMainDim = isMainAxisRow ? minInnerWidth : minInnerHeight
        let maxInnerMainDim = isMainAxisRow ? maxInnerWidth : maxInnerHeight
        var availableInnerWidth = width - marginAxisRow - paddingAndBorderAxisRow
        if (!availableInnerWidth.isNaN) {
            availableInnerWidth = inner(availableInnerWidth, min: minInnerWidth, max: maxInnerWidth)
        }
        var availableInnerHeight = height - marginAxisColumn - paddingAndBorderAxisColumn
        if (!availableInnerHeight.isNaN) {
            availableInnerHeight = inner(availableInnerHeight, min: minInnerHeight, max: maxInnerHeight)
        }
        var availableInnerMainDim: Double = isMainAxisRow ? availableInnerWidth : availableInnerHeight
        let availableInnerCrossDim: Double = isMainAxisRow ? availableInnerHeight : availableInnerWidth
        let singleFlexChild: FlexLayout?
        var measureModeMainDim = isMainAxisRow ? widthMode : heightMode
        if measureModeMainDim.isExactly {
            singleFlexChild = findFlexChild()
        } else {
            singleFlexChild = nil
        }
        var totalOuterFlexBasis = 0.0
        // STEP 3: DETERMINE FLEX BASIS FOR EACH ITEM
        var firstAbsoluteChild: FlexLayout? = nil
        var currentAbsoluteChild: FlexLayout? = nil
        for child in children {
            if child.style.display == Display.none {
                child.zeroLayout()
                child.dirty = false
                continue
            }
            child.resolveDimensions()
            if performLayout {
                let childDirection = child.style.resolveDirection(by: direction)
                child.setPosition(direction: childDirection, mainSize: availableInnerMainDim, crossSize: availableInnerCrossDim, parentWidth: availableInnerWidth)
            }
            if child.style.absoluteLayout {
                if firstAbsoluteChild == nil {
                    firstAbsoluteChild = child
                }
                currentAbsoluteChild?.nextChild = child
                currentAbsoluteChild = child
                child.nextChild = nil
            } else {
                if let singleFlexChild = singleFlexChild, child == singleFlexChild {
                    child.computedFlexBasis = 0
                } else {
                    resolveFlexBasis(for: child, width: availableInnerWidth, widthMode: widthMode, height: availableInnerHeight, heightMode: heightMode, parentWidth: availableInnerWidth, parentHeight: availableInnerHeight, direction: direction)
                }
            }
            totalOuterFlexBasis += child.computedFlexBasis + child.style.totalOuterSize(for: mainAxis, width: availableInnerWidth)
        }
        let flexBasisOverflows = measureModeMainDim == MeasureMode.undefined ? false : totalOuterFlexBasis > availableInnerWidth
        let isNodeFlexWrap = style.wrapped
        if isNodeFlexWrap && flexBasisOverflows && measureModeMainDim.isAtMost {
            measureModeMainDim = .exactly
        }
        // STEP 4: COLLECT FLEX ITEMS INTO FLEX LINES
        var startOfLineIndex = 0
        var endOfLineIndex = 0
        let childCount = children.count
        var lineCount = 0
        var totalLineCrossDim = 0.0
        var maxLineMainDim = 0.0
        let mainAxisParentSize = isMainAxisRow ? parentWidth : parentHeight
        let crossAxisParentSize = isMainAxisRow ? parentHeight : parentWidth
        let leadingPaddingAndBorderMain = style.totalLeadingSize(for: mainAxis, width: parentWidth)
        let trailingPaddingAndBorderMain = style.totalTrailingSize(for: mainAxis, width: parentWidth)
        let leadingPaddingAndBorderCross = style.totalLeadingSize(for: crossAxis, width: parentWidth)
        let measureModeCrossDim = isMainAxisRow ? heightMode : widthMode
        while endOfLineIndex < childCount {
            var itemsOnLine = 0
            var sizeConsumedOnCurrentLine = 0.0
            var sizeConsumedOnCurrentLineIncludingMinConstraint = 0.0
            var totalFlexGrowFactors = 0.0
            var totalFlexShrinkScaledFactors = 0.0
            var firstRelativeChild: FlexLayout? = nil
            var currentRelativeChild: FlexLayout? = nil
            for child: FlexLayout in children[startOfLineIndex..<childCount] {
                if child.style.hidden {
                    endOfLineIndex += 1
                    continue
                }
                child.lineIndex = lineCount
                if !child.style.absoluteLayout {
                    let childMarginMainAxis = child.style.totalOuterSize(for: mainAxis, width: availableInnerWidth)
                    // NOTE: min(nan, 0) => nan, min(0, nan) => 0
                    let flexBasisWithMaxConstraints = fmin(child.style.maxDimension(by: mainAxis).resolve(by: mainAxisParentSize), child.computedFlexBasis)
                    let flexBasisWithMinAndMaxConstraints = fmax(child.style.minDimension(by: mainAxis).resolve(by: mainAxisParentSize), flexBasisWithMaxConstraints)
                    if sizeConsumedOnCurrentLineIncludingMinConstraint + flexBasisWithMinAndMaxConstraints + childMarginMainAxis > availableInnerMainDim && isNodeFlexWrap && itemsOnLine > 0 {
                        break
                    }
                    sizeConsumedOnCurrentLineIncludingMinConstraint += flexBasisWithMinAndMaxConstraints + childMarginMainAxis
                    sizeConsumedOnCurrentLine += flexBasisWithMinAndMaxConstraints + childMarginMainAxis
                    itemsOnLine += 1
                    if child.flexed {
                        totalFlexGrowFactors += child.computedFlexGrow
                        totalFlexShrinkScaledFactors += (0 - child.computedFlexShrink) * child.computedFlexBasis
                    }
                    if firstRelativeChild == nil {
                        firstRelativeChild = child
                    }
                    currentRelativeChild?.nextChild = child
                    currentRelativeChild = child
                    child.nextChild = nil
                }
                endOfLineIndex += 1
            }
            if totalFlexGrowFactors > 0 && totalFlexGrowFactors < 1 {
                totalFlexGrowFactors = 1
            }
            if totalFlexShrinkScaledFactors > 0 && totalFlexShrinkScaledFactors < 1 {
                totalFlexShrinkScaledFactors = 1
            }
            let canSkipFlex = !performLayout && measureModeCrossDim.isExactly
            var leadingMainDim = 0.0
            var betweenMainDim = 0.0
            // STEP 5: RESOLVING FLEXIBLE LENGTHS ON MAIN AXIS
            var sizeBasedOnContent = false
            if measureModeMainDim != MeasureMode.exactly {
                if !minInnerMainDim.isNaN && sizeConsumedOnCurrentLine < minInnerMainDim {
                    availableInnerMainDim = minInnerMainDim
                } else if !maxInnerMainDim.isNaN && sizeConsumedOnCurrentLine > maxInnerMainDim {
                    availableInnerMainDim = maxInnerMainDim
                } else {
                    if totalFlexGrowFactors == 0 || computedFlexGrow == 0 {
                        availableInnerMainDim = sizeConsumedOnCurrentLine
                    }
                    sizeBasedOnContent = true
                }
            }
            var remainingFreeSpace = 0.0
            if !sizeBasedOnContent && !availableInnerMainDim.isNaN {
                remainingFreeSpace = availableInnerMainDim - sizeConsumedOnCurrentLine
            } else if sizeConsumedOnCurrentLine < 0 {
                remainingFreeSpace = 0 - sizeConsumedOnCurrentLine
            }
            let originalRemainingFreeSpace = remainingFreeSpace
            var deltaFreeSpace = 0.0
            if !canSkipFlex {
                var childFlexBasis = 0.0
                var flexShrinkScaledFactor = 0.0
                var flexGrowFactor = 0.0
                var baseMainSize = 0.0
                var boundMainSize = 0.0
                var deltaFlexShrinkScaledFactors = 0.0
                var deltaFlexGrowFactors = 0.0
                currentRelativeChild = firstRelativeChild
                while currentRelativeChild != nil {
                    guard let child = currentRelativeChild else {
                        break
                    }
                    childFlexBasis = fmin(child.style.maxDimension(by: mainAxis).resolve(by: mainAxisParentSize),
                        fmax(child.style.minDimension(by: mainAxis).resolve(by: mainAxisParentSize), child.computedFlexBasis))
                    if remainingFreeSpace < 0 {
                        flexShrinkScaledFactor = (0 - child.computedFlexShrink) * childFlexBasis
                        if flexShrinkScaledFactor != 0 {
                            baseMainSize =
                                childFlexBasis +
                                    remainingFreeSpace / totalFlexShrinkScaledFactors * flexShrinkScaledFactor
                            boundMainSize = child.style.bound(axis: mainAxis, value: baseMainSize, axisSize: availableInnerMainDim, width: availableInnerWidth)
                            if baseMainSize != boundMainSize {
                                deltaFreeSpace -= boundMainSize - childFlexBasis
                                deltaFlexShrinkScaledFactors -= flexShrinkScaledFactor
                            }
                        }
                    } else if remainingFreeSpace > 0 {
                        flexGrowFactor = child.computedFlexGrow
                        if flexGrowFactor != 0 {
                            baseMainSize =
                                childFlexBasis + remainingFreeSpace / totalFlexGrowFactors * flexGrowFactor
                            boundMainSize = child.style.bound(axis: mainAxis, value: baseMainSize, axisSize: availableInnerMainDim, width: availableInnerWidth)
                            if baseMainSize != boundMainSize {
                                deltaFreeSpace -= boundMainSize - childFlexBasis
                                deltaFlexGrowFactors -= flexGrowFactor
                            }
                        }
                    }
                    currentRelativeChild = currentRelativeChild?.nextChild
                }
                totalFlexShrinkScaledFactors += deltaFlexShrinkScaledFactors
                totalFlexGrowFactors += deltaFlexGrowFactors
                remainingFreeSpace += deltaFreeSpace
                deltaFreeSpace = 0
                currentRelativeChild = firstRelativeChild
                while currentRelativeChild != nil {
                    guard let child = currentRelativeChild else {
                        break
                    }
                    childFlexBasis = fmin(child.style.maxDimension(by: mainAxis).resolve(by: mainAxisParentSize), fmax(child.style.minDimension(by: mainAxis).resolve(by: mainAxisParentSize), child.computedFlexBasis))
                    var updatedMainSize = childFlexBasis
                    if remainingFreeSpace < 0 {
                        flexShrinkScaledFactor = (0 - child.computedFlexShrink) * childFlexBasis
                        if flexShrinkScaledFactor != 0 {
                            let childSize: Double
                            if totalFlexShrinkScaledFactors == 0 {
                                childSize = childFlexBasis + flexShrinkScaledFactor
                            } else {
                                childSize = childFlexBasis + (remainingFreeSpace / totalFlexShrinkScaledFactors) * flexShrinkScaledFactor
                            }
                            updatedMainSize = child.style.bound(axis: mainAxis, value: childSize, axisSize: availableInnerMainDim, width: availableInnerWidth)
                        }
                    } else if remainingFreeSpace > 0 {
                        flexGrowFactor = child.computedFlexGrow
                        if flexGrowFactor != 0 {
                            updatedMainSize = child.style.bound(axis: mainAxis, value: childFlexBasis + remainingFreeSpace / totalFlexGrowFactors * flexGrowFactor, axisSize: availableInnerMainDim, width: availableInnerWidth)
                        }
                    }
                    deltaFreeSpace -= updatedMainSize - childFlexBasis
                    let marginMain = child.style.totalOuterSize(for: mainAxis, width: availableInnerWidth)
                    let marginCross = child.style.totalOuterSize(for: crossAxis, width: availableInnerWidth)
                    var childCrossSize = 0.0
                    var childMainSize = updatedMainSize + marginMain
                    var childCrossMeasureMode = MeasureMode.undefined
                    var childMainMeasureMode = MeasureMode.exactly
                    if !child.style.aspectRatio.isNaN {
                        let ratio = child.style.aspectRatio
                        if isMainAxisRow {
                            childCrossSize = (childMainSize - marginMain) / ratio
                        } else {
                            childCrossSize = (childMainSize - marginMain) * ratio
                        }
                        childCrossMeasureMode = .exactly
                        childCrossSize += marginCross
                    } else if !availableInnerCrossDim.isNaN && !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCrossDim) && measureModeCrossDim.isExactly && !(isNodeFlexWrap && flexBasisOverflows) && computedAlignItem(child: child) == AlignItems.stretch && child.style.margin.leading(direction: crossAxis) != StyleValue.auto && child.style.margin.trailing(direction: crossAxis) != StyleValue.auto {
                        childCrossSize = availableInnerCrossDim
                        childCrossMeasureMode = MeasureMode.exactly
                    } else if !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCrossDim) {
                        childCrossSize = availableInnerCrossDim
                        childCrossMeasureMode = childCrossSize.isNaN ? .undefined : .atMost
                    } else {
                        let t: StyleValue = child.box.computedDimension(by: crossAxis)
                        let f: Bool
                        if case StyleValue.percentage = t {
                            f = true
                        } else {
                            f = false
                        }
                        childCrossSize = t.resolve(by: availableInnerCrossDim) + marginCross
                        let isLoosePercentageMeasurement = f && measureModeCrossDim != MeasureMode.exactly
                        childCrossMeasureMode = (childCrossSize.isNaN || isLoosePercentageMeasurement) ? .undefined : .exactly
                    }
                    (childMainMeasureMode, childMainSize) = child.style.constrainMaxSize(axis: mainAxis, parentAxisSize: availableInnerMainDim, parentWidth: availableInnerWidth, mode: childMainMeasureMode, size: childMainSize)
                    (childCrossMeasureMode, childCrossSize) = child.style.constrainMaxSize(axis: crossAxis, parentAxisSize: availableInnerCrossDim, parentWidth: availableInnerWidth, mode: childCrossMeasureMode, size: childCrossSize)
                    let requiresStretchLayout = !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCrossDim) && computedAlignItem(child: child) == AlignItems.stretch && child.style.margin.leading(direction: crossAxis) != StyleValue.auto && child.style.margin.trailing(direction: crossAxis) != StyleValue.auto
                    let childWidth = isMainAxisRow ? childMainSize : childCrossSize
                    let childHeight = !isMainAxisRow ? childMainSize : childCrossSize
                    let childWidthMeasureMode = isMainAxisRow ? childMainMeasureMode : childCrossMeasureMode
                    let childHeightMeasureMode = isMainAxisRow ? childCrossMeasureMode : childMainMeasureMode
                    _ = child.layoutInternal(width: childWidth, height: childHeight, widthMode: childWidthMeasureMode, heightMode: childHeightMeasureMode, parentWidth: availableInnerWidth, parentHeight: availableInnerHeight, direction: direction, layout: performLayout && !requiresStretchLayout, reason: "flex")
                    box.hasOverflow = box.hasOverflow || child.box.hasOverflow
                    currentRelativeChild = child.nextChild
                }
            }
            remainingFreeSpace = originalRemainingFreeSpace + deltaFreeSpace
            box.hasOverflow = box.hasOverflow || (remainingFreeSpace < 0)
            // STEP 6: MAIN-AXIS JUSTIFICATION & CROSS-AXIS SIZE DETERMINATION
            if measureModeMainDim.isAtMost && remainingFreeSpace > 0 {
                if style.minDimension(by: mainAxis).resolve(by: mainAxisParentSize) >= 0 {
                    remainingFreeSpace = fmax(0, style.minDimension(by: mainAxis).resolve(by: mainAxisParentSize) - (availableInnerMainDim - remainingFreeSpace))
                } else {
                    remainingFreeSpace = 0
                }
            }
            var numberOfAutoMarginsOnCurrentLine: Double = 0.0
            for child: FlexLayout in children[startOfLineIndex..<endOfLineIndex] {
                if child.style.relativeLayout {
                    if child.style.margin.leading(direction: mainAxis) == StyleValue.auto {
                        numberOfAutoMarginsOnCurrentLine += 1.0
                    }
                    if child.style.margin.trailing(direction: mainAxis) == StyleValue.auto {
                        numberOfAutoMarginsOnCurrentLine += 1.0
                    }
                }
            }
            if numberOfAutoMarginsOnCurrentLine < 1 {
                switch style.justifyContent {
                case .center:
                    leadingMainDim = remainingFreeSpace / 2
                case .flexEnd:
                    leadingMainDim = remainingFreeSpace
                case .spaceBetween:
                    if itemsOnLine > 1 {
                        betweenMainDim = fmax(remainingFreeSpace, 0) / Double(itemsOnLine - 1)
                    } else {
                        betweenMainDim = 0
                    }
                case .spaceEvenly: // Space is distributed evenly across all elements
                    betweenMainDim = remainingFreeSpace / Double(itemsOnLine + 1)
                    leadingMainDim = betweenMainDim
                case .spaceAround:
                    betweenMainDim = remainingFreeSpace / Double(itemsOnLine)
                    leadingMainDim = betweenMainDim / 2
                case .flexStart:
                    break
                }
            }
            var mainDim = leadingPaddingAndBorderMain + leadingMainDim
            var crossDim = 0.0
            for child: FlexLayout in children[startOfLineIndex..<endOfLineIndex] {
                if child.style.hidden {
                    continue
                }
                if child.style.absoluteLayout && child.style.isLeadingPositionDefined(for: mainAxis) {
                    if performLayout {
                        // In case the child is position absolute and has left/top being
                        // defined, we override the position to whatever the user said
                        // (and margin/border).
                        child.box.position[mainAxis] = child.style.leadingPosition(for: mainAxis, size: availableInnerMainDim) +
                            style.leadingBorder(for: mainAxis) +
                            child.style.leadingMargin(for: mainAxis, width: availableInnerWidth)
                    }
                } else {
                    if child.style.relativeLayout {
                        if child.style.margin.leading(direction: mainAxis) == StyleValue.auto {
                            mainDim += remainingFreeSpace / numberOfAutoMarginsOnCurrentLine
                        }
                        if performLayout {
                            child.box.position[mainAxis] += mainDim
                        }
                        if child.style.margin.trailing(direction: mainAxis) == StyleValue.auto {
                            mainDim += remainingFreeSpace / numberOfAutoMarginsOnCurrentLine
                        }
                        if canSkipFlex {
                            mainDim += betweenMainDim + child.computedFlexBasis +
                                child.style.totalOuterSize(for: mainAxis, width: availableInnerWidth)
                            crossDim = availableInnerCrossDim
                        } else {
                            mainDim += betweenMainDim + child.dimensionWithMargin(for: mainAxis, width: availableInnerWidth)
                            crossDim = fmax(crossDim, child.dimensionWithMargin(for: crossAxis, width: availableInnerWidth))
                        }
                    } else if performLayout {
                        child.box.position[mainAxis] += style.leadingBorder(for: mainAxis) + leadingMainDim
                    }
                }
            }
            mainDim += trailingPaddingAndBorderMain
            var containerCrossAxis = availableInnerCrossDim
            if measureModeCrossDim == MeasureMode.undefined || measureModeCrossDim.isAtMost {
                containerCrossAxis = style.bound(axis: crossAxis, value: crossDim + paddingAndBorderAxisCross, axisSize: crossAxisParentSize, width: parentWidth) - paddingAndBorderAxisCross
            }
            if !isNodeFlexWrap && measureModeCrossDim.isExactly {
                crossDim = availableInnerCrossDim
            }
            crossDim = style.bound(axis: crossAxis, value: crossDim + paddingAndBorderAxisCross, axisSize: crossAxisParentSize, width: parentWidth) - paddingAndBorderAxisCross
            // STEP 7: CROSS-AXIS ALIGNMENT
            if performLayout {
                for child: FlexLayout in children[startOfLineIndex..<endOfLineIndex] {
                    if child.style.hidden {
                        continue
                    }
                    if child.style.absoluteLayout {
                        // If the child is absolutely positioned and has a top/left/bottom/right
                        // set, override all the previously computed positions to set it correctly.
                        let isLeadingPositionDefined = child.style.isLeadingPositionDefined(for: crossAxis)
                        if child.style.isLeadingPositionDefined(for: crossAxis) {
                            child.box.position[crossAxis] = child.style.leadingPosition(for: crossAxis, size: availableInnerCrossDim) +
                                style.leadingBorder(for: crossAxis) +
                                child.style.leadingMargin(for: crossAxis, width: availableInnerWidth)
                        }
                        if !isLeadingPositionDefined || child.box.position.leading(direction: crossAxis).isNaN {
                            // If leading position is not defined or calculations result in Nan, default to border + margin
                            child.box.position[crossAxis] = style.leadingBorder(for: crossAxis) +
                                child.style.leadingMargin(for: crossAxis, width: availableInnerWidth)
                        }
                    } else {
                        var leadingCrossDim = leadingPaddingAndBorderCross
                        let alignItem = computedAlignItem(child: child)
                        if alignItem == AlignItems.stretch && child.style.margin.leading(direction: crossAxis) != StyleValue.auto &&
                               child.style.margin.trailing(direction: crossAxis) != StyleValue.auto {
                            if !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCrossDim) {
                                var childMainSize = child.box.measuredDimension(for: mainAxis)
                                var childCrossSize = crossDim
                                if !child.style.aspectRatio.isNaN {
                                    let size = isMainAxisRow ? childMainSize / child.style.aspectRatio : childMainSize * child.style.aspectRatio
                                    childCrossSize = child.style.totalOuterSize(for: crossAxis, width: availableInnerWidth) + size
                                }
                                childMainSize += child.style.totalOuterSize(for: mainAxis, width: availableInnerWidth)
                                var childMainMeasureMode = MeasureMode.exactly
                                var childCrossMeasureMode = MeasureMode.exactly
                                (childMainMeasureMode, childMainSize) = child.style.constrainMaxSize(axis: mainAxis, parentAxisSize: availableInnerMainDim, parentWidth: availableInnerWidth, mode: childMainMeasureMode, size: childMainSize)
                                (childCrossMeasureMode, childCrossSize) = child.style.constrainMaxSize(axis: crossAxis, parentAxisSize: availableInnerCrossDim, parentWidth: availableInnerWidth, mode: childCrossMeasureMode, size: childCrossSize)
                                let childWidth = isMainAxisRow ? childMainSize : childCrossSize
                                let childHeight = isMainAxisRow ? childCrossSize : childMainSize
                                let childWidthMeasureMode: MeasureMode = childWidth.isNaN ? .undefined : .exactly
                                let childHeightMeasureMode: MeasureMode = childHeight.isNaN ? .undefined : .exactly
                                _ = child.layoutInternal(width: childWidth, height: childHeight, widthMode: childWidthMeasureMode, heightMode: childHeightMeasureMode, parentWidth: availableInnerWidth, parentHeight: availableInnerHeight, direction: direction, layout: true, reason: "stretch")
                            }
                        } else {
                            let remainingCrossDim = containerCrossAxis - child.dimensionWithMargin(for: crossAxis, width: availableInnerWidth)
                            if child.style.margin.leading(direction: crossAxis) == StyleValue.auto {
                                if child.style.margin.trailing(direction: crossAxis) == StyleValue.auto {
                                    leadingCrossDim += fmax(0, remainingCrossDim / 2)
                                } else {
                                    leadingCrossDim += fmax(0, remainingCrossDim)
                                }
                            } else if alignItem == AlignItems.center {
                                leadingCrossDim += remainingCrossDim / 2
                            } else if alignItem == AlignItems.flexStart {
                                // No-op
                            } else {
                                leadingCrossDim += remainingCrossDim
                            }
//                            if child.style.margin.leading(direction: crossAxis) == StyleValue.auto &&
//                                   child.style.margin.trailing(direction: crossAxis) == StyleValue.auto {
//                                leadingCrossDim += fmax(0, remainingCrossDim / 2)
//                            } else if child.style.margin.trailing(direction: crossAxis) == StyleValue.auto {
//                                // No-op
//                            } else if child.style.margin.leading(direction: crossAxis) == StyleValue.auto {
//                                leadingCrossDim += fmax(0, remainingCrossDim)
//                            } else if alignItem == AlignItems.center {
//                                leadingCrossDim += remainingCrossDim / 2
//                            } else if alignItem == AlignItems.flexStart {
//                                // No-op
//                            } else {
//                                leadingCrossDim += remainingCrossDim
//                            }
                        }
                        child.box.position[crossAxis] += totalLineCrossDim + leadingCrossDim
                    }
                }
            }
            totalLineCrossDim += crossDim
            maxLineMainDim = fmax(maxLineMainDim, mainDim)
            lineCount += 1
            startOfLineIndex = endOfLineIndex
        }
        // STEP 8: MULTI-LINE CONTENT ALIGNMENT
        if performLayout && (lineCount > 1 || isBaselineLayout) && !availableInnerCrossDim.isNaN {
            let remainingAlignContentDim = availableInnerCrossDim - totalLineCrossDim
            var crossDimLead = 0.0
            var currentLead = leadingPaddingAndBorderCross
            switch style.alignContent {
            case .flexEnd:
                currentLead += remainingAlignContentDim
            case .center:
                currentLead += remainingAlignContentDim / 2
            case .stretch:
                if availableInnerCrossDim > totalLineCrossDim {
                    crossDimLead = remainingAlignContentDim / Double(lineCount)
                }
            case .spaceAround:
                if availableInnerCrossDim > totalLineCrossDim {
                    currentLead += remainingAlignContentDim / Double(2 * lineCount)
                    if lineCount > 1 {
                        crossDimLead = remainingAlignContentDim / Double(lineCount)
                    }
                } else {
                    currentLead += remainingAlignContentDim / 2
                }
            case .spaceBetween:
                if availableInnerCrossDim > totalLineCrossDim && lineCount > 1 {
                    crossDimLead = remainingAlignContentDim / Double(lineCount - 1)
                }
            default:
                break
            }
            var endIndex = 0
            for i in 0..<lineCount {
                let startIndex = endIndex
                var lineHeight = 0.0
                var maxAscentForCurrentLine = 0.0
                var maxDescentForCurrentLine = 0.0
                var ii = startIndex
                for child: FlexLayout in children[startIndex..<children.count] {
                    if child.style.hidden {
                        ii += 1
                        continue
                    }
                    if !child.style.absoluteLayout {
                        if child.lineIndex != i {
                            break
                        }
                        if child.box.isLayoutDimensionDefined(for: crossAxis) {
                            lineHeight = fmax(lineHeight, child.box.measuredDimension(for: crossAxis) +
                                child.style.totalOuterSize(for: crossAxis, width: availableInnerWidth))
                        }
                        if computedAlignItem(child: child) == AlignItems.baseline {
                            let ascent = child._baseline +
                                child.style.leadingMargin(for: .column, width: availableInnerWidth)
                            let descent = child.box.measuredDimension(for: .column) +
                                child.style.totalOuterSize(for: .column, width: availableInnerWidth) - ascent
                            maxAscentForCurrentLine = fmax(maxAscentForCurrentLine, ascent)
                            maxDescentForCurrentLine = fmax(maxDescentForCurrentLine, descent)
                            lineHeight = fmax(lineHeight, maxAscentForCurrentLine + maxDescentForCurrentLine)
                        }
                    }
                    ii += 1
                }
                endIndex = ii
                lineHeight += crossDimLead
                if performLayout {
                    for child: FlexLayout in children[startIndex..<endIndex] {
                        if child.style.hidden {
                            continue
                        }
                        if !child.style.absoluteLayout {
                            switch computedAlignItem(child: child) {
                            case .flexStart:
                                child.box.position[crossAxis] = currentLead + child.style.leadingMargin(for: crossAxis, width: availableInnerWidth)
                            case .flexEnd:
                                child.box.position[crossAxis] = currentLead + lineHeight -
                                    child.style.trailingMargin(for: crossAxis, width: availableInnerWidth) -
                                    child.box.measuredDimension(for: crossAxis)
                            case .center:
                                child.box.position[crossAxis] = currentLead +
                                    (lineHeight - child.box.measuredDimension(for: crossAxis)) / 2
                            case .stretch:
                                child.box.position[crossAxis] = currentLead +
                                    child.style.leadingMargin(for: crossAxis, width: availableInnerWidth)
                                if !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCrossDim) {
                                    let childWidth: Double = isMainAxisRow ? (child.box.measuredWidth + child.style.totalOuterSize(for: mainAxis, width: availableInnerWidth)) : lineHeight
                                    let childHeight: Double = isMainAxisRow ? lineHeight : (child.box.measuredHeight + child.style.totalOuterSize(for: crossAxis, width: availableInnerWidth))
                                    if !((childWidth == child.box.measuredWidth) && (childHeight == child.box.measuredHeight)) {
                                        _ = child.layoutInternal(width: childWidth, height: childHeight, widthMode: .exactly, heightMode: .exactly, parentWidth: availableInnerWidth, parentHeight: availableInnerHeight, direction: direction, layout: true, reason: "multiline-stretch")
                                    }
                                }
                            case .baseline:
                                child.box.position.top = currentLead + maxAscentForCurrentLine - child._baseline + child.style.leadingPosition(for: .column, size: availableInnerCrossDim)
                            }
                        }
                    }
                }
                currentLead += lineHeight
            }
        }
        // STEP 9: COMPUTING FINAL DIMENSIONS
        box.measuredWidth = style.bound(axis: .row, value: width - marginAxisRow, axisSize: parentWidth, width: parentWidth)
        box.measuredHeight = style.bound(axis: .column, value: height - marginAxisColumn, axisSize: parentHeight, width: parentWidth)
        if measureModeMainDim == MeasureMode.undefined || (!style.overflow.scrolled && measureModeMainDim.isAtMost) {
            box.setMeasuredDimension(for: mainAxis, size: style.bound(axis: mainAxis, value: maxLineMainDim, axisSize: mainAxisParentSize, width: parentWidth))
        } else if measureModeMainDim.isAtMost && style.overflow.scrolled {
            box.setMeasuredDimension(for: mainAxis, size: fmax(fmin(availableInnerMainDim + paddingAndBorderAxisMain, style.bound(axis: mainAxis, value: maxLineMainDim, axisSize: mainAxisParentSize)), paddingAndBorderAxisMain))
        }
        if measureModeCrossDim == MeasureMode.undefined || (!style.overflow.scrolled && measureModeCrossDim.isAtMost) {
            box.setMeasuredDimension(for: crossAxis, size: style.bound(axis: crossAxis, value: totalLineCrossDim + paddingAndBorderAxisCross, axisSize: crossAxisParentSize, width: parentWidth))
        } else if measureModeCrossDim.isAtMost && style.overflow.scrolled {
            box.setMeasuredDimension(for: crossAxis, size: fmax(fmin(availableInnerCrossDim + paddingAndBorderAxisCross, style.bound(axis: crossAxis, value: totalLineCrossDim + paddingAndBorderAxisCross, axisSize: crossAxisParentSize)), paddingAndBorderAxisCross))
        }
        if performLayout && style.flexWrap == FlexWrap.wrapReverse {
            for child: FlexLayout in children {
                if !child.style.absoluteLayout {
                    child.box.position[crossAxis] = box.measuredDimension(for: crossAxis) - child.box.position[crossAxis] - child.box.measuredDimension(for: crossAxis)
                }
            }
        }
        if performLayout {
            // STEP 10: SIZING AND POSITIONING ABSOLUTE CHILDREN
            currentAbsoluteChild = firstAbsoluteChild
            while (currentAbsoluteChild != nil) {
                if let child = currentAbsoluteChild {
                    absoluteLayout(child: child, width: availableInnerWidth, widthMode: (isMainAxisRow ? measureModeMainDim : measureModeCrossDim), height: availableInnerHeight, direction: direction)
                }
                currentAbsoluteChild = currentAbsoluteChild?.nextChild
            }
            // STEP 11: SETTING TRAILING POSITIONS FOR CHILDREN
            let needsMainTrailingPos = mainAxis.reversed
            let needsCrossTrailingPos: Bool = crossAxis.reversed
            if needsMainTrailingPos || needsCrossTrailingPos {
                for child: FlexLayout in children {
                    if child.style.hidden {
                        continue
                    }
                    if needsMainTrailingPos {
                        setChildTrailingPosition(child: child, direction: mainAxis)
                    }
                    if needsCrossTrailingPos {
                        setChildTrailingPosition(child: child, direction: crossAxis)
                    }
                }
            }
        }
    }

    // YGNodeAbsoluteLayoutChild
    func absoluteLayout(child: FlexLayout, width: Double, widthMode: MeasureMode, height: Double, direction: Direction) {
        let mainAxis = style.flexDirection.resolve(by: direction)
        let crossAxis = mainAxis.cross(by: direction)
        let isMainAxisRow = mainAxis.isRow
        var childWidth = Double.nan
        var childHeight = Double.nan
        var childWidthMeasureMode = MeasureMode.undefined
        var childHeightMeasureMode = MeasureMode.undefined
        let marginRow: Double = child.style.totalOuterSize(for: .row, width: width)
        let marginColumn: Double = child.style.totalOuterSize(for: .column, width: width)
        if child.box.isDimensionDefined(for: .row, size: width) {
            childWidth = child.box.resolvedWidth.resolve(by: width) + marginRow
        } else {
            // If the child doesn't have a specified width, compute the width based
            // on the left/right offsets if they're defined.
            if child.style.isLeadingPositionDefined(for: .row) && child.style.isTrailingPositionDefined(for: .row) {
                childWidth = box.measuredWidth - style.totalBorder(for: .row) - child.style.leadingPosition(for: .row, size: width) - child.style.trailingPosition(for: .row, size: width)
                childWidth = child.style.bound(axis: .row, value: childWidth, axisSize: width, width: width)
            }
        }
        if child.box.isDimensionDefined(for: .column, size: height) {
            childHeight = child.box.resolvedHeight.resolve(by: height) + marginColumn
        } else {
            // If the child doesn't have a specified height, compute the height
            // based on the top/bottom offsets if they're defined.
            if child.style.isLeadingPositionDefined(for: .column) && child.style.isTrailingPositionDefined(for: .column) {
                childHeight = box.measuredHeight - style.totalBorder(for: .column) - child.style.leadingPosition(for: .column, size: height) - child.style.trailingPosition(for: .column, size: height)
                childHeight = child.style.bound(axis: .column, value: childHeight, axisSize: height, width: width)
            }
        }
        // true  ^ true  = false true  ^ false = true
        // false ^ true  = true  false ^ false = false
        // Exactly one dimension needs to be defined for us to be able to do aspect ratio
        // calculation. One dimension being the anchor and the other being flexible.
        if childWidth.isNaN != childHeight.isNaN {
            if !child.style.aspectRatio.isNaN {
                if childWidth.isNaN {
                    childWidth = marginRow + (childHeight - marginColumn) * child.style.aspectRatio
                } else if childHeight.isNaN {
                    childHeight = marginColumn + (childWidth - marginRow) / child.style.aspectRatio
                }
            }
        }
        // If we're still missing one or the other dimension, measure the content.
        if childWidth.isNaN || childHeight.isNaN {
            childWidthMeasureMode = childWidth.isNaN ? .undefined : .exactly
            childHeightMeasureMode = childHeight.isNaN ? .undefined : .exactly
            // If the size of the parent is defined then try to constrain the absolute child to that size
            // as well. This allows text within the absolute child to wrap to the size of its parent.
            // This is the same behavior as many browsers implement.
            if !isMainAxisRow && childWidth.isNaN && childWidthMeasureMode != MeasureMode.undefined && width > 0 {
                childWidth = width
                childWidthMeasureMode = .atMost
            }
            _ = child.layoutInternal(width: childWidth, height: childHeight, widthMode: childWidthMeasureMode, heightMode: childHeightMeasureMode, parentWidth: childWidth, parentHeight: childHeight, direction: direction, layout: false, reason: "abs-measure")
            childWidth = child.box.measuredWidth + child.style.totalOuterSize(for: .row, width: width)
            childHeight = child.box.measuredHeight + child.style.totalOuterSize(for: .column, width: width)
        }
        _ = child.layoutInternal(width: childWidth, height: childHeight, widthMode: .exactly, heightMode: .exactly, parentWidth: childWidth, parentHeight: childHeight, direction: direction, layout: true, reason: "abs-layout")
        if child.style.isTrailingPositionDefined(for: mainAxis) && !child.style.isLeadingPositionDefined(for: mainAxis) {
            let size: Double = box.measuredDimension(for: mainAxis) - child.box.measuredDimension(for: mainAxis) - style.trailingBorder(for: mainAxis) - child.style.trailingMargin(for: mainAxis, width: width) - child.style.trailingPosition(for: mainAxis, size: (isMainAxisRow ? width : height))
            child.box.position.setLeading(direction: mainAxis, size: size)
        } else if !child.style.isLeadingPositionDefined(for: mainAxis) && style.justifyContent == JustifyContent.center {
            let size: Double = (box.measuredDimension(for: mainAxis) - child.box.measuredDimension(for: mainAxis)) / 2
            child.box.position.setLeading(direction: mainAxis, size: size)
        } else if !child.style.isTrailingPositionDefined(for: crossAxis) && style.justifyContent == JustifyContent.flexEnd {
            let size = box.measuredDimension(for: mainAxis) - child.box.measuredDimension(for: mainAxis)
            child.box.position.setLeading(direction: mainAxis, size: size)
        }
        if child.style.isTrailingPositionDefined(for: crossAxis) && !child.style.isLeadingPositionDefined(for: crossAxis) {
            let size: Double = box.measuredDimension(for: crossAxis) - child.box.measuredDimension(for: crossAxis) - style.trailingBorder(for: crossAxis) - child.style.trailingMargin(for: crossAxis, width: width) - child.style.trailingPosition(for: crossAxis, size: (isMainAxisRow ? height : width))
            child.box.position.setLeading(direction: crossAxis, size: size)
        } else if !child.style.isLeadingPositionDefined(for: crossAxis) && computedAlignItem(child: child) == AlignItems.center {
            let size: Double = (box.measuredDimension(for: crossAxis) - child.box.measuredDimension(for: crossAxis)) / 2
            child.box.position.setLeading(direction: crossAxis, size: size)
        } else if !child.style.isTrailingPositionDefined(for: crossAxis) && ((computedAlignItem(child: child) == AlignItems.flexEnd) != (style.flexWrap == FlexWrap.wrapReverse)) {
            let size = box.measuredDimension(for: crossAxis) - child.box.measuredDimension(for: crossAxis)
            child.box.position.setLeading(direction: crossAxis, size: size)
        }
    }
}
