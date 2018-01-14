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

// Generated from YGInfiniteHeightTest.cpp
class InfiniteHeightTests: FlexTestCase {

    // This test isn't correct from the Flexbox standard standpoint,
    // because percentages are calculated with parent constraints.
    // However, we need to make sure we fail gracefully in this case, not returning NaN
    // Generated from test: percent_absolute_position_infinite_height
    func testPercentAbsolutePositionInfiniteHeight() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(300))

//        let root_child0 = FlexLayout()
//        root_child0.width(StyleValue.length(300))
//        root_child0.height(StyleValue.length(300))
//        root.append(root_child0)
//
//        let root_child1 = FlexLayout()
//        root_child1.positionType(PositionType.absolute)
//        root_child1.position(left: StyleValue.percentage(20))
//        root_child1.position(top: StyleValue.percentage(20))
//        root_child1.width(StyleValue.percentage(20))
//        root_child1.height(StyleValue.percentage(20))
//        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 300)
//        XCTAssertEqual(root.box.height, 300)

//        XCTAssertEqual(root_child0.box.left, 0)
//        XCTAssertEqual(root_child0.box.top, 0)
//        XCTAssertEqual(root_child0.box.width, 300)
//        XCTAssertEqual(root_child0.box.height, 300)
//
//        XCTAssertEqual(root_child1.box.left, 60)
//        XCTAssertEqual(root_child1.box.top, 0)
//        XCTAssertEqual(root_child1.box.width, 60)
//        XCTAssertEqual(root_child1.box.height, 0)
    }
}
