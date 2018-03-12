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

// Generated from YGRoundingFunctionTest.cpp
class RoundingFunctionTests: FlexTestCase {

    // Generated from test: rounding_value
    func testRoundingValue() {
        // Test that whole numbers are rounded to whole despite ceil/floor flags
        XCTAssertEqual(FlexBox.round(6.000001, scale: 2.0, ceil: false, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(6.000001, scale: 2.0, ceil: true, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(6.000001, scale: 2.0, ceil: false, floor: true), 6.0)
        XCTAssertEqual(FlexBox.round(5.999999, scale: 2.0, ceil: false, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(5.999999, scale: 2.0, ceil: true, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(5.999999, scale: 2.0, ceil: false, floor: true), 6.0)

        // Test that numbers with fraction are rounded correctly accounting for ceil/floor flags
        XCTAssertEqual(FlexBox.round(6.01, scale: 2.0, ceil: false, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(6.01, scale: 2.0, ceil: true, floor: false), 6.5)
        XCTAssertEqual(FlexBox.round(6.01, scale: 2.0, ceil: false, floor: true), 6.0)
        XCTAssertEqual(FlexBox.round(5.99, scale: 2.0, ceil: false, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(5.99, scale: 2.0, ceil: true, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(5.99, scale: 2.0, ceil: false, floor: true), 5.5)
    }
}
