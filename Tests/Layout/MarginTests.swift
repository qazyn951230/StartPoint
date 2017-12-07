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

// Generated from YGMarginTest.cpp
class MarginTests: FlexTestCase {

    // Generated from test: margin_start
    func testMarginStart() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .margin(leading: 10)
            .width(10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 100)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: margin_top
    func testMarginTop() {
        let root = yogaLayout()
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .margin(top: 10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: margin_end
    func testMarginEnd() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(100)
            .justifyContent(.flexEnd)
            .width(100)

        let root_child0 = yogaLayout()
            .margin(trailing: 10)
            .width(10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 100)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: margin_bottom
    func testMarginBottom() {
        let root = yogaLayout()
            .height(100)
            .justifyContent(.flexEnd)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .margin(bottom: 10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 80)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 80)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: margin_and_flex_row
    func testMarginAndFlexRow() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .flexGrow(1)
            .margin(leading: 10)
            .margin(trailing: 10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 100)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: margin_and_flex_column
    func testMarginAndFlexColumn() {
        let root = yogaLayout()
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .flexGrow(1)
            .margin(bottom: 10)
            .margin(top: 10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 80)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 80)
    }

    // Generated from test: margin_and_stretch_row
    func testMarginAndStretchRow() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .flexGrow(1)
            .margin(bottom: 10)
            .margin(top: 10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 80)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 80)
    }

    // Generated from test: margin_and_stretch_column
    func testMarginAndStretchColumn() {
        let root = yogaLayout()
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .flexGrow(1)
            .margin(leading: 10)
            .margin(trailing: 10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 100)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: margin_with_sibling_row
    func testMarginWithSiblingRow() {
        let root = yogaLayout()
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .flexGrow(1)
            .margin(trailing: 10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
        root.append(root_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 45)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 55)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 45)
        XCTAssertEqual(root_child1.box.height, 100)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 55)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 45)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 45)
        XCTAssertEqual(root_child1.box.height, 100)
    }

    // Generated from test: margin_with_sibling_column
    func testMarginWithSiblingColumn() {
        let root = yogaLayout()
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .flexGrow(1)
            .margin(bottom: 10)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexGrow(1)
        root.append(root_child1)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 45)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 55)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 45)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 45)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 55)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 45)
    }

    // Generated from test: margin_auto_bottom
    // func testMarginAutoBottom() {
    // }

    // Generated from test: margin_auto_top
    // func testMarginAutoTop() {
    // }

    // Generated from test: margin_auto_bottom_and_top
    // func testMarginAutoBottomAndTop() {
    // }

    // Generated from test: margin_auto_bottom_and_top_justify_center
    // func testMarginAutoBottomAndTopJustifyCenter() {
    // }

    // Generated from test: margin_auto_mutiple_children_column
    // func testMarginAutoMutipleChildrenColumn() {
    // }

    // Generated from test: margin_auto_mutiple_children_row
    // func testMarginAutoMutipleChildrenRow() {
    // }

    // Generated from test: margin_auto_left_and_right_column
    // func testMarginAutoLeftAndRightColumn() {
    // }

    // Generated from test: margin_auto_left_and_right
    // func testMarginAutoLeftAndRight() {
    // }

    // Generated from test: margin_auto_start_and_end_column
    // func testMarginAutoStartAndEndColumn() {
    // }

    // Generated from test: margin_auto_start_and_end
    // func testMarginAutoStartAndEnd() {
    // }

    // Generated from test: margin_auto_left_and_right_column_and_center
    // func testMarginAutoLeftAndRightColumnAndCenter() {
    // }

    // Generated from test: margin_auto_left
    // func testMarginAutoLeft() {
    // }

    // Generated from test: margin_auto_right
    // func testMarginAutoRight() {
    // }

    // Generated from test: margin_auto_left_and_right_strech
    // func testMarginAutoLeftAndRightStrech() {
    // }

    // Generated from test: margin_auto_top_and_bottom_strech
    // func testMarginAutoTopAndBottomStrech() {
    // }

    // Generated from test: margin_should_not_be_part_of_max_height
    func testMarginShouldNotBePartOfMaxHeight() {
        let root = yogaLayout()
            .height(250)
            .width(250)

        let root_child0 = yogaLayout()
            .height(100)
            .margin(top: 20)
            .maxHeight(100)
            .width(100)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 250)
        XCTAssertEqual(root.box.height, 250)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 20)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 250)
        XCTAssertEqual(root.box.height, 250)

        XCTAssertEqual(root_child0.box.left, 150)
        XCTAssertEqual(root_child0.box.top, 20)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: margin_should_not_be_part_of_max_width
    func testMarginShouldNotBePartOfMaxWidth() {
        let root = yogaLayout()
            .height(250)
            .width(250)

        let root_child0 = yogaLayout()
            .height(100)
            .margin(left: 20)
            .maxWidth(100)
            .width(100)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 250)
        XCTAssertEqual(root.box.height, 250)

        XCTAssertEqual(root_child0.box.left, 20)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 250)
        XCTAssertEqual(root.box.height, 250)

        XCTAssertEqual(root_child0.box.left, 150)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: margin_auto_left_right_child_bigger_than_parent
    // func testMarginAutoLeftRightChildBiggerThanParent() {
    // }

    // Generated from test: margin_auto_left_child_bigger_than_parent
    // func testMarginAutoLeftChildBiggerThanParent() {
    // }

    // Generated from test: margin_fix_left_auto_right_child_bigger_than_parent
    // func testMarginFixLeftAutoRightChildBiggerThanParent() {
    // }

    // Generated from test: margin_auto_left_fix_right_child_bigger_than_parent
    // func testMarginAutoLeftFixRightChildBiggerThanParent() {
    // }

    // Generated from test: margin_auto_top_stretching_child
    // func testMarginAutoTopStretchingChild() {
    // }

    // Generated from test: margin_auto_left_stretching_child
    // func testMarginAutoLeftStretchingChild() {
    // }
}
