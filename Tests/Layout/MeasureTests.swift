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

@testable import StartPoint
import XCTest

// Generated from YGMeasureTest.cpp
class MeasureTests: FlexTestCase {
    var measureCount = 0

    func _measure(width: CGFloat, widthMode: MeasureMode, height: CGFloat, heightMode: MeasureMode) -> CGSize {
        measureCount += 1
        return CGSize(width: 10, height: 10)
    }

    func _simulate_wrapping_text(width: CGFloat, widthMode: MeasureMode, height: CGFloat, heightMode: MeasureMode)
        -> CGSize {
        if widthMode.isUndefined || width >= 68 {
            return CGSize(width: 68, height: 16)
        }
        return CGSize(width: 50, height: 32)
    }

    func _measure_assert_negative(width: CGFloat, widthMode: MeasureMode, height: CGFloat, heightMode: MeasureMode)
        -> CGSize {
        XCTAssertGreaterThanOrEqual(width, 0)
        XCTAssertGreaterThanOrEqual(height, 0)
        return CGSize.zero
    }

    func _measure_90_10(width: CGFloat, widthMode: MeasureMode, height: CGFloat, heightMode: MeasureMode)
        -> CGSize {
        return CGSize(width: 90, height: 10)
    }

    override func setUp() {
        measureCount = 0
    }

    // Generated from test: dont_measure_single_grow_shrink_child
    func testDontMeasureSingleGrowShrinkChild() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = MeasureLayout()
        root_child0._measure = _measure
        root_child0.flexGrow(1)
        root_child0.flexShrink(1)
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(measureCount, 0)
    }

    // Generated from test: measure_absolute_child_with_no_constraints
    func testMeasureAbsoluteChildWithNoConstraints() {
        let root = FlexLayout()

        let root_child0 = FlexLayout()
        root.append(root_child0)

        let root_child0_child0 = MeasureLayout()
        root_child0_child0.positionType(PositionType.absolute)
        root_child0_child0._measure = _measure
        root_child0.append(root_child0_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(measureCount, 1)
    }

    // Generated from test: dont_measure_when_min_equals_max
    func testDontMeasureWhenMinEqualsMax() {
        let root = FlexLayout()
        root.alignItems(.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = MeasureLayout()
        root_child0._measure = _measure
        root_child0.minWidth(StyleValue.length(10))
        root_child0.maxWidth(StyleValue.length(10))
        root_child0.minHeight(StyleValue.length(10))
        root_child0.maxHeight(StyleValue.length(10))
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(measureCount, 0)
        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: dont_measure_when_min_equals_max_percentages
    func testDontMeasureWhenMinEqualsMaxPercentages() {
        let root = FlexLayout()
        root.alignItems(.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = MeasureLayout()
        root_child0._measure = _measure
        root_child0.minWidth(StyleValue.percentage(10))
        root_child0.maxWidth(StyleValue.percentage(10))
        root_child0.minHeight(StyleValue.percentage(10))
        root_child0.maxHeight(StyleValue.percentage(10))
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(measureCount, 0)
        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: measure_nodes_with_margin_auto_and_stretch
    func testMeasureNodesWithMarginAutoAndStretch() {
        let root = FlexLayout()
        root.width(StyleValue.length(500))
        root.height(StyleValue.length(500))

        let root_child0 = MeasureLayout()
        root_child0._measure = _measure
        root_child0.margin(left: StyleValue.auto)
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 490)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: dont_measure_when_min_equals_max_mixed_width_percent
    func testDontMeasureWhenMinEqualsMaxMixedWidthPercent() {
        let root = FlexLayout()
        root.alignItems(.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = MeasureLayout()
        root_child0._measure = _measure
        root_child0.minWidth(StyleValue.percentage(10))
        root_child0.maxWidth(StyleValue.percentage(10))
        root_child0.minHeight(StyleValue.length(10))
        root_child0.maxHeight(StyleValue.length(10))
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(measureCount, 0)
        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: dont_measure_when_min_equals_max_mixed_height_percent
    func testDontMeasureWhenMinEqualsMaxMixedHeightPercent() {
        let root = FlexLayout()
        root.alignItems(.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = MeasureLayout()
        root_child0._measure = _measure
        root_child0.minWidth(StyleValue.length(10))
        root_child0.maxWidth(StyleValue.length(10))
        root_child0.minHeight(StyleValue.percentage(10))
        root_child0.maxHeight(StyleValue.percentage(10))
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(measureCount, 0)
        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: measure_enough_size_should_be_in_single_line
    func testMeasureEnoughSizeShouldBeInSingleLine() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))

        let root_child0 = MeasureLayout()
        root_child0.alignSelf(.flexStart)
        root_child0._measure = _simulate_wrapping_text

        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.width, 68)
        XCTAssertEqual(root_child0.box.height, 16)
    }

    // Generated from test: measure_not_enough_size_should_wrap
    func testMeasureNotEnoughSizeShouldWrap() {
        let root = FlexLayout()
        root.width(StyleValue.length(55))

        let root_child0 = MeasureLayout()
        root_child0.alignSelf(.flexStart)
        root_child0._measure = _simulate_wrapping_text

        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 32)
    }

    // Generated from test: measure_zero_space_should_grow
    func testMeasureZeroSpaceShouldGrow() {
        let root = FlexLayout()
        root.height(StyleValue.length(200))
        root.flexDirection(FlexDirection.column)
        root.flexGrow(0)

        let root_child0 = MeasureLayout()
        root_child0.flexDirection(FlexDirection.column)
        root_child0.padding(value: StyleValue.length(100))
        root_child0._measure = _measure

        root.append(root_child0)

        root.calculate(width: 282, height: Double.nan, direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.width, 282)
        XCTAssertEqual(root_child0.box.top, 0)
    }

    // Generated from test: measure_flex_direction_row_and_padding
    func testMeasureFlexDirectionRowAndPadding() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.padding(left: StyleValue.length(25))
        root.padding(top: StyleValue.length(25))
        root.padding(right: StyleValue.length(25))
        root.padding(bottom: StyleValue.length(25))
        root.width(StyleValue.length(50))
        root.height(StyleValue.length(50))

        let root_child0 = MeasureLayout()
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(5))
        root_child1.height(StyleValue.length(5))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 25)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 75)
        XCTAssertEqual(root_child1.box.top, 25)
        XCTAssertEqual(root_child1.box.width, 5)
        XCTAssertEqual(root_child1.box.height, 5)
    }

    // Generated from test: measure_flex_direction_column_and_padding
    func testMeasureFlexDirectionColumnAndPadding() {
        let root = FlexLayout()
        root.margin(top: StyleValue.length(20))
        root.padding(value: StyleValue.length(25))
        root.width(StyleValue.length(50))
        root.height(StyleValue.length(50))

        let root_child0 = MeasureLayout()
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(5))
        root_child1.height(StyleValue.length(5))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 20)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 25)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 32)

        XCTAssertEqual(root_child1.box.left, 25)
        XCTAssertEqual(root_child1.box.top, 57)
        XCTAssertEqual(root_child1.box.width, 5)
        XCTAssertEqual(root_child1.box.height, 5)
    }

    // Generated from test: measure_flex_direction_row_no_padding
    func testMeasureFlexDirectionRowNoPadding() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.margin(top: StyleValue.length(20))
        root.width(StyleValue.length(50))
        root.height(StyleValue.length(50))

        let root_child0 = MeasureLayout()
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(5))
        root_child1.height(StyleValue.length(5))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 20)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 5)
        XCTAssertEqual(root_child1.box.height, 5)
    }

    // Generated from test: measure_flex_direction_row_no_padding_align_items_flexstart
    func testMeasureFlexDirectionRowNoPaddingAlignItemsFlexstart() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.margin(top: StyleValue.length(20))
        root.width(StyleValue.length(50))
        root.height(StyleValue.length(50))
        root.alignItems(.flexStart)

        let root_child0 = MeasureLayout()
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(5))
        root_child1.height(StyleValue.length(5))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 20)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 32)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 5)
        XCTAssertEqual(root_child1.box.height, 5)
    }

    // Generated from test: measure_with_fixed_size
    func testMeasureWithFixedSize() {
        let root = FlexLayout()
        root.margin(top: StyleValue.length(20))
        root.padding(value: StyleValue.length(25))
        root.width(StyleValue.length(50))
        root.height(StyleValue.length(50))

        let root_child0 = MeasureLayout()
        root_child0._measure = _simulate_wrapping_text
        root_child0.width(StyleValue.length(10))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(5))
        root_child1.height(StyleValue.length(5))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 20)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 25)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 25)
        XCTAssertEqual(root_child1.box.top, 35)
        XCTAssertEqual(root_child1.box.width, 5)
        XCTAssertEqual(root_child1.box.height, 5)
    }

    // Generated from test: measure_with_flex_shrink
    func testMeasureWithFlexShrink() {
        let root = FlexLayout()
        root.margin(top: StyleValue.length(20))
        root.padding(value: StyleValue.length(25))
        root.width(StyleValue.length(50))
        root.height(StyleValue.length(50))

        let root_child0 = MeasureLayout()
        root_child0._measure = _simulate_wrapping_text
        root_child0.flexShrink(1)
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(5))
        root_child1.height(StyleValue.length(5))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 20)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 25)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 25)
        XCTAssertEqual(root_child1.box.top, 25)
        XCTAssertEqual(root_child1.box.width, 5)
        XCTAssertEqual(root_child1.box.height, 5)
    }

    // Generated from test: measure_no_padding
    func testMeasureNoPadding() {
        let root = FlexLayout()
        root.margin(top: StyleValue.length(20))
        root.width(StyleValue.length(50))
        root.height(StyleValue.length(50))

        let root_child0 = MeasureLayout()
        root_child0._measure = _simulate_wrapping_text
        root_child0.flexShrink(1)
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(5))
        root_child1.height(StyleValue.length(5))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 20)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 32)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 32)
        XCTAssertEqual(root_child1.box.width, 5)
        XCTAssertEqual(root_child1.box.height, 5)
    }

    // Generated from test: can_nullify_measure_func_on_any_node
    func testCanNullifyMeasureFuncOnAnyNode() {
        let root = MeasureLayout()
        root.append(FlexLayout())

        root._measure = nil
        XCTAssertNil(root._measure)
    }

    // Generated from test: cant_call_negative_measure
    func testCantCallNegativeMeasure() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.column)
        root.width(StyleValue.length(50))
        root.height(StyleValue.length(10))

        let root_child0 = MeasureLayout()
        root_child0._measure = _measure_assert_negative
        root_child0.margin(top: StyleValue.length(20))
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)
    }

    // Generated from test: cant_call_negative_measure_horizontal
    func testCantCallNegativeMeasureHorizontal() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(10))
        root.height(StyleValue.length(20))

        let root_child0 = MeasureLayout()
        root_child0._measure = _measure_assert_negative
        root_child0.margin(leading: StyleValue.length(20))
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)
    }

    // Generated from test: percent_with_text_node
    func testPercentWithTextNode() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.justifyContent(JustifyContent.spaceBetween)
        root.alignItems(.center)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(80))

        let root_child0 = FlexLayout()
        root.append(root_child0)

        let root_child1 = MeasureLayout()

        root_child1._measure = _measure_90_10
        root_child1.maxWidth(StyleValue.percentage(50))
        root_child1.padding(top: StyleValue.percentage(50))
        root.append(root_child1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 40)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 15)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)
    }
}
