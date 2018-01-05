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

// Generated from YGBaselineFuncTest.cpp
class BaselineFuncTests: FlexTestCase {

    // Generated from test: align_baseline_customer_func
    func testAlignBaselineCustomerFunc() {
        let root = FlexLayout()
        root.style.flexDirection = FlexDirection.row
        root.style.alignItems = .baseline
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 50
        root_child0.style.height = 50
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.style.width = 50
        root_child1.style.height = 20
        root.append(root_child1)

        let root_child1_child0 = BaselineLayout()
        root_child1_child0.style.width = 50
        root_child1_child0.style.height = 20
        root_child1_child0.base = 10
        root_child1.append(root_child1_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 20)
    }
}
