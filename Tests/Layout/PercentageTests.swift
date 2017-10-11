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

// Generated from YGPercentageTest.cpp
class PercentageTests: FlexTestCase {

    // Generated from test: percentage_width_height
    func testPercentageWidthHeight() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .height(.percentage(30))
            .width(.percentage(30))
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 60)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 140)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 60)
    }

    // Generated from test: percentage_position_left_top
    // func testPercentagePositionLeftTop() {
    // }

    // Generated from test: percentage_position_bottom_right
    // func testPercentagePositionBottomRight() {
    // }

    // Generated from test: percentage_flex_basis
    func testPercentageFlexBasis() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexBasis(.percentage(50))
            .flexGrow(1)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(.percentage(25))
            .flexGrow(1)
        root.append(root_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 125)
        XCTAssertEqual(root_child0.box.height, 200)

        XCTAssertEqual(root_child1.box.left, 125)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 75)
        XCTAssertEqual(root_child1.box.height, 200)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 75)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 125)
        XCTAssertEqual(root_child0.box.height, 200)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 75)
        XCTAssertEqual(root_child1.box.height, 200)
    }

    // Generated from test: percentage_flex_basis_cross
    func testPercentageFlexBasisCross() {
        let root = yogaLayout()
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexBasis(.percentage(50))
            .flexGrow(1)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(.percentage(25))
            .flexGrow(1)
        root.append(root_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 125)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 125)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 75)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 125)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 125)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 75)
    }

    // Generated from test: percentage_flex_basis_cross_min_height
    func testPercentageFlexBasisCrossMinHeight() {
        let root = yogaLayout()
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexGrow(1)
            .minHeight(.percentage(60))
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(2)
            .minHeight(.percentage(10))
        root.append(root_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 140)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 140)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 60)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 140)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 140)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 60)
    }

    // Generated from test: percentage_flex_basis_main_max_height
    func testPercentageFlexBasisMainMaxHeight() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexBasis(.percentage(10))
            .flexGrow(1)
            .maxHeight(.percentage(60))
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(.percentage(10))
            .flexGrow(4)
            .maxHeight(.percentage(20))
        root.append(root_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 52)
        XCTAssertEqual(root_child0.box.height, 120)

        XCTAssertEqual(root_child1.box.left, 52)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 148)
        XCTAssertEqual(root_child1.box.height, 40)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 148)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 52)
        XCTAssertEqual(root_child0.box.height, 120)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 148)
        XCTAssertEqual(root_child1.box.height, 40)
    }

    // Generated from test: percentage_flex_basis_cross_max_height
    func testPercentageFlexBasisCrossMaxHeight() {
        let root = yogaLayout()
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexBasis(.percentage(10))
            .flexGrow(1)
            .maxHeight(.percentage(60))
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(.percentage(10))
            .flexGrow(4)
            .maxHeight(.percentage(20))
        root.append(root_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 120)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 120)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 40)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 120)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 120)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 40)
    }

    // Generated from test: percentage_flex_basis_main_max_width
    func testPercentageFlexBasisMainMaxWidth() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexBasis(.percentage(15))
            .flexGrow(1)
            .maxWidth(.percentage(60))
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(.percentage(10))
            .flexGrow(4)
            .maxWidth(.percentage(20))
        root.append(root_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 120)
        XCTAssertEqual(root_child0.box.height, 200)

        XCTAssertEqual(root_child1.box.left, 120)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 40)
        XCTAssertEqual(root_child1.box.height, 200)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 120)
        XCTAssertEqual(root_child0.box.height, 200)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 40)
        XCTAssertEqual(root_child1.box.height, 200)
    }

    // Generated from test: percentage_flex_basis_cross_max_width
    func testPercentageFlexBasisCrossMaxWidth() {
        let root = yogaLayout()
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexBasis(.percentage(10))
            .flexGrow(1)
            .maxWidth(.percentage(60))
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(.percentage(15))
            .flexGrow(4)
            .maxWidth(.percentage(20))
        root.append(root_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 120)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 40)
        XCTAssertEqual(root_child1.box.height, 150)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 120)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 160)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 40)
        XCTAssertEqual(root_child1.box.height, 150)
    }

    // Generated from test: percentage_flex_basis_main_min_width
    func testPercentageFlexBasisMainMinWidth() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexBasis(.percentage(15))
            .flexGrow(1)
            .minWidth(.percentage(60))
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(.percentage(10))
            .flexGrow(4)
            .minWidth(.percentage(20))
        root.append(root_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 120)
        XCTAssertEqual(root_child0.box.height, 200)

        XCTAssertEqual(root_child1.box.left, 120)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 80)
        XCTAssertEqual(root_child1.box.height, 200)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 120)
        XCTAssertEqual(root_child0.box.height, 200)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 80)
        XCTAssertEqual(root_child1.box.height, 200)
    }

    // Generated from test: percentage_flex_basis_cross_min_width
    func testPercentageFlexBasisCrossMinWidth() {
        let root = yogaLayout()
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexBasis(.percentage(10))
            .flexGrow(1)
            .minWidth(.percentage(60))
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(.percentage(15))
            .flexGrow(4)
            .minWidth(.percentage(20))
        root.append(root_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 150)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 150)
    }

    // Generated from test: percentage_multiple_nested_with_padding_margin_and_percentage_values
    // func testPercentageMultipleNestedWithPaddingMarginAndPercentageValues() {
    // }

    // Generated from test: percentage_margin_should_calculate_based_only_on_width
    // func testPercentageMarginShouldCalculateBasedOnlyOnWidth() {
    // }

    // Generated from test: percentage_padding_should_calculate_based_only_on_width
    // func testPercentagePaddingShouldCalculateBasedOnlyOnWidth() {
    // }

    // Generated from test: percentage_absolute_position
    // func testPercentageAbsolutePosition() {
    // }

    // Generated from test: percentage_width_height_undefined_parent_size
    func testPercentageWidthHeightUndefinedParentSize() {
        let root = yogaLayout()

        let root_child0 = yogaLayout()
            .height(.percentage(50))
            .width(.percentage(50))
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 0)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 0)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 0)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 0)
    }

    // Generated from test: percent_within_flex_grow
    func testPercentWithinFlexGrow() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(100)
            .width(350)

        let root_child0 = yogaLayout()
            .width(100)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .width(.percentage(100))
        root_child1.append(root_child1_child0)

        let root_child2 = yogaLayout()
            .width(100)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 350)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 100)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 150)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 150)
        XCTAssertEqual(root_child1_child0.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 250)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 100)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 350)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 250)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 100)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 150)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 150)
        XCTAssertEqual(root_child1_child0.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 100)
    }

    // Generated from test: percentage_container_in_wrapping_container
    func testPercentageContainerInWrappingContainer() {
        let root = yogaLayout()
            .alignItems(.center)
            .height(200)
            .justifyContent(.center)
            .width(200)

        let root_child0 = yogaLayout()
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .flexDirection(.row)
            .justifyContent(.center)
            .width(.percentage(100))
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = yogaLayout()
            .height(50)
            .width(50)
        root_child0_child0.append(root_child0_child0_child0)

        let root_child0_child0_child1 = yogaLayout()
            .height(50)
            .width(50)
        root_child0_child0.append(root_child0_child0_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 75)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0_child1.box.left, 50)
        XCTAssertEqual(root_child0_child0_child1.box.top, 0)
        XCTAssertEqual(root_child0_child0_child1.box.width, 50)
        XCTAssertEqual(root_child0_child0_child1.box.height, 50)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 75)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0_child0.box.left, 50)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child0_child1.box.top, 0)
        XCTAssertEqual(root_child0_child0_child1.box.width, 50)
        XCTAssertEqual(root_child0_child0_child1.box.height, 50)
    }

    // Generated from test: percent_absolute_position
    // func testPercentAbsolutePosition() {
    // }
}
