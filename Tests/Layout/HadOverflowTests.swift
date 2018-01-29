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

// Generated from YGHadOverflowTest.cpp
class HadOverflowTests: FlexTestCase {
    var root = FlexLayout()

    override func setUp() {
        super.setUp()
        root = FlexLayout()
        root.width(float: 200)
        root.height(float: 100)
        root.flexDirection(.column)
        root.flexWrap(.nowrap)
    }

    // Generated from test: children_overflow_no_wrap_and_no_flex_children
    func testChildrenOverflowNoWrapAndNoFlexChildren() {
        let child0 = FlexLayout()
        child0.width(StyleValue.length(80))
        child0.height(StyleValue.length(40))
        child0.margin(top: StyleValue.length(10))
        child0.margin(bottom: StyleValue.length(15))
        root.insert(child0, at: 0)
        let child1 = FlexLayout()
        child1.width(StyleValue.length(80))
        child1.height(StyleValue.length(40))
        child1.margin(bottom: StyleValue.length(5))
        root.insert(child1, at: 1)

        root.calculate(width: 200, height: 100, direction: Direction.ltr)

        XCTAssertTrue(root.box.hasOverflow)
    }

    // Generated from test: spacing_overflow_no_wrap_and_no_flex_children
    func testSpacingOverflowNoWrapAndNoFlexChildren() {
        let child0 = FlexLayout()
        child0.width(StyleValue.length(80))
        child0.height(StyleValue.length(40))
        child0.margin(top: StyleValue.length(10))
        child0.margin(bottom: StyleValue.length(10))
        root.insert(child0, at: 0)
        let child1 = FlexLayout()
        child1.width(StyleValue.length(80))
        child1.height(StyleValue.length(40))
        child1.margin(bottom: StyleValue.length(5))
        root.insert(child1, at: 1)

        root.calculate(width: 200, height: 100, direction: Direction.ltr)

        XCTAssertTrue(root.box.hasOverflow)
    }

    // Generated from test: no_overflow_no_wrap_and_flex_children
    func testNoOverflowNoWrapAndFlexChildren() {
        let child0 = FlexLayout()
        child0.width(StyleValue.length(80))
        child0.height(StyleValue.length(40))
        child0.margin(top: StyleValue.length(10))
        child0.margin(bottom: StyleValue.length(10))
        root.insert(child0, at: 0)
        let child1 = FlexLayout()
        child1.width(StyleValue.length(80))
        child1.height(StyleValue.length(40))
        child1.margin(bottom: StyleValue.length(5))
        child1.flexShrink(1)
        root.insert(child1, at: 1)

        root.calculate(width: 200, height: 100, direction: Direction.ltr)

        XCTAssertFalse(root.box.hasOverflow)
    }

    // Generated from test: hadOverflow_gets_reset_if_not_logger_valid
    func testHadOverflowGetsResetIfNotLoggerValid() {
        let child0 = FlexLayout()
        child0.width(StyleValue.length(80))
        child0.height(StyleValue.length(40))
        child0.margin(top: StyleValue.length(10))
        child0.margin(bottom: StyleValue.length(10))
        root.insert(child0, at: 0)
        let child1 = FlexLayout()
        child1.width(StyleValue.length(80))
        child1.height(StyleValue.length(40))
        child1.margin(bottom: StyleValue.length(5))
        root.insert(child1, at: 1)

        root.calculate(width: 200, height: 100, direction: Direction.ltr)

        XCTAssertTrue(root.box.hasOverflow)

        child1.flexShrink(1)

        root.calculate(width: 200, height: 100, direction: Direction.ltr)

        XCTAssertFalse(root.box.hasOverflow)
    }

    // Generated from test: spacing_overflow_in_nested_nodes
    func testSpacingOverflowInNestedNodes() {
        let child0 = FlexLayout()
        child0.width(StyleValue.length(80))
        child0.height(StyleValue.length(40))
        child0.margin(top: StyleValue.length(10))
        child0.margin(bottom: StyleValue.length(10))
        root.insert(child0, at: 0)
        let child1 = FlexLayout()
        child1.width(StyleValue.length(80))
        child1.height(StyleValue.length(40))
        root.insert(child1, at: 1)
        let child1_1 = FlexLayout()
        child1_1.width(StyleValue.length(80))
        child1_1.height(StyleValue.length(40))
        child1_1.margin(bottom: StyleValue.length(5))
        child1.insert(child1_1, at: 0)

        root.calculate(width: 200, height: 100, direction: Direction.ltr)

        XCTAssertTrue(root.box.hasOverflow)
    }
}
