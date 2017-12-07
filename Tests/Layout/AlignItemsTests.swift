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
        let root = yogaLayout()
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .width(10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 45)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.flexStart)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .width(10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.flexEnd)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
            .width(10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 90)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(10)
            .width(50)
        root_child1.append(root_child1_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(60)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(25)
            .width(50)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(20)
            .width(25)
        root_child1.append(root_child1_child0)

        let root_child1_child1 = yogaLayout()
            .height(10)
            .width(25)
        root_child1.append(root_child1_child1)

        let root_child1_child2 = yogaLayout()
            .height(20)
            .width(25)
        root_child1.append(root_child1_child2)

        let root_child1_child3 = yogaLayout()
            .height(10)
            .width(25)
        root_child1.append(root_child1_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(60)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(25)
            .width(50)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(20)
            .width(25)
        root_child1.append(root_child1_child0)

        let root_child1_child1 = yogaLayout()
            .alignSelf(.baseline)
            .height(10)
            .width(25)
        root_child1.append(root_child1_child1)

        let root_child1_child2 = yogaLayout()
            .height(20)
            .width(25)
        root_child1.append(root_child1_child2)

        let root_child1_child3 = yogaLayout()
            .alignSelf(.baseline)
            .height(10)
            .width(25)
        root_child1.append(root_child1_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(60)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(25)
            .width(50)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(20)
            .width(25)
        root_child1.append(root_child1_child0)

        let root_child1_child1 = yogaLayout()
            .height(10)
            .width(25)
        root_child1.append(root_child1_child1)

        let root_child1_child2 = yogaLayout()
            .height(20)
            .width(25)
        root_child1.append(root_child1_child2)

        let root_child1_child3 = yogaLayout()
            .alignSelf(.baseline)
            .height(10)
            .width(25)
        root_child1.append(root_child1_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .position(top: 10)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(10)
            .width(50)
        root_child1.append(root_child1_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .position(top: 5)
            .width(50)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(10)
            .width(50)
        root_child1.append(root_child1_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .height(20)
            .width(50)
        root_child0.append(root_child0_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(15)
            .width(50)
        root_child1.append(root_child1_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child1)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .margin(bottom: 5)
            .margin(left: 5)
            .margin(right: 5)
            .margin(top: 5)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(10)
            .margin(bottom: 1)
            .margin(left: 1)
            .margin(right: 1)
            .margin(top: 1)
            .width(50)
        root_child1.append(root_child1_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .height(100)
            .padding(bottom: 5)
            .padding(left: 5)
            .padding(right: 5)
            .padding(top: 5)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .padding(bottom: 5)
            .padding(left: 5)
            .padding(right: 5)
            .padding(top: 5)
            .width(50)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(10)
            .width(50)
        root_child1.append(root_child1_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(10)
            .width(50)
        root_child1.append(root_child1_child0)

        let root_child2 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child2)

        let root_child2_child0 = yogaLayout()
            .height(10)
            .width(50)
        root_child2.append(root_child2_child0)

        let root_child3 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexWrap(.wrap)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(50)
            .width(30)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(20)
            .width(20)
        root_child1.append(root_child1_child0)

        let root_child2 = yogaLayout()
            .height(70)
            .width(40)
        root.append(root_child2)

        let root_child2_child0 = yogaLayout()
            .height(10)
            .width(10)
        root_child2.append(root_child2_child0)

        let root_child3 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexWrap(.wrap)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(50)
            .width(30)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(20)
            .width(20)
        root_child1.append(root_child1_child0)

        let root_child2 = yogaLayout()
            .height(70)
            .width(40)
        root.append(root_child2)

        let root_child2_child0 = yogaLayout()
            .height(10)
            .width(10)
        root_child2.append(root_child2_child0)

        let root_child3 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.baseline)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .height(100)
            .width(100)

        let root_child0 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child0)

        let root_child1 = yogaLayout()
            .height(50)
            .width(50)
        root.append(root_child1)

        let root_child1_child0 = yogaLayout()
            .height(10)
            .width(50)
        root_child1.append(root_child1_child0)

        let root_child2 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child2)

        let root_child2_child0 = yogaLayout()
            .height(10)
            .width(50)
        root_child2.append(root_child2_child0)

        let root_child3 = yogaLayout()
            .height(20)
            .width(50)
        root.append(root_child3)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .height(52)
            .justifyContent(.center)
            .width(52)

        let root_child0 = yogaLayout()
            .alignItems(.center)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .height(52)
            .margin(left: 10)
            .margin(right: 10)
            .width(52)
        root_child0.append(root_child0_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .height(52)
            .justifyContent(.center)
            .width(52)

        let root_child0 = yogaLayout()
            .alignItems(.flexEnd)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .height(52)
            .margin(left: 10)
            .margin(right: 10)
            .width(52)
        root_child0.append(root_child0_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .height(52)
            .justifyContent(.center)
            .width(52)

        let root_child0 = yogaLayout()
            .alignItems(.center)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .height(72)
            .width(72)
        root_child0.append(root_child0_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .height(52)
            .justifyContent(.center)
            .width(52)

        let root_child0 = yogaLayout()
            .alignItems(.flexEnd)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .height(72)
            .width(72)
        root_child0.append(root_child0_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .alignItems(.center)
            .height(100)
            .margin(top: 20)
            .width(100)

        let root_child0 = yogaLayout()
            .flexShrink(1)
            .justifyContent(.center)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .flexGrow(1)
            .flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = yogaLayout()
            .height(20)
            .width(20)
        root_child0_child0.append(root_child0_child0_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(100)
            .margin(top: 20)
            .width(100)

        let root_child0 = yogaLayout()
            .flexShrink(1)
            .justifyContent(.center)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .flexGrow(1)
            .flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = yogaLayout()
            .height(20)
            .width(20)
        root_child0_child0.append(root_child0_child0_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(500)
            .width(500)

        let root_child0 = yogaLayout()
            .alignItems(.flexStart)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .flexGrow(1)
            .flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = yogaLayout()
            .flexGrow(1)
            .flexShrink(1)
        root_child0_child0.append(root_child0_child0_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(500)
            .width(500)

        let root_child0 = yogaLayout()
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .flexGrow(1)
            .flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = yogaLayout()
            .flexGrow(1)
            .flexShrink(1)
        root_child0_child0.append(root_child0_child0_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
        let root = yogaLayout()
            .height(500)
            .width(500)

        let root_child0 = yogaLayout()
            .alignItems(.flexStart)
        root.append(root_child0)

        let root_child0_child0 = yogaLayout()
            .flexGrow(1)
            .flexShrink(1)
        root_child0.append(root_child0_child0)

        let root_child0_child0_child0 = yogaLayout()
            .flexGrow(1)
            .flexShrink(1)
        root_child0_child0.append(root_child0_child0_child0)
        root.calculate(direction: .ltr)

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

        root.calculate(direction: .rtl)

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
