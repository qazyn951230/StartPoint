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

// Generated from YGStyleTest.cpp
class StyleTests: FlexTestCase {

    // Generated from test: copy_style_same
    func testCopyStyleSame() {
        let node0 = FlexLayout()
        let node1 = FlexLayout()
        XCTAssertFalse(node0.dirty)

        node0.copyStyle(from: node1)
        XCTAssertFalse(node0.dirty)
    }

    // Generated from test: copy_style_modified
    func testCopyStyleModified() {
        let node0 = FlexLayout()
        XCTAssertFalse(node0.dirty)
        XCTAssertEqual(node0.style.flexDirection, FlexDirection.column)
        XCTAssertNil(node0.style.maxHeight)

        let node1 = FlexLayout()
        node1.flexDirection(FlexDirection.row)
        node1.maxHeight(StyleValue.length(10))

        node0.copyStyle(from: node1)
        XCTAssertTrue(node0.dirty)
        XCTAssertEqual(node0.style.flexDirection, FlexDirection.row)
        XCTAssertEqual(node0.style.maxHeight, StyleValue.length(10))
    }

    // Generated from test: copy_style_modified_same
    func testCopyStyleModifiedSame() {
        let node0 = FlexLayout()
        node0.flexDirection(FlexDirection.row)
        node0.maxHeight(StyleValue.length(10))
        node0.calculate(direction: Direction.ltr)
        XCTAssertFalse(node0.dirty)

        let node1 = FlexLayout()
        node1.flexDirection(FlexDirection.row)
        node1.maxHeight(StyleValue.length(10))

        node0.copyStyle(from: node1)
        XCTAssertFalse(node0.dirty)
    }

    // Generated from test: initialise_flexShrink_flexGrow
    func testInitialiseFlexShrinkFlexGrow() {
        let node0 = FlexLayout()
        node0.flexShrink(1)
        XCTAssertEqual(node0.style.flexShrink, 1)

        node0.flexShrink(Double.nan)
        node0.flexGrow(3)
        // Default value is Zero, if flex shrink is not defined
        XCTAssertEqual(node0.style.flexShrink, 0)
        XCTAssertEqual(node0.style.flexGrow, 3)

        node0.flexGrow(Double.nan)
        node0.flexShrink(3)
        // Default value is Zero, if flex grow is not defined
        XCTAssertEqual(node0.style.flexGrow, 0)
        XCTAssertEqual(node0.style.flexShrink, 3)
    }
}
