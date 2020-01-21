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

// Generated from YGComputedMarginTest.cpp
class ComputedMarginTests: FlexTestCase {

    // Generated from test: computed_layout_margin
    func testComputedLayoutMargin() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))
        root.margin(leading: StyleValue.percentage(10))

        root.calculate(width: 100, height: 100, direction: Direction.ltr)

        XCTAssertEqual(root.box.margin.left, 10)
        XCTAssertEqual(root.box.margin.right, 0)

        root.calculate(width: 100, height: 100, direction: Direction.rtl)

        XCTAssertEqual(root.box.margin.left, 0)
        XCTAssertEqual(root.box.margin.right, 10)
    }

    // Generated from test: margin_side_overrides_horizontal_and_vertical
    func testMarginSideOverridesHorizontalAndVertical() {
        let edges: [Edge] = [Edge.top, Edge.bottom, Edge.leading, Edge.trailing, Edge.left, Edge.right]
        for value in 0..<2 {
            for edge in edges {
                let other: Edge = (edge == Edge.top || edge == Edge.bottom) ? Edge.vertical : Edge.horizontal

                let root = FlexLayout()
                root.width(StyleValue.length(100))
                root.height(StyleValue.length(100))
                root.margin(edge: other, StyleValue.length(10))
                root.margin(edge: edge, StyleValue.length(Double(value)))

                root.calculate(width: 100, height: 100, direction: Direction.ltr)

                XCTAssertEqual(root.layoutMargin(edge: edge), Double(value), "Current edge: \(edge)")
            }
        }
    }

    // Generated from test: margin_side_overrides_all
    func testMarginSideOverridesAll() {
        let edges: [Edge] = [Edge.top, Edge.bottom, Edge.leading, Edge.trailing, Edge.left, Edge.right]
        for value in 0..<2 {
            for edge in edges {
                let root = FlexLayout()
                root.width(StyleValue.length(100))
                root.height(StyleValue.length(100))
                root.margin(value: StyleValue.length(10))
                root.margin(edge: edge, StyleValue.length(Double(value)))

                root.calculate(width: 100, height: 100, direction: Direction.ltr)

                XCTAssertEqual(root.layoutMargin(edge: edge), Double(value), "Current edge: \(edge)")
            }
        }
    }

    // Generated from test: margin_horizontal_and_vertical_overrides_all
    func testMarginHorizontalAndVerticalOverridesAll() {
        let directions: [Edge] = [Edge.horizontal, Edge.vertical]
        for value in 0..<2 {
            for direction in directions {
                let root = FlexLayout()
                root.width(StyleValue.length(100))
                root.height(StyleValue.length(100))
                root.margin(value: StyleValue.length(10))
                root.margin(edge: direction, StyleValue.length(Double(value)))
                
                root.calculate(width: 100, height: 100, direction: Direction.ltr)
                
                if direction == Edge.vertical {
                    XCTAssertEqual(root.box.margin.top, Double(value))
                    XCTAssertEqual(root.box.margin.bottom, Double(value))
                } else {
                    XCTAssertEqual(root.layoutMargin(edge: Edge.leading), Double(value))
                    XCTAssertEqual(root.layoutMargin(edge: Edge.trailing), Double(value))
                    XCTAssertEqual(root.box.margin.left, Double(value))
                    XCTAssertEqual(root.box.margin.right, Double(value))
                }
            }
        }
    }
}
