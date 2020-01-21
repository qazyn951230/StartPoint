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

// Generated from YGRoundingTest.cpp
class RoundingTests: FlexTestCase {

    // Generated from test: rounding_flex_basis_flex_grow_row_width_of_100
    func testRoundingFlexBasisFlexGrowRowWidthOf100() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 33)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 33)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 34)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 67)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 33)
        XCTAssertEqual(root_child2.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 67)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 33)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 33)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 34)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 33)
        XCTAssertEqual(root_child2.box.height, 100)
    }

    // Generated from test: rounding_flex_basis_flex_grow_row_prime_number_width
    func testRoundingFlexBasisFlexGrowRowPrimeNumberWidth() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(113))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root.insert(root_child2, at: 2)

        let root_child3 = FlexLayout()
        root_child3.flexGrow(1)
        root.insert(root_child3, at: 3)

        let root_child4 = FlexLayout()
        root_child4.flexGrow(1)
        root.insert(root_child4, at: 4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 113)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 23)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 23)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 22)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 45)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 23)
        XCTAssertEqual(root_child2.box.height, 100)

        XCTAssertEqual(root_child3.box.left, 68)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 22)
        XCTAssertEqual(root_child3.box.height, 100)

        XCTAssertEqual(root_child4.box.left, 90)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 23)
        XCTAssertEqual(root_child4.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 113)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 90)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 23)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 68)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 22)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 45)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 23)
        XCTAssertEqual(root_child2.box.height, 100)

        XCTAssertEqual(root_child3.box.left, 23)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 22)
        XCTAssertEqual(root_child3.box.height, 100)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 23)
        XCTAssertEqual(root_child4.box.height, 100)
    }

    // Generated from test: rounding_flex_basis_flex_shrink_row
    func testRoundingFlexBasisFlexShrinkRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(101))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexShrink(1)
        root_child0.flexBasis(100)
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexBasis(25)
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.flexBasis(25)
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 101)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 51)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 51)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 25)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 76)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 25)
        XCTAssertEqual(root_child2.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 101)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 51)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 25)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 25)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 25)
        XCTAssertEqual(root_child2.box.height, 100)
    }

    // Generated from test: rounding_flex_basis_overrides_main_size
    func testRoundingFlexBasisOverridesMainSize() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(113))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(50)
        root_child0.height(StyleValue.length(20))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 113)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 64)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 64)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 24)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 113)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 64)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 64)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 24)
    }

    // Generated from test: rounding_total_fractial
    func testRoundingTotalFractial() {
        let root = FlexLayout()
        root.width(StyleValue.length(87.4))
        root.height(StyleValue.length(113.4))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(0.7)
        root_child0.flexBasis(50.3)
        root_child0.height(StyleValue.length(20.3))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1.6)
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1.1)
        root_child2.height(StyleValue.length(10.7))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 87)
        XCTAssertEqual(root.box.height, 113)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 87)
        XCTAssertEqual(root_child0.box.height, 59)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 59)
        XCTAssertEqual(root_child1.box.width, 87)
        XCTAssertEqual(root_child1.box.height, 30)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 87)
        XCTAssertEqual(root_child2.box.height, 24)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 87)
        XCTAssertEqual(root.box.height, 113)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 87)
        XCTAssertEqual(root_child0.box.height, 59)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 59)
        XCTAssertEqual(root_child1.box.width, 87)
        XCTAssertEqual(root_child1.box.height, 30)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 87)
        XCTAssertEqual(root_child2.box.height, 24)
    }

    // Generated from test: rounding_total_fractial_nested
    func testRoundingTotalFractialNested() {
        let root = FlexLayout()
        root.width(StyleValue.length(87.4))
        root.height(StyleValue.length(113.4))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(0.7)
        root_child0.flexBasis(FlexBasis.length(50.3))
        root_child0.height(StyleValue.length(20.3))
        root.insert(root_child0, at: 0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexBasis(FlexBasis.length(0.3))
        root_child0_child0.position(bottom: StyleValue.length(13.3))
        root_child0_child0.height(StyleValue.length(9.9))
        root_child0.insert(root_child0_child0, at: 0)

        let root_child0_child1 = FlexLayout()
        root_child0_child1.flexGrow(4)
        root_child0_child1.flexBasis(FlexBasis.length(0.3))
        root_child0_child1.position(top: StyleValue.length(13.3))
        root_child0_child1.height(StyleValue.length(1.1))
        root_child0.insert(root_child0_child1, at: 1)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1.6)
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1.1)
        root_child2.height(StyleValue.length(10.7))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 87)
        XCTAssertEqual(root.box.height, 113)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 87)
        XCTAssertEqual(root_child0.box.height, 59)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, -13)
        XCTAssertEqual(root_child0_child0.box.width, 87)
        XCTAssertEqual(root_child0_child0.box.height, 12)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 25)
        XCTAssertEqual(root_child0_child1.box.width, 87)
        XCTAssertEqual(root_child0_child1.box.height, 47)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 59)
        XCTAssertEqual(root_child1.box.width, 87)
        XCTAssertEqual(root_child1.box.height, 30)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 87)
        XCTAssertEqual(root_child2.box.height, 24)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 87)
        XCTAssertEqual(root.box.height, 113)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 87)
        XCTAssertEqual(root_child0.box.height, 59)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, -13)
        XCTAssertEqual(root_child0_child0.box.width, 87)
        XCTAssertEqual(root_child0_child0.box.height, 12)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 25)
        XCTAssertEqual(root_child0_child1.box.width, 87)
        XCTAssertEqual(root_child0_child1.box.height, 47)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 59)
        XCTAssertEqual(root_child1.box.width, 87)
        XCTAssertEqual(root_child1.box.height, 30)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 87)
        XCTAssertEqual(root_child2.box.height, 24)
    }

    // Generated from test: rounding_fractial_input_1
    func testRoundingFractialInput1() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(113.4))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(50)
        root_child0.height(StyleValue.length(20))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 113)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 64)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 64)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 24)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 113)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 64)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 64)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 24)
    }

    // Generated from test: rounding_fractial_input_2
    func testRoundingFractialInput2() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(113.6))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(50)
        root_child0.height(StyleValue.length(20))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 114)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 65)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 65)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 24)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 25)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 114)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 65)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 65)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 24)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 25)
    }

    // Generated from test: rounding_fractial_input_3
    func testRoundingFractialInput3() {
        let root = FlexLayout()
        root.position(top: StyleValue.length(0.3))
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(113.4))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(50)
        root_child0.height(StyleValue.length(20))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 114)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 65)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 64)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 24)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 25)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 114)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 65)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 64)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 24)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 25)
    }

    // Generated from test: rounding_fractial_input_4
    func testRoundingFractialInput4() {
        let root = FlexLayout()
        root.position(top: StyleValue.length(0.7))
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(113.4))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(50)
        root_child0.height(StyleValue.length(20))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 1)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 113)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 64)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 64)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 24)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 1)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 113)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 64)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 64)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 89)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 24)
    }

    // Generated from test: rounding_inner_node_controversy_horizontal
    func testRoundingInnerNodeControversyHorizontal() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(320))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.height(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.flexGrow(1)
        root_child1_child0.height(StyleValue.length(10))
        root_child1.insert(root_child1_child0, at: 0)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 320)
        XCTAssertEqual(root.box.height, 10)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 107)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 107)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 106)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 106)
        XCTAssertEqual(root_child1_child0.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 213)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 107)
        XCTAssertEqual(root_child2.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 320)
        XCTAssertEqual(root.box.height, 10)

        XCTAssertEqual(root_child0.box.left, 213)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 107)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 107)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 106)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 106)
        XCTAssertEqual(root_child1_child0.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 107)
        XCTAssertEqual(root_child2.box.height, 10)
    }

    // Generated from test: rounding_inner_node_controversy_vertical
    func testRoundingInnerNodeControversyVertical() {
        let root = FlexLayout()
        root.height(StyleValue.length(320))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.width(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.width(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.flexGrow(1)
        root_child1_child0.width(StyleValue.length(10))
        root_child1.insert(root_child1_child0, at: 0)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root_child2.width(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 10)
        XCTAssertEqual(root.box.height, 320)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 107)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 107)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 106)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 10)
        XCTAssertEqual(root_child1_child0.box.height, 106)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 213)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 107)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 10)
        XCTAssertEqual(root.box.height, 320)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 107)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 107)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 106)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 10)
        XCTAssertEqual(root_child1_child0.box.height, 106)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 213)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 107)
    }

    // Generated from test: rounding_inner_node_controversy_combined
    func testRoundingInnerNodeControversyCombined() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(640))
        root.height(StyleValue.length(320))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.height(StyleValue.percentage(100))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.height(StyleValue.percentage(100))
        root.insert(root_child1, at: 1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.flexGrow(1)
        root_child1_child0.width(StyleValue.percentage(100))
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1 = FlexLayout()
        root_child1_child1.flexGrow(1)
        root_child1_child1.width(StyleValue.percentage(100))
        root_child1.insert(root_child1_child1, at: 1)

        let root_child1_child1_child0 = FlexLayout()
        root_child1_child1_child0.flexGrow(1)
        root_child1_child1_child0.width(StyleValue.percentage(100))
        root_child1_child1.insert(root_child1_child1_child0, at: 0)

        let root_child1_child2 = FlexLayout()
        root_child1_child2.flexGrow(1)
        root_child1_child2.width(StyleValue.percentage(100))
        root_child1.insert(root_child1_child2, at: 2)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root_child2.height(StyleValue.percentage(100))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 640)
        XCTAssertEqual(root.box.height, 320)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 213)
        XCTAssertEqual(root_child0.box.height, 320)

        XCTAssertEqual(root_child1.box.left, 213)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 214)
        XCTAssertEqual(root_child1.box.height, 320)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 214)
        XCTAssertEqual(root_child1_child0.box.height, 107)

        XCTAssertEqual(root_child1_child1.box.left, 0)
        XCTAssertEqual(root_child1_child1.box.top, 107)
        XCTAssertEqual(root_child1_child1.box.width, 214)
        XCTAssertEqual(root_child1_child1.box.height, 106)

        XCTAssertEqual(root_child1_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child1_child0.box.width, 214)
        XCTAssertEqual(root_child1_child1_child0.box.height, 106)

        XCTAssertEqual(root_child1_child2.box.left, 0)
        XCTAssertEqual(root_child1_child2.box.top, 213)
        XCTAssertEqual(root_child1_child2.box.width, 214)
        XCTAssertEqual(root_child1_child2.box.height, 107)

        XCTAssertEqual(root_child2.box.left, 427)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 213)
        XCTAssertEqual(root_child2.box.height, 320)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 640)
        XCTAssertEqual(root.box.height, 320)

        XCTAssertEqual(root_child0.box.left, 427)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 213)
        XCTAssertEqual(root_child0.box.height, 320)

        XCTAssertEqual(root_child1.box.left, 213)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 214)
        XCTAssertEqual(root_child1.box.height, 320)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 214)
        XCTAssertEqual(root_child1_child0.box.height, 107)

        XCTAssertEqual(root_child1_child1.box.left, 0)
        XCTAssertEqual(root_child1_child1.box.top, 107)
        XCTAssertEqual(root_child1_child1.box.width, 214)
        XCTAssertEqual(root_child1_child1.box.height, 106)

        XCTAssertEqual(root_child1_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child1_child0.box.width, 214)
        XCTAssertEqual(root_child1_child1_child0.box.height, 106)

        XCTAssertEqual(root_child1_child2.box.left, 0)
        XCTAssertEqual(root_child1_child2.box.top, 213)
        XCTAssertEqual(root_child1_child2.box.width, 214)
        XCTAssertEqual(root_child1_child2.box.height, 107)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 213)
        XCTAssertEqual(root_child2.box.height, 320)
    }
}
