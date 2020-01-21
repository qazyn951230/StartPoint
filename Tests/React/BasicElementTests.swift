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

#if os(iOS)
@testable import StartPoint
import XCTest

class BasicElementTests: ElementTestCase {
    func testCreateOffThread() {
        var element: TestElement?
        runOffThread {
            element = TestElement()
        }
        XCTAssertNotNil(element)
    }

    func testAddElement() {
        let parent = TestElement()
        parent.addChild(parent)
        XCTAssertNil(parent.owner)

        let child = TestElement()
        parent.addChild(child)
        XCTAssertEqual(child.owner, parent as TestElement?)

        let parent2 = TestElement()
        parent2.addChild(child)
        XCTAssertEqual(child.owner, parent2 as TestElement?)
        XCTAssertEqual(parent.children.count, 0)
    }

    func testAddElementNoRetainCycle() {
        weak var parent: TestElement?
        weak var child: TestElement?
        withExtendedLifetime((TestElement(), TestElement())) { (t: (TestElement, TestElement)) in
            t.0.addChild(t.1)
            parent = t.0
            child = t.1
            XCTAssertNotNil(parent)
            XCTAssertNotNil(child)
        }
        XCTAssertNil(parent)
        XCTAssertNil(child)
    }
}
#endif // #if os(iOS)
