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

// Generated from YGMinMaxDimensionTest.cpp
class MinMaxDimensionTests: FlexTestCase {

    // Generated from test: max_width
    func testMaxWidth() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.maxWidth(StyleValue.length(50))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: max_height
    func testMaxHeight() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root_child0.maxHeight(StyleValue.length(50))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 90)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: min_height
    func testMinHeight() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.minHeight(StyleValue.length(60))
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
        XCTAssertEqual(root_child0.box.height, 80)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 80)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 80)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 80)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 20)
    }

    // Generated from test: min_width
    func testMinWidth() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.minWidth(StyleValue.length(60))
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
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 80)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 20)
        XCTAssertEqual(root_child1.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 20)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 20)
        XCTAssertEqual(root_child1.box.height, 100)
    }

    // Generated from test: justify_content_min_max
    func testJustifyContentMinMax() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.width(StyleValue.length(100))
        root.minHeight(StyleValue.length(100))
        root.maxHeight(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(60))
        root_child0.height(StyleValue.length(60))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 20)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 60)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 40)
        XCTAssertEqual(root_child0.box.top, 20)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 60)
    }

    // Generated from test: align_items_min_max
    func testAlignItemsMinMax() {
        let root = FlexLayout()
        root.alignItems(AlignItems.center)
        root.minWidth(StyleValue.length(100))
        root.maxWidth(StyleValue.length(200))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(60))
        root_child0.height(StyleValue.length(60))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 20)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 60)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 20)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 60)
    }

    // Generated from test: justify_content_overflow_min_max
    func testJustifyContentOverflowMinMax() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.minHeight(StyleValue.length(100))
        root.maxHeight(StyleValue.length(110))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
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
        XCTAssertEqual(root.box.height, 110)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, -20)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 30)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 80)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 110)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, -20)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 30)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 80)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)
    }

    // Generated from test: flex_grow_to_min
    func testFlexGrowToMin() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.minHeight(StyleValue.length(100))
        root.maxHeight(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexShrink(1)
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(50))
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

    // Generated from test: flex_grow_in_at_most_container
    func testFlexGrowInAtMostContainer() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexBasis(FlexBasis.length(0))
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0.box.height, 0)
    }

    // Generated from test: flex_grow_child
    func testFlexGrowChild() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.length(0))
        root_child0.height(StyleValue.length(100))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: flex_grow_within_constrained_min_max_column
    func testFlexGrowWithinConstrainedMinMaxColumn() {
        let root = FlexLayout()
        root.minHeight(StyleValue.length(100))
        root.maxHeight(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(50))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 50)
    }

    // Generated from test: flex_grow_within_max_width
    func testFlexGrowWithinMaxWidth() {
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.maxWidth(StyleValue.length(100))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.height(StyleValue.length(20))
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 20)
    }

    // Generated from test: flex_grow_within_constrained_max_width
    func testFlexGrowWithinConstrainedMaxWidth() {
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.maxWidth(StyleValue.length(300))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.height(StyleValue.length(20))
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 200)
        XCTAssertEqual(root_child0_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 200)
        XCTAssertEqual(root_child0_child0.box.height, 20)
    }

    // Generated from test: flex_root_ignored
    func testFlexRootIgnored() {
        let root = FlexLayout()
        root.flexGrow(1)
        root.width(StyleValue.length(100))
        root.minHeight(StyleValue.length(100))
        root.maxHeight(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.length(200))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(100))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 300)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 200)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 200)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 300)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 200)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 200)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 100)
    }

    // Generated from test: flex_grow_root_minimized
    func testFlexGrowRootMinimized() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.minHeight(StyleValue.length(100))
        root.maxHeight(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.minHeight(StyleValue.length(100))
        root_child0.maxHeight(StyleValue.length(500))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexBasis(FlexBasis.length(200))
        root_child0.append(root_child0_child0)

        let root_child0_child1 = FlexLayout()
        root_child0_child1.height(StyleValue.length(100))
        root_child0.append(root_child0_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 300)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 300)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 200)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 200)
        XCTAssertEqual(root_child0_child1.box.width, 100)
        XCTAssertEqual(root_child0_child1.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 300)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 300)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 200)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 200)
        XCTAssertEqual(root_child0_child1.box.width, 100)
        XCTAssertEqual(root_child0_child1.box.height, 100)
    }

    // Generated from test: flex_grow_height_maximized
    func testFlexGrowHeightMaximized() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.minHeight(StyleValue.length(100))
        root_child0.maxHeight(StyleValue.length(500))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexBasis(FlexBasis.length(200))
        root_child0.append(root_child0_child0)

        let root_child0_child1 = FlexLayout()
        root_child0_child1.height(StyleValue.length(100))
        root_child0.append(root_child0_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 500)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 400)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 400)
        XCTAssertEqual(root_child0_child1.box.width, 100)
        XCTAssertEqual(root_child0_child1.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 500)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 400)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 400)
        XCTAssertEqual(root_child0_child1.box.width, 100)
        XCTAssertEqual(root_child0_child1.box.height, 100)
    }

    // Generated from test: flex_grow_within_constrained_min_row
    func testFlexGrowWithinConstrainedMinRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.minWidth(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
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

    // Generated from test: flex_grow_within_constrained_min_column
    func testFlexGrowWithinConstrainedMinColumn() {
        let root = FlexLayout()
        root.minHeight(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(50))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 0)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 50)
    }

    // Generated from test: flex_grow_within_constrained_max_row
    func testFlexGrowWithinConstrainedMaxRow() {
        let root = FlexLayout()
        root.width(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.maxWidth(StyleValue.length(100))
        root_child0.height(StyleValue.length(100))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexShrink(1)
        root_child0_child0.flexBasis(FlexBasis.length(100))
        root_child0.append(root_child0_child0)

        let root_child0_child1 = FlexLayout()
        root_child0_child1.width(StyleValue.length(50))
        root_child0.append(root_child0_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 100)

        XCTAssertEqual(root_child0_child1.box.left, 50)
        XCTAssertEqual(root_child0_child1.box.top, 0)
        XCTAssertEqual(root_child0_child1.box.width, 50)
        XCTAssertEqual(root_child0_child1.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 50)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 100)

        XCTAssertEqual(root_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child1.box.top, 0)
        XCTAssertEqual(root_child0_child1.box.width, 50)
        XCTAssertEqual(root_child0_child1.box.height, 100)
    }

    // Generated from test: flex_grow_within_constrained_max_column
    func testFlexGrowWithinConstrainedMaxColumn() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.maxHeight(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexShrink(1)
        root_child0.flexBasis(FlexBasis.length(100))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(50))
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

    // Generated from test: child_min_max_width_flexing
    func testChildMinMaxWidthFlexing() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(120))
        root.height(StyleValue.length(50))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.length(0))
        root_child0.minWidth(StyleValue.length(60))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.flexBasis(FlexBasis.percentage(50))
        root_child1.maxWidth(StyleValue.length(20))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 120)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 100)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 20)
        XCTAssertEqual(root_child1.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 120)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 20)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 20)
        XCTAssertEqual(root_child1.box.height, 50)
    }

    // Generated from test: min_width_overrides_width
    func testMinWidthOverridesWidth() {
        let root = FlexLayout()
        root.width(StyleValue.length(50))
        root.minWidth(StyleValue.length(100))
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 0)
    }

    // Generated from test: max_width_overrides_width
    func testMaxWidthOverridesWidth() {
        let root = FlexLayout()
        root.width(StyleValue.length(200))
        root.maxWidth(StyleValue.length(100))
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 0)
    }

    // Generated from test: min_height_overrides_height
    func testMinHeightOverridesHeight() {
        let root = FlexLayout()
        root.height(StyleValue.length(50))
        root.minHeight(StyleValue.length(100))
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 100)
    }

    // Generated from test: max_height_overrides_height
    func testMaxHeightOverridesHeight() {
        let root = FlexLayout()
        root.height(StyleValue.length(200))
        root.maxHeight(StyleValue.length(100))
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 0)
        XCTAssertEqual(root.box.height, 100)
    }

    // Generated from test: min_max_percent_no_width_height
    func testMinMaxPercentNoWidthHeight() {
        let root = FlexLayout()
        root.alignItems(AlignItems.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.minWidth(StyleValue.percentage(10))
        root_child0.maxWidth(StyleValue.percentage(10))
        root_child0.minHeight(StyleValue.percentage(10))
        root_child0.maxHeight(StyleValue.percentage(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 90)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }
}
