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

class OverlayTests: FlexTestCase {
    func testNegativeTopMargin() {
        let root = FlexLayout()

        let root_child0 = FlexLayout()
        root_child0.width(.length(100))
        root_child0.height(.length(100))
        root_child0.margin(top: .length(-50))
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 50)
        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, -50)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    func testNegativeLeftMargin() {
        let root = FlexLayout()

        let root_child0 = FlexLayout()
        root_child0.width(.length(100))
        root_child0.height(.length(100))
        root_child0.margin(left: .length(-50))
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 100)
        XCTAssertEqual(root_child0.box.left, -50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 100)
        XCTAssertEqual(root_child0.box.left, -50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    func testNegativeLeadingMargin() {
        let root = FlexLayout()

        let root_child0 = FlexLayout()
        root_child0.width(.length(100))
        root_child0.height(.length(100))
        root_child0.margin(leading: .length(-50))
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 100)
        XCTAssertEqual(root_child0.box.left, -50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 100)
        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    func testRightAutoMargin() {
        let root = FlexLayout()
        root.flexDirection(.row)

        let root_child0 = FlexLayout()
        root_child0.width(.length(44))
        root_child0.height(.length(44))
        root_child0.margin(right: .auto)
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(.length(44))
        root_child1.height(.length(44))
        root.append(root_child1)

        root.calculate(width: 100, height: 100, direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)
        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 44)
        XCTAssertEqual(root_child0.box.height, 44)
        XCTAssertEqual(root_child1.box.left, 56)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 44)
        XCTAssertEqual(root_child1.box.height, 44)

        root.calculate(width: 100, height: 100, direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)
        XCTAssertEqual(root_child0.box.left, 44)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 44)
        XCTAssertEqual(root_child0.box.height, 44)
        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 44)
        XCTAssertEqual(root_child1.box.height, 44)
    }
}
