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

import XCTest
@testable import StartPoint

class MeasureLayout: FlexLayout {
    var _measure: ((CGFloat, MeasureMode, CGFloat, MeasureMode) -> CGSize)?

    override init(view: LayoutView? = nil) {
        super.init(view: view)
        measureSelf = true
        layoutType = .text // measureSelf ? .text : .default
    }

    override func measure(width: CGFloat, widthMode: MeasureMode, height: CGFloat, heightMode: MeasureMode) -> CGSize {
        return _measure?(width, widthMode, height, heightMode) ?? CGSize.zero
    }
}

    // Generated from YGMeasureTest.cpp
class MeasureTests: FlexTestCase {
    var count = 0

    func _measure(width: CGFloat, widthMode: MeasureMode, height: CGFloat, heightMode: MeasureMode) -> CGSize {
        count += 1
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

    override func setUp() {
        count = 0
    }

    // Generated from test: dont_measure_single_grow_shrink_child
    func testDontMeasureSingleGrowShrinkChild() {
        let root = yogaLayout()
            .width(100)
            .height(100)
        let root_child0 = MeasureLayout()
        root_child0.flexGrow(1)
            .flexShrink(1)
        root_child0._measure = _measure
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(count, 0)
    }

    // Generated from test: measure_absolute_child_with_no_constraints
    func testMeasureAbsoluteChildWithNoConstraints() {
        let root = yogaLayout()
        let root_child0 = yogaLayout()
        root.append(root_child0)
        let root_child0_child0 = MeasureLayout()
        root_child0_child0.positionType(.absolute)
        root_child0_child0._measure = _measure
        root_child0.append(root_child0_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(count, 1)
    }

    // Generated from test: dont_measure_when_min_equals_max
    func testDontMeasureWhenMinEqualsMax() {
        let root = yogaLayout()
            .alignItems(.flexStart)
            .width(100)
            .height(100)
        let root_child0 = MeasureLayout()
        root_child0.minWidth(10)
            .maxWidth(10)
            .minHeight(10)
            .maxHeight(10)
        root_child0._measure = _measure
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(count, 0)
        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: dont_measure_when_min_equals_max_percentages
    func testDontMeasureWhenMinEqualsMaxPercentages() {
        let root = yogaLayout()
            .alignItems(.flexStart)
            .width(100)
            .height(100)
        let root_child0 = MeasureLayout()
        root_child0.minWidth(10)
            .maxWidth(10)
            .minHeight(10)
            .maxHeight(10)
        root_child0._measure = _measure
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(count, 0)
        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: dont_measure_when_min_equals_max_mixed_width_percent
    func testDontMeasureWhenMinEqualsMaxMixedWidthPercent() {
        let root = yogaLayout()
            .alignItems(.flexStart)
            .width(100)
            .height(100)
        let root_child0 = MeasureLayout()
        root_child0.minWidth(10)
            .maxWidth(10)
            .minHeight(10)
            .maxHeight(10)
        root_child0._measure = _measure
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(count, 0)
        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: dont_measure_when_min_equals_max_mixed_height_percent
    func testDontMeasureWhenMinEqualsMaxMixedHeightPercent() {
        let root = yogaLayout()
            .alignItems(.flexStart)
            .width(100)
            .height(100)
        let root_child0 = MeasureLayout()
        root_child0.minWidth(10)
            .maxWidth(10)
            .minHeight(10)
            .maxHeight(10)
        root_child0._measure = _measure
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(count, 0)
        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: measure_enough_size_should_be_in_single_line
    func testMeasureEnoughSizeShouldBeInSingleLine() {
        let root = yogaLayout()
            .width(100)
        let root_child0 = MeasureLayout()
        root_child0.alignSelf(.flexStart)
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root_child0.box.width, 68)
        XCTAssertEqual(root_child0.box.height, 16)
    }

    // Generated from test: measure_not_enough_size_should_wrap
    func testMeasureNotEnoughSizeShouldWrap() {
        let root = yogaLayout()
            .width(55)
        let root_child0 = MeasureLayout()
        root_child0.alignSelf(.flexStart)
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 32)
    }

    // Generated from test: measure_zero_space_should_grow
    func testMeasureZeroSpaceShouldGrow() {
        let root = yogaLayout()
            .height(200)
            .flexDirection(.column)
            .flexGrow(0)
        let root_child0 = MeasureLayout()
        root_child0.flexDirection(.column)
            .padding(100)
        root_child0._measure = _measure
        root.append(root_child0)
        root.calculate(width: 282, direction: .ltr)

        XCTAssertEqual(root_child0.box.width, 282)
        XCTAssertEqual(root_child0.box.top, 0)
    }

    // Generated from test: measure_flex_direction_row_and_padding
    func testMeasureFlexDirectionRowAndPadding() {
        let root = yogaLayout()
            .flexDirection(.row)
            .padding(left: 25)
            .padding(top: 25)
            .padding(right: 25)
            .padding(bottom: 25)
            .width(50)
            .height(50)
        let root_child0 = MeasureLayout()
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)
        let root_child1 = yogaLayout()
            .width(5)
            .height(5)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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
        let root = yogaLayout()
            .margin(top: 20)
            .padding(25)
            .width(50)
            .height(50)
        let root_child0 = MeasureLayout()
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)
        let root_child1 = yogaLayout()
            .width(5)
            .height(5)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .margin(top: 20)
            .width(50)
            .height(50)
        let root_child0 = MeasureLayout()
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)
        let root_child1 = yogaLayout()
            .width(5)
            .height(5)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .margin(top: 20)
            .width(50)
            .height(50)
            .alignItems(.flexStart)
        let root_child0 = MeasureLayout()
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)
        let root_child1 = yogaLayout()
            .width(5)
            .height(5)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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
        let root = yogaLayout()
            .margin(top: 20)
            .padding(25)
            .width(50)
            .height(50)
        let root_child0 = MeasureLayout()
        root_child0.width(10)
            .height(10)

        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)
        let root_child1 = yogaLayout()
            .width(5)
            .height(5)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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
        let root = yogaLayout()
            .margin(top: 20)
            .padding(25)
            .width(50)
            .height(50)
        let root_child0 = MeasureLayout()
        root_child0.flexShrink(1)
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)
        let root_child1 = yogaLayout()
            .width(5)
            .height(5)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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
        let root = yogaLayout()
            .margin(top: 20)
            .width(50)
            .height(50)
        let root_child0 = MeasureLayout()
        root_child0.flexShrink(1)
        root_child0._measure = _simulate_wrapping_text
        root.append(root_child0)
        let root_child1 = yogaLayout()
            .width(5)
            .height(5)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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

    // Generated from test: cant_call_negative_measure
    func testCantCallNegativeMeasure() {
        let root = yogaLayout()
            .flexDirection(.column)
            .width(50)
            .height(10)
        let root_child0 = MeasureLayout()
        root_child0.margin(top: 20)
        root_child0._measure = _measure_assert_negative
        root.append(root_child0)

        root.calculate(direction: .ltr)
    }

    // Generated from test: cant_call_negative_measure_horizontal
    func testCantCallNegativeMeasureHorizontal() {
        let root = yogaLayout()
            .flexDirection(.row)
            .width(10)
            .height(20)
        let root_child0 = MeasureLayout()
        root_child0.margin(leading: 20)
        root_child0._measure = _measure_assert_negative
        root.append(root_child0)

        root.calculate(direction: .ltr)
    }

    func testMeasureNotEnoughSizeShouldWrap2() {
        func fn(width: CGFloat, widthMode: MeasureMode, height: CGFloat, heightMode: MeasureMode) -> CGSize {
            return CGSize(width: width, height: 67)
        }

        let div4 = FlexLayout()
            .flexDirection(.row)
            .margin(top: 20)
        let div5 = FlexLayout()
            .width(60)
            .height(60)
        div4.append(div5)
        let text6 = MeasureLayout()
        text6.flex(1)
        text6._measure = fn
        div4.append(text6)

        div4.calculate(width: 320, height: 568)

        XCTAssertEqual(div4.box.left, 0)
        XCTAssertEqual(div4.box.top, 20)
        XCTAssertEqual(div4.box.width, 320)
        XCTAssertEqual(div4.box.height, 548)

        XCTAssertEqual(div5.box.left, 0)
        XCTAssertEqual(div5.box.top, 0)
        XCTAssertEqual(div5.box.width, 60)
        XCTAssertEqual(div5.box.height, 60)

        XCTAssertEqual(text6.box.left, 60)
        XCTAssertEqual(text6.box.top, 0)
        XCTAssertEqual(text6.box.width, 260)
        XCTAssertEqual(text6.box.height, 548)
    }

    func testPercentWithTextNode() {
        func fn(width: CGFloat, widthMode: MeasureMode, height: CGFloat, heightMode: MeasureMode) -> CGSize {
                return CGSize(width: 90, height: 10)
        }
        
        let root = yogaLayout()
            .flexDirection(.row)
            .justifyContent(.spaceBetween)
            .alignItems(.center)
            .width(float: 100)
            .height(float: 80)
        
        let root_child0 = yogaLayout().append(to: root)
        
        let root_child1 = MeasureLayout()
            .padding(top:40)
            .maxWidth(0.5)
            .append(to: root)
        root_child1._measure = fn
        
        root.calculate()
        
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
