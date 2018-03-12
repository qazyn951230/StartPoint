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

class ManualLayoutTests: XCTestCase {
    func layout(container size: CGSize? = nil) -> Layout {
        return Layout(for: UIView(frame: .zero), container: size)
    }

    func testBasicLayout() {
        let root = layout()
        XCTAssertEqual(root.computedX, 0)
        XCTAssertEqual(root.computedY, 0)
        XCTAssertEqual(root.computedWidth, 0)
        XCTAssertEqual(root.computedHeight, 0)

        _ = root.left(10).right(10).top(10).bottom(10)
        XCTAssertEqual(root.computedX, 10)
        XCTAssertEqual(root.computedY, 10)
        XCTAssertEqual(root.computedWidth, 0)
        XCTAssertEqual(root.computedHeight, 0)

        let root1 = layout(container: CGSize(width: 100, height: 100))
            .left(10).right(10).top(10).bottom(10)
        XCTAssertEqual(root1.computedX, 10)
        XCTAssertEqual(root1.computedY, 10)
        XCTAssertEqual(root1.computedWidth, 80)
        XCTAssertEqual(root1.computedHeight, 80)

        let root2 = layout()
            .left(10).top(10).width(80).height(80)
        XCTAssertEqual(root2.computedX, 10)
        XCTAssertEqual(root2.computedY, 10)
        XCTAssertEqual(root2.computedWidth, 80)
        XCTAssertEqual(root2.computedHeight, 80)

        let root3 = layout(container: CGSize(width: 100, height: 100))
            .right().top().width(40).height(40)
        XCTAssertEqual(root3.computedX, 60)
        XCTAssertEqual(root3.computedY, 0)
        XCTAssertEqual(root3.computedWidth, 40)
        XCTAssertEqual(root3.computedHeight, 40)
    }

    func testRowLayout() {
        let first = UIView(frame: .zero)
        Layout(for: first).width(50).height(50).apply()
        let second = UIView(frame: .zero)
        Layout(for: second, containerWidth: 200).right().width(50).height(50).apply()
        let third = UIView(frame: .zero)
        Layout(for: third, containerWidth: 200).left(to: first, edge: .right)
            .width(0, to: second, edge: .left).height(50).apply()

        XCTAssertEqual(first.frame.origin.x, 0)
        XCTAssertEqual(first.frame.origin.y, 0)
        XCTAssertEqual(first.frame.size.width, 50)
        XCTAssertEqual(first.frame.size.height, 50)

        XCTAssertEqual(second.frame.origin.x, 150)
        XCTAssertEqual(second.frame.origin.y, 0)
        XCTAssertEqual(second.frame.size.width, 50)
        XCTAssertEqual(second.frame.size.height, 50)

        XCTAssertEqual(third.frame.origin.x, 50)
        XCTAssertEqual(third.frame.origin.y, 0)
        XCTAssertEqual(third.frame.size.width, 100)
        XCTAssertEqual(third.frame.size.height, 50)
    }
}
