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

// Generated from YGPaddingTest.cpp
class PaddingTests: FlexTestCase {

    // Generated from test: padding_no_size
    func testPaddingNoSize() {
        let root = yogaLayout()
            .padding(bottom: 10)
            .padding(left: 10)
            .padding(right: 10)
            .padding(top: 10)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 20)
        XCTAssertEqual(root.box.height, 20)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 20)
        XCTAssertEqual(root.box.height, 20)
    }

    // Generated from test: padding_container_match_child
    func testPaddingContainerMatchChild() {
        let root = yogaLayout()
            .padding(bottom: 10)
            .padding(left: 10)
            .padding(right: 10)
            .padding(top: 10)

        let root_child0 = yogaLayout()
            .height(10)
            .width(10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 30)
        XCTAssertEqual(root.box.height, 30)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 30)
        XCTAssertEqual(root.box.height, 30)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: padding_flex_child
    func testPaddingFlexChild() {
        let root = yogaLayout()
            .height(100)
            .padding(bottom: 10)
            .padding(left: 10)
            .padding(right: 10)
            .padding(top: 10)
            .width(100)

        let root_child0 = yogaLayout()
            .flexGrow(1)
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
        XCTAssertEqual(root_child0.box.height, 80)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 80)
    }

    // Generated from test: padding_stretch_child
    func testPaddingStretchChild() {
        let root = yogaLayout()
            .height(100)
            .padding(bottom: 10)
            .padding(left: 10)
            .padding(right: 10)
            .padding(top: 10)
            .width(100)

        let root_child0 = yogaLayout()
            .height(10)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: padding_center_child
    func testPaddingCenterChild() {
        let root = yogaLayout()
            .alignItems(.center)
            .height(100)
            .justifyContent(.center)
            .padding(bottom: 20)
            .padding(leading: 10)
            .padding(trailing: 20)
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

        XCTAssertEqual(root_child0.box.left, 40)
        XCTAssertEqual(root_child0.box.top, 35)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 35)
        XCTAssertEqual(root_child0.box.width, 10)
        XCTAssertEqual(root_child0.box.height, 10)
    }

    // Generated from test: child_with_padding_align_end
    func testChildWithPaddingAlignEnd() {
        let root = yogaLayout()
            .alignItems(.flexEnd)
            .height(200)
            .justifyContent(.flexEnd)
            .width(200)

        let root_child0 = yogaLayout()
            .height(100)
            .padding(bottom: 20)
            .padding(left: 20)
            .padding(right: 20)
            .padding(top: 20)
            .width(100)
        root.append(root_child0)
        root.calculate(direction: .ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 100)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        root.calculate(direction: .rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 100)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }
}
