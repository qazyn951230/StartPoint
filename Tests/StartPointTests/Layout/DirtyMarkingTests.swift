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

// Generated from YGDirtyMarkingTest.cpp
class DirtyMarkingTests: FlexTestCase {

    // Generated from test: dirty_propagation
    func testDirtyPropagation() {
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

        root_child0.width(StyleValue.length(20))

        XCTAssertTrue(root_child0.dirty)
        XCTAssertFalse(root_child1.dirty)
        XCTAssertTrue(root.dirty)

        root.calculate(direction: Direction.ltr)

        XCTAssertFalse(root_child0.dirty)
        XCTAssertFalse(root_child1.dirty)
        XCTAssertFalse(root.dirty)
    }

    // Generated from test: dirty_propagation_only_if_prop_changed
    func testDirtyPropagationOnlyIfPropChanged() {
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

        root_child0.width(StyleValue.length(50))

        XCTAssertFalse(root_child0.dirty)
        XCTAssertFalse(root_child1.dirty)
        XCTAssertFalse(root.dirty)
    }

    // Generated from test: dirty_mark_all_children_as_dirty_when_display_changes
    func testDirtyMarkAllChildrenAsDirtyWhenDisplayChanges() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.height(StyleValue.length(100))

        let child0 = FlexLayout()
        child0.flexGrow(1)
        let child1 = FlexLayout()
        child1.flexGrow(1)

        let child1_child0 = FlexLayout()
        let child1_child0_child0 = FlexLayout()
        child1_child0_child0.width(StyleValue.length(8))
        child1_child0_child0.height(StyleValue.length(16))

        child1_child0.insert(child1_child0_child0, at: 0)

        child1.insert(child1_child0, at: 0)
        root.insert(child0, at: 0)
        root.insert(child1, at: 0)

        child0.display(Display.flex)
        child1.display(Display.none)
        root.calculate(direction: Direction.ltr)
        XCTAssertEqual(child1_child0_child0.box.width, 0)
        XCTAssertEqual(child1_child0_child0.box.height, 0)

        child0.display(Display.none)
        child1.display(Display.flex)
        root.calculate(direction: Direction.ltr)
        XCTAssertEqual(child1_child0_child0.box.width, 8)
        XCTAssertEqual(child1_child0_child0.box.height, 16)

        child0.display(Display.flex)
        child1.display(Display.none)
        root.calculate(direction: Direction.ltr)
        XCTAssertEqual(child1_child0_child0.box.width, 0)
        XCTAssertEqual(child1_child0_child0.box.height, 0)

        child0.display(Display.none)
        child1.display(Display.flex)
        root.calculate(direction: Direction.ltr)
        XCTAssertEqual(child1_child0_child0.box.width, 8)
        XCTAssertEqual(child1_child0_child0.box.height, 16)
    }

    // Generated from test: dirty_node_only_if_children_are_actually_removed
    func testDirtyNodeOnlyIfChildrenAreActuallyRemoved() {
        let root = FlexLayout()
        root.alignItems(AlignItems.flexStart)
        root.width(StyleValue.length(50))
        root.height(StyleValue.length(50))

        let child0 = FlexLayout()
        child0.width(StyleValue.length(50))
        child0.height(StyleValue.length(25))
        root.insert(child0, at: 0)

        root.calculate(direction: Direction.ltr)

        let child1 = FlexLayout()
        root.remove(child1)
        XCTAssertFalse(root.dirty)

        root.remove(child0)
        XCTAssertTrue(root.dirty)
    }

    // Generated from test: dirty_node_only_if_undefined_values_gets_set_to_undefined
    func testDirtyNodeOnlyIfUndefinedValuesGetsSetToUndefined() {
        let root = FlexLayout()
        root.width(StyleValue.length(50))
        root.height(StyleValue.length(50))
        root.minWidth(StyleValue.length(Double.nan))

        root.calculate(direction: Direction.ltr)

        XCTAssertFalse(root.dirty)

        root.minWidth(StyleValue.length(Double.nan))

        XCTAssertFalse(root.dirty)
    }
}
