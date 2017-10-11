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

// Generated from YGRoundingTest.cpp
class RoundingTests: FlexTestCase {

    // Generated from test: rounding_flex_basis_flex_grow_row_width_of_100
    func testRoundingFlexBasisFlexGrowRowWidthOf100() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .flexGrow(1)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .flexGrow(1)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .height(100)
            .width(113)

        let root_child0 = yogaLayout()
            .flexGrow(1)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .flexGrow(1)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .flexGrow(1)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .flexGrow(1)
        root.append(root_child4)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .height(100)
            .width(101)

        let root_child0 = yogaLayout()
            .flexBasis(100)
            .flexShrink(1)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(25)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .flexBasis(25)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(113)
            .width(100)

        let root_child0 = yogaLayout()
            .flexBasis(50)
            .flexGrow(1)
            .height(20)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(113.4)
            .width(87.4)

        let root_child0 = yogaLayout()
            .flexBasis(50.3)
            .flexGrow(0.7)
            .height(20.3)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1.6)
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .flexGrow(1.1)
            .height(10.7)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(113.4)
            .width(87.4)

        let root_child0 = yogaLayout()
            .flexBasis(50.3)
            .flexGrow(0.7)
            .height(20.3)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .flexBasis(.length(0.3))
            .flexGrow(1)
            .height(9.9)
            .position(bottom: 13.3)
        root_child0.append(root_child0_child0)

        let root_child0_child1 = yogaLayout()
            .flexBasis(.length(0.3))
            .flexGrow(4)
            .height(1.1)
            .position(top: 13.3)
        root_child0.append(root_child0_child1)

        let root_child1 = yogaLayout()
            .flexGrow(1.6)
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .flexGrow(1.1)
            .height(10.7)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(113.4)
            .width(100)

        let root_child0 = yogaLayout()
            .flexBasis(50)
            .flexGrow(1)
            .height(20)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(113.6)
            .width(100)

        let root_child0 = yogaLayout()
            .flexBasis(50)
            .flexGrow(1)
            .height(20)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(113.4)
            .position(top: 0.3)
            .width(100)

        let root_child0 = yogaLayout()
            .flexBasis(50)
            .flexGrow(1)
            .height(20)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(113.4)
            .position(top: 0.7)
            .width(100)

        let root_child0 = yogaLayout()
            .flexBasis(50)
            .flexGrow(1)
            .height(20)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .width(320)

        let root_child0 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root_child1.append(root_child1_child0)

        let root_child2 = yogaLayout()
            .flexGrow(1)
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(320)

        let root_child0 = yogaLayout()
            .flexGrow(1)
            .width(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
            .width(10)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .flexGrow(1)
            .width(10)
        root_child1.append(root_child1_child0)

        let root_child2 = yogaLayout()
            .flexGrow(1)
            .width(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .height(320)
            .width(640)

        let root_child0 = yogaLayout()
            .flexGrow(1)
            .height(.percentage(100))
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
            .height(.percentage(100))
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .flexGrow(1)
            .width(.percentage(100))
        root_child1.append(root_child1_child0)

        let root_child1_child1 = yogaLayout()
            .flexGrow(1)
            .width(.percentage(100))
        root_child1.append(root_child1_child1)

        let root_child1_child1_child0 = yogaLayout()
            .flexGrow(1)
            .width(.percentage(100))
        root_child1_child1.append(root_child1_child1_child0)

        let root_child1_child2 = yogaLayout()
            .flexGrow(1)
            .width(.percentage(100))
        root_child1.append(root_child1_child2)

        let root_child2 = yogaLayout()
            .flexGrow(1)
            .height(.percentage(100))
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
