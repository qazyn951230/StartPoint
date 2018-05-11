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

// Generated from YGTreeMutationTest.cpp
class TreeMutationTests: FlexTestCase {
    // Generated from test: set_children_adds_children_to_parent
    func testSetChildrenAddsChildrenToParent() {
        let root = FlexLayout()
        let root_child0 = FlexLayout()
        let root_child1 = FlexLayout()

        root.replaceAll([root_child0, root_child1])

        let children: [FlexLayout] = root.children
        let expectedChildren: [FlexLayout] = [root_child0, root_child1]
        XCTAssertEqual(expectedChildren, children)

        let owners: [FlexLayout] = [root_child0.parent!, root_child1.parent!]
        let expectedOwners: [FlexLayout] = [root, root]
        XCTAssertEqual(expectedOwners, owners)
    }

    // Generated from test: set_children_to_empty_removes_old_children
    func testSetChildrenToEmptyRemovesOldChildren() {
        let root = FlexLayout()
        let root_child0 = FlexLayout()
        let root_child1 = FlexLayout()

        root.replaceAll([root_child0, root_child1])
        root.replaceAll([])

        let children: [FlexLayout] = root.children
        let expectedChildren: [FlexLayout] = []
        XCTAssertEqual(expectedChildren, children)

        let owners: [FlexLayout?] = [root_child0.parent, root_child1.parent]
        let expectedOwners: [FlexLayout?] = [nil, nil]
        XCTAssertEqual(expectedOwners, owners)
    }

    // Generated from test: set_children_replaces_non_common_children
    func testSetChildrenReplacesNonCommonChildren() {
        let root = FlexLayout()
        let root_child0 = FlexLayout()
        let root_child1 = FlexLayout()

        root.replaceAll([root_child0, root_child1])

        let root_child2 = FlexLayout()
        let root_child3 = FlexLayout()

        root.replaceAll([root_child2, root_child3])

        let children: [FlexLayout] = root.children
        let expectedChildren: [FlexLayout] = [root_child2, root_child3]
        XCTAssertEqual(expectedChildren, children)

        let owners: [FlexLayout?] = [root_child0.parent, root_child1.parent]
        let expectedOwners: [FlexLayout?] = [nil, nil]
        XCTAssertEqual(expectedOwners, owners)
    }

    // Generated from test: set_children_keeps_and_reorders_common_children
    func testSetChildrenKeepsAndReordersCommonChildren() {
        let root = FlexLayout()
        let root_child0 = FlexLayout()
        let root_child1 = FlexLayout()
        let root_child2 = FlexLayout()

        root.replaceAll([root_child0, root_child1, root_child2])

        let root_child3 = FlexLayout()

        root.replaceAll([root_child2, root_child1, root_child3])

        let children: [FlexLayout] = root.children
        let expectedChildren: [FlexLayout] = [root_child2, root_child1, root_child3]
        XCTAssertEqual(expectedChildren, children)

        let owners: [FlexLayout?] = [root_child0.parent, root_child1.parent,
                                     root_child2.parent, root_child3.parent]
        let expectedOwners: [FlexLayout?] = [nil, root, root, root]
        XCTAssertEqual(expectedOwners, owners)
    }
}
