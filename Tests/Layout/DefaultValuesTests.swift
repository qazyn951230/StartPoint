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

// Generated from YGDefaultValuesTest.cpp
class DefaultValuesTests: FlexTestCase {

    // Generated from test: assert_default_values
    func testAssertDefaultValues() {
        let root = FlexLayout()

        XCTAssertEqual(root.children.count, 0)
        XCTAssertNil(root.child(at: 1))

        XCTAssertEqual(root.style.direction, Direction.inherit)
        XCTAssertEqual(root.style.flexDirection, FlexDirection.column)
        XCTAssertEqual(root.style.justifyContent, JustifyContent.flexStart)
        XCTAssertEqual(root.style.alignContent, AlignContent.flexStart)
        XCTAssertEqual(root.style.alignItems, AlignItems.stretch)
        XCTAssertEqual(root.style.alignSelf, AlignSelf.auto)
        XCTAssertEqual(root.style.positionType, PositionType.relative)
        XCTAssertEqual(root.style.flexWrap, FlexWrap.nowrap)
        XCTAssertEqual(root.style.overflow, Overflow.visible)
        XCTAssertEqual(root.style.flexGrow, 0.0)
        XCTAssertEqual(root.style.flexShrink, 0.0)
        XCTAssertEqual(root.style.flexBasis, FlexBasis.auto)

        XCTAssertNil(root.style.position.left)
        XCTAssertNil(root.style.position.top)
        XCTAssertNil(root.style.position.right)
        XCTAssertNil(root.style.position.bottom)
        XCTAssertNil(root.style.position.leading)
        XCTAssertNil(root.style.position.trailing)

        XCTAssertEqual(root.style.margin.left, StyleValue.length(0))
        XCTAssertEqual(root.style.margin.top, StyleValue.length(0))
        XCTAssertEqual(root.style.margin.right, StyleValue.length(0))
        XCTAssertEqual(root.style.margin.bottom, StyleValue.length(0))
        XCTAssertNil(root.style.margin.leading)
        XCTAssertNil(root.style.margin.trailing)

        XCTAssertEqual(root.style.padding.left, StyleValue.length(0))
        XCTAssertEqual(root.style.padding.top, StyleValue.length(0))
        XCTAssertEqual(root.style.padding.right, StyleValue.length(0))
        XCTAssertEqual(root.style.padding.bottom, StyleValue.length(0))
        XCTAssertNil(root.style.padding.leading)
        XCTAssertNil(root.style.padding.trailing)

        XCTAssertEqual(root.style.border.left, StyleValue.length(0))
        XCTAssertEqual(root.style.border.top, StyleValue.length(0))
        XCTAssertEqual(root.style.border.right, StyleValue.length(0))
        XCTAssertEqual(root.style.border.bottom, StyleValue.length(0))
        XCTAssertNil(root.style.border.leading)
        XCTAssertNil(root.style.border.trailing)

        XCTAssertEqual(root.style.width, StyleValue.auto)
        XCTAssertEqual(root.style.height, StyleValue.auto)
        XCTAssertEqual(root.style.minWidth, StyleValue.length(0))
        XCTAssertEqual(root.style.minHeight, StyleValue.length(0))
        XCTAssertNil(root.style.maxWidth)
        XCTAssertNil(root.style.maxHeight)

        XCTAssertEqual(root.box.left, 0.0)
        XCTAssertEqual(root.box.top, 0.0)
        XCTAssertEqual(root.box.right, 0.0)
        XCTAssertEqual(root.box.bottom, 0.0)

        XCTAssertEqual(root.box.margin.top, 0.0)
        XCTAssertEqual(root.box.margin.left, 0.0)
        XCTAssertEqual(root.box.margin.bottom, 0.0)
        XCTAssertEqual(root.box.margin.right, 0.0)

        XCTAssertEqual(root.box.padding.top, 0.0)
        XCTAssertEqual(root.box.padding.left, 0.0)
        XCTAssertEqual(root.box.padding.bottom, 0.0)
        XCTAssertEqual(root.box.padding.right, 0.0)

        XCTAssertEqual(root.box.border.top, 0.0)
        XCTAssertEqual(root.box.border.left, 0.0)
        XCTAssertEqual(root.box.border.bottom, 0.0)
        XCTAssertEqual(root.box.border.right, 0.0)

        XCTAssertTrue(root.box.width.isNaN)
        XCTAssertTrue(root.box.height.isNaN)
        XCTAssertEqual(root.box.direction, Direction.inherit)
    }

    // Generated from test: assert_legacy_stretch_behaviour
//    func testAssertLegacyStretchBehaviour() {
//        YGConfigSetUseLegacyStretchBehaviour(config, true)
//        let root = yogaLayout()
//        root.style.width = 500
//        root.style.height = 500
//
//        let root_child0 = yogaLayout()
//        root_child0.style.alignItems = .flexStart
//        root.append(root_child0)
//
//        let root_child0_child0 = yogaLayout()
//        root_child0_child0.style.flexGrow = 1
//        root_child0_child0.style.flexShrink = 1
//        root_child0.append(root_child0_child0)
//
//        let root_child0_child0_child0 = yogaLayout()
//        root_child0_child0_child0.style.flexGrow = 1
//        root_child0_child0_child0.style.flexShrink = 1
//        root_child0_child0.append(root_child0_child0_child0)
//        root.calculate(direction: Direction.ltr)
//
//        XCTAssertEqual(root.box.left, 0.0)
//        XCTAssertEqual(root.box.top, 0.0)
//        XCTAssertEqual(root.box.width, 500.0)
//        XCTAssertEqual(root.box.height, 500.0)
//
//        XCTAssertEqual(root_child0.box.left, 0.0)
//        XCTAssertEqual(root_child0.box.top, 0.0)
//        XCTAssertEqual(root_child0.box.width, 500.0)
//        XCTAssertEqual(root_child0.box.height, 500.0)
//
//        XCTAssertEqual(root_child0_child0.box.left, 0.0)
//        XCTAssertEqual(root_child0_child0.box.top, 0.0)
//        XCTAssertEqual(root_child0_child0.box.width, 0.0)
//        XCTAssertEqual(root_child0_child0.box.height, 500.0)
//
//        XCTAssertEqual(root_child0_child0_child0.box.left, 0.0)
//        XCTAssertEqual(root_child0_child0_child0.box.top, 0.0)
//        XCTAssertEqual(root_child0_child0_child0.box.width, 0.0)
//        XCTAssertEqual(root_child0_child0_child0.box.height, 500.0)
//    }
}
