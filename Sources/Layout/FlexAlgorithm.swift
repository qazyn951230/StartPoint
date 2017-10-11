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
            result = resolvedSize.resolve(by: size) + style.totalOuterSize(for: direction)
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
        let mainDirection = style.resolveDirection(by: direction)
        let crossDirection = mainDirection.cross(by: direction)
        let mainPosition = style.relativePosition(for: mainDirection, size: mainSize)
        let crossPosition = style.relativePosition(for: crossDirection, size: crossSize)
        box.setLeadingPosition(direction: mainDirection,
            size: style.margin.leading(direction: mainDirection) + mainPosition)
        box.setTrailingPosition(direction: mainDirection,
            size: style.margin.trailing(direction: mainDirection) + mainPosition)
        box.setLeadingPosition(direction: crossDirection,
            size: style.margin.leading(direction: crossDirection) + crossPosition)
        box.setTrailingPosition(direction: crossDirection,
            size: style.margin.trailing(direction: crossDirection) + crossPosition)
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
        let size = child.box.measuredDimension(direction: direction)
        child.box.setTrailingPosition(direction: direction, size: box.measuredDimension(direction: direction) -
            size - child.box.position[direction])
    }

    // YGNodeDimWithMargin
    func dimensionWithMargin(axis: FlexDirection, width: Double) -> Double {
        return box.measuredDimension(direction: axis) + style.margin.total(direction: axis)
    }

    func measure(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> (Double, Double) {
        let size = measure(width: CGFloat(width), widthMode: widthMode, height: CGFloat(height), heightMode: heightMode)
        return (Double(size.width), Double(size.height))
    }

    // YGNodeComputeFlexBasisForChild
    func resolveFlexBasis(for child: FlexLayout, width: Double, widthMode: MeasureMode, height: Double,
                          heightMode: MeasureMode, parentWidth: Double, parentHeight: Double, direction: Direction) {
        let mainDirection = style.resolveDirection(by: direction)
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
                child.computedFlexBasis = fmax(resolvedFlexBasis, child.style.padding.total(direction: mainDirection) + child.style.border.total(direction: mainDirection))
            }
        } else if isMainAxisRow && isRowStyleDimDefined {
            child.computedFlexBasis = fmax(child.box.resolvedWidth.resolve(by: parentWidth), child.style.padding.total(direction: .row) + child.style.border.total(direction: .row))
        } else if !isMainAxisRow && isColumnStyleDimDefined {
            child.computedFlexBasis = fmax(child.box.resolvedHeight.resolve(by: parentHeight), child.style.padding.total(direction: .column) + child.style.border.total(direction: .column))
        } else {
            childWidth = Double.nan
            childHeight = Double.nan
            let marginRow = child.style.margin.total(direction: .row)
            let marginColumn = child.style.margin.total(direction: .column)
            if isRowStyleDimDefined {
                childWidth = child.box.resolvedWidth.resolve(by: parentWidth) + marginRow
                childWidthMeasureMode = .exactly
            }
            if isColumnStyleDimDefined {
                childHeight = child.box.resolvedHeight.resolve(by: parentWidth) + marginColumn
                childHeightMeasureMode = .exactly
            }
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
            child.computedFlexBasis = max(child.box.measuredDimension(direction: mainDirection), child.style.padding.total(direction: mainDirection) + child.style.border.total(direction: mainDirection))
        }
    }

    // YGLayoutNodeInternal
    internal func layoutInternal(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode,
                                 parentWidth: Double, parentHeight: Double, direction: Direction,
                                 layout performLayout: Bool, reason: String) -> Bool {
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
            let marginRow = style.totalOuterSize(for: .row)
            let marginColumn = style.totalOuterSize(for: .column)
            if let layout = cachedLayout, layout.validate(width: width, height: height, widthMode: widthMode,
                heightMode: heightMode, marginRow: marginRow, marginColumn: marginColumn, scale: FlexStyle.scale) {
                cachedResult = layout
            } else {
                cachedResult = cachedMeasurements.first { cache in
                    return cache.validate(width: width, height: height, widthMode: widthMode, heightMode: heightMode,
                        marginRow: marginRow, marginColumn: marginColumn, scale: FlexStyle.scale)
                }
            }
        } else if performLayout {
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
            layoutImplement(width: width, height: height, direction: direction, widthMode: widthMode,
                heightMode: heightMode, parentWidth: parentWidth, parentHeight: parentHeight, layout: performLayout)
            lastParentDirection = direction
            if cachedResult == nil {
                if cachedMeasurements.count > 20 {
                    cachedMeasurements.removeFirst(10)
                }
                let result = LayoutCache(width: width, height: height, computedWidth: box.measuredWidth,
                    computedHeight: box.measuredHeight, widthMode: widthMode, heightMode: heightMode)
                if performLayout {
                    cachedLayout = result
                } else {
                    cachedMeasurements.append(result)
                }
            }
        }
        if performLayout {
            box.width = box.measuredWidth
            box.height = box.measuredHeight
            dirty = false
        }
        box.generation = FlexBox.totalGeneration
        return (layoutNeeded || cachedResult == nil)
    }

    // YGNodelayoutImpl
    func layoutImplement(width: Double, height: Double, direction: Direction, widthMode: MeasureMode, heightMode: MeasureMode, parentWidth: Double, parentHeight: Double, layout performLayout: Bool) {
        let widthMode: MeasureMode = width.isNaN ? .undefined : widthMode
        let heightMode: MeasureMode = height.isNaN ? .undefined : heightMode
        if children.count > 0 {
            flexLayout(width: width, height: height, direction: direction, widthMode: widthMode,
                heightMode: heightMode, parentWidth: parentWidth, parentHeight: parentHeight, layout: performLayout)
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

    // YGNodeWithMeasureFuncSetMeasuredDimensions
    func measureLayout(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode,
                       parentWidth: Double, parentHeight: Double) {
        let marginRow = style.totalOuterSize(for: .row)
        let marginColumn = style.totalOuterSize(for: .column)
        if widthMode.isExactly && heightMode.isExactly {
            box.measuredWidth = style.bound(axis: .row, value: width - marginRow,
                axisSize: parentWidth, width: parentWidth)
            box.measuredHeight = style.bound(axis: .column, value: height - marginColumn,
                axisSize: parentHeight, width: parentWidth)
        } else {
            let innerSizeRow = style.totalInnerSize(for: .row)
            let innerSizeColumn = style.totalInnerSize(for: .column)
            let innerWidth = width.isNaN ? width : fmax(0, width - innerSizeRow - marginRow)
            let innerHeight = height.isNaN ? height : fmax(0, height - innerSizeColumn - marginColumn)
            let (width1, height1) = measure(width: innerWidth, widthMode: widthMode, height: innerHeight, heightMode: heightMode)
            let width2 = !widthMode.isExactly ? (width1 + innerSizeRow) : (width - marginRow)
            let height2 = !heightMode.isExactly ? (height1 + innerSizeColumn) : (height - marginColumn)
            box.measuredWidth = style.bound(axis: .row, value: width2, axisSize: width, width: width)
            box.measuredHeight = style.bound(axis: .column, value: height2, axisSize: height, width: width)
        }
    }

    // YGNodeEmptyContainerSetMeasuredDimensions
    func emptyLayout(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode,
                     parentWidth: Double, parentHeight: Double) {
        let innerRow = style.totalInnerSize(for: .row)
        let innerColumn = style.totalInnerSize(for: .column)
        let outerRow = style.totalOuterSize(for: .row)
        let outerColumn = style.totalOuterSize(for: .column)
        let width: Double = (!widthMode.isExactly) ? innerRow : (width - outerRow)
        box.measuredWidth = style.bound(axis: .row, value: width, axisSize: parentWidth, width: parentWidth)
        let height: Double = (!heightMode.isExactly) ? innerColumn : (height - outerColumn)
        box.measuredHeight = style.bound(axis: .column, value: height, axisSize: parentHeight, width: parentWidth)
    }

    func fixedLayout(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode,
                     parentWidth: Double, parentHeight: Double) -> Bool {
        guard (widthMode.isAtMost && width <= 0) || (heightMode.isAtMost && height <= 0) ||
                  (widthMode.isExactly && heightMode.isExactly) else {
            return false
        }
        let marginAxisColumn = style.totalOuterSize(for: .column)
        let marginAxisRow = style.totalOuterSize(for: .row)
        let width: Double = (width.isNaN || (widthMode.isAtMost && width <= 0)) ? 0.0 : width - marginAxisRow
        box.measuredWidth = style.bound(axis: .row, value: width, axisSize: parentWidth, width: parentHeight)
        let height: Double = (height.isNaN || (heightMode.isAtMost && height <= 0)) ? 0.0 : height - marginAxisColumn
        box.measuredHeight = style.bound(axis: .column, value: height, axisSize: parentHeight, width: parentWidth)
        return true
    }

    func flexLayout(width: Double, height: Double, direction: Direction, widthMode: MeasureMode, heightMode: MeasureMode, parentWidth: Double, parentHeight: Double, layout performLayout: Bool) {
        if !performLayout && fixedLayout(width: width, height: height, widthMode: widthMode, heightMode: heightMode, parentWidth: parentWidth, parentHeight: parentHeight) {
            return
        }
        let direction = style.resolveLayoutDirection(by: direction)
        // STEP 1: CALCULATE VALUES FOR REMAINDER OF ALGORITHM
        let mainAxis = style.flexDirection.resolve(by: direction)
        let crossAxis = mainAxis.cross(by: direction)
        let isMainAxisRow = mainAxis.isRow
        let paddingAndBorderAxisMain = style.totalInnerSize(for: mainAxis)
        let paddingAndBorderAxisCross = style.totalInnerSize(for: crossAxis)
        let paddingAndBorderAxisRow = isMainAxisRow ? paddingAndBorderAxisMain : paddingAndBorderAxisCross
        let paddingAndBorderAxisColumn = isMainAxisRow ? paddingAndBorderAxisCross : paddingAndBorderAxisMain
        let marginAxisRow: Double = style.totalOuterSize(for: .row)
        let marginAxisColumn: Double = style.totalOuterSize(for: .column)
        // STEP 2: DETERMINE AVAILABLE SIZE IN MAIN AND CROSS DIRECTIONS
        let minInnerWidth = style.minWidth.resolve(by: width) - marginAxisRow - paddingAndBorderAxisRow
        let maxInnerWidth = style.computedMaxWidth.resolve(by: width) - marginAxisRow - paddingAndBorderAxisRow
        let minInnerHeight = style.minHeight.resolve(by: height) - marginAxisColumn - paddingAndBorderAxisColumn
        let maxInnerHeight = style.computedMaxHeight.resolve(by: height) - marginAxisColumn - paddingAndBorderAxisColumn
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
                let childDirection = child.style.resolveLayoutDirection(by: direction)
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
            totalOuterFlexBasis += child.computedFlexBasis + child.style.totalOuterSize(for: mainAxis)
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
        let leadingPaddingAndBorderMain = style.totalLeadingSize(for: mainAxis)
        let trailingPaddingAndBorderMain = style.totalTrailingSize(for: mainAxis)
        let leadingPaddingAndBorderCross = style.totalLeadingSize(for: crossAxis)
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
                    let childMarginMainAxis = child.style.totalOuterSize(for: mainAxis)
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
            if measureModeMainDim != MeasureMode.exactly {
                if !minInnerMainDim.isNaN && sizeConsumedOnCurrentLine < minInnerMainDim {
                    availableInnerMainDim = minInnerMainDim
                } else if !maxInnerMainDim.isNaN && sizeConsumedOnCurrentLine > maxInnerMainDim {
                    availableInnerMainDim = maxInnerMainDim
                } else {
                    if totalFlexGrowFactors == 0 || computedFlexGrow == 0 {
                        availableInnerMainDim = sizeConsumedOnCurrentLine
                    }
                }
            }
            var remainingFreeSpace = 0.0
            if !availableInnerMainDim.isNaN {
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
                    let marginMain = child.style.totalOuterSize(for: mainAxis)
                    let marginCross = child.style.totalOuterSize(for: crossAxis)
                    var childCrossSize = 0.0
                    var childMainSize = updatedMainSize + marginMain
                    var childCrossMeasureMode = MeasureMode.undefined
                    var childMainMeasureMode = MeasureMode.exactly
                    if let t = currentRelativeChild, !t.style.aspectRatio.isNaN {
                        let ratio = t.style.aspectRatio
                        if isMainAxisRow {
                            childCrossSize = (childMainSize - marginMain) / ratio
                        } else {
                            childCrossSize = (childMainSize - marginMain) * ratio
                        }
                        childCrossMeasureMode = .exactly
                        childCrossSize += marginCross
                    } else if !availableInnerCrossDim.isNaN && !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCrossDim) && measureModeCrossDim.isExactly && !(isNodeFlexWrap && flexBasisOverflows) && computedAlignItem(child: child) == AlignItems.stretch {
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
                    let requiresStretchLayout = !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCrossDim) && computedAlignItem(child: child) == AlignItems.stretch
                    let childWidth = isMainAxisRow ? childMainSize : childCrossSize
                    let childHeight = !isMainAxisRow ? childMainSize : childCrossSize
                    let childWidthMeasureMode = isMainAxisRow ? childMainMeasureMode : childCrossMeasureMode
                    let childHeightMeasureMode = isMainAxisRow ? childCrossMeasureMode : childMainMeasureMode
                    _ = child.layoutInternal(width: childWidth, height: childHeight, widthMode: childWidthMeasureMode, heightMode: childHeightMeasureMode, parentWidth: availableInnerWidth, parentHeight: availableInnerHeight, direction: direction, layout: performLayout && !requiresStretchLayout, reason: "flex")
                    currentRelativeChild = currentRelativeChild?.nextChild
                }
            }
            remainingFreeSpace = originalRemainingFreeSpace + deltaFreeSpace
            // STEP 6: MAIN-AXIS JUSTIFICATION & CROSS-AXIS SIZE DETERMINATION
            if measureModeMainDim.isAtMost && remainingFreeSpace > 0 {
                if style.minDimension(by: mainAxis).resolve(by: mainAxisParentSize) >= 0 {
                    remainingFreeSpace = fmax(0, style.minDimension(by: mainAxis).resolve(by: mainAxisParentSize) - (availableInnerMainDim - remainingFreeSpace))
                } else {
                    remainingFreeSpace = 0
                }
            }
            // No support with auto margin
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
            case .spaceAround:
                betweenMainDim = remainingFreeSpace / Double(itemsOnLine)
                leadingMainDim = betweenMainDim / 2
            case .flexStart:
                break
            }
            var mainDim = leadingPaddingAndBorderMain + leadingMainDim
            var crossDim = 0.0
            for child: FlexLayout in children[startOfLineIndex..<endOfLineIndex] {
                if child.style.hidden {
                    continue
                }
                if child.style.absoluteLayout && child.style.isLeadingPositionDefined(for: mainAxis) {
                    if performLayout {
                        child.box.position[mainAxis] = child.style.leadingPosition(for: mainAxis) + style.border.leading(direction: mainAxis) + child.style.margin.leading(direction: mainAxis)
                    }
                } else {
                    if !child.style.absoluteLayout {
                        if performLayout {
                            child.box.position[mainAxis] += mainDim
                        }
                        if canSkipFlex {
                            mainDim += betweenMainDim + child.style.totalOuterSize(for: mainAxis) + child.computedFlexBasis
                            crossDim = availableInnerCrossDim
                        } else {
                            mainDim += betweenMainDim + child.dimensionWithMargin(axis: mainAxis, width: availableInnerWidth)
                            crossDim = fmax(crossDim, child.dimensionWithMargin(axis: crossAxis, width: availableInnerWidth))
                        }
                    } else if performLayout {
                        child.box.position[mainAxis] += style.border.leading(direction: mainAxis) + leadingMainDim
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
                        if child.style.isLeadingPositionDefined(for: crossAxis) {
                            child.box.position[crossAxis] = child.style.leadingPosition(for: crossAxis) + style.border.leading(direction: crossAxis) + child.style.margin.leading(direction: crossAxis)
                        } else {
                            child.box.position[crossAxis] = style.border.leading(direction: crossAxis) + child.style.margin.leading(direction: crossAxis)
                        }
                    } else {
                        var leadingCrossDim = leadingPaddingAndBorderCross
                        let alignItem = computedAlignItem(child: child)
                        if alignItem == AlignItems.stretch {
                            if !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCrossDim) {
                                var childMainSize = child.box.measuredDimension(direction: mainAxis)
                                var childCrossSize = crossDim
                                if !child.style.aspectRatio.isNaN {
                                    let size = isMainAxisRow ? childMainSize / child.style.aspectRatio : childMainSize * child.style.aspectRatio
                                    childCrossSize = child.style.totalOuterSize(for: crossAxis) + size
                                }
                                childMainSize += child.style.totalOuterSize(for: mainAxis)
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
                            let remainingCrossDim = containerCrossAxis - child.dimensionWithMargin(axis: crossAxis, width: availableInnerWidth)
                            if alignItem == AlignItems.center {
                                leadingCrossDim += remainingCrossDim / 2
                            } else if alignItem == AlignItems.flexStart {
                                // Do nothing.
                            } else {
                                leadingCrossDim += remainingCrossDim
                            }
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
                            lineHeight = fmax(lineHeight, child.box.measuredDimension(direction: crossAxis) + child.style.totalOuterSize(for: crossAxis))
                        }
                        if computedAlignItem(child: child) == AlignItems.baseline {
                            let ascent = child.baseline + child.style.margin.leading(direction: .column)
                            let descent = child.box.measuredDimension(direction: .column) + child.style.totalOuterSize(for: .column) - ascent
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
                                child.box.position[crossAxis] = currentLead + child.style.margin.leading(direction: crossAxis)
                            case .flexEnd:
                                child.box.position[crossAxis] = currentLead + lineHeight - child.style.margin.trailing(direction: crossAxis) - child.box.measuredDimension(direction: crossAxis)
                            case .center:
                                child.box.position[crossAxis] = currentLead + (lineHeight - child.box.measuredDimension(direction: crossAxis)) / 2
                            case .stretch:
                                child.box.position[crossAxis] = currentLead + child.style.margin.leading(direction: crossAxis)
                                if !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCrossDim) {
                                    let childWidth: Double = isMainAxisRow ? (child.box.measuredWidth + child.style.totalOuterSize(for: mainAxis)) : lineHeight
                                    let childHeight: Double = isMainAxisRow ? lineHeight : (child.box.measuredHeight + child.style.totalOuterSize(for: crossAxis))
                                    if !((childWidth == child.box.measuredWidth) && (childHeight == child.box.measuredHeight)) {
                                        _ = child.layoutInternal(width: childWidth, height: childHeight, widthMode: .exactly, heightMode: .exactly, parentWidth: availableInnerWidth, parentHeight: availableInnerHeight, direction: direction, layout: true, reason: "multiline-stretch")
                                    }
                                }
                            case .baseline:
                                child.box.position.top = currentLead + maxAscentForCurrentLine - child.baseline + child.style.leadingPosition(for: .column)
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
            box.setMeasuredDimension(direction: mainAxis, size: style.bound(axis: mainAxis, value: maxLineMainDim, axisSize: mainAxisParentSize, width: parentWidth))
        } else if measureModeMainDim.isAtMost && style.overflow.scrolled {
            box.setMeasuredDimension(direction: mainAxis, size: fmax(fmin(availableInnerMainDim + paddingAndBorderAxisMain, style.bound(axis: mainAxis, value: maxLineMainDim, axisSize: mainAxisParentSize)), paddingAndBorderAxisMain))
        }
        if measureModeCrossDim == MeasureMode.undefined || (!style.overflow.scrolled && measureModeCrossDim.isAtMost) {
            box.setMeasuredDimension(direction: crossAxis, size: style.bound(axis: crossAxis, value: totalLineCrossDim + paddingAndBorderAxisCross, axisSize: crossAxisParentSize, width: parentWidth))
        } else if measureModeCrossDim.isAtMost && style.overflow.scrolled {
            box.setMeasuredDimension(direction: crossAxis, size: fmax(fmin(availableInnerCrossDim + paddingAndBorderAxisCross, style.bound(axis: crossAxis, value: totalLineCrossDim + paddingAndBorderAxisCross, axisSize: crossAxisParentSize)), paddingAndBorderAxisCross))
        }
        if performLayout && style.flexWrap == FlexWrap.wrapReverse {
            for child: FlexLayout in children {
                if !child.style.absoluteLayout {
                    child.box.position[crossAxis] = box.measuredDimension(direction: crossAxis) - child.box.position[crossAxis] - child.box.measuredDimension(direction: crossAxis)
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
        let marginRow = child.style.margin.total(direction: .row)
        let marginColumn = child.style.margin.total(direction: .column)
        if child.box.isDimensionDefined(for: .row, size: width) {
            childWidth = child.box.resolvedWidth.resolve(by: width) + marginRow
        } else {
            if child.style.isLeadingPositionDefined(for: .row) && child.style.isTrailingPositionDefined(for: .row) {
                childWidth = box.measuredWidth - style.border.leading(direction: .row) - style.border.trailing(direction: .row) - child.style.leadingPosition(for: .row) - child.style.trailingPosition(for: .row)
                childWidth = child.style.bound(axis: .row, value: childWidth, axisSize: width, width: width)
            }
        }
        if child.box.isDimensionDefined(for: .column, size: height) {
            childHeight = child.box.resolvedHeight.resolve(by: height) + marginColumn
        } else {
            if child.style.isLeadingPositionDefined(for: .column) && child.style.isTrailingPositionDefined(for: .column) {
                childHeight = box.measuredHeight - style.border.leading(direction: .column) - style.border.trailing(direction: .column) - child.style.leadingPosition(for: .column) - child.style.trailingPosition(for: .column)
                childHeight = child.style.bound(axis: .column, value: childHeight, axisSize: height, width: width)
            }
        }
        // true  ^ true  = false true  ^ false = true
        // false ^ true  = true  false ^ false = false
        if childWidth.isNaN != childHeight.isNaN {
            if !child.style.aspectRatio.isNaN {
                if childWidth.isNaN {
                    childWidth = marginRow + (childHeight - marginColumn) * child.style.aspectRatio
                } else if childHeight.isNaN {
                    childHeight = marginColumn + (childWidth - marginRow) / child.style.aspectRatio
                }
            }
        }
        if childWidth.isNaN || childHeight.isNaN {
            childWidthMeasureMode = childWidth.isNaN ? .undefined : .exactly
            childHeightMeasureMode = childHeight.isNaN ? .undefined : .exactly
            if !isMainAxisRow && childWidth.isNaN && childWidthMeasureMode != MeasureMode.undefined && width > 0 {
                childWidth = width
                childWidthMeasureMode = .atMost
            }
            _ = child.layoutInternal(width: childWidth, height: childHeight, widthMode: childWidthMeasureMode, heightMode: childHeightMeasureMode, parentWidth: childWidth, parentHeight: childHeight, direction: direction, layout: false, reason: "abs-measure")
            childWidth = child.box.measuredWidth + child.style.margin.total(direction: .row)
            childHeight = child.box.measuredHeight + child.style.margin.total(direction: .column)
        }
        _ = child.layoutInternal(width: childWidth, height: childHeight, widthMode: .exactly, heightMode: .exactly, parentWidth: childWidth, parentHeight: childHeight, direction: direction, layout: true, reason: "abs-layout")
        if child.style.isTrailingPositionDefined(for: mainAxis) && !child.style.isLeadingPositionDefined(for: mainAxis) {
            let size: Double = box.measuredDimension(direction: mainAxis) - child.box.measuredDimension(direction: mainAxis) - style.border.trailing(direction: mainAxis) - child.style.margin.trailing(direction: mainAxis) - child.style.trailingPosition(for: mainAxis)
            child.box.position.setLeading(direction: mainAxis, size: size)
        } else if !child.style.isLeadingPositionDefined(for: mainAxis) && style.justifyContent == JustifyContent.center {
            let size: Double = (box.measuredDimension(direction: mainAxis) - child.box.measuredDimension(direction: mainAxis)) / 2
            child.box.position.setLeading(direction: mainAxis, size: size)
        } else if !child.style.isTrailingPositionDefined(for: crossAxis) && style.justifyContent == JustifyContent.flexEnd {
            let size = box.measuredDimension(direction: mainAxis) - child.box.measuredDimension(direction: mainAxis)
            child.box.position.setLeading(direction: mainAxis, size: size)
        }
        if child.style.isTrailingPositionDefined(for: crossAxis) && !child.style.isLeadingPositionDefined(for: crossAxis) {
            let size: Double = box.measuredDimension(direction: crossAxis) - child.box.measuredDimension(direction: crossAxis) - style.border.trailing(direction: crossAxis) - child.style.margin.trailing(direction: crossAxis) - child.style.trailingPosition(for: crossAxis)
            child.box.position.setLeading(direction: crossAxis, size: size)
        } else if !child.style.isLeadingPositionDefined(for: crossAxis) && computedAlignItem(child: child) == AlignItems.center {
            let size: Double = (box.measuredDimension(direction: crossAxis) - child.box.measuredDimension(direction: crossAxis)) / 2
            child.box.position.setLeading(direction: crossAxis, size: size)
        } else if !child.style.isTrailingPositionDefined(for: crossAxis) && ((computedAlignItem(child: child) == AlignItems.flexEnd) != (style.flexWrap == FlexWrap.wrapReverse)) {
            let size = box.measuredDimension(direction: crossAxis) - child.box.measuredDimension(direction: crossAxis)
            child.box.position.setLeading(direction: crossAxis, size: size)
        }
    }
}
