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

// Generated from YGFlexWrapTest.cpp
class FlexWrapTests: FlexTestCase {

    // Generated from test: wrap_column
    func testWrapColumn() {
        let root = FlexLayout()
        root.flexWrap(FlexWrap.wrap)
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(30))
        root_child0.height(StyleValue.length(30))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(30))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(30))
        root_child2.height(StyleValue.length(30))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(30))
        root_child3.height(StyleValue.length(30))
        root.append(root_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 60)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 30)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 30)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 30)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 60)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 30)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 30)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 60)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 30)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 30)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 30)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 30)

        XCTAssertEqual(root_child2.box.left, 30)
        XCTAssertEqual(root_child2.box.top, 60)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 30)
    }

    // Generated from test: wrap_row
    func testWrapRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(30))
        root_child0.height(StyleValue.length(30))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(30))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(30))
        root_child2.height(StyleValue.length(30))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(30))
        root_child3.height(StyleValue.length(30))
        root.append(root_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 60)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 30)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 30)

        XCTAssertEqual(root_child2.box.left, 60)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 30)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 60)

        XCTAssertEqual(root_child0.box.left, 70)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 30)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 30)

        XCTAssertEqual(root_child2.box.left, 10)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 70)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 30)
    }

    // Generated from test: wrap_row_align_items_flex_end
    func testWrapRowAlignItemsFlexEnd() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.flexEnd)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(30))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(30))
        root_child2.height(StyleValue.length(30))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(30))
        root_child3.height(StyleValue.length(30))
        root.append(root_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 60)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 20)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 60)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 30)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 60)

        XCTAssertEqual(root_child0.box.left, 70)
        XCTAssertEqual(root_child0.box.top, 20)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 10)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 70)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 30)
    }

    // Generated from test: wrap_row_align_items_center
    func testWrapRowAlignItemsCenter() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.center)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(30))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(30))
        root_child2.height(StyleValue.length(30))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(30))
        root_child3.height(StyleValue.length(30))
        root.append(root_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 60)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 5)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 60)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 30)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 60)

        XCTAssertEqual(root_child0.box.left, 70)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 5)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 10)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 70)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 30)
    }

    // Generated from test: flex_wrap_children_with_min_main_overriding_flex_basis
    func testFlexWrapChildrenWithMinMainOverridingFlexBasis() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexBasis(FlexBasis.length(50))
        root_child0.minWidth(StyleValue.length(55))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexBasis(FlexBasis.length(50))
        root_child1.minWidth(StyleValue.length(55))
        root_child1.height(StyleValue.length(50))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 55)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 55)
        XCTAssertEqual(root_child1.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 45)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 55)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 45)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 55)
        XCTAssertEqual(root_child1.box.height, 50)
    }

    // Generated from test: flex_wrap_wrap_to_child_height
    func testFlexWrapWrapToChildHeight() {
        let root = FlexLayout()

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.alignItems(AlignItems.flexStart)
        root_child0.flexWrap(FlexWrap.wrap)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.width(StyleValue.length(100))
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.width(StyleValue.length(100))
        root_child0_child0_child0.height(StyleValue.length(100))
        root_child0_child0.append(root_child0_child0_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(100))
        root_child1.height(StyleValue.length(100))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 100)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 100)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 100)
    }

    // Generated from test: flex_wrap_align_stretch_fits_one_row
    func testFlexWrapAlignStretchFitsOneRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
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
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 100)
    }

    // Generated from test: wrap_reverse_row_align_content_flex_start
    func testWrapReverseRowAlignContentFlexStart() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.flexWrap(FlexWrap.wrapReverse)
        root.width(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(30))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(30))
        root_child2.height(StyleValue.length(30))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(30))
        root_child3.height(StyleValue.length(40))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(30))
        root_child4.height(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 70)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 60)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 60)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 30)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 70)
        XCTAssertEqual(root_child0.box.top, 70)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 60)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 10)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 70)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 40)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: wrap_reverse_row_align_content_center
    func testWrapReverseRowAlignContentCenter() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.center)
        root.flexWrap(FlexWrap.wrapReverse)
        root.width(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(30))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(30))
        root_child2.height(StyleValue.length(30))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(30))
        root_child3.height(StyleValue.length(40))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(30))
        root_child4.height(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 70)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 60)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 60)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 30)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 70)
        XCTAssertEqual(root_child0.box.top, 70)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 60)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 10)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 70)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 40)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: wrap_reverse_row_single_line_different_size
    func testWrapReverseRowSingleLineDifferentSize() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.flexWrap(FlexWrap.wrapReverse)
        root.width(StyleValue.length(300))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(30))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(30))
        root_child2.height(StyleValue.length(30))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(30))
        root_child3.height(StyleValue.length(40))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(30))
        root_child4.height(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 300)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 40)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 30)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 60)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 90)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 120)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 300)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 270)
        XCTAssertEqual(root_child0.box.top, 40)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 240)
        XCTAssertEqual(root_child1.box.top, 30)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 210)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 180)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 150)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: wrap_reverse_row_align_content_stretch
    func testWrapReverseRowAlignContentStretch() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrapReverse)
        root.width(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(30))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(30))
        root_child2.height(StyleValue.length(30))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(30))
        root_child3.height(StyleValue.length(40))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(30))
        root_child4.height(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 70)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 60)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 60)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 30)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 70)
        XCTAssertEqual(root_child0.box.top, 70)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 60)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 10)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 70)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 40)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: wrap_reverse_row_align_content_space_around
    func testWrapReverseRowAlignContentSpaceAround() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.spaceAround)
        root.flexWrap(FlexWrap.wrapReverse)
        root.width(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(30))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(30))
        root_child2.height(StyleValue.length(30))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(30))
        root_child3.height(StyleValue.length(40))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(30))
        root_child4.height(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 70)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 60)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 60)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 30)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 70)
        XCTAssertEqual(root_child0.box.top, 70)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 60)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 10)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 70)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 40)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: wrap_reverse_column_fixed_size
    func testWrapReverseColumnFixedSize() {
        let root = FlexLayout()
        root.alignItems(AlignItems.center)
        root.flexWrap(FlexWrap.wrapReverse)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(30))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(30))
        root_child2.height(StyleValue.length(30))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(30))
        root_child3.height(StyleValue.length(40))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(30))
        root_child4.height(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 170)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 170)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 170)
        XCTAssertEqual(root_child2.box.top, 30)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 170)
        XCTAssertEqual(root_child3.box.top, 60)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 140)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 30)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 30)
        XCTAssertEqual(root_child2.box.width, 30)
        XCTAssertEqual(root_child2.box.height, 30)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 60)
        XCTAssertEqual(root_child3.box.width, 30)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 30)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 30)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: wrapped_row_within_align_items_center
    func testWrappedRowWithinAlignItemsCenter() {
        let root = FlexLayout()
        root.alignItems(AlignItems.center)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.flexWrap(FlexWrap.wrap)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.width(StyleValue.length(150))
        root_child0_child0.height(StyleValue.length(80))
        root_child0.append(root_child0_child0)

        let root_child0_child1 = FlexLayout()
        root_child0_child1.width(StyleValue.length(80))
        root_child0_child1.height(StyleValue.length(80))
        root_child0.append(root_child0_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 160)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 150)
        XCTAssertEqual(root_child0_child0.box.height, 80)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 80)
        XCTAssertEqual(root_child0_child1.box.width, 80)
        XCTAssertEqual(root_child0_child1.box.height, 80)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 160)

        XCTAssertEqual(root_child0_child0.box.left, 50)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 150)
        XCTAssertEqual(root_child0_child0.box.height, 80)

        XCTAssertEqual(root_child0_child1.box.left, 120)
        XCTAssertEqual(root_child0_child1.box.top, 80)
        XCTAssertEqual(root_child0_child1.box.width, 80)
        XCTAssertEqual(root_child0_child1.box.height, 80)
    }

    // Generated from test: wrapped_row_within_align_items_flex_start
    func testWrappedRowWithinAlignItemsFlexStart() {
        let root = FlexLayout()
        root.alignItems(AlignItems.flexStart)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.flexWrap(FlexWrap.wrap)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.width(StyleValue.length(150))
        root_child0_child0.height(StyleValue.length(80))
        root_child0.append(root_child0_child0)

        let root_child0_child1 = FlexLayout()
        root_child0_child1.width(StyleValue.length(80))
        root_child0_child1.height(StyleValue.length(80))
        root_child0.append(root_child0_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 160)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 150)
        XCTAssertEqual(root_child0_child0.box.height, 80)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 80)
        XCTAssertEqual(root_child0_child1.box.width, 80)
        XCTAssertEqual(root_child0_child1.box.height, 80)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 160)

        XCTAssertEqual(root_child0_child0.box.left, 50)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 150)
        XCTAssertEqual(root_child0_child0.box.height, 80)

        XCTAssertEqual(root_child0_child1.box.left, 120)
        XCTAssertEqual(root_child0_child1.box.top, 80)
        XCTAssertEqual(root_child0_child1.box.width, 80)
        XCTAssertEqual(root_child0_child1.box.height, 80)
    }

    // Generated from test: wrapped_row_within_align_items_flex_end
    func testWrappedRowWithinAlignItemsFlexEnd() {
        let root = FlexLayout()
        root.alignItems(AlignItems.flexEnd)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.flexWrap(FlexWrap.wrap)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.width(StyleValue.length(150))
        root_child0_child0.height(StyleValue.length(80))
        root_child0.append(root_child0_child0)

        let root_child0_child1 = FlexLayout()
        root_child0_child1.width(StyleValue.length(80))
        root_child0_child1.height(StyleValue.length(80))
        root_child0.append(root_child0_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 160)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 150)
        XCTAssertEqual(root_child0_child0.box.height, 80)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 80)
        XCTAssertEqual(root_child0_child1.box.width, 80)
        XCTAssertEqual(root_child0_child1.box.height, 80)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 160)

        XCTAssertEqual(root_child0_child0.box.left, 50)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 150)
        XCTAssertEqual(root_child0_child0.box.height, 80)

        XCTAssertEqual(root_child0_child1.box.left, 120)
        XCTAssertEqual(root_child0_child1.box.top, 80)
        XCTAssertEqual(root_child0_child1.box.width, 80)
        XCTAssertEqual(root_child0_child1.box.height, 80)
    }

    // Generated from test: wrapped_column_max_height
    func testWrappedColumnMaxHeight() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignContent(AlignContent.center)
        root.alignItems(AlignItems.center)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(700))
        root.height(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(100))
        root_child0.height(StyleValue.length(500))
        root_child0.maxHeight(StyleValue.length(200))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.margin(left: StyleValue.length(20))
        root_child1.margin(top: StyleValue.length(20))
        root_child1.margin(right: StyleValue.length(20))
        root_child1.margin(bottom: StyleValue.length(20))
        root_child1.width(StyleValue.length(200))
        root_child1.height(StyleValue.length(200))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(100))
        root_child2.height(StyleValue.length(100))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 700)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 250)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 200)

        XCTAssertEqual(root_child1.box.left, 200)
        XCTAssertEqual(root_child1.box.top, 250)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 200)

        XCTAssertEqual(root_child2.box.left, 420)
        XCTAssertEqual(root_child2.box.top, 200)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 700)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 350)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 200)

        XCTAssertEqual(root_child1.box.left, 300)
        XCTAssertEqual(root_child1.box.top, 250)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 200)

        XCTAssertEqual(root_child2.box.left, 180)
        XCTAssertEqual(root_child2.box.top, 200)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 100)
    }

    // Generated from test: wrapped_column_max_height_flex
    func testWrappedColumnMaxHeightFlex() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignContent(AlignContent.center)
        root.alignItems(AlignItems.center)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(700))
        root.height(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexShrink(1)
        root_child0.flexBasis(FlexBasis.percentage(0))
        root_child0.width(StyleValue.length(100))
        root_child0.height(StyleValue.length(500))
        root_child0.maxHeight(StyleValue.length(200))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.flexShrink(1)
        root_child1.flexBasis(FlexBasis.percentage(0))
        root_child1.margin(left: StyleValue.length(20))
        root_child1.margin(top: StyleValue.length(20))
        root_child1.margin(right: StyleValue.length(20))
        root_child1.margin(bottom: StyleValue.length(20))
        root_child1.width(StyleValue.length(200))
        root_child1.height(StyleValue.length(200))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(100))
        root_child2.height(StyleValue.length(100))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 700)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 300)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 180)

        XCTAssertEqual(root_child1.box.left, 250)
        XCTAssertEqual(root_child1.box.top, 200)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 180)

        XCTAssertEqual(root_child2.box.left, 300)
        XCTAssertEqual(root_child2.box.top, 400)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 700)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 300)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 180)

        XCTAssertEqual(root_child1.box.left, 250)
        XCTAssertEqual(root_child1.box.top, 200)
        XCTAssertEqual(root_child1.box.width, 200)
        XCTAssertEqual(root_child1.box.height, 180)

        XCTAssertEqual(root_child2.box.left, 300)
        XCTAssertEqual(root_child2.box.top, 400)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 100)
    }

    // Generated from test: wrap_nodes_with_content_sizing_overflowing_margin
    func testWrapNodesWithContentSizingOverflowingMargin() {
        let root = FlexLayout()
        root.width(StyleValue.length(500))
        root.height(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.flexWrap(FlexWrap.wrap)
        root_child0.width(StyleValue.length(85))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.width(StyleValue.length(40))
        root_child0_child0_child0.height(StyleValue.length(40))
        root_child0_child0.append(root_child0_child0_child0)

        let root_child0_child1 = FlexLayout()
        root_child0_child1.margin(right: StyleValue.length(10))
        root_child0.append(root_child0_child1)

        let root_child0_child1_child0 = FlexLayout()
        root_child0_child1_child0.width(StyleValue.length(40))
        root_child0_child1_child0.height(StyleValue.length(40))
        root_child0_child1.append(root_child0_child1_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 85)
        XCTAssertEqual(root_child0.box.height, 80)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 40)
        XCTAssertEqual(root_child0_child0.box.height, 40)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 40)
        XCTAssertEqual(root_child0_child0_child0.box.height, 40)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 40)
        XCTAssertEqual(root_child0_child1.box.width, 40)
        XCTAssertEqual(root_child0_child1.box.height, 40)

        XCTAssertEqual(root_child0_child1_child0.box.left, 0)
        XCTAssertEqual(root_child0_child1_child0.box.top, 0)
        XCTAssertEqual(root_child0_child1_child0.box.width, 40)
        XCTAssertEqual(root_child0_child1_child0.box.height, 40)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 415)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 85)
        XCTAssertEqual(root_child0.box.height, 80)

        XCTAssertEqual(root_child0_child0.box.left, 45)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 40)
        XCTAssertEqual(root_child0_child0.box.height, 40)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 40)
        XCTAssertEqual(root_child0_child0_child0.box.height, 40)

        XCTAssertEqual(root_child0_child1.box.left, 35)
        XCTAssertEqual(root_child0_child1.box.top, 40)
        XCTAssertEqual(root_child0_child1.box.width, 40)
        XCTAssertEqual(root_child0_child1.box.height, 40)

        XCTAssertEqual(root_child0_child1_child0.box.left, 0)
        XCTAssertEqual(root_child0_child1_child0.box.top, 0)
        XCTAssertEqual(root_child0_child1_child0.box.width, 40)
        XCTAssertEqual(root_child0_child1_child0.box.height, 40)
    }

    // Generated from test: wrap_nodes_with_content_sizing_margin_cross
    func testWrapNodesWithContentSizingMarginCross() {
        let root = FlexLayout()
        root.width(StyleValue.length(500))
        root.height(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.flexWrap(FlexWrap.wrap)
        root_child0.width(StyleValue.length(70))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.width(StyleValue.length(40))
        root_child0_child0_child0.height(StyleValue.length(40))
        root_child0_child0.append(root_child0_child0_child0)

        let root_child0_child1 = FlexLayout()
        root_child0_child1.margin(top: StyleValue.length(10))
        root_child0.append(root_child0_child1)

        let root_child0_child1_child0 = FlexLayout()
        root_child0_child1_child0.width(StyleValue.length(40))
        root_child0_child1_child0.height(StyleValue.length(40))
        root_child0_child1.append(root_child0_child1_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 70)
        XCTAssertEqual(root_child0.box.height, 90)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 40)
        XCTAssertEqual(root_child0_child0.box.height, 40)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 40)
        XCTAssertEqual(root_child0_child0_child0.box.height, 40)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 50)
        XCTAssertEqual(root_child0_child1.box.width, 40)
        XCTAssertEqual(root_child0_child1.box.height, 40)

        XCTAssertEqual(root_child0_child1_child0.box.left, 0)
        XCTAssertEqual(root_child0_child1_child0.box.top, 0)
        XCTAssertEqual(root_child0_child1_child0.box.width, 40)
        XCTAssertEqual(root_child0_child1_child0.box.height, 40)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 430)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 70)
        XCTAssertEqual(root_child0.box.height, 90)

        XCTAssertEqual(root_child0_child0.box.left, 30)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 40)
        XCTAssertEqual(root_child0_child0.box.height, 40)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 40)
        XCTAssertEqual(root_child0_child0_child0.box.height, 40)

        XCTAssertEqual(root_child0_child1.box.left, 30)
        XCTAssertEqual(root_child0_child1.box.top, 50)
        XCTAssertEqual(root_child0_child1.box.width, 40)
        XCTAssertEqual(root_child0_child1.box.height, 40)

        XCTAssertEqual(root_child0_child1_child0.box.left, 0)
        XCTAssertEqual(root_child0_child1_child0.box.top, 0)
        XCTAssertEqual(root_child0_child1_child0.box.width, 40)
        XCTAssertEqual(root_child0_child1_child0.box.height, 40)
    }
}
