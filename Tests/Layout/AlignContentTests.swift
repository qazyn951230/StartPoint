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

// Generated from YGAlignContentTest.cpp
class AlignContentTests: FlexTestCase {

    // Generated from test: align_content_flex_start
    func testAlignContentFlexStart() {
        let root = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(130)

        let root_child0 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 130)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 10)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 20)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 130)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 80)
        XCTAssertEqual(root_child2.box.top, 10)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 30)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 80)
        XCTAssertEqual(root_child4.box.top, 20)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)
    }

    // Generated from test: align_content_flex_start_without_height_on_children
    func testAlignContentFlexStartWithoutHeightOnChildren() {
        let root = yogaLayout()
            .flexWrap(.wrap)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 10)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 20)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 10)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 20)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)
    }

    // Generated from test: align_content_flex_start_with_flex
    func testAlignContentFlexStartWithFlex() {
        let root = yogaLayout()
            .flexWrap(.wrap)
            .height(120)
            .width(100)

        let root_child0 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .height(10)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .flexShrink(1)
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 120)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 40)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 40)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 80)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 80)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 120)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 120)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 40)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 40)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 80)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 80)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 120)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)
    }

    // Generated from test: align_content_flex_end
    func testAlignContentFlexEnd() {
        let root = yogaLayout()
            .alignContent(.flexEnd)
            .flexWrap(.wrap)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 40)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 40)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)
    }

    // Generated from test: align_content_stretch
    func testAlignContentStretch() {
        let root = yogaLayout()
            .alignContent(.stretch)
            .flexWrap(.wrap)
            .height(100)
            .width(150)

        let root_child0 = yogaLayout()
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 0)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 100)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 0)

        XCTAssertEqual(root_child4.box.left, 100)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)
    }

    // Generated from test: align_content_spacebetween
    func testAlignContentSpacebetween() {
        let root = yogaLayout()
            .alignContent(.spaceBetween)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(130)

        let root_child0 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 130)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 45)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 45)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 90)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 130)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 80)
        XCTAssertEqual(root_child2.box.top, 45)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 30)
        XCTAssertEqual(root_child3.box.top, 45)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 80)
        XCTAssertEqual(root_child4.box.top, 90)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)
    }

    // Generated from test: align_content_spacearound
    func testAlignContentSpacearound() {
        let root = yogaLayout()
            .alignContent(.spaceAround)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(120)
            .width(140)

        let root_child0 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .height(10)
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 140)
        XCTAssertEqual(root.box.height, 120)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 15)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 15)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 55)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 55)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 95)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 140)
        XCTAssertEqual(root.box.height, 120)

        XCTAssertEqual(root_child0.box.left, 90)
        XCTAssertEqual(root_child0.box.top, 15)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 15)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 90)
        XCTAssertEqual(root_child2.box.top, 55)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 40)
        XCTAssertEqual(root_child3.box.top, 55)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 90)
        XCTAssertEqual(root_child4.box.top, 95)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)
    }

    // Generated from test: align_content_stretch_row
    func testAlignContentStretchRow() {
        let root = yogaLayout()
            .alignContent(.stretch)
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

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: align_content_stretch_row_with_children
    func testAlignContentStretchRowWithChildren() {
        let root = yogaLayout()
            .alignContent(.stretch)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(150)

        let root_child0 = yogaLayout()
            .width(50)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child1 = yogaLayout()
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: align_content_stretch_row_with_flex
    func testAlignContentStretchRowWithFlex() {
        let root = yogaLayout()
            .alignContent(.stretch)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(150)

        let root_child0 = yogaLayout()
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .flexShrink(1)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .flexShrink(1)
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
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
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 100)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 0)
        XCTAssertEqual(root_child3.box.height, 100)

        XCTAssertEqual(root_child4.box.left, 100)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 100)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 100)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 100)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 0)
        XCTAssertEqual(root_child3.box.height, 100)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 100)
    }

    // Generated from test: align_content_stretch_row_with_flex_no_shrink
    func testAlignContentStretchRowWithFlexNoShrink() {
        let root = yogaLayout()
            .alignContent(.stretch)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(150)

        let root_child0 = yogaLayout()
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .flexShrink(1)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
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
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 100)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 0)
        XCTAssertEqual(root_child3.box.height, 100)

        XCTAssertEqual(root_child4.box.left, 100)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 100)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 100)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 100)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 0)
        XCTAssertEqual(root_child3.box.height, 100)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 100)
    }

    // Generated from test: align_content_stretch_row_with_margin
    func testAlignContentStretchRowWithMargin() {
        let root = yogaLayout()
            .alignContent(.stretch)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(150)

        let root_child0 = yogaLayout()
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .margin(bottom: 10)
            .margin(left: 10)
            .margin(right: 10)
            .margin(top: 10)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .margin(bottom: 10)
            .margin(left: 10)
            .margin(right: 10)
            .margin(top: 10)
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 40)

        XCTAssertEqual(root_child1.box.left, 60)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 40)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 40)

        XCTAssertEqual(root_child3.box.left, 60)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 80)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 20)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 40)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 40)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 40)

        XCTAssertEqual(root_child3.box.left, 40)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)

        XCTAssertEqual(root_child4.box.left, 100)
        XCTAssertEqual(root_child4.box.top, 80)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 20)
    }

    // Generated from test: align_content_stretch_row_with_padding
    func testAlignContentStretchRowWithPadding() {
        let root = yogaLayout()
            .alignContent(.stretch)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(150)

        let root_child0 = yogaLayout()
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .padding(bottom: 10)
            .padding(left: 10)
            .padding(right: 10)
            .padding(top: 10)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .padding(bottom: 10)
            .padding(left: 10)
            .padding(right: 10)
            .padding(top: 10)
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: align_content_stretch_row_with_single_row
    func testAlignContentStretchRowWithSingleRow() {
        let root = yogaLayout()
            .alignContent(.stretch)
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

    // Generated from test: align_content_stretch_row_with_fixed_height
    func testAlignContentStretchRowWithFixedHeight() {
        let root = yogaLayout()
            .alignContent(.stretch)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(150)

        let root_child0 = yogaLayout()
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(60)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 80)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 60)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 80)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 80)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 80)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 20)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 80)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 60)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 80)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 80)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 80)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 20)
    }

    // Generated from test: align_content_stretch_row_with_max_height
    func testAlignContentStretchRowWithMaxHeight() {
        let root = yogaLayout()
            .alignContent(.stretch)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(150)

        let root_child0 = yogaLayout()
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .maxHeight(20)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: align_content_stretch_row_with_min_height
    func testAlignContentStretchRowWithMinHeight() {
        let root = yogaLayout()
            .alignContent(.stretch)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(150)

        let root_child0 = yogaLayout()
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .minHeight(80)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .width(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .width(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 90)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 90)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 90)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 90)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 90)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 90)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 90)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 90)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 90)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 90)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)
    }

    // Generated from test: align_content_stretch_column
    func testAlignContentStretchColumn() {
        let root = yogaLayout()
            .alignContent(.stretch)
            .flexWrap(.wrap)
            .height(150)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child1 = yogaLayout()
            .flexBasis(0)
            .flexGrow(1)
            .flexShrink(1)
            .height(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(50)
        root.append(root_child3)

        let root_child4 = yogaLayout()
            .height(50)
        root.append(root_child4)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 150)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 100)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 150)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 100)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: align_content_stretch_is_not_overriding_align_items
    func testAlignContentStretchIsNotOverridingAlignItems() {
        let root = yogaLayout()
            .alignContent(.stretch)

        let root_child0 = yogaLayout()
            .alignContent(.stretch)
            .alignItems(.center)
            .flexDirection(.row)
            .height(100)
            .width(100)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .alignContent(.stretch)
            .height(10)
            .width(10)
        root_child0.append(root_child0_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 45)
        XCTAssertEqual(root_child0_child0.box.width, 10)
        XCTAssertEqual(root_child0_child0.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 90)
        XCTAssertEqual(root_child0_child0.box.top, 45)
        XCTAssertEqual(root_child0_child0.box.width, 10)
        XCTAssertEqual(root_child0_child0.box.height, 10)
    }
}
