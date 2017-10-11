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

import XCTest
@testable import StartPoint

// Generated from YGAbsolutePositionTest.cpp
class AbsolutePositionTests: FlexTestCase {

    // Generated from test: absolute_layout_width_height_start_top
    func testAbsoluteLayoutWidthHeightStartTop() {
        let root = yogaLayout()
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .position(leading: 10)
            .position(top: 10)
            .positionType(.absolute)
            .width(10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .position(bottom: 10)
            .position(trailing: 10)
            .positionType(.absolute)
            .width(10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 80)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .position(bottom: 10)
            .position(leading: 10)
            .position(top: 10)
            .position(trailing: 10)
            .positionType(.absolute)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 80)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .position(bottom: 10)
            .position(leading: 10)
            .position(top: 10)
            .position(trailing: 10)
            .positionType(.absolute)
            .width(10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .height(50)
            .overflow(.hidden)
            .width(50)

        let root_child0 = yogaLayout()
            .position(leading: 0)
            .position(top: 0)
            .positionType(.absolute)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .height(100)
            .width(100)
        root_child0.append(root_child0_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .border(bottom: 10)
            .border(left: 10)
            .border(right: 10)
            .border(top: 10)
            .height(100)
            .margin(bottom: 10)
            .margin(left: 10)
            .margin(right: 10)
            .margin(top: 10)
            .padding(bottom: 10)
            .padding(left: 10)
            .padding(right: 10)
            .padding(top: 10)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .position(left: 0)
            .position(top: 0)
            .positionType(.absolute)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(50)
            .position(bottom: 0)
            .position(right: 0)
            .positionType(.absolute)
            .width(50)
        root.append(root_child1)

        let root_child2 = yogaLayout()
            .height(50)
            .margin(bottom: 10)
            .margin(left: 10)
            .margin(right: 10)
            .margin(top: 10)
            .position(left: 0)
            .position(top: 0)
            .positionType(.absolute)
            .width(50)
        root.append(root_child2)

        let root_child3 = yogaLayout()
            .height(50)
            .margin(bottom: 10)
            .margin(left: 10)
            .margin(right: 10)
            .margin(top: 10)
            .position(bottom: 0)
            .position(right: 0)
            .positionType(.absolute)
            .width(50)
        root.append(root_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .flexGrow(1)
            .height(100)
            .justifyContent(.center)
            .width(110)

        let root_child0 = yogaLayout()
            .height(40)
            .positionType(.absolute)
            .width(60)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.flexEnd)
            .flexGrow(1)
            .height(100)
            .justifyContent(.flexEnd)
            .width(110)

        let root_child0 = yogaLayout()
            .height(40)
            .positionType(.absolute)
            .width(60)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 60)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexGrow(1)
            .height(100)
            .justifyContent(.center)
            .width(110)

        let root_child0 = yogaLayout()
            .height(40)
            .positionType(.absolute)
            .width(60)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .flexGrow(1)
            .height(100)
            .width(110)

        let root_child0 = yogaLayout()
            .height(40)
            .positionType(.absolute)
            .width(60)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexGrow(1)
            .height(100)
            .width(110)

        let root_child0 = yogaLayout()
            .alignSelf(.center)
            .height(40)
            .positionType(.absolute)
            .width(60)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .flexGrow(1)
            .height(100)
            .justifyContent(.center)
            .width(110)

        let root_child0 = yogaLayout()
            .height(40)
            .position(top: 10)
            .positionType(.absolute)
            .width(60)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .flexGrow(1)
            .height(100)
            .justifyContent(.center)
            .width(110)

        let root_child0 = yogaLayout()
            .height(40)
            .position(bottom: 10)
            .positionType(.absolute)
            .width(60)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 25)
        XCTAssertEqual(root_child0.box.top, 50)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .flexGrow(1)
            .height(100)
            .justifyContent(.center)
            .width(110)

        let root_child0 = yogaLayout()
            .height(40)
            .position(left: 5)
            .positionType(.absolute)
            .width(60)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 5)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .flexGrow(1)
            .height(100)
            .justifyContent(.center)
            .width(110)

        let root_child0 = yogaLayout()
            .height(40)
            .position(right: 5)
            .positionType(.absolute)
            .width(60)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 110)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 45)
        XCTAssertEqual(root_child0.box.top, 30)
        XCTAssertEqual(root_child0.box.width, 60)
        XCTAssertEqual(root_child0.box.height, 40)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(52)
            .position(left: 72)
            .width(52)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 72)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 72)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)
    }

    // Generated from test: absolute_layout_percentage_bottom_based_on_parent_height
    // func testAbsoluteLayoutPercentageBottomBasedOnParentHeight() {
    // }

    // Generated from test: absolute_layout_in_wrap_reverse_column_container
    func testAbsoluteLayoutInWrapReverseColumnContainer() {
        let root = yogaLayout()
            .flexWrap(.wrapReverse)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(20)
            .positionType(.absolute)
            .width(20)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrapReverse)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(20)
            .positionType(.absolute)
            .width(20)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 80)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexWrap(.wrapReverse)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .alignSelf(.flexEnd)
            .height(20)
            .positionType(.absolute)
            .width(20)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrapReverse)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .alignSelf(.flexEnd)
            .height(20)
            .positionType(.absolute)
            .width(20)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        root.calculate(direction: .rtl)

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
