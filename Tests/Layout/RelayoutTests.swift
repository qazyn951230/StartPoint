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

// Generated from YGRelayoutTest.cpp
class RelayoutTests: FlexTestCase {

    // Generated from test: recalculate_resolvedDimonsion_onchange
    func testRecalculateResolvedDimonsionOnchange() {
        let root = FlexLayout()

        let root_child0 = FlexLayout()
        root_child0.minHeight(StyleValue.length(10))
        root_child0.maxHeight(StyleValue.length(10))
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)
        XCTAssertEqual(root_child0.box.height, 10)

        root_child0.minHeight(StyleValue.length(Double.nan))
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.height, 0)
    }
}