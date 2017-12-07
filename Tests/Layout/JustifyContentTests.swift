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

// Generated from YGJustifyContentTest.cpp
class JustifyContentTests: FlexTestCase {

    // Generated from test: justify_content_row_flex_start
    func testJustifyContentRowFlexStart() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(102)
            .width(102)

        let root_child0 = yogaLayout()
            .width(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .width(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 102)

        XCTAssertEqual(root_child1.box.left, 10)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 102)

        XCTAssertEqual(root_child2.box.left, 20)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 102)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 92)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 102)

        XCTAssertEqual(root_child1.box.left, 82)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 102)

        XCTAssertEqual(root_child2.box.left, 72)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 102)
    }

    // Generated from test: justify_content_row_flex_end
    func testJustifyContentRowFlexEnd() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(102)
            .justifyContent(.flexEnd)
            .width(102)

        let root_child0 = yogaLayout()
            .width(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .width(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 72)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 102)

        XCTAssertEqual(root_child1.box.left, 82)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 102)

        XCTAssertEqual(root_child2.box.left, 92)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 102)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 20)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 102)

        XCTAssertEqual(root_child1.box.left, 10)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 102)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 102)
    }

    // Generated from test: justify_content_row_center
    func testJustifyContentRowCenter() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(102)
            .justifyContent(.center)
            .width(102)

        let root_child0 = yogaLayout()
            .width(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .width(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 36)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 102)

        XCTAssertEqual(root_child1.box.left, 46)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 102)

        XCTAssertEqual(root_child2.box.left, 56)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 102)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 56)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 102)

        XCTAssertEqual(root_child1.box.left, 46)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 102)

        XCTAssertEqual(root_child2.box.left, 36)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 102)
    }

    // Generated from test: justify_content_row_space_between
    func testJustifyContentRowSpaceBetween() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(102)
            .justifyContent(.spaceBetween)
            .width(102)

        let root_child0 = yogaLayout()
            .width(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .width(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 102)

        XCTAssertEqual(root_child1.box.left, 46)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 102)

        XCTAssertEqual(root_child2.box.left, 92)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 102)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 92)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 102)

        XCTAssertEqual(root_child1.box.left, 46)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 102)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 102)
    }

    // Generated from test: justify_content_row_space_around
    func testJustifyContentRowSpaceAround() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(102)
            .justifyContent(.spaceAround)
            .width(102)

        let root_child0 = yogaLayout()
            .width(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .width(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .width(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 12)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 102)

        XCTAssertEqual(root_child1.box.left, 46)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 102)

        XCTAssertEqual(root_child2.box.left, 80)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 102)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 102)

        XCTAssertEqual(root_child1.box.left, 46)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 102)

        XCTAssertEqual(root_child2.box.left, 12)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 102)
    }

    // Generated from test: justify_content_column_flex_start
    func testJustifyContentColumnFlexStart() {
        let root = yogaLayout()
            .height(102)
            .width(102)

        let root_child0 = yogaLayout()
            .height(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)
    }

    // Generated from test: justify_content_column_flex_end
    func testJustifyContentColumnFlexEnd() {
        let root = yogaLayout()
            .height(102)
            .justifyContent(.flexEnd)
            .width(102)

        let root_child0 = yogaLayout()
            .height(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 72)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 82)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 92)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 72)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 82)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 92)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)
    }

    // Generated from test: justify_content_column_center
    func testJustifyContentColumnCenter() {
        let root = yogaLayout()
            .height(102)
            .justifyContent(.center)
            .width(102)

        let root_child0 = yogaLayout()
            .height(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 36)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 46)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 56)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 36)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 46)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 56)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)
    }

    // Generated from test: justify_content_column_space_between
    func testJustifyContentColumnSpaceBetween() {
        let root = yogaLayout()
            .height(102)
            .justifyContent(.spaceBetween)
            .width(102)

        let root_child0 = yogaLayout()
            .height(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 46)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 92)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 46)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 92)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)
    }

    // Generated from test: justify_content_column_space_around
    func testJustifyContentColumnSpaceAround() {
        let root = yogaLayout()
            .height(102)
            .justifyContent(.spaceAround)
            .width(102)

        let root_child0 = yogaLayout()
            .height(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 12)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 46)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 80)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 12)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 46)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 80)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)
    }

    // Generated from test: justify_content_row_min_width_and_margin
    func testJustifyContentRowMinWidthAndMargin() {
        let root = yogaLayout()
            .flexDirection(.row)
            .justifyContent(.center)
            .margin(left: 100)
            .minWidth(50)

        let root_child0 = yogaLayout()
            .height(20)
            .width(20)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 100)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 20)

        XCTAssertEqual(root_child0.box.left, 15)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 100)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 20)

        XCTAssertEqual(root_child0.box.left, 15)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)
    }

    // Generated from test: justify_content_row_max_width_and_margin
    func testJustifyContentRowMaxWidthAndMargin() {
        let root = yogaLayout()
            .flexDirection(.row)
            .justifyContent(.center)
            .margin(left: 100)
            .maxWidth(80)
            .width(100)

        let root_child0 = yogaLayout()
            .height(20)
            .width(20)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 100)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 80)
        XCTAssertEqual(root.box.height, 20)

        XCTAssertEqual(root_child0.box.left, 30)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 100)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 80)
        XCTAssertEqual(root.box.height, 20)

        XCTAssertEqual(root_child0.box.left, 30)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)
    }

    // Generated from test: justify_content_column_min_height_and_margin
    func testJustifyContentColumnMinHeightAndMargin() {
        let root = yogaLayout()
            .justifyContent(.center)
            .margin(top: 100)
            .minHeight(50)

        let root_child0 = yogaLayout()
            .height(20)
            .width(20)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 100)
        XCTAssertEqual(root.box.width, 20)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 15)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 100)
        XCTAssertEqual(root.box.width, 20)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 15)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)
    }

    // Generated from test: justify_content_colunn_max_height_and_margin
    func testJustifyContentColunnMaxHeightAndMargin() {
        let root = yogaLayout()
            .height(100)
            .justifyContent(.center)
            .margin(top: 100)
            .maxHeight(80)

        let root_child0 = yogaLayout()
            .height(20)
            .width(20)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 100)
        XCTAssertEqual(root.box.width, 20)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 100)
        XCTAssertEqual(root.box.width, 20)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)
    }

    // Generated from test: justify_content_column_space_evenly
    func testJustifyContentColumnSpaceEvenly() {
        let root = yogaLayout()
            .height(102)
            .justifyContent(.spaceEvenly)
            .width(102)

        let root_child0 = yogaLayout()
            .height(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 18)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 46)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 74)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 18)
        XCTAssertEqual(root_child0.box.width, 102)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 46)
        XCTAssertEqual(root_child1.box.width, 102)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 74)
        XCTAssertEqual(root_child2.box.width, 102)
        XCTAssertEqual(root_child2.box.height, 10)
    }

    // Generated from test: justify_content_row_space_evenly
    func testJustifyContentRowSpaceEvenly() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(102)
            .justifyContent(.spaceEvenly)
            .width(102)

        let root_child0 = yogaLayout()
            .height(10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(10)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(10)
        root.append(root_child2)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 26)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 51)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 77)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 0)
        XCTAssertEqual(root_child2.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 102)
        XCTAssertEqual(root.box.height, 102)

        XCTAssertEqual(root_child0.box.left, 77)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 51)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 26)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 0)
        XCTAssertEqual(root_child2.box.height, 10)
    }
}
