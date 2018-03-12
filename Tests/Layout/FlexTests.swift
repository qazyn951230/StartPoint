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

// Generated from YGFlexTest.cpp
class FlexTests: FlexTestCase {

    // Generated from test: flex_basis_flex_grow_column
    func testFlexBasisFlexGrowColumn() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 75)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 75)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 25)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 75)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 75)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 25)
    }

    // Generated from test: flex_basis_flex_grow_row
    func testFlexBasisFlexGrowRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 75)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 75)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 25)
        XCTAssertEqual(root_child1.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 75)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 25)
        XCTAssertEqual(root_child1.box.height, 100)
    }

    // Generated from test: flex_basis_flex_shrink_column
    func testFlexBasisFlexShrinkColumn() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexShrink(1)
        root_child0.flexBasis(FlexBasis.length(100))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexBasis(FlexBasis.length(50))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 50)
    }

    // Generated from test: flex_basis_flex_shrink_row
    func testFlexBasisFlexShrinkRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexShrink(1)
        root_child0.flexBasis(FlexBasis.length(100))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexBasis(FlexBasis.length(50))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 100)
    }

    // Generated from test: flex_shrink_to_zero
    func testFlexShrinkToZero() {
        let root = FlexLayout()
        root.height(StyleValue.length(75))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexShrink(1)
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(50))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root_child2.height(StyleValue.length(50))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 75)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 75)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)
    }

    // Generated from test: flex_basis_overrides_main_size
    func testFlexBasisOverridesMainSize() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.length(50))
        root_child0.height(StyleValue.length(20))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.height(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root_child2.height(StyleValue.length(10))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 60)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 60)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 80)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 60)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 60)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 80)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 20)
    }

    // Generated from test: flex_grow_shrink_at_most
    func testFlexGrowShrinkAtMost() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexShrink(1)
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 0)
    }

    // Generated from test: flex_grow_less_than_factor_one
    func testFlexGrowLessThanFactorOne() {
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(0.2)
        root_child0.flexBasis(FlexBasis.length(40))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(0.2)
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(0.4)
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 132)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 132)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 92)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 224)
        XCTAssertEqual(root_child2.box.width, 200)
        XCTAssertEqual(root_child2.box.height, 184)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 132)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 132)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 92)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 224)
        XCTAssertEqual(root_child2.box.width, 200)
        XCTAssertEqual(root_child2.box.height, 184)
    }
}
