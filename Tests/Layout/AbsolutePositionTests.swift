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

// Generated from YGAbsolutePositionTest.cpp
class AbsolutePositionTests: FlexTestCase {

    // Generated from test: absolute_layout_width_height_start_top
    func testAbsoluteLayoutWidthHeightStartTop() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(leading: StyleValue.length(10))
        root_child0.position(top: StyleValue.length(10))
        root_child0.width(StyleValue.length(10))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: absolute_layout_width_height_end_bottom
    func testAbsoluteLayoutWidthHeightEndBottom() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(trailing: StyleValue.length(10))
        root_child0.position(bottom: StyleValue.length(10))
        root_child0.width(StyleValue.length(10))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 80)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 80)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: absolute_layout_start_top_end_bottom
    func testAbsoluteLayoutStartTopEndBottom() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(leading: StyleValue.length(10))
        root_child0.position(top: StyleValue.length(10))
        root_child0.position(trailing: StyleValue.length(10))
        root_child0.position(bottom: StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 80)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 80)
    }

    // Generated from test: absolute_layout_width_height_start_top_end_bottom
    func testAbsoluteLayoutWidthHeightStartTopEndBottom() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(leading: StyleValue.length(10))
        root_child0.position(top: StyleValue.length(10))
        root_child0.position(trailing: StyleValue.length(10))
        root_child0.position(bottom: StyleValue.length(10))
        root_child0.width(StyleValue.length(10))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: do_not_clamp_height_of_absolute_node_to_height_of_its_overflow_hidden_parent
    func testDoNotClampHeightOfAbsoluteNodeToHeightOfItsOverflowHiddenParent() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.overflow(Overflow.hidden)
        root.width(StyleValue.length(50))
        root.height(StyleValue.length(50))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(leading: StyleValue.length(0))
        root_child0.position(top: StyleValue.length(0))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.width(StyleValue.length(100))
        root_child0_child0.height(StyleValue.length(100))
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 50)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.left, -50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 100)
    }

    // Generated from test: absolute_layout_within_border
    func testAbsoluteLayoutWithinBorder() {
        let root = FlexLayout()
        root.margin(left: StyleValue.length(10))
        root.margin(top: StyleValue.length(10))
        root.margin(right: StyleValue.length(10))
        root.margin(bottom: StyleValue.length(10))
        root.padding(left: StyleValue.length(10))
        root.padding(top: StyleValue.length(10))
        root.padding(right: StyleValue.length(10))
        root.padding(bottom: StyleValue.length(10))
        root.border(left: 10)
        root.border(top: 10)
        root.border(right: 10)
        root.border(bottom: 10)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(left: StyleValue.length(0))
        root_child0.position(top: StyleValue.length(0))
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.positionType(PositionType.absolute)
        root_child1.position(right: StyleValue.length(0))
        root_child1.position(bottom: StyleValue.length(0))
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(50))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.positionType(PositionType.absolute)
        root_child2.position(left: StyleValue.length(0))
        root_child2.position(top: StyleValue.length(0))
        root_child2.margin(left: StyleValue.length(10))
        root_child2.margin(top: StyleValue.length(10))
        root_child2.margin(right: StyleValue.length(10))
        root_child2.margin(bottom: StyleValue.length(10))
        root_child2.width(StyleValue.length(50))
        root_child2.height(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.positionType(PositionType.absolute)
        root_child3.position(right: StyleValue.length(0))
        root_child3.position(bottom: StyleValue.length(0))
        root_child3.margin(left: StyleValue.length(10))
        root_child3.margin(top: StyleValue.length(10))
        root_child3.margin(right: StyleValue.length(10))
        root_child3.margin(bottom: StyleValue.length(10))
        root_child3.width(StyleValue.length(50))
        root_child3.height(StyleValue.length(50))
        root.append(root_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 10)
        XCTAssertEqual(root.box.top, 10)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 20)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 30)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 10)
        XCTAssertEqual(root.box.top, 10)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 20)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 30)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)
    }

    // Generated from test: absolute_layout_align_items_and_justify_content_center
    func testAbsoluteLayoutAlignItemsAndJustifyContentCenter() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignItems(AlignItems.center)
        root.flexGrow(1)
        root.width(StyleValue.length(110))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.width(StyleValue.length(60))
        root_child0.height(StyleValue.length(40))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)
    }

    // Generated from test: absolute_layout_align_items_and_justify_content_flex_end
    func testAbsoluteLayoutAlignItemsAndJustifyContentFlexEnd() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.flexEnd)
        root.alignItems(AlignItems.flexEnd)
        root.flexGrow(1)
        root.width(StyleValue.length(110))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.width(StyleValue.length(60))
        root_child0.height(StyleValue.length(40))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 60)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 60)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)
    }

    // Generated from test: absolute_layout_justify_content_center
    func testAbsoluteLayoutJustifyContentCenter() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.flexGrow(1)
        root.width(StyleValue.length(110))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.width(StyleValue.length(60))
        root_child0.height(StyleValue.length(40))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)
    }

    // Generated from test: absolute_layout_align_items_center
    func testAbsoluteLayoutAlignItemsCenter() {
        let root = FlexLayout()
        root.alignItems(AlignItems.center)
        root.flexGrow(1)
        root.width(StyleValue.length(110))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.width(StyleValue.length(60))
        root_child0.height(StyleValue.length(40))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)
    }

    // Generated from test: absolute_layout_align_items_center_on_child_only
    func testAbsoluteLayoutAlignItemsCenterOnChildOnly() {
        let root = FlexLayout()
        root.flexGrow(1)
        root.width(StyleValue.length(110))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.alignSelf(AlignSelf.center)
        root_child0.positionType(PositionType.absolute)
        root_child0.width(StyleValue.length(60))
        root_child0.height(StyleValue.length(40))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)
    }

    // Generated from test: absolute_layout_align_items_and_justify_content_center_and_top_position
    func testAbsoluteLayoutAlignItemsAndJustifyContentCenterAndTopPosition() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignItems(AlignItems.center)
        root.flexGrow(1)
        root.width(StyleValue.length(110))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(top: StyleValue.length(10))
        root_child0.width(StyleValue.length(60))
        root_child0.height(StyleValue.length(40))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)
    }

    // Generated from test: absolute_layout_align_items_and_justify_content_center_and_bottom_position
    func testAbsoluteLayoutAlignItemsAndJustifyContentCenterAndBottomPosition() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignItems(AlignItems.center)
        root.flexGrow(1)
        root.width(StyleValue.length(110))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(bottom: StyleValue.length(10))
        root_child0.width(StyleValue.length(60))
        root_child0.height(StyleValue.length(40))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 50)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 50)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)
    }

    // Generated from test: absolute_layout_align_items_and_justify_content_center_and_left_position
    func testAbsoluteLayoutAlignItemsAndJustifyContentCenterAndLeftPosition() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignItems(AlignItems.center)
        root.flexGrow(1)
        root.width(StyleValue.length(110))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(left: StyleValue.length(5))
        root_child0.width(StyleValue.length(60))
        root_child0.height(StyleValue.length(40))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 5)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 5)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)
    }

    // Generated from test: absolute_layout_align_items_and_justify_content_center_and_right_position
    func testAbsoluteLayoutAlignItemsAndJustifyContentCenterAndRightPosition() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignItems(AlignItems.center)
        root.flexGrow(1)
        root.width(StyleValue.length(110))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(right: StyleValue.length(5))
        root_child0.width(StyleValue.length(60))
        root_child0.height(StyleValue.length(40))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 45)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 45)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)
    }

    // Generated from test: position_root_with_rtl_should_position_withoutdirection
    func testPositionRootWithRtlShouldPositionWithoutdirection() {
        let root = FlexLayout()
        root.position(left: StyleValue.length(72))
        root.width(StyleValue.length(52))
        root.height(StyleValue.length(52))
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 72)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 72)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)
    }

    // Generated from test: absolute_layout_percentage_bottom_based_on_parent_height
    func testAbsoluteLayoutPercentageBottomBasedOnParentHeight() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(200))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.position(top: StyleValue.percentage(50))
        root_child0.width(StyleValue.length(10))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.positionType(PositionType.absolute)
        root_child1.position(bottom: StyleValue.percentage(50))
        root_child1.width(StyleValue.length(10))
        root_child1.height(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.positionType(PositionType.absolute)
        root_child2.position(top: StyleValue.percentage(10))
        root_child2.position(bottom: StyleValue.percentage(10))
        root_child2.width(StyleValue.length(10))
        root.append(root_child2)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 100)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 90)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 160)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 90)
        XCTAssertEqual(root_child0.box.top, 100)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 90)
        XCTAssertEqual(root_child1.box.top, 90)
        XCTAssertEqual(root_child1.box.width, 10)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 90)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 10)
        XCTAssertEqual(root_child2.box.height, 160)
    }

    // Generated from test: absolute_layout_in_wrap_reverse_column_container
    func testAbsoluteLayoutInWrapReverseColumnContainer() {
        let root = FlexLayout()
        root.flexWrap(FlexWrap.wrapReverse)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.width(StyleValue.length(20))
        root_child0.height(StyleValue.length(20))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)
    }

    // Generated from test: absolute_layout_in_wrap_reverse_row_container
    func testAbsoluteLayoutInWrapReverseRowContainer() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.flexWrap(FlexWrap.wrapReverse)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.positionType(PositionType.absolute)
        root_child0.width(StyleValue.length(20))
        root_child0.height(StyleValue.length(20))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 80)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 80)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)
    }

    // Generated from test: absolute_layout_in_wrap_reverse_column_container_flex_end
    func testAbsoluteLayoutInWrapReverseColumnContainerFlexEnd() {
        let root = FlexLayout()
        root.flexWrap(FlexWrap.wrapReverse)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.alignSelf(AlignSelf.flexEnd)
        root_child0.positionType(PositionType.absolute)
        root_child0.width(StyleValue.length(20))
        root_child0.height(StyleValue.length(20))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)
    }

    // Generated from test: absolute_layout_in_wrap_reverse_row_container_flex_end
    func testAbsoluteLayoutInWrapReverseRowContainerFlexEnd() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.flexWrap(FlexWrap.wrapReverse)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.alignSelf(AlignSelf.flexEnd)
        root_child0.positionType(PositionType.absolute)
        root_child0.width(StyleValue.length(20))
        root_child0.height(StyleValue.length(20))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)
    }
}
