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

// Generated from YGZeroOutLayoutRecursivlyTest.cpp
class ZeroOutLayoutRecursivlyTests: FlexTestCase {

    // Generated from test: zero_out_layout
    func testZeroOutLayout() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(200))
        root.height(StyleValue.length(200))

        let child = FlexLayout()
        root.insert(child, at: 0)
        child.width(StyleValue.length(100))
        child.height(StyleValue.length(100))
        child.margin(top: StyleValue.length(10))
        child.padding(top: StyleValue.length(10))

        root.calculate(width: 100, height: 100, direction: Direction.ltr)

        XCTAssertEqual(child.box.margin.top, 10)
        XCTAssertEqual(child.box.padding.top, 10)

        child.display(Display.none)

        root.calculate(width: 100, height: 100, direction: Direction.ltr)

        XCTAssertEqual(child.box.margin.top, 0)
        XCTAssertEqual(child.box.padding.top, 0)
    }
}
