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

@testable import StartPoint
import XCTest

// Generated from YGPercentageTest.cpp
class PercentageTests: FlexTestCase {

    // Generated from test: percentage_width_height
    func testPercentageWidthHeight() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.percentage(30))
        root_child0.height(StyleValue.percentage(30))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 60)

        root.calculate(direction: Direction.rtl)

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
    func testPercentagePositionLeftTop() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(400))
        root.height(StyleValue.length(400))

        let root_child0 = FlexLayout()
        root_child0.position(left: StyleValue.percentage(10))
        root_child0.position(top: StyleValue.percentage(20))
        root_child0.width(StyleValue.percentage(45))
        root_child0.height(StyleValue.percentage(55))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 400)
        XCTAssertEqual(root.box.height, 400)

        XCTAssertEqual(root_child0.box.left, 40)
        XCTAssertEqual(root_child0.box.top, 80)
        XCTAssertEqual(root_child0.box.width, 180)
        XCTAssertEqual(root_child0.box.height, 220)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 400)
        XCTAssertEqual(root.box.height, 400)

        XCTAssertEqual(root_child0.box.left, 260)
        XCTAssertEqual(root_child0.box.top, 80)
        XCTAssertEqual(root_child0.box.width, 180)
        XCTAssertEqual(root_child0.box.height, 220)
    }

    // Generated from test: percentage_position_bottom_right
    func testPercentagePositionBottomRight() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(500))
        root.height(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.position(right: StyleValue.percentage(20))
        root_child0.position(bottom: StyleValue.percentage(10))
        root_child0.width(StyleValue.percentage(55))
        root_child0.height(StyleValue.percentage(15))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, -100)
        XCTAssertEqual(root_child0.box.top, -50)
        XCTAssertEqual(root_child0.box.width, 275)
        XCTAssertEqual(root_child0.box.height, 75)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 125)
        XCTAssertEqual(root_child0.box.top, -50)
        XCTAssertEqual(root_child0.box.width, 275)
        XCTAssertEqual(root_child0.box.height, 75)
    }

    // Generated from test: percentage_flex_basis
    func testPercentageFlexBasis() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.percentage(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.flexBasis(FlexBasis.percentage(25))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.percentage(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.flexBasis(FlexBasis.percentage(25))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.minHeight(StyleValue.percentage(60))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(2)
        root_child1.minHeight(StyleValue.percentage(10))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.percentage(10))
        root_child0.maxHeight(StyleValue.percentage(60))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(4)
        root_child1.flexBasis(FlexBasis.percentage(10))
        root_child1.maxHeight(StyleValue.percentage(20))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.percentage(10))
        root_child0.maxHeight(StyleValue.percentage(60))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(4)
        root_child1.flexBasis(FlexBasis.percentage(10))
        root_child1.maxHeight(StyleValue.percentage(20))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.percentage(15))
        root_child0.maxWidth(StyleValue.percentage(60))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(4)
        root_child1.flexBasis(FlexBasis.percentage(10))
        root_child1.maxWidth(StyleValue.percentage(20))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.percentage(10))
        root_child0.maxWidth(StyleValue.percentage(60))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(4)
        root_child1.flexBasis(FlexBasis.percentage(15))
        root_child1.maxWidth(StyleValue.percentage(20))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.percentage(15))
        root_child0.minWidth(StyleValue.percentage(60))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(4)
        root_child1.flexBasis(FlexBasis.percentage(10))
        root_child1.minWidth(StyleValue.percentage(20))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.percentage(10))
        root_child0.minWidth(StyleValue.percentage(60))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(4)
        root_child1.flexBasis(FlexBasis.percentage(15))
        root_child1.minWidth(StyleValue.percentage(20))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
    func testPercentageMultipleNestedWithPaddingMarginAndPercentageValues() {
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.percentage(10))
        root_child0.margin(left: StyleValue.length(5))
        root_child0.margin(top: StyleValue.length(5))
        root_child0.margin(right: StyleValue.length(5))
        root_child0.margin(bottom: StyleValue.length(5))
        root_child0.padding(left: StyleValue.length(3))
        root_child0.padding(top: StyleValue.length(3))
        root_child0.padding(right: StyleValue.length(3))
        root_child0.padding(bottom: StyleValue.length(3))
        root_child0.minWidth(StyleValue.percentage(60))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.margin(left: StyleValue.length(5))
        root_child0_child0.margin(top: StyleValue.length(5))
        root_child0_child0.margin(right: StyleValue.length(5))
        root_child0_child0.margin(bottom: StyleValue.length(5))
        root_child0_child0.padding(left: StyleValue.percentage(3))
        root_child0_child0.padding(top: StyleValue.percentage(3))
        root_child0_child0.padding(right: StyleValue.percentage(3))
        root_child0_child0.padding(bottom: StyleValue.percentage(3))
        root_child0_child0.width(StyleValue.percentage(50))
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.margin(left: StyleValue.percentage(5))
        root_child0_child0_child0.margin(top: StyleValue.percentage(5))
        root_child0_child0_child0.margin(right: StyleValue.percentage(5))
        root_child0_child0_child0.margin(bottom: StyleValue.percentage(5))
        root_child0_child0_child0.padding(left: StyleValue.length(3))
        root_child0_child0_child0.padding(top: StyleValue.length(3))
        root_child0_child0_child0.padding(right: StyleValue.length(3))
        root_child0_child0_child0.padding(bottom: StyleValue.length(3))
        root_child0_child0_child0.width(StyleValue.percentage(45))
        root_child0_child0.append(root_child0_child0_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(4)
        root_child1.flexBasis(FlexBasis.percentage(15))
        root_child1.minWidth(StyleValue.percentage(20))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 5)
        XCTAssertEqual(root_child0.box.top, 5)
        XCTAssertEqual(root_child0.box.width, 190)
        XCTAssertEqual(root_child0.box.height, 48)

        XCTAssertEqual(root_child0_child0.box.left, 8)
        XCTAssertEqual(root_child0_child0.box.top, 8)
        XCTAssertEqual(root_child0_child0.box.width, 92)
        XCTAssertEqual(root_child0_child0.box.height, 25)

        XCTAssertEqual(root_child0_child0_child0.box.left, 10)
        XCTAssertEqual(root_child0_child0_child0.box.top, 10)
        XCTAssertEqual(root_child0_child0_child0.box.width, 36)
        XCTAssertEqual(root_child0_child0_child0.box.height, 6)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 58)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 142)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 5)
        XCTAssertEqual(root_child0.box.top, 5)
        XCTAssertEqual(root_child0.box.width, 190)
        XCTAssertEqual(root_child0.box.height, 48)

        XCTAssertEqual(root_child0_child0.box.left, 90)
        XCTAssertEqual(root_child0_child0.box.top, 8)
        XCTAssertEqual(root_child0_child0.box.width, 92)
        XCTAssertEqual(root_child0_child0.box.height, 25)

        XCTAssertEqual(root_child0_child0_child0.box.left, 46)
        XCTAssertEqual(root_child0_child0_child0.box.top, 10)
        XCTAssertEqual(root_child0_child0_child0.box.width, 36)
        XCTAssertEqual(root_child0_child0_child0.box.height, 6)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 58)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 142)
    }

    // Generated from test: percentage_margin_should_calculate_based_only_on_width
    func testPercentageMarginShouldCalculateBasedOnlyOnWidth() {
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.margin(left: StyleValue.percentage(10))
        root_child0.margin(top: StyleValue.percentage(10))
        root_child0.margin(right: StyleValue.percentage(10))
        root_child0.margin(bottom: StyleValue.percentage(10))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.width(StyleValue.length(10))
        root_child0_child0.height(StyleValue.length(10))
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 20)
        XCTAssertEqual(root_child0.box.top, 20)
        XCTAssertEqual(root_child0.box.width, 160)
        XCTAssertEqual(root_child0.box.height, 60)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 10)
        XCTAssertEqual(root_child0_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 20)
        XCTAssertEqual(root_child0.box.top, 20)
        XCTAssertEqual(root_child0.box.width, 160)
        XCTAssertEqual(root_child0.box.height, 60)

        XCTAssertEqual(root_child0_child0.box.left, 150)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 10)
        XCTAssertEqual(root_child0_child0.box.height, 10)
    }

    // Generated from test: percentage_padding_should_calculate_based_only_on_width
    func testPercentagePaddingShouldCalculateBasedOnlyOnWidth() {
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.padding(left: StyleValue.percentage(10))
        root_child0.padding(top: StyleValue.percentage(10))
        root_child0.padding(right: StyleValue.percentage(10))
        root_child0.padding(bottom: StyleValue.percentage(10))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.width(StyleValue.length(10))
        root_child0_child0.height(StyleValue.length(10))
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 20)
        XCTAssertEqual(root_child0_child0.box.top, 20)
        XCTAssertEqual(root_child0_child0.box.width, 10)
        XCTAssertEqual(root_child0_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 170)
        XCTAssertEqual(root_child0_child0.box.top, 20)
        XCTAssertEqual(root_child0_child0.box.width, 10)
        XCTAssertEqual(root_child0_child0.box.height, 10)
    }

    // Generated from test: percentage_absolute_position
    func testPercentageAbsolutePosition() {
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(left: StyleValue.percentage(30))
        root_child0.position(top: StyleValue.percentage(10))
        root_child0.width(StyleValue.length(10))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 60)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 60)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: percentage_width_height_undefined_parent_size
    func testPercentageWidthHeightUndefinedParentSize() {
        let root = FlexLayout()

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.percentage(50))
        root_child0.height(StyleValue.percentage(50))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 0)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 0)

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(350))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(100))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.percentage(100))
        root_child1.append(root_child1_child0)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(100))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignItems(AlignItems.center)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexDirection(FlexDirection.row)
        root_child0_child0.justifyContent(JustifyContent.center)
        root_child0_child0.width(StyleValue.percentage(100))
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.width(StyleValue.length(50))
        root_child0_child0_child0.height(StyleValue.length(50))
        root_child0_child0.append(root_child0_child0_child0)

        let root_child0_child0_child1 = FlexLayout()
        root_child0_child0_child1.width(StyleValue.length(50))
        root_child0_child0_child1.height(StyleValue.length(50))
        root_child0_child0.append(root_child0_child0_child1)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
    func testPercentAbsolutePosition() {
        let root = FlexLayout()
        root.width(StyleValue.length(60))
        root.height(StyleValue.length(50))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.positionType(PositionType.absolute)
        root_child0.position(left: StyleValue.percentage(50))
        root_child0.width(StyleValue.percentage(100))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.width(StyleValue.percentage(100))
        root_child0.append(root_child0_child0)

        let root_child0_child1 = FlexLayout()
        root_child0_child1.width(StyleValue.percentage(100))
        root_child0.append(root_child0_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 60)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 30)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 60)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child0_child1.box.left, 60)
        XCTAssertEqual(root_child0_child1.box.top, 0)
        XCTAssertEqual(root_child0_child1.box.width, 60)
        XCTAssertEqual(root_child0_child1.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 60)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 30)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 60)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child0_child1.box.left, -60)
        XCTAssertEqual(root_child0_child1.box.top, 0)
        XCTAssertEqual(root_child0_child1.box.width, 60)
        XCTAssertEqual(root_child0_child1.box.height, 50)
    }
}
