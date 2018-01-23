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

// Generated from YGAlignItemsTest.cpp
class AlignItemsTests: FlexTestCase {

    // Generated from test: align_items_stretch
    func testAlignItemsStretch() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: align_items_center
    func testAlignItemsCenter() {
        let root = FlexLayout()
        root.alignItems(AlignItems.center)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 45)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 45)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: align_items_flex_start
    func testAlignItemsFlexStart() {
        let root = FlexLayout()
        root.alignItems(AlignItems.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 90)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: align_items_flex_end
    func testAlignItemsFlexEnd() {
        let root = FlexLayout()
        root.alignItems(AlignItems.flexEnd)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(10))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 90)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: align_baseline
    func testAlignBaseline() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 30)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 30)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)
    }

    // Generated from test: align_baseline_child
    func testAlignBaselineChild() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(50))
        root_child1_child0.height(StyleValue.length(10))
        root_child1.append(root_child1_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)
    }

    // Generated from test: align_baseline_child_multiline
    func testAlignBaselineChildMultiline() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(60))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexDirection(FlexDirection.row)
        root_child1.flexWrap(FlexWrap.wrap)
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(25))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(25))
        root_child1_child0.height(StyleValue.length(20))
        root_child1.append(root_child1_child0)

        let root_child1_child1 = FlexLayout()
        root_child1_child1.width(StyleValue.length(25))
        root_child1_child1.height(StyleValue.length(10))
        root_child1.append(root_child1_child1)

        let root_child1_child2 = FlexLayout()
        root_child1_child2.width(StyleValue.length(25))
        root_child1_child2.height(StyleValue.length(20))
        root_child1.append(root_child1_child2)

        let root_child1_child3 = FlexLayout()
        root_child1_child3.width(StyleValue.length(25))
        root_child1_child3.height(StyleValue.length(10))
        root_child1.append(root_child1_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 60)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 25)
        XCTAssertEqual(root_child1_child0.box.height, 20)

        XCTAssertEqual(root_child1_child1.box.left, 25)
        XCTAssertEqual(root_child1_child1.box.top, 0)
        XCTAssertEqual(root_child1_child1.box.width, 25)
        XCTAssertEqual(root_child1_child1.box.height, 10)

        XCTAssertEqual(root_child1_child2.box.left, 0)
        XCTAssertEqual(root_child1_child2.box.top, 20)
        XCTAssertEqual(root_child1_child2.box.width, 25)
        XCTAssertEqual(root_child1_child2.box.height, 20)

        XCTAssertEqual(root_child1_child3.box.left, 25)
        XCTAssertEqual(root_child1_child3.box.top, 20)
        XCTAssertEqual(root_child1_child3.box.width, 25)
        XCTAssertEqual(root_child1_child3.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 60)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child1_child0.box.left, 25)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 25)
        XCTAssertEqual(root_child1_child0.box.height, 20)

        XCTAssertEqual(root_child1_child1.box.left, 0)
        XCTAssertEqual(root_child1_child1.box.top, 0)
        XCTAssertEqual(root_child1_child1.box.width, 25)
        XCTAssertEqual(root_child1_child1.box.height, 10)

        XCTAssertEqual(root_child1_child2.box.left, 25)
        XCTAssertEqual(root_child1_child2.box.top, 20)
        XCTAssertEqual(root_child1_child2.box.width, 25)
        XCTAssertEqual(root_child1_child2.box.height, 20)

        XCTAssertEqual(root_child1_child3.box.left, 0)
        XCTAssertEqual(root_child1_child3.box.top, 20)
        XCTAssertEqual(root_child1_child3.box.width, 25)
        XCTAssertEqual(root_child1_child3.box.height, 10)
    }

    // Generated from test: align_baseline_child_multiline_override
    func testAlignBaselineChildMultilineOverride() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(60))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexDirection(FlexDirection.row)
        root_child1.flexWrap(FlexWrap.wrap)
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(25))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(25))
        root_child1_child0.height(StyleValue.length(20))
        root_child1.append(root_child1_child0)

        let root_child1_child1 = FlexLayout()
        root_child1_child1.alignSelf(AlignSelf.baseline)
        root_child1_child1.width(StyleValue.length(25))
        root_child1_child1.height(StyleValue.length(10))
        root_child1.append(root_child1_child1)

        let root_child1_child2 = FlexLayout()
        root_child1_child2.width(StyleValue.length(25))
        root_child1_child2.height(StyleValue.length(20))
        root_child1.append(root_child1_child2)

        let root_child1_child3 = FlexLayout()
        root_child1_child3.alignSelf(AlignSelf.baseline)
        root_child1_child3.width(StyleValue.length(25))
        root_child1_child3.height(StyleValue.length(10))
        root_child1.append(root_child1_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 60)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 25)
        XCTAssertEqual(root_child1_child0.box.height, 20)

        XCTAssertEqual(root_child1_child1.box.left, 25)
        XCTAssertEqual(root_child1_child1.box.top, 0)
        XCTAssertEqual(root_child1_child1.box.width, 25)
        XCTAssertEqual(root_child1_child1.box.height, 10)

        XCTAssertEqual(root_child1_child2.box.left, 0)
        XCTAssertEqual(root_child1_child2.box.top, 20)
        XCTAssertEqual(root_child1_child2.box.width, 25)
        XCTAssertEqual(root_child1_child2.box.height, 20)

        XCTAssertEqual(root_child1_child3.box.left, 25)
        XCTAssertEqual(root_child1_child3.box.top, 20)
        XCTAssertEqual(root_child1_child3.box.width, 25)
        XCTAssertEqual(root_child1_child3.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 60)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child1_child0.box.left, 25)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 25)
        XCTAssertEqual(root_child1_child0.box.height, 20)

        XCTAssertEqual(root_child1_child1.box.left, 0)
        XCTAssertEqual(root_child1_child1.box.top, 0)
        XCTAssertEqual(root_child1_child1.box.width, 25)
        XCTAssertEqual(root_child1_child1.box.height, 10)

        XCTAssertEqual(root_child1_child2.box.left, 25)
        XCTAssertEqual(root_child1_child2.box.top, 20)
        XCTAssertEqual(root_child1_child2.box.width, 25)
        XCTAssertEqual(root_child1_child2.box.height, 20)

        XCTAssertEqual(root_child1_child3.box.left, 0)
        XCTAssertEqual(root_child1_child3.box.top, 20)
        XCTAssertEqual(root_child1_child3.box.width, 25)
        XCTAssertEqual(root_child1_child3.box.height, 10)
    }

    // Generated from test: align_baseline_child_multiline_no_override_on_secondline
    func testAlignBaselineChildMultilineNoOverrideOnSecondline() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(60))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexDirection(FlexDirection.row)
        root_child1.flexWrap(FlexWrap.wrap)
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(25))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(25))
        root_child1_child0.height(StyleValue.length(20))
        root_child1.append(root_child1_child0)

        let root_child1_child1 = FlexLayout()
        root_child1_child1.width(StyleValue.length(25))
        root_child1_child1.height(StyleValue.length(10))
        root_child1.append(root_child1_child1)

        let root_child1_child2 = FlexLayout()
        root_child1_child2.width(StyleValue.length(25))
        root_child1_child2.height(StyleValue.length(20))
        root_child1.append(root_child1_child2)

        let root_child1_child3 = FlexLayout()
        root_child1_child3.alignSelf(AlignSelf.baseline)
        root_child1_child3.width(StyleValue.length(25))
        root_child1_child3.height(StyleValue.length(10))
        root_child1.append(root_child1_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 60)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 25)
        XCTAssertEqual(root_child1_child0.box.height, 20)

        XCTAssertEqual(root_child1_child1.box.left, 25)
        XCTAssertEqual(root_child1_child1.box.top, 0)
        XCTAssertEqual(root_child1_child1.box.width, 25)
        XCTAssertEqual(root_child1_child1.box.height, 10)

        XCTAssertEqual(root_child1_child2.box.left, 0)
        XCTAssertEqual(root_child1_child2.box.top, 20)
        XCTAssertEqual(root_child1_child2.box.width, 25)
        XCTAssertEqual(root_child1_child2.box.height, 20)

        XCTAssertEqual(root_child1_child3.box.left, 25)
        XCTAssertEqual(root_child1_child3.box.top, 20)
        XCTAssertEqual(root_child1_child3.box.width, 25)
        XCTAssertEqual(root_child1_child3.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 60)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 25)

        XCTAssertEqual(root_child1_child0.box.left, 25)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 25)
        XCTAssertEqual(root_child1_child0.box.height, 20)

        XCTAssertEqual(root_child1_child1.box.left, 0)
        XCTAssertEqual(root_child1_child1.box.top, 0)
        XCTAssertEqual(root_child1_child1.box.width, 25)
        XCTAssertEqual(root_child1_child1.box.height, 10)

        XCTAssertEqual(root_child1_child2.box.left, 25)
        XCTAssertEqual(root_child1_child2.box.top, 20)
        XCTAssertEqual(root_child1_child2.box.width, 25)
        XCTAssertEqual(root_child1_child2.box.height, 20)

        XCTAssertEqual(root_child1_child3.box.left, 0)
        XCTAssertEqual(root_child1_child3.box.top, 20)
        XCTAssertEqual(root_child1_child3.box.width, 25)
        XCTAssertEqual(root_child1_child3.box.height, 10)
    }

    // Generated from test: align_baseline_child_top
    func testAlignBaselineChildTop() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.position(top: StyleValue.length(10))
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(50))
        root_child1_child0.height(StyleValue.length(10))
        root_child1.append(root_child1_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)
    }

    // Generated from test: align_baseline_child_top2
    func testAlignBaselineChildTop2() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.position(top: StyleValue.length(5))
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(50))
        root_child1_child0.height(StyleValue.length(10))
        root_child1.append(root_child1_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 45)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 45)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)
    }

    // Generated from test: align_baseline_double_nested_child
    func testAlignBaselineDoubleNestedChild() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.width(StyleValue.length(50))
        root_child0_child0.height(StyleValue.length(20))
        root_child0.append(root_child0_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(50))
        root_child1_child0.height(StyleValue.length(15))
        root_child1.append(root_child1_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 20)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 5)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 15)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 20)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 5)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 15)
    }

    // Generated from test: align_baseline_column
    func testAlignBaselineColumn() {
        let root = FlexLayout()
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)
    }

    // Generated from test: align_baseline_child_margin
    func testAlignBaselineChildMargin() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.margin(left: StyleValue.length(5))
        root_child0.margin(top: StyleValue.length(5))
        root_child0.margin(right: StyleValue.length(5))
        root_child0.margin(bottom: StyleValue.length(5))
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.margin(left: StyleValue.length(1))
        root_child1_child0.margin(top: StyleValue.length(1))
        root_child1_child0.margin(right: StyleValue.length(1))
        root_child1_child0.margin(bottom: StyleValue.length(1))
        root_child1_child0.width(StyleValue.length(50))
        root_child1_child0.height(StyleValue.length(10))
        root_child1.append(root_child1_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 5)
        XCTAssertEqual(root_child0.box.top, 5)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 60)
        XCTAssertEqual(root_child1.box.top, 44)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 1)
        XCTAssertEqual(root_child1_child0.box.top, 1)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 45)
        XCTAssertEqual(root_child0.box.top, 5)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, -10)
        XCTAssertEqual(root_child1.box.top, 44)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, -1)
        XCTAssertEqual(root_child1_child0.box.top, 1)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)
    }

    // Generated from test: align_baseline_child_padding
    func testAlignBaselineChildPadding() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.padding(left: StyleValue.length(5))
        root.padding(top: StyleValue.length(5))
        root.padding(right: StyleValue.length(5))
        root.padding(bottom: StyleValue.length(5))
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.padding(left: StyleValue.length(5))
        root_child1.padding(top: StyleValue.length(5))
        root_child1.padding(right: StyleValue.length(5))
        root_child1.padding(bottom: StyleValue.length(5))
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(50))
        root_child1_child0.height(StyleValue.length(10))
        root_child1.append(root_child1_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 5)
        XCTAssertEqual(root_child0.box.top, 5)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 55)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 5)
        XCTAssertEqual(root_child1_child0.box.top, 5)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 45)
        XCTAssertEqual(root_child0.box.top, 5)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, -5)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, -5)
        XCTAssertEqual(root_child1_child0.box.top, 5)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)
    }

    // Generated from test: align_baseline_multiline
    func testAlignBaselineMultiline() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(20))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(50))
        root_child1_child0.height(StyleValue.length(10))
        root_child1.append(root_child1_child0)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root_child2.height(StyleValue.length(20))
        root.append(root_child2)

        let root_child2_child0 = FlexLayout()
        root_child2_child0.width(StyleValue.length(50))
        root_child2_child0.height(StyleValue.length(10))
        root_child2.append(root_child2_child0)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root_child3.height(StyleValue.length(50))
        root.append(root_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 100)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 20)

        XCTAssertEqual(root_child2_child0.box.left, 0)
        XCTAssertEqual(root_child2_child0.box.top, 0)
        XCTAssertEqual(root_child2_child0.box.width, 50)
        XCTAssertEqual(root_child2_child0.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 60)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 100)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 20)

        XCTAssertEqual(root_child2_child0.box.left, 0)
        XCTAssertEqual(root_child2_child0.box.top, 0)
        XCTAssertEqual(root_child2_child0.box.width, 50)
        XCTAssertEqual(root_child2_child0.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 60)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)
    }

    // Generated from test: align_baseline_multiline_column
    func testAlignBaselineMultilineColumn() {
        let root = FlexLayout()
        root.alignItems(AlignItems.baseline)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(50))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(20))
        root_child1_child0.height(StyleValue.length(20))
        root_child1.append(root_child1_child0)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(40))
        root_child2.height(StyleValue.length(70))
        root.append(root_child2)

        let root_child2_child0 = FlexLayout()
        root_child2_child0.width(StyleValue.length(10))
        root_child2_child0.height(StyleValue.length(10))
        root_child2.append(root_child2_child0)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root_child3.height(StyleValue.length(20))
        root.append(root_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 20)
        XCTAssertEqual(root_child1_child0.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 40)
        XCTAssertEqual(root_child2.box.height, 70)

        XCTAssertEqual(root_child2_child0.box.left, 0)
        XCTAssertEqual(root_child2_child0.box.top, 0)
        XCTAssertEqual(root_child2_child0.box.width, 10)
        XCTAssertEqual(root_child2_child0.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 70)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 70)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child1_child0.box.left, 10)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 20)
        XCTAssertEqual(root_child1_child0.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 10)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 40)
        XCTAssertEqual(root_child2.box.height, 70)

        XCTAssertEqual(root_child2_child0.box.left, 30)
        XCTAssertEqual(root_child2_child0.box.top, 0)
        XCTAssertEqual(root_child2_child0.box.width, 10)
        XCTAssertEqual(root_child2_child0.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 70)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)
    }

    // Generated from test: align_baseline_multiline_column2
    func testAlignBaselineMultilineColumn2() {
        let root = FlexLayout()
        root.alignItems(AlignItems.baseline)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(30))
        root_child1.height(StyleValue.length(50))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(20))
        root_child1_child0.height(StyleValue.length(20))
        root_child1.append(root_child1_child0)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(40))
        root_child2.height(StyleValue.length(70))
        root.append(root_child2)

        let root_child2_child0 = FlexLayout()
        root_child2_child0.width(StyleValue.length(10))
        root_child2_child0.height(StyleValue.length(10))
        root_child2.append(root_child2_child0)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root_child3.height(StyleValue.length(20))
        root.append(root_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 20)
        XCTAssertEqual(root_child1_child0.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 40)
        XCTAssertEqual(root_child2.box.height, 70)

        XCTAssertEqual(root_child2_child0.box.left, 0)
        XCTAssertEqual(root_child2_child0.box.top, 0)
        XCTAssertEqual(root_child2_child0.box.width, 10)
        XCTAssertEqual(root_child2_child0.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 70)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 70)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 30)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child1_child0.box.left, 10)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 20)
        XCTAssertEqual(root_child1_child0.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 10)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 40)
        XCTAssertEqual(root_child2.box.height, 70)

        XCTAssertEqual(root_child2_child0.box.left, 30)
        XCTAssertEqual(root_child2_child0.box.top, 0)
        XCTAssertEqual(root_child2_child0.box.width, 10)
        XCTAssertEqual(root_child2_child0.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 70)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)
    }

    // Generated from test: align_baseline_multiline_row_and_column
    func testAlignBaselineMultilineRowAndColumn() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(50))
        root.append(root_child1)

        let root_child1_child0 = FlexLayout()
        root_child1_child0.width(StyleValue.length(50))
        root_child1_child0.height(StyleValue.length(10))
        root_child1.append(root_child1_child0)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root_child2.height(StyleValue.length(20))
        root.append(root_child2)

        let root_child2_child0 = FlexLayout()
        root_child2_child0.width(StyleValue.length(50))
        root_child2_child0.height(StyleValue.length(10))
        root_child2.append(root_child2_child0)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root_child3.height(StyleValue.length(20))
        root.append(root_child3)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 100)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 20)

        XCTAssertEqual(root_child2_child0.box.left, 0)
        XCTAssertEqual(root_child2_child0.box.top, 0)
        XCTAssertEqual(root_child2_child0.box.width, 50)
        XCTAssertEqual(root_child2_child0.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 90)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)
        XCTAssertEqual(root_child1_child0.box.width, 50)
        XCTAssertEqual(root_child1_child0.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 100)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 20)

        XCTAssertEqual(root_child2_child0.box.left, 0)
        XCTAssertEqual(root_child2_child0.box.top, 0)
        XCTAssertEqual(root_child2_child0.box.width, 50)
        XCTAssertEqual(root_child2_child0.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 90)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)
    }

    // Generated from test: align_items_center_child_with_margin_bigger_than_parent
    func testAlignItemsCenterChildWithMarginBiggerThanParent() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignItems(AlignItems.center)
        root.width(StyleValue.length(52))
        root.height(StyleValue.length(52))

        let root_child0 = FlexLayout()
        root_child0.alignItems(AlignItems.center)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.margin(left: StyleValue.length(10))
        root_child0_child0.margin(right: StyleValue.length(10))
        root_child0_child0.width(StyleValue.length(52))
        root_child0_child0.height(StyleValue.length(52))
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)

        XCTAssertEqual(root_child0.box.left, -10)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 72)
        XCTAssertEqual(root_child0.box.height, 52)

        XCTAssertEqual(root_child0_child0.box.left, 10)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 52)
        XCTAssertEqual(root_child0_child0.box.height, 52)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)

        XCTAssertEqual(root_child0.box.left, -10)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 72)
        XCTAssertEqual(root_child0.box.height, 52)

        XCTAssertEqual(root_child0_child0.box.left, 10)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 52)
        XCTAssertEqual(root_child0_child0.box.height, 52)
    }

    // Generated from test: align_items_flex_end_child_with_margin_bigger_than_parent
    func testAlignItemsFlexEndChildWithMarginBiggerThanParent() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignItems(AlignItems.center)
        root.width(StyleValue.length(52))
        root.height(StyleValue.length(52))

        let root_child0 = FlexLayout()
        root_child0.alignItems(AlignItems.flexEnd)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.margin(left: StyleValue.length(10))
        root_child0_child0.margin(right: StyleValue.length(10))
        root_child0_child0.width(StyleValue.length(52))
        root_child0_child0.height(StyleValue.length(52))
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)

        XCTAssertEqual(root_child0.box.left, -10)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 72)
        XCTAssertEqual(root_child0.box.height, 52)

        XCTAssertEqual(root_child0_child0.box.left, 10)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 52)
        XCTAssertEqual(root_child0_child0.box.height, 52)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)

        XCTAssertEqual(root_child0.box.left, -10)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 72)
        XCTAssertEqual(root_child0.box.height, 52)

        XCTAssertEqual(root_child0_child0.box.left, 10)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 52)
        XCTAssertEqual(root_child0_child0.box.height, 52)
    }

    // Generated from test: align_items_center_child_without_margin_bigger_than_parent
    func testAlignItemsCenterChildWithoutMarginBiggerThanParent() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignItems(AlignItems.center)
        root.width(StyleValue.length(52))
        root.height(StyleValue.length(52))

        let root_child0 = FlexLayout()
        root_child0.alignItems(AlignItems.center)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.width(StyleValue.length(72))
        root_child0_child0.height(StyleValue.length(72))
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)

        XCTAssertEqual(root_child0.box.left, -10)
        XCTAssertEqual(root_child0.box.top, -10)
        XCTAssertEqual(root_child0.box.width, 72)
        XCTAssertEqual(root_child0.box.height, 72)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 72)
        XCTAssertEqual(root_child0_child0.box.height, 72)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)

        XCTAssertEqual(root_child0.box.left, -10)
        XCTAssertEqual(root_child0.box.top, -10)
        XCTAssertEqual(root_child0.box.width, 72)
        XCTAssertEqual(root_child0.box.height, 72)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 72)
        XCTAssertEqual(root_child0_child0.box.height, 72)
    }

    // Generated from test: align_items_flex_end_child_without_margin_bigger_than_parent
    func testAlignItemsFlexEndChildWithoutMarginBiggerThanParent() {
        let root = FlexLayout()
        root.justifyContent(JustifyContent.center)
        root.alignItems(AlignItems.center)
        root.width(StyleValue.length(52))
        root.height(StyleValue.length(52))

        let root_child0 = FlexLayout()
        root_child0.alignItems(AlignItems.flexEnd)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.width(StyleValue.length(72))
        root_child0_child0.height(StyleValue.length(72))
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)

        XCTAssertEqual(root_child0.box.left, -10)
        XCTAssertEqual(root_child0.box.top, -10)
        XCTAssertEqual(root_child0.box.width, 72)
        XCTAssertEqual(root_child0.box.height, 72)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 72)
        XCTAssertEqual(root_child0_child0.box.height, 72)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 52)
        XCTAssertEqual(root.box.height, 52)

        XCTAssertEqual(root_child0.box.left, -10)
        XCTAssertEqual(root_child0.box.top, -10)
        XCTAssertEqual(root_child0.box.width, 72)
        XCTAssertEqual(root_child0.box.height, 72)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 72)
        XCTAssertEqual(root_child0_child0.box.height, 72)
    }

    // Generated from test: align_center_should_size_based_on_content
    func testAlignCenterShouldSizeBasedOnContent() {
        let root = FlexLayout()
        root.alignItems(AlignItems.center)
        root.margin(top: StyleValue.length(20))
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.justifyContent(JustifyContent.center)
        root_child0.flexShrink(1)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.width(StyleValue.length(20))
        root_child0_child0_child0.height(StyleValue.length(20))
        root_child0_child0.append(root_child0_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 20)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 40)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 20)
        XCTAssertEqual(root_child0_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 20)
        XCTAssertEqual(root_child0_child0_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 20)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 40)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 20)
        XCTAssertEqual(root_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 20)
        XCTAssertEqual(root_child0_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 20)
        XCTAssertEqual(root_child0_child0_child0.box.height, 20)
    }

    // Generated from test: align_strech_should_size_based_on_parent
    func testAlignStrechShouldSizeBasedOnParent() {
        let root = FlexLayout()
        root.margin(top: StyleValue.length(20))
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.justifyContent(JustifyContent.center)
        root_child0.flexShrink(1)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.width(StyleValue.length(20))
        root_child0_child0_child0.height(StyleValue.length(20))
        root_child0_child0.append(root_child0_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 20)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 20)
        XCTAssertEqual(root_child0_child0_child0.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 20)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 20)

        XCTAssertEqual(root_child0_child0_child0.box.left, 80)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 20)
        XCTAssertEqual(root_child0_child0_child0.box.height, 20)
    }

    // Generated from test: align_flex_start_with_shrinking_children
    func testAlignFlexStartWithShrinkingChildren() {
        let root = FlexLayout()
        root.width(StyleValue.length(500))
        root.height(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.alignItems(AlignItems.flexStart)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.flexGrow(1)
        root_child0_child0_child0.flexShrink(1)
        root_child0_child0.append(root_child0_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 500)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0_child0.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 500)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0.box.left, 500)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0_child0.box.height, 0)
    }

    // Generated from test: align_flex_start_with_stretching_children
    func testAlignFlexStartWithStretchingChildren() {
        let root = FlexLayout()
        root.width(StyleValue.length(500))
        root.height(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.flexGrow(1)
        root_child0_child0_child0.flexShrink(1)
        root_child0_child0.append(root_child0_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 500)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 500)
        XCTAssertEqual(root_child0_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 500)
        XCTAssertEqual(root_child0_child0_child0.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 500)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 500)
        XCTAssertEqual(root_child0_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 500)
        XCTAssertEqual(root_child0_child0_child0.box.height, 0)
    }

    // Generated from test: align_flex_start_with_shrinking_children_with_stretch
    func testAlignFlexStartWithShrinkingChildrenWithStretch() {
        let root = FlexLayout()
        root.width(StyleValue.length(500))
        root.height(StyleValue.length(500))

        let root_child0 = FlexLayout()
        root_child0.alignItems(AlignItems.flexStart)
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.flexGrow(1)
        root_child0_child0_child0.flexShrink(1)
        root_child0_child0.append(root_child0_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 500)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0_child0.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 500)
        XCTAssertEqual(root.box.height, 500)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 500)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0.box.left, 500)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0_child0.box.height, 0)
    }
}
