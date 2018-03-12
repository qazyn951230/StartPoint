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

// Generated from YGDisplayTest.cpp
class DisplayTests: FlexTestCase {

    // Generated from test: display_none
    func testDisplayNone() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.display(Display.none)
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 0)
    }

    // Generated from test: display_none_fixed_size
    func testDisplayNoneFixedSize() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(20))
        root_child1.height(StyleValue.length(20))
        root_child1.display(Display.none)
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 0)
    }

    // Generated from test: display_none_with_margin
    func testDisplayNoneWithMargin() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.margin(left: StyleValue.length(10))
        root_child0.margin(top: StyleValue.length(10))
        root_child0.margin(right: StyleValue.length(10))
        root_child0.margin(bottom: StyleValue.length(10))
        root_child0.width(StyleValue.length(20))
        root_child0.height(StyleValue.length(20))
        root_child0.display(Display.none)
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
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 100)
    }

    // Generated from test: display_none_with_child
    func testDisplayNoneWithChild() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexShrink(1)
        root_child0.flexBasis(FlexBasis.percentage(0))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.flexShrink(1)
        root_child1.flexBasis(FlexBasis.percentage(0))
        root_child1.display(Display.none)
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.flexGrow(1)
        root_child1_child0.flexShrink(1)
        root_child1_child0.flexBasis(FlexBasis.percentage(0))
        root_child1_child0.width(StyleValue.length(20))
        root_child1_child0.minWidth(StyleValue.length(0))
        root_child1_child0.minHeight(StyleValue.length(0))
        root_child1.append(root_child1_child0)

        let root_child2 = FlexLayout()
        root_child2.flexGrow(1)
        root_child2.flexShrink(1)
        root_child2.flexBasis(FlexBasis.percentage(0))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 0)
        XCTAssertEqual(root_child1_child0.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 100)

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
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 0)
        XCTAssertEqual(root_child1_child0.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 100)
    }

    // Generated from test: display_none_with_position
    func testDisplayNoneWithPosition() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.position(top: StyleValue.length(10))
        root_child1.display(Display.none)
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 0)
    }
}
