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

// Generated from YGPersistenceTest.cpp
class PersistenceTests: FlexTestCase {

    // Generated from test: cloning_shared_root
    func testCloningSharedRoot() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(50)
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root.insert(root_child1, at: 1)
        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 75)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 75)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 25)

        let root2: FlexLayout = root.copy()
        root2.width(StyleValue.length(100))

        XCTAssertEqual(root2.children.count, 2)
        // The children should have referential equality at this point.
        XCTAssertEqual(root2.child(at: 0), root_child0)
        XCTAssertEqual(root2.child(at: 1), root_child1)

        root2.calculate(direction: Direction.ltr)

        XCTAssertEqual(root2.children.count, 2)
        // Relayout with no changed input should result in referential equality.
        XCTAssertEqual(root2.child(at: 0), root_child0)
        XCTAssertEqual(root2.child(at: 1), root_child1)

        root2.width(StyleValue.length(150))
        root2.height(StyleValue.length(200))
        root2.calculate(direction: Direction.ltr)

        XCTAssertEqual(root2.children.count, 2)
        // Relayout with changed input should result in cloned children.
        let root2_child0: FlexLayout = root2.child(at: 0)!
        let root2_child1: FlexLayout = root2.child(at: 1)!
        XCTAssertNotEqual(root2_child0, root_child0)
        XCTAssertNotEqual(root2_child1, root_child1)

        // Everything in the root should remain unchanged.
        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 75)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 75)
        XCTAssertEqual(root_child1.box.width, 100)
        XCTAssertEqual(root_child1.box.height, 25)

        // The new root now has new layout.
        XCTAssertEqual(root2.box.left, 0)
        XCTAssertEqual(root2.box.top, 0)
        XCTAssertEqual(root2.box.width, 150)
        XCTAssertEqual(root2.box.height, 200)

        XCTAssertEqual(root2_child0.box.left, 0)
        XCTAssertEqual(root2_child0.box.top, 0)
        XCTAssertEqual(root2_child0.box.width, 150)
        XCTAssertEqual(root2_child0.box.height, 125)

        XCTAssertEqual(root2_child1.box.left, 0)
        XCTAssertEqual(root2_child1.box.top, 125)
        XCTAssertEqual(root2_child1.box.width, 150)
        XCTAssertEqual(root2_child1.box.height, 75)
    }

    // Generated from test: mutating_children_of_a_clone_clones
    func testMutatingChildrenOfACloneClones() {
        let root = FlexLayout()
        XCTAssertEqual(root.children.count, 0)

        let root2: FlexLayout = root.copy()
        XCTAssertEqual(root2.children.count, 0)

        let root2_child0 = FlexLayout()
        root2.insert(root2_child0, at: 0)

        XCTAssertEqual(root.children.count, 0)
        XCTAssertEqual(root2.children.count, 1)

        let root3: FlexLayout = root2.copy()
        XCTAssertEqual(root2.children.count, 1)
        XCTAssertEqual(root3.children.count, 1)
        XCTAssertEqual(root3.child(at: 0), root2.child(at: 0))

        let root3_child1 = FlexLayout()
        root3.insert(root3_child1, at: 1)
        XCTAssertEqual(root2.children.count, 1)
        XCTAssertEqual(root3.children.count, 2)
        XCTAssertEqual(root3.child(at: 1), root3_child1)
        XCTAssertNotEqual(root3.child(at: 0), root2.child(at: 0))

        let root4: FlexLayout = root3.copy()
        XCTAssertEqual(root4.child(at: 1), root3_child1)

        root4.remove(root3_child1)
        XCTAssertEqual(root3.children.count, 2)
        XCTAssertEqual(root4.children.count, 1)
        XCTAssertNotEqual(root4.child(at: 0), root3.child(at: 0))
    }

    // Generated from test: cloning_two_levels
    func testCloningTwoLevels() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(15)
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(1)
        root.insert(root_child1, at: 1)

        let root_child1_0 = FlexLayout()
        root_child1_0.flexBasis(10)
        root_child1_0.flexGrow(1)
        root_child1.insert(root_child1_0, at: 0)

        let root_child1_1 = FlexLayout()
        root_child1_1.flexBasis(25)
        root_child1.insert(root_child1_1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.height, 40)
        XCTAssertEqual(root_child1.box.height, 60)
        XCTAssertEqual(root_child1_0.box.height, 35)
        XCTAssertEqual(root_child1_1.box.height, 25)

        let root2_child0: FlexLayout = root_child0.copy()
        let root2_child1: FlexLayout = root_child1.copy()
        let root2: FlexLayout = root.copy()

        root2_child0.flexGrow(0)
        root2_child0.flexBasis(40)

        root2.removeAll()
        root2.insert(root2_child0, at: 0)
        root2.insert(root2_child1, at: 1)
        XCTAssertEqual(root2.children.count, 2)

        root2.calculate(direction: Direction.ltr)

        // Original root is unchanged
        XCTAssertEqual(root_child0.box.height, 40)
        XCTAssertEqual(root_child1.box.height, 60)
        XCTAssertEqual(root_child1_0.box.height, 35)
        XCTAssertEqual(root_child1_1.box.height, 25)

        // New root has new layout at the top
        XCTAssertEqual(root2_child0.box.height, 40)
        XCTAssertEqual(root2_child1.box.height, 60)

        // The deeper children are untouched.
        XCTAssertEqual(root2_child1.child(at: 0)!, root_child1_0)
        XCTAssertEqual(root2_child1.child(at: 1)!, root_child1_1)
    }
}
