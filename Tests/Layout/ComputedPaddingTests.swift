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

// Generated from YGComputedPaddingTest.cpp
class ComputedPaddingTests: FlexTestCase {

    // Generated from test: computed_layout_padding
    func testComputedLayoutPadding() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))
        root.padding(leading: StyleValue.percentage(10))

        root.calculate(width: 100, height: 100, direction: Direction.ltr)

        XCTAssertEqual(root.box.padding.left, 10)
        XCTAssertEqual(root.box.padding.right, 0)

        root.calculate(width: 100, height: 100, direction: Direction.rtl)

        XCTAssertEqual(root.box.padding.left, 0)
        XCTAssertEqual(root.box.padding.right, 10)
    }
    
    // Generated from test: padding_side_overrides_horizontal_and_vertical
    func testPaddingSideOverridesHorizontalAndVertical() {
        let edges: [Edge] = [Edge.top, Edge.bottom, Edge.leading, Edge.trailing, Edge.left, Edge.right]
        for value in 0..<2 {
            for edge in edges {
                let other: Edge = (edge == Edge.top || edge == Edge.bottom) ? Edge.vertical : Edge.horizontal
                
                let root = FlexLayout()
                root.width(StyleValue.length(100))
                root.height(StyleValue.length(100))
                root.padding(edge: other, StyleValue.length(10))
                root.padding(edge: edge, StyleValue.length(Double(value)))
                
                root.calculate(width: 100, height: 100, direction: Direction.ltr)
                
                XCTAssertEqual(root.layoutPadding(edge: edge), Double(value), "Current edge: \(edge)")
            }
        }
    }

    // Generated from test: padding_side_overrides_all
    func testPaddingSideOverridesAll() {
        let edges: [Edge] = [Edge.top, Edge.bottom, Edge.leading, Edge.trailing, Edge.left, Edge.right]
        for value in 0..<2 {
            for edge in edges {
                let root = FlexLayout()
                root.width(StyleValue.length(100))
                root.height(StyleValue.length(100))
                root.padding(value: StyleValue.length(10))
                root.padding(edge: edge, StyleValue.length(Double(value)))
                
                root.calculate(width: 100, height: 100, direction: Direction.ltr)
                
                XCTAssertEqual(root.layoutPadding(edge: edge), Double(value), "Current edge: \(edge)")
            }
        }
    }

    // Generated from test: padding_horizontal_and_vertical_overrides_all
    func testPaddingHorizontalAndVerticalOverridesAll() {
        let directions: [Edge] = [Edge.horizontal, Edge.vertical]
        for value in 0..<2 {
            for direction in directions {
                let root = FlexLayout()
                root.width(StyleValue.length(100))
                root.height(StyleValue.length(100))
                root.padding(value: StyleValue.length(10))
                root.padding(edge: direction, StyleValue.length(Double(value)))
                
                root.calculate(width: 100, height: 100, direction: Direction.ltr)
                
                if direction == Edge.vertical {
                    XCTAssertEqual(root.box.padding.top, Double(value))
                    XCTAssertEqual(root.box.padding.bottom, Double(value))
                } else {
                    XCTAssertEqual(root.layoutPadding(edge: Edge.leading), Double(value))
                    XCTAssertEqual(root.layoutPadding(edge: Edge.trailing), Double(value))
                    XCTAssertEqual(root.box.padding.left, Double(value))
                    XCTAssertEqual(root.box.padding.right, Double(value))
                }
            }
        }
    }
}
