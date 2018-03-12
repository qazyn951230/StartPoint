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

// Generated from YGPaddingTest.cpp
class PaddingTests: FlexTestCase {

    // Generated from test: padding_no_size
    func testPaddingNoSize() {
        let root = FlexLayout()
        root.padding(left: StyleValue.length(10))
        root.padding(top: StyleValue.length(10))
        root.padding(right: StyleValue.length(10))
        root.padding(bottom: StyleValue.length(10))
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 20)
        XCTAssertEqual(root.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 20)
        XCTAssertEqual(root.box.height, 20)
    }

    // Generated from test: padding_container_match_child
    func testPaddingContainerMatchChild() {
        let root = FlexLayout()
        root.padding(left: StyleValue.length(10))
        root.padding(top: StyleValue.length(10))
        root.padding(right: StyleValue.length(10))
        root.padding(bottom: StyleValue.length(10))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 30)
        XCTAssertEqual(root.box.height, 30)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 30)
        XCTAssertEqual(root.box.height, 30)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: padding_flex_child
    func testPaddingFlexChild() {
        let root = FlexLayout()
        root.padding(left: StyleValue.length(10))
        root.padding(top: StyleValue.length(10))
        root.padding(right: StyleValue.length(10))
        root.padding(bottom: StyleValue.length(10))
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.width(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 80)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 80)
    }

    // Generated from test: padding_stretch_child
    func testPaddingStretchChild() {
        let root = FlexLayout()
        root.padding(left: StyleValue.length(10))
        root.padding(top: StyleValue.length(10))
        root.padding(right: StyleValue.length(10))
        root.padding(bottom: StyleValue.length(10))
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: padding_center_child
    func testPaddingCenterChild() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignItems(AlignItems.center)
        root.padding(leading: StyleValue.length(10))
        root.padding(trailing: StyleValue.length(20))
        root.padding(bottom: StyleValue.length(20))
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 40)
        XCTAssertEqual(root_child0.box.top, 35)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 35)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: child_with_padding_align_end
    func testChildWithPaddingAlignEnd() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.flexEnd)
        root.alignItems(AlignItems.flexEnd)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.padding(left: StyleValue.length(20))
        root_child0.padding(top: StyleValue.length(20))
        root_child0.padding(right: StyleValue.length(20))
        root_child0.padding(bottom: StyleValue.length(20))
        root_child0.width(StyleValue.length(100))
        root_child0.height(StyleValue.length(100))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 100)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 100)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }
}
