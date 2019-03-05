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
    func measureText(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
        return Size(width: 10, height: 10)
    }

    // Generated from test: rounding_value
    func testRoundingValue() {
        // Test that whole numbers are rounded to whole despite ceil/floor flags
        XCTAssertEqual(FlexBox.round(6.000001, scale: 2.0, ceil: false, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(6.000001, scale: 2.0, ceil: true, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(6.000001, scale: 2.0, ceil: false, floor: true), 6.0)
        XCTAssertEqual(FlexBox.round(5.999999, scale: 2.0, ceil: false, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(5.999999, scale: 2.0, ceil: true, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(5.999999, scale: 2.0, ceil: false, floor: true), 6.0)
        // Same tests for negative numbers
        XCTAssertEqual(FlexBox.round(-6.000001, scale: 2.0, ceil: false, floor: false), -6.0)
        XCTAssertEqual(FlexBox.round(-6.000001, scale: 2.0, ceil: true, floor: false), -6.0)
        XCTAssertEqual(FlexBox.round(-6.000001, scale: 2.0, ceil: false, floor: true), -6.0)
        XCTAssertEqual(FlexBox.round(-5.999999, scale: 2.0, ceil: false, floor: false), -6.0)
        XCTAssertEqual(FlexBox.round(-5.999999, scale: 2.0, ceil: true, floor: false), -6.0)
        XCTAssertEqual(FlexBox.round(-5.999999, scale: 2.0, ceil: false, floor: true), -6.0)

        // Test that numbers with fraction are rounded correctly accounting for ceil/floor flags
        XCTAssertEqual(FlexBox.round(6.01, scale: 2.0, ceil: false, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(6.01, scale: 2.0, ceil: true, floor: false), 6.5)
        XCTAssertEqual(FlexBox.round(6.01, scale: 2.0, ceil: false, floor: true), 6.0)
        XCTAssertEqual(FlexBox.round(5.99, scale: 2.0, ceil: false, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(5.99, scale: 2.0, ceil: true, floor: false), 6.0)
        XCTAssertEqual(FlexBox.round(5.99, scale: 2.0, ceil: false, floor: true), 5.5)
        // Same tests for negative numbers
        XCTAssertEqual(FlexBox.round(-6.01, scale: 2.0, ceil: false, floor: false), -6.0)
        XCTAssertEqual(FlexBox.round(-6.01, scale: 2.0, ceil: true, floor: false), -6.0)
        XCTAssertEqual(FlexBox.round(-6.01, scale: 2.0, ceil: false, floor: true), -6.5)
        XCTAssertEqual(FlexBox.round(-5.99, scale: 2.0, ceil: false, floor: false), -6.0)
        XCTAssertEqual(FlexBox.round(-5.99, scale: 2.0, ceil: true, floor: false), -5.5)
        XCTAssertEqual(FlexBox.round(-5.99, scale: 2.0, ceil: false, floor: true), -6.0)
    }
    
    // Generated from test: consistent_rounding_during_repeated_layouts
    func testConsistentRoundingDuringRepeatedLayouts() {
        FlexStyle.scale = 2
        
        let root = FlexLayout()
        root.margin(top: StyleValue.length(-1.49))
        root.width(StyleValue.length(500))
        root.height(StyleValue.length(500))
        
        let node0 = FlexLayout()
        root.insert(node0, at: 0)
        
        let node1 = FlexLayout()
        node1.measureSelf = measureText
        root.insert(node1, at: 1)
        
        for i in 0..<5 {
            // Dirty the tree so YGRoundToPixelGrid runs again
            root.margin(left: StyleValue.length(Double(i)))

            root.calculate(direction: Direction.ltr)
            XCTAssertEqual(node1.box.height, 10)
        }
    }
}
