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

// Generated from YGAndroidNewsFeed.cpp
class AndroidNewsFeeds: FlexTestCase {

    // Generated from test: android_news_feed
    func testAndroidNewsFeed() {
        let root = FlexLayout()
        root.alignContent(AlignContent.stretch)
        root.width(StyleValue.length(1080))

        let root_child0 = FlexLayout()
        root.insert(root_child0, at: 0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.alignContent(AlignContent.stretch)
        root_child0.insert(root_child0_child0, at: 0)

        let root_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0.alignContent(AlignContent.stretch)
        root_child0_child0.insert(root_child0_child0_child0, at: 0)

        let root_child0_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0_child0.flexDirection(FlexDirection.row)
        root_child0_child0_child0_child0.alignContent(AlignContent.stretch)
        root_child0_child0_child0_child0.alignItems(AlignItems.flexStart)
        root_child0_child0_child0_child0.margin(leading: StyleValue.length(36))
        root_child0_child0_child0_child0.margin(top: StyleValue.length(24))
        root_child0_child0_child0.insert(root_child0_child0_child0_child0, at: 0)

        let root_child0_child0_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0_child0_child0.flexDirection(FlexDirection.row)
        root_child0_child0_child0_child0_child0.alignContent(AlignContent.stretch)
        root_child0_child0_child0_child0.insert(root_child0_child0_child0_child0_child0, at: 0)

        let root_child0_child0_child0_child0_child0_child0 = FlexLayout()
        root_child0_child0_child0_child0_child0_child0.alignContent(AlignContent.stretch)
        root_child0_child0_child0_child0_child0_child0.width(StyleValue.length(120))
        root_child0_child0_child0_child0_child0_child0.height(StyleValue.length(120))
        root_child0_child0_child0_child0_child0.insert(root_child0_child0_child0_child0_child0_child0, at: 0)

        let root_child0_child0_child0_child0_child1 = FlexLayout()
        root_child0_child0_child0_child0_child1.alignContent(AlignContent.stretch)
        root_child0_child0_child0_child0_child1.flexShrink(1)
        root_child0_child0_child0_child0_child1.margin(right: StyleValue.length(36))
        root_child0_child0_child0_child0_child1.padding(left: StyleValue.length(36))
        root_child0_child0_child0_child0_child1.padding(top: StyleValue.length(21))
        root_child0_child0_child0_child0_child1.padding(right: StyleValue.length(36))
        root_child0_child0_child0_child0_child1.padding(bottom: StyleValue.length(18))
        root_child0_child0_child0_child0.insert(root_child0_child0_child0_child0_child1, at: 1)

        let root_child0_child0_child0_child0_child1_child0 = FlexLayout()
        root_child0_child0_child0_child0_child1_child0.flexDirection(FlexDirection.row)
        root_child0_child0_child0_child0_child1_child0.alignContent(AlignContent.stretch)
        root_child0_child0_child0_child0_child1_child0.flexShrink(1)
        root_child0_child0_child0_child0_child1.insert(root_child0_child0_child0_child0_child1_child0, at: 0)

        let root_child0_child0_child0_child0_child1_child1 = FlexLayout()
        root_child0_child0_child0_child0_child1_child1.alignContent(AlignContent.stretch)
        root_child0_child0_child0_child0_child1_child1.flexShrink(1)
        root_child0_child0_child0_child0_child1.insert(root_child0_child0_child0_child0_child1_child1, at: 1)

        let root_child0_child0_child1 = FlexLayout()
        root_child0_child0_child1.alignContent(AlignContent.stretch)
        root_child0_child0.insert(root_child0_child0_child1, at: 1)

        let root_child0_child0_child1_child0 = FlexLayout()
        root_child0_child0_child1_child0.flexDirection(FlexDirection.row)
        root_child0_child0_child1_child0.alignContent(AlignContent.stretch)
        root_child0_child0_child1_child0.alignItems(AlignItems.flexStart)
        root_child0_child0_child1_child0.margin(leading: StyleValue.length(174))
        root_child0_child0_child1_child0.margin(top: StyleValue.length(24))
        root_child0_child0_child1.insert(root_child0_child0_child1_child0, at: 0)

        let root_child0_child0_child1_child0_child0 = FlexLayout()
        root_child0_child0_child1_child0_child0.flexDirection(FlexDirection.row)
        root_child0_child0_child1_child0_child0.alignContent(AlignContent.stretch)
        root_child0_child0_child1_child0.insert(root_child0_child0_child1_child0_child0, at: 0)

        let root_child0_child0_child1_child0_child0_child0 = FlexLayout()
        root_child0_child0_child1_child0_child0_child0.alignContent(AlignContent.stretch)
        root_child0_child0_child1_child0_child0_child0.width(StyleValue.length(72))
        root_child0_child0_child1_child0_child0_child0.height(StyleValue.length(72))
        root_child0_child0_child1_child0_child0.insert(root_child0_child0_child1_child0_child0_child0, at: 0)

        let root_child0_child0_child1_child0_child1 = FlexLayout()
        root_child0_child0_child1_child0_child1.alignContent(AlignContent.stretch)
        root_child0_child0_child1_child0_child1.flexShrink(1)
        root_child0_child0_child1_child0_child1.margin(right: StyleValue.length(36))
        root_child0_child0_child1_child0_child1.padding(left: StyleValue.length(36))
        root_child0_child0_child1_child0_child1.padding(top: StyleValue.length(21))
        root_child0_child0_child1_child0_child1.padding(right: StyleValue.length(36))
        root_child0_child0_child1_child0_child1.padding(bottom: StyleValue.length(18))
        root_child0_child0_child1_child0.insert(root_child0_child0_child1_child0_child1, at: 1)

        let root_child0_child0_child1_child0_child1_child0 = FlexLayout()
        root_child0_child0_child1_child0_child1_child0.flexDirection(FlexDirection.row)
        root_child0_child0_child1_child0_child1_child0.alignContent(AlignContent.stretch)
        root_child0_child0_child1_child0_child1_child0.flexShrink(1)
        root_child0_child0_child1_child0_child1.insert(root_child0_child0_child1_child0_child1_child0, at: 0)

        let root_child0_child0_child1_child0_child1_child1 = FlexLayout()
        root_child0_child0_child1_child0_child1_child1.alignContent(AlignContent.stretch)
        root_child0_child0_child1_child0_child1_child1.flexShrink(1)
        root_child0_child0_child1_child0_child1.insert(root_child0_child0_child1_child0_child1_child1, at: 1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 1080)
        XCTAssertEqual(root.box.height, 240)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 1080)
        XCTAssertEqual(root_child0.box.height, 240)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 1080)
        XCTAssertEqual(root_child0_child0.box.height, 240)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 1080)
        XCTAssertEqual(root_child0_child0_child0.box.height, 144)

        XCTAssertEqual(root_child0_child0_child0_child0.box.left, 36)
        XCTAssertEqual(root_child0_child0_child0_child0.box.top, 24)
        XCTAssertEqual(root_child0_child0_child0_child0.box.width, 1044)
        XCTAssertEqual(root_child0_child0_child0_child0.box.height, 120)

        XCTAssertEqual(root_child0_child0_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child0.box.width, 120)
        XCTAssertEqual(root_child0_child0_child0_child0_child0.box.height, 120)

        XCTAssertEqual(root_child0_child0_child0_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child0_child0.box.width, 120)
        XCTAssertEqual(root_child0_child0_child0_child0_child0_child0.box.height, 120)

        XCTAssertEqual(root_child0_child0_child0_child0_child1.box.left, 120)
        XCTAssertEqual(root_child0_child0_child0_child0_child1.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child1.box.width, 72)
        XCTAssertEqual(root_child0_child0_child0_child0_child1.box.height, 39)

        XCTAssertEqual(root_child0_child0_child0_child0_child1_child0.box.left, 36)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child0.box.top, 21)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0_child0_child0_child1_child1.box.left, 36)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child1.box.top, 21)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child1.box.width, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child1.box.height, 0)

        XCTAssertEqual(root_child0_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child0_child1.box.top, 144)
        XCTAssertEqual(root_child0_child0_child1.box.width, 1080)
        XCTAssertEqual(root_child0_child0_child1.box.height, 96)

        XCTAssertEqual(root_child0_child0_child1_child0.box.left, 174)
        XCTAssertEqual(root_child0_child0_child1_child0.box.top, 24)
        XCTAssertEqual(root_child0_child0_child1_child0.box.width, 906)
        XCTAssertEqual(root_child0_child0_child1_child0.box.height, 72)

        XCTAssertEqual(root_child0_child0_child1_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child0.box.width, 72)
        XCTAssertEqual(root_child0_child0_child1_child0_child0.box.height, 72)

        XCTAssertEqual(root_child0_child0_child1_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child0_child0.box.width, 72)
        XCTAssertEqual(root_child0_child0_child1_child0_child0_child0.box.height, 72)

        XCTAssertEqual(root_child0_child0_child1_child0_child1.box.left, 72)
        XCTAssertEqual(root_child0_child0_child1_child0_child1.box.top, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child1.box.width, 72)
        XCTAssertEqual(root_child0_child0_child1_child0_child1.box.height, 39)

        XCTAssertEqual(root_child0_child0_child1_child0_child1_child0.box.left, 36)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child0.box.top, 21)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0_child1_child0_child1_child1.box.left, 36)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child1.box.top, 21)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child1.box.width, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child1.box.height, 0)

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 1080)
        XCTAssertEqual(root.box.height, 240)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 1080)
        XCTAssertEqual(root_child0.box.height, 240)

        XCTAssertEqual(root_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0.box.width, 1080)
        XCTAssertEqual(root_child0_child0.box.height, 240)

        XCTAssertEqual(root_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0.box.width, 1080)
        XCTAssertEqual(root_child0_child0_child0.box.height, 144)

        XCTAssertEqual(root_child0_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0_child0.box.top, 24)
        XCTAssertEqual(root_child0_child0_child0_child0.box.width, 1044)
        XCTAssertEqual(root_child0_child0_child0_child0.box.height, 120)

        XCTAssertEqual(root_child0_child0_child0_child0_child0.box.left, 924)
        XCTAssertEqual(root_child0_child0_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child0.box.width, 120)
        XCTAssertEqual(root_child0_child0_child0_child0_child0.box.height, 120)

        XCTAssertEqual(root_child0_child0_child0_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child0_child0.box.width, 120)
        XCTAssertEqual(root_child0_child0_child0_child0_child0_child0.box.height, 120)

        XCTAssertEqual(root_child0_child0_child0_child0_child1.box.left, 816)
        XCTAssertEqual(root_child0_child0_child0_child0_child1.box.top, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child1.box.width, 72)
        XCTAssertEqual(root_child0_child0_child0_child0_child1.box.height, 39)

        XCTAssertEqual(root_child0_child0_child0_child0_child1_child0.box.left, 36)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child0.box.top, 21)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0_child0_child0_child1_child1.box.left, 36)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child1.box.top, 21)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child1.box.width, 0)
        XCTAssertEqual(root_child0_child0_child0_child0_child1_child1.box.height, 0)

        XCTAssertEqual(root_child0_child0_child1.box.left, 0)
        XCTAssertEqual(root_child0_child0_child1.box.top, 144)
        XCTAssertEqual(root_child0_child0_child1.box.width, 1080)
        XCTAssertEqual(root_child0_child0_child1.box.height, 96)

        XCTAssertEqual(root_child0_child0_child1_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child1_child0.box.top, 24)
        XCTAssertEqual(root_child0_child0_child1_child0.box.width, 906)
        XCTAssertEqual(root_child0_child0_child1_child0.box.height, 72)

        XCTAssertEqual(root_child0_child0_child1_child0_child0.box.left, 834)
        XCTAssertEqual(root_child0_child0_child1_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child0.box.width, 72)
        XCTAssertEqual(root_child0_child0_child1_child0_child0.box.height, 72)

        XCTAssertEqual(root_child0_child0_child1_child0_child0_child0.box.left, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child0_child0.box.top, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child0_child0.box.width, 72)
        XCTAssertEqual(root_child0_child0_child1_child0_child0_child0.box.height, 72)

        XCTAssertEqual(root_child0_child0_child1_child0_child1.box.left, 726)
        XCTAssertEqual(root_child0_child0_child1_child0_child1.box.top, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child1.box.width, 72)
        XCTAssertEqual(root_child0_child0_child1_child0_child1.box.height, 39)

        XCTAssertEqual(root_child0_child0_child1_child0_child1_child0.box.left, 36)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child0.box.top, 21)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child0.box.width, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child0.box.height, 0)

        XCTAssertEqual(root_child0_child0_child1_child0_child1_child1.box.left, 36)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child1.box.top, 21)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child1.box.width, 0)
        XCTAssertEqual(root_child0_child0_child1_child0_child1_child1.box.height, 0)
    }
}
