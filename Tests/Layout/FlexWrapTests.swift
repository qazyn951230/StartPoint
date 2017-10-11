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

// Generated from YGFlexWrapTest.cpp
class FlexWrapTests: FlexTestCase {

    // Generated from test: wrap_column
    func testWrapColumn() {
        let root = yogaLayout()
            .flexWrap(.wrap)
            .height(100)

        let root_child0 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
            .width(100)

        let root_child0 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.flexEnd)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .width(30)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(30)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .width(30)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(30)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
            .width(100)

        let root_child0 = yogaLayout()
            .flexBasis(50)
            .height(50)
            .minWidth(55)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(50)
            .height(50)
            .minWidth(55)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()

        let root_child0 = yogaLayout()
            .alignItems(.flexStart)
            .flexDirection(.row)
            .flexWrap(.wrap)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .width(100)
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = yogaLayout()
            .height(100)
            .width(100)
        root_child0_child0.append(root_child0_child0_child0)

        let root_child1 = yogaLayout()
            .height(100)
            .width(100)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(150)

        let root_child0 = yogaLayout()
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .width(50)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrapReverse)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .width(30)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(30)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(40)
            .width(30)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .height(50)
            .width(30)
        root.append(root_child4)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignContent(.center)
            .flexDirection(.row)
            .flexWrap(.wrapReverse)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .width(30)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(30)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(40)
            .width(30)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .height(50)
            .width(30)
        root.append(root_child4)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrapReverse)
            .width(300)

        let root_child0 = yogaLayout()
            .height(10)
            .width(30)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(30)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(40)
            .width(30)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .height(50)
            .width(30)
        root.append(root_child4)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignContent(.stretch)
            .flexDirection(.row)
            .flexWrap(.wrapReverse)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .width(30)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(30)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(40)
            .width(30)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .height(50)
            .width(30)
        root.append(root_child4)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignContent(.spaceAround)
            .flexDirection(.row)
            .flexWrap(.wrapReverse)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .width(30)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(30)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(40)
            .width(30)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .height(50)
            .width(30)
        root.append(root_child4)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .flexWrap(.wrapReverse)
            .height(100)
            .width(200)

        let root_child0 = yogaLayout()
            .height(10)
            .width(30)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(30)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(30)
            .width(30)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(40)
            .width(30)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .height(50)
            .width(30)
        root.append(root_child4)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .height(80)
            .width(150)
        root_child0.append(root_child0_child0)

        let root_child0_child1 = yogaLayout()
            .height(80)
            .width(80)
        root_child0.append(root_child0_child1)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.flexStart)
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .height(80)
            .width(150)
        root_child0.append(root_child0_child0)

        let root_child0_child1 = yogaLayout()
            .height(80)
            .width(80)
        root_child0.append(root_child0_child1)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.flexEnd)
            .height(200)
            .width(200)

        let root_child0 = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .height(80)
            .width(150)
        root_child0.append(root_child0_child0)

        let root_child0_child1 = yogaLayout()
            .height(80)
            .width(80)
        root_child0.append(root_child0_child1)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignContent(.center)
            .alignItems(.center)
            .flexWrap(.wrap)
            .height(500)
            .justifyContent(.center)
            .width(700)

        let root_child0 = yogaLayout()
            .height(500)
            .maxHeight(200)
            .width(100)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(200)
            .margin(bottom: 20)
            .margin(left: 20)
            .margin(right: 20)
            .margin(top: 20)
            .width(200)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(100)
            .width(100)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignContent(.center)
            .alignItems(.center)
            .flexWrap(.wrap)
            .height(500)
            .justifyContent(.center)
            .width(700)

        let root_child0 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .flexShrink(1)
            .height(500)
            .maxHeight(200)
            .width(100)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .flexShrink(1)
            .height(200)
            .margin(bottom: 20)
            .margin(left: 20)
            .margin(right: 20)
            .margin(top: 20)
            .width(200)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(100)
            .width(100)
        root.append(root_child2)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(500)
            .width(500)

        let root_child0 = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
            .width(85)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = yogaLayout()
            .height(40)
            .width(40)
        root_child0_child0.append(root_child0_child0_child0)

        let root_child0_child1 = yogaLayout()
            .margin(right: 10)
        root_child0.append(root_child0_child1)

        let root_child0_child1_child0 = yogaLayout()
            .height(40)
            .width(40)
        root_child0_child1.append(root_child0_child1_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(500)
            .width(500)

        let root_child0 = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
            .width(70)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = yogaLayout()
            .height(40)
            .width(40)
        root_child0_child0.append(root_child0_child0_child0)

        let root_child0_child1 = yogaLayout()
            .margin(top: 10)
        root_child0.append(root_child0_child1)

        let root_child0_child1_child0 = yogaLayout()
            .height(40)
            .width(40)
        root_child0_child1.append(root_child0_child1_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
