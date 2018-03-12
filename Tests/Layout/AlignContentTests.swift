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

// Generated from YGAlignContentTest.cpp
class AlignContentTests: FlexTestCase {

    // Generated from test: align_content_flex_start
    func testAlignContentFlexStart() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(130))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root_child2.height(StyleValue.length(10))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root_child3.height(StyleValue.length(10))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root_child4.height(StyleValue.length(10))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 130)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 10)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 20)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 130)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 80)
        XCTAssertEqual(root_child2.box.top, 10)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 30)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 80)
        XCTAssertEqual(root_child4.box.top, 20)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)
    }

    // Generated from test: align_content_flex_start_without_height_on_children
    func testAlignContentFlexStartWithoutHeightOnChildren() {
        let root = FlexLayout()
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root_child3.height(StyleValue.length(10))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 10)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 20)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 10)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 10)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 20)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)
    }

    // Generated from test: align_content_flex_start_with_flex
    func testAlignContentFlexStartWithFlex() {
        let root = FlexLayout()
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(120))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(FlexBasis.percentage(0))
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.flexBasis(FlexBasis.percentage(0))
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.flexGrow(1)
        root_child3.flexShrink(1)
        root_child3.flexBasis(FlexBasis.percentage(0))
        root_child3.width(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 120)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 40)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 40)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 80)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 80)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 120)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 120)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 40)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 40)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 40)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 80)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 80)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 40)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 120)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)
    }

    // Generated from test: align_content_flex_end
    func testAlignContentFlexEnd() {
        let root = FlexLayout()
        root.alignContent(AlignContent.flexEnd)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root_child2.height(StyleValue.length(10))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root_child3.height(StyleValue.length(10))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root_child4.height(StyleValue.length(10))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 40)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 20)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 30)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 40)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)
    }

    // Generated from test: align_content_stretch
    func testAlignContentStretch() {
        let root = FlexLayout()
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 0)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 0)

        XCTAssertEqual(root_child1.box.left, 100)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 0)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 0)

        XCTAssertEqual(root_child4.box.left, 100)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 0)
    }

    // Generated from test: align_content_spacebetween
    func testAlignContentSpacebetween() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.spaceBetween)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(130))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root_child2.height(StyleValue.length(10))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root_child3.height(StyleValue.length(10))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root_child4.height(StyleValue.length(10))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 130)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 45)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 45)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 90)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 130)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 80)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 30)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 80)
        XCTAssertEqual(root_child2.box.top, 45)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 30)
        XCTAssertEqual(root_child3.box.top, 45)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 80)
        XCTAssertEqual(root_child4.box.top, 90)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)
    }

    // Generated from test: align_content_spacearound
    func testAlignContentSpacearound() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.spaceAround)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(140))
        root.height(StyleValue.length(120))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(10))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(10))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root_child2.height(StyleValue.length(10))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root_child3.height(StyleValue.length(10))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root_child4.height(StyleValue.length(10))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 140)
        XCTAssertEqual(root.box.height, 120)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 15)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 15)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 55)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 55)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 95)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 140)
        XCTAssertEqual(root.box.height, 120)

        XCTAssertEqual(root_child0.box.left, 90)
        XCTAssertEqual(root_child0.box.top, 15)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 10)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 15)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 10)

        XCTAssertEqual(root_child2.box.left, 90)
        XCTAssertEqual(root_child2.box.top, 55)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 10)

        XCTAssertEqual(root_child3.box.left, 40)
        XCTAssertEqual(root_child3.box.top, 55)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 90)
        XCTAssertEqual(root_child4.box.top, 95)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)
    }

    // Generated from test: align_content_stretch_row
    func testAlignContentStretchRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: align_content_stretch_row_with_children
    func testAlignContentStretchRowWithChildren() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexShrink(1)
        root_child0_child0.flexBasis(FlexBasis.percentage(0))
        root_child0.append(root_child0_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: align_content_stretch_row_with_flex
    func testAlignContentStretchRowWithFlex() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.flexShrink(1)
        root_child1.flexBasis(FlexBasis.percentage(0))
        root_child1.width(StyleValue.length(50))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.flexGrow(1)
        root_child3.flexShrink(1)
        root_child3.flexBasis(FlexBasis.percentage(0))
        root_child3.width(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 100)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 0)
        XCTAssertEqual(root_child3.box.height, 100)

        XCTAssertEqual(root_child4.box.left, 100)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 100)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 100)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 0)
        XCTAssertEqual(root_child3.box.height, 100)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 100)
    }

    // Generated from test: align_content_stretch_row_with_flex_no_shrink
    func testAlignContentStretchRowWithFlexNoShrink() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.flexShrink(1)
        root_child1.flexBasis(FlexBasis.percentage(0))
        root_child1.width(StyleValue.length(50))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.flexGrow(1)
        root_child3.flexBasis(FlexBasis.percentage(0))
        root_child3.width(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 100)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 0)
        XCTAssertEqual(root_child3.box.height, 100)

        XCTAssertEqual(root_child4.box.left, 100)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 100)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 0)
        XCTAssertEqual(root_child1.box.height, 100)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 100)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 0)
        XCTAssertEqual(root_child3.box.width, 0)
        XCTAssertEqual(root_child3.box.height, 100)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 100)
    }

    // Generated from test: align_content_stretch_row_with_margin
    func testAlignContentStretchRowWithMargin() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.margin(left: StyleValue.length(10))
        root_child1.margin(top: StyleValue.length(10))
        root_child1.margin(right: StyleValue.length(10))
        root_child1.margin(bottom: StyleValue.length(10))
        root_child1.width(StyleValue.length(50))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.margin(left: StyleValue.length(10))
        root_child3.margin(top: StyleValue.length(10))
        root_child3.margin(right: StyleValue.length(10))
        root_child3.margin(bottom: StyleValue.length(10))
        root_child3.width(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 40)

        XCTAssertEqual(root_child1.box.left, 60)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 40)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 40)

        XCTAssertEqual(root_child3.box.left, 60)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 80)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 40)

        XCTAssertEqual(root_child1.box.left, 40)
        XCTAssertEqual(root_child1.box.top, 10)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 40)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 40)

        XCTAssertEqual(root_child3.box.left, 40)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)

        XCTAssertEqual(root_child4.box.left, 100)
        XCTAssertEqual(root_child4.box.top, 80)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 20)
    }

    // Generated from test: align_content_stretch_row_with_padding
    func testAlignContentStretchRowWithPadding() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.padding(left: StyleValue.length(10))
        root_child1.padding(top: StyleValue.length(10))
        root_child1.padding(right: StyleValue.length(10))
        root_child1.padding(bottom: StyleValue.length(10))
        root_child1.width(StyleValue.length(50))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.padding(left: StyleValue.length(10))
        root_child3.padding(top: StyleValue.length(10))
        root_child3.padding(right: StyleValue.length(10))
        root_child3.padding(bottom: StyleValue.length(10))
        root_child3.width(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: align_content_stretch_row_with_single_row
    func testAlignContentStretchRowWithSingleRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root.append(root_child1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 100)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 100)
    }

    // Generated from test: align_content_stretch_row_with_fixed_height
    func testAlignContentStretchRowWithFixedHeight() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(60))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 80)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 60)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 80)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 80)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 80)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 20)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 80)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 60)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 80)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 80)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 20)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 80)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 20)
    }

    // Generated from test: align_content_stretch_row_with_max_height
    func testAlignContentStretchRowWithMaxHeight() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.maxHeight(StyleValue.length(20))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 20)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 50)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 50)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: align_content_stretch_row_with_min_height
    func testAlignContentStretchRowWithMinHeight() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(150))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.minHeight(StyleValue.length(80))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.width(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.width(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.width(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 90)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 90)

        XCTAssertEqual(root_child2.box.left, 100)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 90)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 90)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 90)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 100)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 90)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 90)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 0)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 90)

        XCTAssertEqual(root_child3.box.left, 100)
        XCTAssertEqual(root_child3.box.top, 90)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 10)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 90)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 10)
    }

    // Generated from test: align_content_stretch_column
    func testAlignContentStretchColumn() {
        let root = FlexLayout()
        root.alignContent(AlignContent.stretch)
        root.flexWrap(FlexWrap.wrap)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(150))

        let root_child0 = FlexLayout()
        root_child0.height(StyleValue.length(50))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.flexGrow(1)
        root_child0_child0.flexShrink(1)
        root_child0_child0.flexBasis(FlexBasis.percentage(0))
        root_child0.append(root_child0_child0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root_child1.flexShrink(1)
        root_child1.flexBasis(FlexBasis.percentage(0))
        root_child1.height(StyleValue.length(50))
        root.append(root_child1)

        let root_child2 = FlexLayout()
        root_child2.height(StyleValue.length(50))
        root.append(root_child2)

        let root_child3 = FlexLayout()
        root_child3.height(StyleValue.length(50))
        root.append(root_child3)

        let root_child4 = FlexLayout()
        root_child4.height(StyleValue.length(50))
        root.append(root_child4)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 150)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 0)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 0)
        XCTAssertEqual(root_child3.box.top, 100)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 50)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 150)

        XCTAssertEqual(root_child0.box.left, 50)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 50)
        XCTAssertEqual(root_child0_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 0)

        XCTAssertEqual(root_child2.box.left, 50)
        XCTAssertEqual(root_child2.box.top, 50)
        XCTAssertEqual(root_child2.box.width, 50)
        XCTAssertEqual(root_child2.box.height, 50)

        XCTAssertEqual(root_child3.box.left, 50)
        XCTAssertEqual(root_child3.box.top, 100)
        XCTAssertEqual(root_child3.box.width, 50)
        XCTAssertEqual(root_child3.box.height, 50)

        XCTAssertEqual(root_child4.box.left, 0)
        XCTAssertEqual(root_child4.box.top, 0)
        XCTAssertEqual(root_child4.box.width, 50)
        XCTAssertEqual(root_child4.box.height, 50)
    }

    // Generated from test: align_content_stretch_is_not_overriding_align_items
    func testAlignContentStretchIsNotOverridingAlignItems() {
        let root = FlexLayout()
        root.alignContent(AlignContent.stretch)

        let root_child0 = FlexLayout()
        root_child0.flexDirection(FlexDirection.row)
        root_child0.alignContent(AlignContent.stretch)
        root_child0.alignItems(AlignItems.center)
        root_child0.width(StyleValue.length(100))
        root_child0.height(StyleValue.length(100))
        root.append(root_child0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.alignContent(AlignContent.stretch)
        root_child0_child0.width(StyleValue.length(10))
        root_child0_child0.height(StyleValue.length(10))
        root_child0.append(root_child0_child0)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 45)
        XCTAssertEqual(root_child0_child0.box.width, 10)
        XCTAssertEqual(root_child0_child0.box.height, 10)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.left, 90)
        XCTAssertEqual(root_child0_child0.box.top, 45)
        XCTAssertEqual(root_child0_child0.box.width, 10)
        XCTAssertEqual(root_child0_child0.box.height, 10)
    }
}
