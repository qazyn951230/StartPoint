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

// Generated from YGFlexDirectionTest.cpp
class FlexDirectionTests: FlexTestCase {

    // Generated from test: flex_direction_column_no_height
    func testFlexDirectionColumnNoHeight() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.height(StyleValue.length(10))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 30)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 30)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 10)
    }

    // Generated from test: flex_direction_row_no_width
    func testFlexDirectionRowNoWidth() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(10))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 30)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 10)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 20)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 30)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 20)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 10)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 100)
    }

    // Generated from test: flex_direction_column
    func testFlexDirectionColumn() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.height(StyleValue.length(10))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 10)
    }

    // Generated from test: flex_direction_row
    func testFlexDirectionRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(10))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 10)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 20)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 90)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 80)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 70)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 100)
    }

    // Generated from test: flex_direction_column_reverse
    func testFlexDirectionColumnReverse() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.columnReverse)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.height(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.height(StyleValue.length(10))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 90)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 80)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 70)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 90)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 80)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 70)
        XCTAssertEqual(root_child2.box.width, 100)
        XCTAssertEqual(root_child2.box.height, 10)
    }

    // Generated from test: flex_direction_row_reverse
    func testFlexDirectionRowReverse() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.rowReverse)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(10))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 90)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 80)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 70)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 10)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 20)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 100)
    }
}
