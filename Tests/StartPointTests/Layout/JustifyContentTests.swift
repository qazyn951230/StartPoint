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

// Generated from YGJustifyContentTest.cpp
class JustifyContentTests: FlexTestCase {

    // Generated from test: justify_content_row_flex_start
    func testJustifyContentRowFlexStart() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.justifyContent(JustifyContent.flexEnd)
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.justifyContent(JustifyContent.center)
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.justifyContent(JustifyContent.spaceBetween)
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.justifyContent(JustifyContent.spaceAround)
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.justifyContent(JustifyContent.flexEnd)
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.justifyContent(JustifyContent.spaceBetween)
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.justifyContent(JustifyContent.spaceAround)
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.justifyContent(JustifyContent.center)
        root.margin(left: StyleValue.length(100))
        root.minWidth(StyleValue.length(50))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(20))
        root_child0.height(StyleValue.length(20))
        root.insert(root_child0, at: 0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 100)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 20)

        XCTAssertEqual(root_child0.box.left, 15)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.justifyContent(JustifyContent.center)
        root.margin(left: StyleValue.length(100))
        root.width(StyleValue.length(100))
        root.maxWidth(StyleValue.length(80))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(20))
        root_child0.height(StyleValue.length(20))
        root.insert(root_child0, at: 0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 100)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 80)
        XCTAssertEqual(root.box.height, 20)

        XCTAssertEqual(root_child0.box.left, 30)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.margin(top: StyleValue.length(100))
        root.minHeight(StyleValue.length(50))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(20))
        root_child0.height(StyleValue.length(20))
        root.insert(root_child0, at: 0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 100)
        XCTAssertEqual(root.box.width, 20)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 15)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.margin(top: StyleValue.length(100))
        root.height(StyleValue.length(100))
        root.maxHeight(StyleValue.length(80))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(20))
        root_child0.height(StyleValue.length(20))
        root.insert(root_child0, at: 0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 100)
        XCTAssertEqual(root.box.width, 20)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.justifyContent(JustifyContent.spaceEvenly)
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.justifyContent(JustifyContent.spaceEvenly)
        root.width(StyleValue.length(102))
        root.height(StyleValue.length(102))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(10))
        root.insert(root_child1, at: 1)

        let root_child2 = FlexLayout()
        root_child2.height(StyleValue.length(10))
        root.insert(root_child2, at: 2)
        root.calculate(direction: Direction.ltr)

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

        root.calculate(direction: Direction.rtl)

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

    // Generated from test: justify_content_min_width_with_padding_child_width_greater_than_parent
    func testJustifyContentMinWidthWithPaddingChildWidthGreaterThanParent() {
        let root = FlexLayout()
        root.alignContent(AlignContent.stretch)
        root.width(StyleValue.length(1000))
        root.height(StyleValue.length(1584))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.alignContent(AlignContent.stretch)
        root.insert(root_child0, at: 0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexDirection(FlexDirection.row)
        root_child0_child0.justifyContent(JustifyContent.center)
        root_child0_child0.alignContent(AlignContent.stretch)
        root_child0_child0.padding(left: StyleValue.length(100))
        root_child0_child0.padding(right: StyleValue.length(100))
        root_child0_child0.minWidth(StyleValue.length(400))
        root_child0.insert(root_child0_child0, at: 0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.flexDirection(FlexDirection.row)
        root_child0_child0_child0.alignContent(AlignContent.stretch)
        root_child0_child0_child0.width(StyleValue.length(300))
        root_child0_child0_child0.height(StyleValue.length(100))
        root_child0_child0.insert(root_child0_child0_child0, at: 0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 1000)
        XCTAssertEqual(root.box.height, 1584)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 1000)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 500)
        XCTAssertEqual(root_child0_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0_child0.box.left, 100)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 300)
        XCTAssertEqual(root_child0_child0_child0.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 1000)
        XCTAssertEqual(root.box.height, 1584)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 1000)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 500)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 500)
        XCTAssertEqual(root_child0_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0_child0.box.left, 100)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 300)
        XCTAssertEqual(root_child0_child0_child0.box.height, 100)
    }

    // Generated from test: justify_content_min_width_with_padding_child_width_lower_than_parent
    func testJustifyContentMinWidthWithPaddingChildWidthLowerThanParent() {
        let root = FlexLayout()
        root.alignContent(AlignContent.stretch)
        root.width(StyleValue.length(1080))
        root.height(StyleValue.length(1584))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.alignContent(AlignContent.stretch)
        root.insert(root_child0, at: 0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexDirection(FlexDirection.row)
        root_child0_child0.justifyContent(JustifyContent.center)
        root_child0_child0.alignContent(AlignContent.stretch)
        root_child0_child0.padding(left: StyleValue.length(100))
        root_child0_child0.padding(right: StyleValue.length(100))
        root_child0_child0.minWidth(StyleValue.length(400))
        root_child0.insert(root_child0_child0, at: 0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.flexDirection(FlexDirection.row)
        root_child0_child0_child0.alignContent(AlignContent.stretch)
        root_child0_child0_child0.width(StyleValue.length(199))
        root_child0_child0_child0.height(StyleValue.length(100))
        root_child0_child0.insert(root_child0_child0_child0, at: 0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 1080)
        XCTAssertEqual(root.box.height, 1584)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 1080)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 400)
        XCTAssertEqual(root_child0_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0_child0.box.left, 101)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 199)
        XCTAssertEqual(root_child0_child0_child0.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 1080)
        XCTAssertEqual(root.box.height, 1584)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 1080)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 680)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 400)
        XCTAssertEqual(root_child0_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0_child0.box.left, 101)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 199)
        XCTAssertEqual(root_child0_child0_child0.box.height, 100)
    }
}
