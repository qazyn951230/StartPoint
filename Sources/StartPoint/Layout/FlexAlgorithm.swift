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
import CoreGraphics

final class CollectFlexItems {
    var itemsOnLine: Int = 0
    var sizeConsumedOnCurrentLine: Double = 0.0
    var totalFlexGrowFactors: Double = 0.0
    var totalFlexShrinkScaledFactors: Double = 0.0
    var endOfLineIndex: Int = 0
    var relativeChildren: [FlexLayout] = []
    var remainingFreeSpace: Double = 0.0
    var mainDim: Double = 0.0
    var crossDim: Double = 0.0
}

final class FlexAlgorithm {
    // YGNodelayoutImpl
    let availableWidth: Double
    let availableHeight: Double
    let ownerDirection: Direction
    let widthMeasureMode: MeasureMode
    let heightMeasureMode: MeasureMode
    let ownerWidth: Double
    let ownerHeight: Double
    let performLayout: Bool

    let node: FlexLayout
    let style: FlexStyle

    let direction: Direction
    let mainAxis: FlexDirection
    let crossAxis: FlexDirection
    let isMainAxisRow: Bool
    let isNodeFlexWrap: Bool
    let mainAxisOwnerSize: Double
    let crossAxisOwnerSize: Double
    let totalLeadingCross: Double
    // paddingAndBorderAxisMain
    let totalInnerMain: Double
    // paddingAndBorderAxisCross
    let totalInnerCross: Double
    let totalInnerRow: Double
    let totalInnerColumn: Double
    let marginRow: Double
    let marginColumn: Double
    let minInnerWidth: Double
    let maxInnerWidth: Double
    let minInnerHeight: Double
    let maxInnerHeight: Double
    let minInnerMain: Double
    let maxInnerMain: Double

    var mainMeasureMode: MeasureMode
    var crossMeasureMode: MeasureMode
    // for step2
    var availableInnerWidth: Double = 0.0
    var availableInnerHeight: Double = 0.0
    var availableInnerMain: Double = 0.0
    var availableInnerCross: Double = 0.0
    // for step3
    var totalOuterFlexBasis: Double = 0.0
    var flexBasisOverflows = false
    // for step4
    var totalLineCrossDim: Double = 0.0
    var maxLineMainDim: Double = 0.0
    // for step6
    var containerCrossAxis: Double = 0.0

    // STEP 1: CALCULATE VALUES FOR REMAINDER OF ALGORITHM
    init(for layout: FlexLayout, ownerDirection: Direction,
         availableWidth: Double, availableHeight: Double,
         widthMeasureMode: MeasureMode, heightMeasureMode: MeasureMode,
         ownerWidth: Double, ownerHeight: Double, performLayout: Bool) {
        self.availableWidth = availableWidth
        self.availableHeight = availableHeight
        self.ownerDirection = ownerDirection
        self.widthMeasureMode = widthMeasureMode
        self.heightMeasureMode = heightMeasureMode
        self.ownerWidth = ownerWidth
        self.ownerHeight = ownerHeight
        self.performLayout = performLayout

        node = layout
        style = layout.style
        direction = style.resolveDirection(by: ownerDirection)

        mainAxis = style.flexDirection.resolve(by: direction)
        crossAxis = mainAxis.cross(by: direction)
        isMainAxisRow = mainAxis.isRow
        isNodeFlexWrap = style.wrapped
        mainAxisOwnerSize = isMainAxisRow ? ownerWidth : ownerHeight
        crossAxisOwnerSize = isMainAxisRow ? ownerHeight : ownerWidth
        totalLeadingCross = style.totalLeadingSize(for: crossAxis, width: ownerWidth)
        totalInnerMain = style.totalInnerSize(for: mainAxis, width: ownerWidth)
        totalInnerCross = style.totalInnerSize(for: crossAxis, width: ownerWidth)
        totalInnerRow = isMainAxisRow ? totalInnerMain : totalInnerCross
        totalInnerColumn = isMainAxisRow ? totalInnerCross : totalInnerMain
        marginRow = style.totalOuterSize(for: .row, width: ownerWidth)
        marginColumn = style.totalOuterSize(for: .column, width: ownerWidth)
        minInnerWidth = style.minWidth.resolve(by: ownerWidth) - totalInnerRow
        maxInnerWidth = style.computedMaxWidth.resolve(by: ownerWidth) - totalInnerRow
        minInnerHeight = style.minHeight.resolve(by: ownerHeight) - totalInnerColumn
        maxInnerHeight = style.computedMaxHeight.resolve(by: ownerHeight) - totalInnerColumn
        minInnerMain = isMainAxisRow ? minInnerWidth : minInnerHeight
        maxInnerMain = isMainAxisRow ? maxInnerWidth : maxInnerHeight

        mainMeasureMode = isMainAxisRow ? widthMeasureMode : heightMeasureMode
        crossMeasureMode = isMainAxisRow ? heightMeasureMode : widthMeasureMode
    }

    func steps() {
        step2()
        step3()
        step4()
        step9()
        step10()
        step11()
    }

    // STEP 2: DETERMINE AVAILABLE SIZE IN MAIN AND CROSS DIRECTIONS
    private func step2() {
        availableInnerWidth = availableInnerSize(for: .row, availableSize: availableWidth, size: ownerWidth)
        availableInnerHeight = availableInnerSize(for: .column, availableSize: availableHeight, size: ownerHeight)
        availableInnerMain = isMainAxisRow ? availableInnerWidth : availableInnerHeight
        availableInnerCross = isMainAxisRow ? availableInnerHeight : availableInnerWidth
    }

    // STEP 3: DETERMINE FLEX BASIS FOR EACH ITEM
    private func step3() {
        totalOuterFlexBasis = computeFlexBasis()
        flexBasisOverflows = mainMeasureMode.isUndefined ? false : totalOuterFlexBasis > availableInnerWidth
        if isNodeFlexWrap && flexBasisOverflows && mainMeasureMode.isAtMost {
            mainMeasureMode = MeasureMode.exactly
        }
    }

    // STEP 4: COLLECT FLEX ITEMS INTO FLEX LINES
    private func step4() {
        var startOfLineIndex = 0
        var endOfLineIndex = 0
        var lineCount = 0
        var items = CollectFlexItems()
        let childCount = node.children.count
        while endOfLineIndex < childCount {
            items = calculateCollectFlexItems(lineCount, startOfLineIndex)
            endOfLineIndex = items.endOfLineIndex
            let canSkipFlex = !performLayout && crossMeasureMode.isExactly
            step5(items: items, canSkipFlex: canSkipFlex)
            step6(items: items, startOfLineIndex)
            step7(items: items, startOfLineIndex, endOfLineIndex)
            lineCount += 1
            startOfLineIndex = endOfLineIndex
        }
        step8(lineCount, node.isBaselineLayout)
    }

    // STEP 5: RESOLVING FLEXIBLE LENGTHS ON MAIN AXIS
    private func step5(items: CollectFlexItems, canSkipFlex: Bool) {
        var sizeBasedOnContent = false
        if !mainMeasureMode.isExactly {
            if !minInnerMain.isNaN && items.sizeConsumedOnCurrentLine < minInnerMain {
                availableInnerMain = minInnerMain
            } else if !maxInnerMain.isNaN && items.sizeConsumedOnCurrentLine > maxInnerMain {
                availableInnerMain = maxInnerMain
            } else {
                if items.totalFlexGrowFactors == 0 || node.computedFlexGrow == 0 {
                    availableInnerMain = items.sizeConsumedOnCurrentLine
                }
                sizeBasedOnContent = true
            }
        }
        if !sizeBasedOnContent && !availableInnerMain.isNaN {
            items.remainingFreeSpace = availableInnerMain - items.sizeConsumedOnCurrentLine
        } else if items.sizeConsumedOnCurrentLine < 0 {
            items.remainingFreeSpace = 0 - items.sizeConsumedOnCurrentLine
        }
        if !canSkipFlex {
            resolveFlexibleLength(items: items)
        }
        node.box.hasOverflow = node.box.hasOverflow || (items.remainingFreeSpace < 0)
    }

    // STEP 6: MAIN-AXIS JUSTIFICATION & CROSS-AXIS SIZE DETERMINATION
    private func step6(items: CollectFlexItems, _ startOfLineIndex: Int) {
        justifyMainAxis(items, startOfLineIndex)
        containerCrossAxis = availableInnerCross
        if !crossMeasureMode.isExactly {
            containerCrossAxis = style.bound(axis: crossAxis, value: items.crossDim + totalInnerCross,
                axisSize: crossAxisOwnerSize, width: ownerWidth) - totalInnerCross
        }
        if !isNodeFlexWrap && crossMeasureMode.isExactly {
            items.crossDim = availableInnerCross
        }
        // Clamp to the min/max size specified on the container.
        items.crossDim = style.bound(axis: crossAxis, value: items.crossDim + totalInnerCross,
            axisSize: crossAxisOwnerSize, width: ownerWidth) - totalInnerCross
    }

    // STEP 7: CROSS-AXIS ALIGNMENT
    // We can skip child alignment if we're just measuring the container.
    private func step7(items: CollectFlexItems, _ startOfLineIndex: Int, _ endOfLineIndex: Int) {
        if performLayout {
            for child: FlexLayout in node.children[startOfLineIndex..<endOfLineIndex]
                where !child.style.hidden {
                if child.style.absoluteLayout {
                    // If the child is absolutely positioned and has a top/left/bottom/right
                    // set, override all the previously computed positions to set it correctly.
                    // isLeadingPositionDefined
                    let leadingDefined = child.style.isLeadingPositionDefined(for: crossAxis)
                    if leadingDefined {
                        child.box.position[crossAxis] = style.leadingBorder(for: crossAxis) +
                            child.style.leadingPosition(for: crossAxis, size: availableInnerCross) +
                            child.style.leadingMargin(for: crossAxis, width: availableInnerWidth)
                    }
                    if !leadingDefined || child.box.position.leading(direction: crossAxis).isNaN {
                        // If leading position is not defined or calculations result in Nan, default to border + margin
                        child.box.position[crossAxis] = style.leadingBorder(for: crossAxis) +
                            child.style.leadingMargin(for: crossAxis, width: availableInnerWidth)
                    }
                } else {
                    var leadingCrossDim = totalLeadingCross
                    let alignItem = node.computedAlignItem(child: child)
                    if (alignItem == AlignItems.stretch &&
                        child.style.margin.leading(direction: crossAxis) != StyleValue.auto &&
                        child.style.margin.trailing(direction: crossAxis) != StyleValue.auto) {
                        if !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCross) {
                            var childMainSize: Double = child.box.measuredDimension(for: mainAxis)
                            var childCrossSize: Double = 0.0
                            let aspectRatio = child.style.aspectRatio
                            if aspectRatio.isNaN {
                                childCrossSize = items.crossDim
                            } else {
                                childCrossSize = child.style.totalOuterSize(for: crossAxis, width: availableInnerWidth)
                                if isMainAxisRow {
                                    childCrossSize += childMainSize / aspectRatio
                                } else {
                                    childCrossSize += childMainSize * aspectRatio
                                }
                            }
                            childMainSize += child.style.totalOuterSize(for: mainAxis, width: availableInnerWidth)
                            var childMainMeasureMode = MeasureMode.exactly
                            var childCrossMeasureMode = MeasureMode.exactly
                            (childMainMeasureMode, childMainSize) = child.style.constrainMaxSize(axis: mainAxis,
                                parentAxisSize: availableInnerMain, parentWidth: availableInnerWidth,
                                mode: childMainMeasureMode, size: childMainSize)
                            (childCrossMeasureMode, childCrossSize) = child.style.constrainMaxSize(axis: crossAxis,
                                parentAxisSize: availableInnerCross, parentWidth: availableInnerWidth,
                                mode: childCrossMeasureMode, size: childCrossSize)
                            let childWidth = isMainAxisRow ? childMainSize : childCrossSize
                            let childHeight = isMainAxisRow ? childCrossSize : childMainSize
                            let childWidthMeasureMode: MeasureMode =
                                childWidth.isNaN ? MeasureMode.undefined : MeasureMode.exactly
                            let childHeightMeasureMode: MeasureMode =
                                childHeight.isNaN ? MeasureMode.undefined : MeasureMode.exactly
                            _ = child.layoutInternal(width: childWidth, height: childHeight,
                                widthMode: childWidthMeasureMode, heightMode: childHeightMeasureMode,
                                parentWidth: availableInnerWidth, parentHeight: availableInnerHeight,
                                direction: direction, layout: true, reason: "stretch")
                        }
                    } else {
                        let remainingCrossDim = containerCrossAxis -
                            child.dimensionWithMargin(for: crossAxis, width: availableInnerWidth)
                        if (child.style.margin.leading(direction: crossAxis) == StyleValue.auto &&
                            child.style.margin.trailing(direction: crossAxis) == StyleValue.auto) {
                            leadingCrossDim += fmax(0, remainingCrossDim / 2)
                        } else if child.style.margin.trailing(direction: crossAxis) == StyleValue.auto {
                            // No-op
                        } else if child.style.margin.leading(direction: crossAxis) == StyleValue.auto  {
                            leadingCrossDim += fmax(0, remainingCrossDim)
                        } else if alignItem == AlignItems.flexStart {
                            // No-op
                        } else if alignItem == AlignItems.center {
                            leadingCrossDim += remainingCrossDim / 2
                        } else {
                            leadingCrossDim += remainingCrossDim
                        }
                    }
                    child.box.position[crossAxis] += totalLineCrossDim + leadingCrossDim
                }
            }
        }
        totalLineCrossDim += items.crossDim
        maxLineMainDim = fmax(maxLineMainDim, items.mainDim)
    }

    // STEP 8: MULTI-LINE CONTENT
    private func step8(_ lineCount: Int, _ isBaselineLayout: Bool) {
        guard performLayout && (lineCount > 1 || isBaselineLayout) else {
            return
        }
        var crossDimLead: Double = 0.0
        var currentLead: Double = totalLeadingCross
        if !availableInnerCross.isNaN {
            let remainingAlignContentDim = availableInnerCross - totalLineCrossDim
            switch style.alignContent {
            case .flexStart:
                break
            case .flexEnd:
                currentLead += remainingAlignContentDim
            case .center:
                currentLead += remainingAlignContentDim / 2
            case .stretch:
                if availableInnerCross > totalLineCrossDim {
                    crossDimLead = remainingAlignContentDim / Double(lineCount)
                }
            case .spaceAround:
                if availableInnerCross > totalLineCrossDim {
                    currentLead += remainingAlignContentDim / Double(2 * lineCount)
                    if lineCount > 1 {
                        crossDimLead = remainingAlignContentDim / Double(lineCount)
                    }
                } else {
                    currentLead += remainingAlignContentDim / 2
                }
            case .spaceBetween:
                if availableInnerCross > totalLineCrossDim && lineCount > 1 {
                    crossDimLead = remainingAlignContentDim / Double(lineCount - 1)
                }
            }
        }
        var endIndex = 0
        for i in 0..<lineCount {
            let startIndex = endIndex
            // compute the line's height and find the endIndex
            var lineHeight = 0.0
            var maxAscentForCurrentLine = 0.0
            var maxDescentForCurrentLine = 0.0
            var ii = startIndex
            for child: FlexLayout in node.children[startIndex...] {
                if child.style.hidden {
                    ii += 1
                    continue
                }
                if !child.style.absoluteLayout {
                    if child.lineIndex != i {
                        break
                    }
                    if child.box.isLayoutDimensionDefined(for: crossAxis) {
                        lineHeight = fmax(lineHeight,
                            child.box.measuredDimension(for: crossAxis) +
                            child.style.totalOuterSize(for: crossAxis, width: availableInnerWidth))
                    }
                    if node.computedAlignItem(child: child) == AlignItems.baseline {
                        let ascent: Double = child.baseline() +
                            child.style.leadingMargin(for: .column, width: availableInnerWidth)
                        let descent: Double = child.box.measuredDimension(for: .column) - ascent +
                            child.style.totalOuterSize(for: .column, width: availableInnerWidth)
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
                for child: FlexLayout in node.children[startIndex..<endIndex]
                    where !child.style.hidden && !child.style.absoluteLayout {
                    switch node.computedAlignItem(child: child) {
                    case .flexStart:
                        child.box.position[crossAxis] = currentLead +
                            child.style.leadingMargin(for: crossAxis, width: availableInnerWidth)
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
                        if !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCross) {
                            let childWidth: Double
                            let childHeight: Double
                            if isMainAxisRow {
                                childWidth = child.box.measuredWidth +
                                    child.style.totalOuterSize(for: mainAxis, width: availableInnerWidth)
                                childHeight = lineHeight
                            } else {
                                childWidth = lineHeight
                                childHeight = child.box.measuredHeight +
                                    child.style.totalOuterSize(for: crossAxis, width: availableInnerWidth)
                            }
                            // !(a == b && c == d) => a != b || c != d
                            if childWidth != child.box.measuredWidth || childHeight != child.box.measuredHeight {
                                _ = child.layoutInternal(width: childWidth, height: childHeight,
                                    widthMode: MeasureMode.exactly, heightMode: MeasureMode.exactly,
                                    parentWidth: availableInnerWidth, parentHeight: availableInnerHeight,
                                    direction: direction, layout: true, reason: "multiline-stretch")
                            }
                        }
                    case .baseline:
                        child.box.position.top = currentLead + maxAscentForCurrentLine -
                            child.baseline() + child.style.leadingPosition(for: .column, size: availableInnerCross)
                    }
                }
            }
            currentLead += lineHeight
        }
    }

    // STEP 9: COMPUTING FINAL DIMENSIONS
    private func step9() {
        node.box.measuredWidth = style.bound(axis: FlexDirection.row,
            value: availableWidth - marginRow, axisSize: ownerWidth, width: ownerWidth)
        node.box.measuredHeight = style.bound(axis: FlexDirection.column,
            value: availableHeight - marginColumn, axisSize: ownerHeight, width: ownerWidth)
        if mainMeasureMode.isUndefined || (!style.overflow.scrolled && mainMeasureMode.isAtMost) {
            let size: Double = style.bound(axis: mainAxis, value: maxLineMainDim,
                axisSize: mainAxisOwnerSize, width: ownerWidth)
            node.box.setMeasuredDimension(for: mainAxis, size: size)
        } else if mainMeasureMode.isAtMost && style.overflow.scrolled {
            var size: Double = style.bound(for: mainAxis, value: maxLineMainDim, size: mainAxisOwnerSize)
            size = fmax(fmin(availableInnerMain + totalInnerMain, size), totalInnerMain)
            node.box.setMeasuredDimension(for: mainAxis, size: size)
        }
        if crossMeasureMode.isUndefined || (!style.overflow.scrolled && crossMeasureMode.isAtMost) {
            let size: Double = style.bound(axis: crossAxis, value: totalLineCrossDim + totalInnerCross,
                axisSize: crossAxisOwnerSize, width: ownerWidth)
            node.box.setMeasuredDimension(for: crossAxis, size: size)
        } else if crossMeasureMode.isAtMost && style.overflow.scrolled {
            var size: Double = style.bound(for: crossAxis, value: totalLineCrossDim + totalInnerCross,
                size: crossAxisOwnerSize)
            size = fmax(fmin(availableInnerCross + totalInnerCross, size), totalInnerCross)
            node.box.setMeasuredDimension(for: crossAxis, size: size)
        }
        guard performLayout && style.flexWrap == FlexWrap.wrapReverse else {
            return
        }
        for child in node.children where child.style.relativeLayout {
            child.box.position[crossAxis] = node.box.measuredDimension(for: crossAxis) -
                child.box.position[crossAxis] -
                child.box.measuredDimension(for: crossAxis)
        }
    }

    // STEP 10: SIZING AND POSITIONING ABSOLUTE CHILDREN
    private func step10() {
        guard performLayout else {
            return
        }
        for child in node.children where child.style.absoluteLayout {
            node.absoluteLayout(child: child, width: availableInnerWidth,
                widthMode: (isMainAxisRow ? mainMeasureMode : crossMeasureMode),
                height: availableInnerHeight, direction: direction)
        }
    }

    // STEP 11: SETTING TRAILING POSITIONS FOR CHILDREN
    private func step11() {
        let needsMainTrailingPos: Bool = mainAxis.reversed
        let needsCrossTrailingPos: Bool = crossAxis.reversed
        guard needsMainTrailingPos || needsCrossTrailingPos else {
            return
        }
        for child: FlexLayout in node.children where !child.style.hidden {
            if needsMainTrailingPos {
                node.setChildTrailingPosition(child: child, direction: mainAxis)
            }
            if needsCrossTrailingPos {
                node.setChildTrailingPosition(child: child, direction: crossAxis)
            }
        }
    }

    // YGNodeComputeFlexBasisForChildren
    private func computeFlexBasis() -> Double {
        var totalOuterFlexBasis: Double = 0.0
        let singleFlexChild: FlexLayout? = mainMeasureMode.isExactly ? node.findFlexChild() : nil
        for child: FlexLayout in node.children {
            child.resolveDimensions()
            if child.style.display == Display.none {
                child.zeroLayout()
                child.hasNewLayout = true
                child.dirty = false
                continue
            }
            if (performLayout) {
                let childDirection: Direction = child.style.resolveDirection(by: direction)
                let mainSize: Double = mainAxis.isRow ? availableInnerWidth : availableInnerHeight
                let crossSize: Double = mainAxis.isRow ? availableInnerHeight : availableInnerWidth
                child.setPosition(for: childDirection, main: mainSize, cross: crossSize,
                    width: availableInnerWidth)
            }
            if (child.style.absoluteLayout) {
                continue
            }
            if (child == singleFlexChild) {
                child.box.computedFlexBasis = 0
            } else {
                node.resolveFlexBasis(for: child,
                    width: availableInnerWidth, widthMode: widthMeasureMode,
                    height: availableInnerHeight, heightMode: heightMeasureMode,
                    parentWidth: availableInnerWidth, parentHeight: availableInnerHeight,
                    direction: direction)
            }
            totalOuterFlexBasis += child.box.computedFlexBasis +
                child.style.totalOuterSize(for: mainAxis, width: availableInnerWidth)
        }
        let flexBasisOverflows = mainMeasureMode.isUndefined ? false : totalOuterFlexBasis > availableInnerWidth
        let isNodeFlexWrap = style.wrapped
        if isNodeFlexWrap && flexBasisOverflows && mainMeasureMode.isAtMost {
            mainMeasureMode = MeasureMode.exactly
        }
        return totalOuterFlexBasis
    }

    // YGResolveFlexibleLength
    private func resolveFlexibleLength(items: CollectFlexItems) {
        let originalFreeSpace = items.remainingFreeSpace
        distributeFreeSpace(items)
        let size = distributeFreeSpace2(items)
        items.remainingFreeSpace = originalFreeSpace - size
    }

    // YGDistributeFreeSpaceFirstPass
    private func distributeFreeSpace(_ items: CollectFlexItems) {
        var flexShrinkScaledFactor = 0.0
        var flexGrowFactor = 0.0
        var baseMainSize = 0.0
        var boundMainSize = 0.0
        var deltaFreeSpace = 0.0
        for child in items.relativeChildren {
            let childFlexBasis = child.style.bound(for: mainAxis,
                value: child.box.computedFlexBasis, size: mainAxisOwnerSize)
            if items.remainingFreeSpace < 0 {
                flexShrinkScaledFactor = (0 - child.computedFlexShrink) * childFlexBasis
                // Is this child able to shrink?
                if !flexShrinkScaledFactor.isNaN && flexShrinkScaledFactor != 0 {
                    baseMainSize = childFlexBasis + items.remainingFreeSpace /
                        items.totalFlexShrinkScaledFactors * flexShrinkScaledFactor
                    boundMainSize = child.style.bound(axis: mainAxis, value: baseMainSize,
                        axisSize: availableInnerMain, width: availableInnerWidth)
                    if !baseMainSize.isNaN && !boundMainSize.isNaN && baseMainSize != boundMainSize {
                        // By excluding this item's size and flex factor from remaining, this
                        // item's min/max constraints should also trigger in the second pass
                        // resulting in the item's size calculation being identical in the
                        // first and second passes.
                        deltaFreeSpace += boundMainSize - childFlexBasis
                        items.totalFlexShrinkScaledFactors -= flexShrinkScaledFactor
                    }
                }
            } else if !items.remainingFreeSpace.isNaN && items.remainingFreeSpace > 0 {
                flexGrowFactor = child.computedFlexGrow
                // Is this child able to grow?
                if !flexGrowFactor.isNaN && flexGrowFactor != 0 {
                    baseMainSize = childFlexBasis + items.remainingFreeSpace /
                        items.totalFlexGrowFactors * flexGrowFactor
                    boundMainSize = child.style.bound(axis: mainAxis, value: baseMainSize,
                        axisSize: availableInnerMain, width: availableInnerWidth)
                    if !baseMainSize.isNaN && !boundMainSize.isNaN && baseMainSize != boundMainSize {
                        deltaFreeSpace += boundMainSize - childFlexBasis
                        items.totalFlexGrowFactors -= flexGrowFactor
                    }
                }
            }
        }
        items.remainingFreeSpace -= deltaFreeSpace
    }

    // YGDistributeFreeSpaceSecondPass
    private func distributeFreeSpace2(_ items: CollectFlexItems) -> Double {
        var flexShrinkScaledFactor = 0.0
        var flexGrowFactor = 0.0
        var deltaFreeSpace = 0.0
        for child in items.relativeChildren {
            let childFlexBasis = child.style.bound(for: mainAxis,
                value: child.box.computedFlexBasis, size: mainAxisOwnerSize)
            var updatedMainSize = childFlexBasis
            if !items.remainingFreeSpace.isNaN && items.remainingFreeSpace < 0 {
                flexShrinkScaledFactor = (0 - child.computedFlexShrink) * childFlexBasis
                // Is this child able to shrink?
                if flexShrinkScaledFactor != 0 {
                    let childSize: Double
                    if !items.totalFlexShrinkScaledFactors.isNaN && items.totalFlexShrinkScaledFactors == 0 {
                        childSize = childFlexBasis + flexShrinkScaledFactor
                    } else {
                        childSize = childFlexBasis + items.remainingFreeSpace /
                            items.totalFlexShrinkScaledFactors * flexShrinkScaledFactor
                    }
                    updatedMainSize = child.style.bound(axis: mainAxis, value: childSize,
                        axisSize: availableInnerMain, width: availableInnerWidth)
                }
            } else if !items.remainingFreeSpace.isNaN && items.remainingFreeSpace > 0 {
                flexGrowFactor = child.computedFlexGrow
                // Is this child able to grow?
                if !flexGrowFactor.isNaN && flexGrowFactor != 0 {
                    updatedMainSize = child.style.bound(axis: mainAxis,
                        value: childFlexBasis + items.remainingFreeSpace / items.totalFlexGrowFactors * flexGrowFactor,
                        axisSize: availableInnerMain, width: availableInnerWidth)
                }
            }
            deltaFreeSpace += updatedMainSize - childFlexBasis
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
                childCrossMeasureMode = MeasureMode.exactly
                childCrossSize += marginCross
            } else if (!availableInnerCross.isNaN &&
                !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCross) &&
                crossMeasureMode.isExactly &&
                !(isNodeFlexWrap && flexBasisOverflows) &&
                node.computedAlignItem(child: child) == AlignItems.stretch &&
                child.style.margin.leading(direction: crossAxis) != StyleValue.auto &&
                child.style.margin.trailing(direction: crossAxis) != StyleValue.auto) {
                childCrossSize = availableInnerCross
                childCrossMeasureMode = MeasureMode.exactly
            } else if !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCross) {
                childCrossSize = availableInnerCross
                childCrossMeasureMode = childCrossSize.isNaN ? MeasureMode.undefined : MeasureMode.atMost
            } else {
                let size: StyleValue = child.box.computedDimension(by: crossAxis)
                let flag: Bool
                if case StyleValue.percentage = size {
                    flag = true
                } else {
                    flag = false
                }
                childCrossSize = size.resolve(by: availableInnerCross) + marginCross
                // isLoosePercentageMeasurement
                let loose = flag && !crossMeasureMode.isExactly
                childCrossMeasureMode = (childCrossSize.isNaN || loose) ? MeasureMode.undefined : MeasureMode.exactly
            }
            (childMainMeasureMode, childMainSize) = child.style.constrainMaxSize(axis: mainAxis,
                parentAxisSize: availableInnerMain, parentWidth: availableInnerWidth,
                mode: childMainMeasureMode, size: childMainSize)
            (childCrossMeasureMode, childCrossSize) = child.style.constrainMaxSize(axis: crossAxis,
                parentAxisSize: availableInnerCross, parentWidth: availableInnerWidth,
                mode: childCrossMeasureMode, size: childCrossSize)
            let requiresStretchLayout = !child.box.isDimensionDefined(for: crossAxis, size: availableInnerCross) &&
                node.computedAlignItem(child: child) == AlignItems.stretch &&
                child.style.margin.leading(direction: crossAxis) != StyleValue.auto &&
                child.style.margin.trailing(direction: crossAxis) != StyleValue.auto
            let childWidth = isMainAxisRow ? childMainSize : childCrossSize
            let childHeight = !isMainAxisRow ? childMainSize : childCrossSize
            let childWidthMeasureMode = isMainAxisRow ? childMainMeasureMode : childCrossMeasureMode
            let childHeightMeasureMode = isMainAxisRow ? childCrossMeasureMode : childMainMeasureMode
            _ = child.layoutInternal(width: childWidth, height: childHeight,
                widthMode: childWidthMeasureMode, heightMode: childHeightMeasureMode,
                parentWidth: availableInnerWidth, parentHeight: availableInnerHeight,
                direction: direction, layout: performLayout && !requiresStretchLayout,
                reason: "flex")
            node.box.hasOverflow = node.box.hasOverflow || child.box.hasOverflow
        }
        return deltaFreeSpace
    }

    // YGCalculateCollectFlexItemsRowValues
    private func calculateCollectFlexItems(_ lineCount: Int, _ startOfLineIndex: Int) -> CollectFlexItems {
        let items = CollectFlexItems()
        items.relativeChildren.reserveCapacity(node.children.count)
        // sizeConsumedOnCurrentLineIncludingMinConstraint
        var sizeConsumed: Double = 0.0
        var endOfLineIndex: Int = startOfLineIndex
        for child in node.children[startOfLineIndex...] {
            if (child.style.hidden || child.style.absoluteLayout) {
                endOfLineIndex += 1
                continue
            }
            child.lineIndex = lineCount
            let childMarginMain = child.style.totalOuterSize(for: mainAxis, width: availableInnerWidth)
            // flexBasisWithMinAndMaxConstraints
            let flexBasis = child.style.bound(for: mainAxis, value: child.box.computedFlexBasis,
                size: mainAxisOwnerSize)
            if sizeConsumed + flexBasis + childMarginMain > availableInnerMain &&
                   isNodeFlexWrap && items.itemsOnLine > 0 {
                break
            }
            sizeConsumed += flexBasis + childMarginMain
            items.sizeConsumedOnCurrentLine += flexBasis + childMarginMain
            items.itemsOnLine += 1
            if child.flexible {
                items.totalFlexGrowFactors += child.computedFlexGrow
                items.totalFlexShrinkScaledFactors += (0 - child.computedFlexShrink) * child.box.computedFlexBasis
            }
            items.relativeChildren.append(child)
            endOfLineIndex += 1
        }
        // The total flex factor needs to be floored to 1.
        if items.totalFlexGrowFactors > 0 && items.totalFlexGrowFactors < 1 {
            items.totalFlexGrowFactors = 1
        }
        // The total flex shrink factor needs to be floored to 1.
        if items.totalFlexShrinkScaledFactors > 0 && items.totalFlexShrinkScaledFactors < 1 {
            items.totalFlexShrinkScaledFactors = 1
        }
        items.endOfLineIndex = endOfLineIndex
        return items
    }

    // YGJustifyMainAxis
    private func justifyMainAxis(_ items: CollectFlexItems, _ startOfLineIndex: Int) {
        let leadingInnerMain = style.totalLeadingSize(for: mainAxis, width: ownerWidth)
        let trailingInnerMain = style.totalTrailingSize(for: mainAxis, width: ownerWidth)
        if mainMeasureMode.isAtMost && items.remainingFreeSpace > 0 {
            let minMainSize = style.minDimension(by: mainAxis).resolve(by: mainAxisOwnerSize)
            if !minMainSize.isNaN {
                let minAvailableMain: Double = minMainSize - leadingInnerMain - trailingInnerMain
                // occupiedSpaceByChildNodes
                let occupied: Double = availableInnerMain - items.remainingFreeSpace
                items.remainingFreeSpace = fmax(0, minAvailableMain - occupied)
            } else {
                items.remainingFreeSpace = 0
            }
        }
        var numberOfAutoMarginsOnCurrentLine: Int = 0
        for child: FlexLayout in node.children[startOfLineIndex..<items.endOfLineIndex]
            where child.style.relativeLayout {
            if child.style.margin.leading(direction: mainAxis) == StyleValue.auto {
                numberOfAutoMarginsOnCurrentLine += 1
            }
            if child.style.margin.trailing(direction: mainAxis) == StyleValue.auto {
                numberOfAutoMarginsOnCurrentLine += 1
            }
        }
        var leadingMainDim: Double = 0.0
        var betweenMainDim: Double = 0.0
        if numberOfAutoMarginsOnCurrentLine == 0 {
            switch style.justifyContent {
            case .center:
                leadingMainDim = items.remainingFreeSpace / 2
            case .flexEnd:
                leadingMainDim = items.remainingFreeSpace
            case .spaceBetween:
                if items.itemsOnLine > 1 {
                    betweenMainDim = fmax(items.remainingFreeSpace, 0) / Double(items.itemsOnLine - 1)
                } else {
                    betweenMainDim = 0
                }
            case .spaceEvenly: // Space is distributed evenly across all elements
                betweenMainDim = items.remainingFreeSpace / Double(items.itemsOnLine + 1)
                leadingMainDim = betweenMainDim
            case .spaceAround:
                betweenMainDim = items.remainingFreeSpace / Double(items.itemsOnLine)
                leadingMainDim = betweenMainDim / 2
            case .flexStart:
                break
            }
        }
        items.mainDim = leadingInnerMain + leadingMainDim
        items.crossDim = 0.0
        let baselineLayout: Bool = node.isBaselineLayout
        var maxAscentForCurrentLine: Double = 0.0
        var maxDescentForCurrentLine: Double = 0.0
        for child: FlexLayout in node.children[startOfLineIndex..<items.endOfLineIndex]
            where !child.style.hidden {
            if child.style.absoluteLayout && child.style.isLeadingPositionDefined(for: mainAxis) {
                if performLayout {
                    // In case the child is position absolute and has left/top being defined,
                    // we override the position to whatever the user said (and margin/border).
                    child.box.position[mainAxis] = style.leadingBorder(for: mainAxis) +
                        child.style.leadingPosition(for: mainAxis, size: availableInnerMain) +
                        child.style.leadingMargin(for: mainAxis, width: availableInnerWidth)
                }
            } else {
                // Now that we placed the element, we need to update the variables.
                // We need to do that only for relative elements. Absolute elements do not
                // take part in that phase.
                if child.style.relativeLayout {
                    if child.style.margin.leading(direction: mainAxis) == StyleValue.auto {
                        items.mainDim += items.remainingFreeSpace / Double(numberOfAutoMarginsOnCurrentLine)
                    }
                    if performLayout {
                        child.box.position[mainAxis] += items.mainDim
                    }
                    if child.style.margin.trailing(direction: mainAxis) == StyleValue.auto {
                        items.mainDim += items.remainingFreeSpace / Double(numberOfAutoMarginsOnCurrentLine)
                    }
                    let canSkipFlex = !performLayout && crossMeasureMode.isExactly
                    if canSkipFlex {
                        items.mainDim += betweenMainDim + child.box.computedFlexBasis +
                            child.style.totalOuterSize(for: mainAxis, width: availableInnerWidth)
                        items.crossDim = availableInnerCross
                    } else {
                        items.mainDim += betweenMainDim + child.dimensionWithMargin(for: mainAxis, width: availableInnerWidth)
                        if baselineLayout {
                            let ascent = child.baseline() + child.style.leadingMargin(for: .column,
                                width: availableInnerWidth)
                            let descent = child.box.measuredHeight + child.style.totalOuterSize(for: .column,
                                width: availableInnerWidth) - ascent
                            maxAscentForCurrentLine = fmax(maxAscentForCurrentLine, ascent)
                            maxDescentForCurrentLine = fmax(maxDescentForCurrentLine, descent)
                        } else {
                            items.crossDim = fmax(items.crossDim, child.dimensionWithMargin(for: crossAxis, width: availableInnerWidth))
                        }
                    }
                } else if performLayout {
                    child.box.position[mainAxis] += style.leadingBorder(for: mainAxis) + leadingMainDim
                }
            }
        }
        items.mainDim += trailingInnerMain
        if baselineLayout {
            items.crossDim = maxAscentForCurrentLine + maxDescentForCurrentLine
        }
    }
    
    // YGNodeCalculateAvailableInnerDim
    private func availableInnerSize(for axis: FlexDirection, availableSize: Double, size: Double) -> Double {
        let isWidth = axis.isRow
        let direction: FlexDirection = isWidth ? FlexDirection.row : FlexDirection.column
        let margin = style.totalOuterSize(for: direction, width: size)
        let innerSize = style.totalInnerSize(for: direction, width: size)
        let available = availableSize - margin - innerSize
        if available.isNaN {
            return available
        }
        var minSize: Double
        var manSize: Double
        if isWidth {
            minSize = style.minWidth.resolve(by: size)
            manSize = style.computedMaxWidth.resolve(by: size)
        } else {
            minSize = style.minHeight.resolve(by: size)
            manSize = style.computedMaxHeight.resolve(by: size)
        }
        minSize = minSize.isNaN ? 0.0 : minSize - innerSize
        manSize = manSize.isNaN ? Double.greatestFiniteMagnitude : manSize - innerSize
        return fmax(fmin(available, manSize), minSize)
    }
}

extension FlexLayout {
    // YGNode::resolveDimension
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

    // YGNode::setPosition
    func setPosition(for direction: Direction, main mainSize: Double, cross crossSize: Double,
                     width ownerWidth: Double) {
        let direction = parent != nil ? direction : Direction.ltr
        let mainAxis = style.resolveFlexDirection(by: direction)
        let crossAxis = mainAxis.cross(by: direction)
        let mainPosition = style.relativePosition(for: mainAxis, size: mainSize)
        let crossPosition = style.relativePosition(for: crossAxis, size: crossSize)
        box.setLeadingPosition(for: mainAxis,
            size: style.leadingMargin(for: mainAxis, width: ownerWidth) + mainPosition)
        box.setTrailingPosition(for: mainAxis,
            size: style.leadingMargin(for: mainAxis, width: ownerWidth) + mainPosition)
        box.setLeadingPosition(for: crossAxis,
            size: style.leadingMargin(for: crossAxis, width: ownerWidth) + crossPosition)
        box.setTrailingPosition(for: crossAxis,
            size: style.leadingMargin(for: crossAxis, width: ownerWidth) + crossPosition)
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
        for child in children where child.flexible {
            if (result != nil || child.computedFlexGrow ~~ 0.0 ||
                child.computedFlexShrink ~~ 0.0) {
                result = nil
                break
            } else {
                result = child
            }
        }
        return result
    }

    // YGZeroOutLayoutRecursivly
    func zeroLayout() {
        invalidate()
        box.width = 0
        box.height = 0
        box.measuredWidth = 0
        box.measuredHeight = 0
        hasNewLayout = true
        copyChildrenIfNeeded()
        children.forEach { child in
            child.zeroLayout()
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
            if child.box.computedFlexBasis.isNaN {
                child.box.computedFlexBasis = fmax(resolvedFlexBasis,
                    child.style.totalInnerSize(for: mainDirection, width: parentWidth))
            }
        } else if isMainAxisRow && isRowStyleDimDefined {
            // The width is definite, so use that as the flex basis.
            child.box.computedFlexBasis = fmax(child.box.resolvedWidth.resolve(by: parentWidth),
                child.style.totalInnerSize(for: .row, width: parentWidth))
        } else if !isMainAxisRow && isColumnStyleDimDefined {
            // The height is definite, so use that as the flex basis.
            child.box.computedFlexBasis = fmax(child.box.resolvedHeight.resolve(by: parentHeight),
                child.style.totalInnerSize(for: .column, width: parentWidth))
        } else {
            // Compute the flex basis and hypothetical main size (i.e. the clamped flex basis).
            childWidth = Double.nan
            childHeight = Double.nan
            let marginRow: Double = child.style.totalOuterSize(for: .row, width: parentWidth)
            let marginColumn: Double = child.style.totalOuterSize(for: .column, width: parentWidth)
            if isRowStyleDimDefined {
                childWidth = child.box.resolvedWidth.resolve(by: parentWidth) + marginRow
                childWidthMeasureMode = MeasureMode.exactly
            }
            if isColumnStyleDimDefined {
                childHeight = child.box.resolvedHeight.resolve(by: parentWidth) + marginColumn
                childHeightMeasureMode = MeasureMode.exactly
            }
            // The W3C spec doesn't say anything about the 'overflow' property,
            // but all major browsers appear to implement the following logic.
            if !isMainAxisRow && style.overflow.scrolled || !style.overflow.scrolled {
                if childWidth.isNaN && !width.isNaN {
                    childWidth = width
                    childWidthMeasureMode = MeasureMode.atMost
                }
            }
            if isMainAxisRow && style.overflow.scrolled || !style.overflow.scrolled {
                if childHeight.isNaN && !height.isNaN {
                    childHeight = height
                    childHeightMeasureMode = MeasureMode.atMost
                }
            }
            if !child.style.aspectRatio.isNaN {
                if !isMainAxisRow && childWidthMeasureMode.isExactly {
                    childHeight = marginColumn + (childWidth - marginRow) / child.style.aspectRatio
                    childHeightMeasureMode = MeasureMode.exactly
                } else if isMainAxisRow && childHeightMeasureMode.isExactly {
                    childWidth = (childHeight - marginColumn) * child.style.aspectRatio
                    childWidthMeasureMode = MeasureMode.exactly
                }
            }
            // If child has no defined size in the cross axis and is set to stretch, set the cross axis to be measured
            // exactly with the available inner width
            let hasExactWidth: Bool = !width.isNaN && widthMode.isExactly
            let childWidthStretch: Bool = computedAlignItem(child: child) == AlignItems.stretch && !childWidthMeasureMode.isExactly
            if !isMainAxisRow && !isRowStyleDimDefined && hasExactWidth && childWidthStretch {
                childWidth = width
                childWidthMeasureMode = MeasureMode.exactly
                if !child.style.aspectRatio.isNaN {
                    childHeight = (childWidth - marginRow) / child.style.aspectRatio
                    childHeightMeasureMode = MeasureMode.exactly
                }
            }
            let hasExactHeight: Bool = !height.isNaN && heightMode.isExactly
            let childHeightStretch: Bool = computedAlignItem(child: child) == AlignItems.stretch && !childHeightMeasureMode.isExactly
            if isMainAxisRow && !isColumnStyleDimDefined && hasExactHeight && childHeightStretch {
                childHeight = height
                childHeightMeasureMode = MeasureMode.exactly
                if !child.style.aspectRatio.isNaN {
                    childWidth = (childHeight - marginColumn) * child.style.aspectRatio
                    childWidthMeasureMode = MeasureMode.exactly
                }
            }
            (childWidthMeasureMode, childWidth) = child.style.constrainMaxSize(axis: .row, parentAxisSize: parentWidth, parentWidth: parentWidth, mode: childWidthMeasureMode, size: childWidth)
            (childHeightMeasureMode, childHeight) = child.style.constrainMaxSize(axis: .column, parentAxisSize: parentHeight, parentWidth: parentWidth, mode: childHeightMeasureMode, size: childHeight)
            // Measure the child
            _ = child.layoutInternal(width: childWidth, height: childHeight, widthMode: childWidthMeasureMode, heightMode: childHeightMeasureMode, parentWidth: parentWidth, parentHeight: parentHeight, direction: direction, layout: false, reason: "measure")
            child.box.computedFlexBasis = max(child.box.measuredDimension(for: mainDirection), child.style.totalInnerSize(for: mainDirection, width: parentWidth))
        }
    }

    // YGLayoutNodeInternal
    internal func layoutInternal(width: Double, height: Double, widthMode: MeasureMode, heightMode: MeasureMode,
                                 parentWidth: Double, parentHeight: Double, direction: Direction,
                                 layout: Bool, reason: String) -> Bool {
        let layoutNeeded = (dirty && box.generation != FlexBox.totalGeneration) || lastParentDirection != direction
        if layoutNeeded {
            // Invalidate the cached results.
            cachedLayout = nil
            cachedMeasurements.removeAll()
        }
        var cachedResult: LayoutCache? = nil
        if children.count < 1 && measureSelf != nil {
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
            hasNewLayout = true
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
        // Set the resolved resolution in the node's layout.
        box.direction = style.resolveDirection(by: direction)
        layoutBox(by: direction, width: parentWidth)

        if children.count > 0 {
            flexLayout(width: width, height: height, direction: direction, widthMode: widthMode,
                heightMode: heightMode, parentWidth: parentWidth, parentHeight: parentHeight, layout: layout)
        } else {
            if measureSelf != nil {
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
            let size = measure(width: innerWidth, widthMode: widthMode, height: innerHeight, heightMode: heightMode)
            let width2 = !widthMode.isExactly ? (size.width + innerSizeRow) : (width - marginRow)
            let height2 = !heightMode.isExactly ? (size.height + innerSizeColumn) : (height - marginColumn)
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
        let _width: Double = (!widthMode.isExactly) ? innerRow : (width - outerRow)
        box.measuredWidth = style.bound(axis: .row, value: _width, axisSize: parentWidth, width: parentWidth)
        let _height: Double = (!heightMode.isExactly) ? innerColumn : (height - outerColumn)
        box.measuredHeight = style.bound(axis: .column, value: _height, axisSize: parentHeight, width: parentWidth)
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
    func flexLayout(width: Double, height: Double, direction: Direction,
                    widthMode: MeasureMode, heightMode: MeasureMode,
                    parentWidth: Double, parentHeight: Double, layout performLayout: Bool) {
        // If we're not being asked to perform a full layout we can skip the algorithm if we already know the size
        if !performLayout && fixedLayout(width: width, height: height, widthMode: widthMode,
            heightMode: heightMode, parentWidth: parentWidth, parentHeight: parentHeight) {
            return
        }
        copyChildrenIfNeeded()
        // Reset layout flags, as they could have changed.
        box.hasOverflow = false
        let algorithm = FlexAlgorithm(for: self, ownerDirection: direction,
            availableWidth: width, availableHeight: height,
            widthMeasureMode: widthMode, heightMeasureMode: heightMode,
            ownerWidth: parentWidth, ownerHeight: parentHeight, performLayout: performLayout)
        algorithm.steps()
    }

    // YGNodeAbsoluteLayoutChild
    func absoluteLayout(child: FlexLayout, width: Double, widthMode: MeasureMode, height: Double,
                        direction: Direction) {
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
                childWidth = box.measuredWidth - style.totalBorder(for: .row) -
                    child.style.leadingPosition(for: .row, size: width) -
                    child.style.trailingPosition(for: .row, size: width)
                childWidth = child.style.bound(axis: .row, value: childWidth, axisSize: width, width: width)
            }
        }
        if child.box.isDimensionDefined(for: .column, size: height) {
            childHeight = child.box.resolvedHeight.resolve(by: height) + marginColumn
        } else {
            // If the child doesn't have a specified height, compute the height
            // based on the top/bottom offsets if they're defined.
            if (child.style.isLeadingPositionDefined(for: .column) &&
                child.style.isTrailingPositionDefined(for: .column)) {
                childHeight = box.measuredHeight - style.totalBorder(for: .column) -
                    child.style.leadingPosition(for: .column, size: height) -
                    child.style.trailingPosition(for: .column, size: height)
                childHeight = child.style.bound(axis: .column, value: childHeight, axisSize: height, width: width)
            }
        }
        // true  ^ true  = false
        // true  ^ false = true
        // false ^ true  = true
        // false ^ false = false
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
            _ = child.layoutInternal(width: childWidth, height: childHeight,
                widthMode: childWidthMeasureMode, heightMode: childHeightMeasureMode,
                parentWidth: childWidth, parentHeight: childHeight, direction: direction,
                layout: false, reason: "abs-measure")
            childWidth = child.box.measuredWidth + child.style.totalOuterSize(for: .row, width: width)
            childHeight = child.box.measuredHeight + child.style.totalOuterSize(for: .column, width: width)
        }
        _ = child.layoutInternal(width: childWidth, height: childHeight,
            widthMode: .exactly, heightMode: .exactly, parentWidth: childWidth,
            parentHeight: childHeight, direction: direction, layout: true, reason: "abs-layout")
        if (child.style.isTrailingPositionDefined(for: mainAxis) &&
            !child.style.isLeadingPositionDefined(for: mainAxis)) {
            let size: Double = box.measuredDimension(for: mainAxis) -
                child.box.measuredDimension(for: mainAxis) - style.trailingBorder(for: mainAxis) -
                child.style.trailingMargin(for: mainAxis, width: width) -
                child.style.trailingPosition(for: mainAxis, size: (isMainAxisRow ? width : height))
            child.box.position.setLeading(direction: mainAxis, size: size)
        } else if (!child.style.isLeadingPositionDefined(for: mainAxis) &&
            style.justifyContent == JustifyContent.center) {
            let size: Double = (box.measuredDimension(for: mainAxis) - child.box.measuredDimension(for: mainAxis)) / 2
            child.box.position.setLeading(direction: mainAxis, size: size)
        } else if (!child.style.isTrailingPositionDefined(for: crossAxis) &&
            style.justifyContent == JustifyContent.flexEnd) {
            let size = box.measuredDimension(for: mainAxis) - child.box.measuredDimension(for: mainAxis)
            child.box.position.setLeading(direction: mainAxis, size: size)
        }
        if (child.style.isTrailingPositionDefined(for: crossAxis) &&
            !child.style.isLeadingPositionDefined(for: crossAxis)) {
            let size: Double = box.measuredDimension(for: crossAxis) -
                child.box.measuredDimension(for: crossAxis) - style.trailingBorder(for: crossAxis) -
                child.style.trailingMargin(for: crossAxis, width: width) -
                child.style.trailingPosition(for: crossAxis, size: (isMainAxisRow ? height : width))
            child.box.position.setLeading(direction: crossAxis, size: size)
        } else if (!child.style.isLeadingPositionDefined(for: crossAxis) &&
            computedAlignItem(child: child) == AlignItems.center) {
            let size: Double = (box.measuredDimension(for: crossAxis) - child.box.measuredDimension(for: crossAxis)) / 2
            child.box.position.setLeading(direction: crossAxis, size: size)
        } else if (!child.style.isTrailingPositionDefined(for: crossAxis) &&
            ((computedAlignItem(child: child) == AlignItems.flexEnd) != (style.flexWrap == FlexWrap.wrapReverse))) {
            let size = box.measuredDimension(for: crossAxis) - child.box.measuredDimension(for: crossAxis)
            child.box.position.setLeading(direction: crossAxis, size: size)
        }
    }
}
