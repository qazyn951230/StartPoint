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

// Generated from YGComputedPaddingTest.cpp
class ComputedPaddingTests: FlexTestCase {

    // Generated from test: computed_layout_padding
    func testComputedLayoutPadding() {
        let root = FlexLayout()
        root.style.width = 100
        root.style.height = 100
        root.style.padding.leading = StyleValue.percentage(10)

        root.calculate(width: 100, height: 100, direction: Direction.ltr)

        XCTAssertEqual(root.box.padding.left, 10)
        XCTAssertEqual(root.box.padding.right, 0)

        root.calculate(width: 100, height: 100, direction: Direction.rtl)

        XCTAssertEqual(root.box.padding.left, 0)
        XCTAssertEqual(root.box.padding.right, 10)
    }
}
