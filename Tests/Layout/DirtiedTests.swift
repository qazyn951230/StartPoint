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

// Generated from YGDirtiedTest.cpp
class DirtiedTests: FlexTestCase {
    static void _dirtied(YGNodeRef node) {
        int* dirtiedCount = (int*) node.getContext()
        (*dirtiedCount)++
    }

    // Generated from test: dirtied
    func testDirtied() {
        let root = FlexLayout()
        root.alignItems(AlignItems.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        root.calculate(direction: Direction.ltr)

        int dirtiedCount = 0
        root.setContext(&dirtiedCount)
        root.setDirtiedFunc(_dirtied)

        XCTAssertEqual(dirtiedCount, 0)

        // `_dirtied` MUST be called in case of explicit dirtying.
        root.setDirty(true)
        XCTAssertEqual(dirtiedCount, 1)

        // `_dirtied` MUST be called ONCE.
        root.setDirty(true)
        XCTAssertEqual(dirtiedCount, 1)
    }

    // Generated from test: dirtied_propagation
    func testDirtiedPropagation() {
        let root = FlexLayout()
        root.alignItems(AlignItems.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(20))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(20))
        root.insert(root_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        int dirtiedCount = 0
        root.setContext(&dirtiedCount)
        root.setDirtiedFunc(_dirtied)

        XCTAssertEqual(dirtiedCount, 0)

        // `_dirtied` MUST be called for the first time.
        root_child0.markDirtyAndPropogate()
        XCTAssertEqual(dirtiedCount, 1)

        // `_dirtied` must NOT be called for the second time.
        root_child0.markDirtyAndPropogate()
        XCTAssertEqual(dirtiedCount, 1)
    }

    // Generated from test: dirtied_hierarchy
    func testDirtiedHierarchy() {
        let root = FlexLayout()
        root.alignItems(AlignItems.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(20))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(20))
        root.insert(root_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        int dirtiedCount = 0
        root_child0.setContext(&dirtiedCount)
        root_child0.setDirtiedFunc(_dirtied)

        XCTAssertEqual(dirtiedCount, 0)

        // `_dirtied` must NOT be called for descendants.
        root.markDirtyAndPropogate()
        XCTAssertEqual(dirtiedCount, 0)

        // `_dirtied` must NOT be called for the sibling node.
        root_child1.markDirtyAndPropogate()
        XCTAssertEqual(dirtiedCount, 0)

        // `_dirtied` MUST be called in case of explicit dirtying.
        root_child0.markDirtyAndPropogate()
        XCTAssertEqual(dirtiedCount, 1)
    }
}
