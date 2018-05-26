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
import UIKit
import CoreGraphics

class ManualLayoutTests: XCTestCase {
    func layout(size: CGSize? = nil) -> Layout {
        return Layout(view: UIView(frame: .zero), parentSize: size)
    }

    func layout(width: CGFloat, height: CGFloat) -> Layout {
        return layout(size: CGSize(width: width, height: height))
    }

    func testBasicLayout() {
        let object = layout()
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 0)
        XCTAssertEqual(frame.height, 0)
    }

    func testBasicLayout2() {
        let object = layout(width: 100, height: 100)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 100)
        XCTAssertEqual(frame.height, 100)
    }

    func testBasicLayout3() {
        let object = layout(width: 100, height: 100).left(10)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 10)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 90)
        XCTAssertEqual(frame.height, 100)

        let object1 = layout(width: 100, height: 100).left(0.1)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 10)
        XCTAssertEqual(frame1.minY, 0)
        XCTAssertEqual(frame1.width, 90)
        XCTAssertEqual(frame1.height, 100)
    }

    func testBasicLayout4() {
        let object = layout(width: 100, height: 100).right(10)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 90)
        XCTAssertEqual(frame.height, 100)

        let object1 = layout(width: 100, height: 100).right(0.1)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 0)
        XCTAssertEqual(frame1.minY, 0)
        XCTAssertEqual(frame1.width, 90)
        XCTAssertEqual(frame1.height, 100)
    }

    func testBasicLayout5() {
        let object = layout(width: 100, height: 100).top(10)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 10)
        XCTAssertEqual(frame.width, 100)
        XCTAssertEqual(frame.height, 90)

        let object1 = layout(width: 100, height: 100).top(0.1)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 0)
        XCTAssertEqual(frame1.minY, 10)
        XCTAssertEqual(frame1.width, 100)
        XCTAssertEqual(frame1.height, 90)
    }

    func testBasicLayout6() {
        let object = layout(width: 100, height: 100).bottom(10)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 100)
        XCTAssertEqual(frame.height, 90)

        let object1 = layout(width: 100, height: 100).bottom(0.1)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 0)
        XCTAssertEqual(frame1.minY, 0)
        XCTAssertEqual(frame1.width, 100)
        XCTAssertEqual(frame1.height, 90)
    }

    func testBasicLayout7() {
        let object = layout(width: 100, height: 100).left(10).right(10)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 10)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 80)
        XCTAssertEqual(frame.height, 100)

        let object1 = layout(width: 100, height: 100).top(10).bottom(10)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 0)
        XCTAssertEqual(frame1.minY, 10)
        XCTAssertEqual(frame1.width, 100)
        XCTAssertEqual(frame1.height, 80)

        let object2 = layout(width: 100, height: 100).left(10).right(10)
            .top(10).bottom(10)
        object2.apply()
        let frame2: CGRect = object2.view.frame
        XCTAssertEqual(frame2.minX, 10)
        XCTAssertEqual(frame2.minY, 10)
        XCTAssertEqual(frame2.width, 80)
        XCTAssertEqual(frame2.height, 80)
    }

    func testRelativeLeftLayout() {
        let other = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        let object = layout(width: 100, height: 100).left(10, to: other, edge: .left)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 40)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 60)
        XCTAssertEqual(frame.height, 100)

        let object1 = layout(width: 100, height: 100).left(10, to: other, edge: .right)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 90)
        XCTAssertEqual(frame1.minY, 0)
        XCTAssertEqual(frame1.width, 10)
        XCTAssertEqual(frame1.height, 100)

        let object2 = layout(width: 100, height: 100).left(10, from: other, edge: .left)
        object2.apply()
        let frame2: CGRect = object2.view.frame
        XCTAssertEqual(frame2.minX, 60)
        XCTAssertEqual(frame2.minY, 0)
        XCTAssertEqual(frame2.width, 40)
        XCTAssertEqual(frame2.height, 100)

        let object3 = layout(width: 100, height: 100).left(10, from: other, edge: .right)
        object3.apply()
        let frame3: CGRect = object3.view.frame
        XCTAssertEqual(frame3.minX, 110)
        XCTAssertEqual(frame3.minY, 0)
        XCTAssertEqual(frame3.width, 0)
        XCTAssertEqual(frame3.height, 100)
    }

    func testRelativeRightLayout() {
        let other = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        let object = layout(width: 100, height: 100).right(10, to: other, edge: .left)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 40)
        XCTAssertEqual(frame.height, 100)

        let object1 = layout(width: 100, height: 100).right(10, to: other, edge: .right)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 0)
        XCTAssertEqual(frame1.minY, 0)
        XCTAssertEqual(frame1.width, 90)
        XCTAssertEqual(frame1.height, 100)

        let object2 = layout(width: 100, height: 100).right(10, from: other, edge: .left)
        object2.apply()
        let frame2: CGRect = object2.view.frame
        XCTAssertEqual(frame2.minX, 0)
        XCTAssertEqual(frame2.minY, 0)
        XCTAssertEqual(frame2.width, 60)
        XCTAssertEqual(frame2.height, 100)

        let object3 = layout(width: 100, height: 100).right(10, from: other, edge: .right)
        object3.apply()
        let frame3: CGRect = object3.view.frame
        XCTAssertEqual(frame3.minX, 0)
        XCTAssertEqual(frame3.minY, 0)
        XCTAssertEqual(frame3.width, 110)
        XCTAssertEqual(frame3.height, 100)
    }

    func testRelativeTopLayout() {
        let other = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        let object = layout(width: 100, height: 100).top(10, to: other, edge: .top)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 40)
        XCTAssertEqual(frame.width, 100)
        XCTAssertEqual(frame.height, 60)

        let object1 = layout(width: 100, height: 100).top(10, to: other, edge: .bottom)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 0)
        XCTAssertEqual(frame1.minY, 90)
        XCTAssertEqual(frame1.width, 100)
        XCTAssertEqual(frame1.height, 10)

        let object2 = layout(width: 100, height: 100).top(10, from: other, edge: .top)
        object2.apply()
        let frame2: CGRect = object2.view.frame
        XCTAssertEqual(frame2.minX, 0)
        XCTAssertEqual(frame2.minY, 60)
        XCTAssertEqual(frame2.width, 100)
        XCTAssertEqual(frame2.height, 40)

        let object3 = layout(width: 100, height: 100).top(10, from: other, edge: .bottom)
        object3.apply()
        let frame3: CGRect = object3.view.frame
        XCTAssertEqual(frame3.minX, 0)
        XCTAssertEqual(frame3.minY, 110)
        XCTAssertEqual(frame3.width, 100)
        XCTAssertEqual(frame3.height, 0)
    }

    func testRelativeBottomLayout() {
        let other = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        let object = layout(width: 100, height: 100).bottom(10, to: other, edge: .top)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 100)
        XCTAssertEqual(frame.height, 40)

        let object1 = layout(width: 100, height: 100).bottom(10, to: other, edge: .bottom)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 0)
        XCTAssertEqual(frame1.minY, 0)
        XCTAssertEqual(frame1.width, 100)
        XCTAssertEqual(frame1.height, 90)

        let object2 = layout(width: 100, height: 100).bottom(10, from: other, edge: .top)
        object2.apply()
        let frame2: CGRect = object2.view.frame
        XCTAssertEqual(frame2.minX, 0)
        XCTAssertEqual(frame2.minY, 0)
        XCTAssertEqual(frame2.width, 100)
        XCTAssertEqual(frame2.height, 60)

        let object3 = layout(width: 100, height: 100).bottom(10, from: other, edge: .bottom)
        object3.apply()
        let frame3: CGRect = object3.view.frame
        XCTAssertEqual(frame3.minX, 0)
        XCTAssertEqual(frame3.minY, 0)
        XCTAssertEqual(frame3.width, 100)
        XCTAssertEqual(frame3.height, 110)
    }

    func testRelativeLayout() {
        let other = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        let object = layout(width: 100, height: 100)
            .left(10, to: other, edge: .left)
            .right(10, to: other, edge: .right)
            .top(10, to: other, edge: .top)
            .bottom(10, to: other, edge: .bottom)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 40)
        XCTAssertEqual(frame.minY, 40)
        XCTAssertEqual(frame.width, 50)
        XCTAssertEqual(frame.height, 50)

        let object1 = layout(width: 100, height: 100)
            .left(10, from: other, edge: .left)
            .right(10, from: other, edge: .right)
            .top(10, from: other, edge: .top)
            .bottom(10, from: other, edge: .bottom)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 60)
        XCTAssertEqual(frame1.minY, 60)
        XCTAssertEqual(frame1.width, 50)
        XCTAssertEqual(frame1.height, 50)

        let object2 = layout(width: 100, height: 100)
            .left(10, to: other, edge: .left)
            .right(10, from: other, edge: .right)
            .top(10, to: other, edge: .top)
            .bottom(10, from: other, edge: .bottom)
        object2.apply()
        let frame2: CGRect = object2.view.frame
        XCTAssertEqual(frame2.minX, 40)
        XCTAssertEqual(frame2.minY, 40)
        XCTAssertEqual(frame2.width, 70)
        XCTAssertEqual(frame2.height, 70)

        let object3 = layout(width: 100, height: 100)
            .left(10, from: other, edge: .left)
            .right(10, to: other, edge: .right)
            .top(10, from: other, edge: .top)
            .bottom(10, to: other, edge: .bottom)
        object3.apply()
        let frame3: CGRect = object3.view.frame
        XCTAssertEqual(frame3.minX, 60)
        XCTAssertEqual(frame3.minY, 60)
        XCTAssertEqual(frame3.width, 30)
        XCTAssertEqual(frame3.height, 30)
    }

    func testWidthLayout() {
        let object = layout(width: 100, height: 100)
            .width(50)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 50)
        XCTAssertEqual(frame.height, 100)

        let object1 = layout(width: 100, height: 100)
            .width(0.5)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 0)
        XCTAssertEqual(frame1.minY, 0)
        XCTAssertEqual(frame1.width, 50)
        XCTAssertEqual(frame1.height, 100)

        let object2 = layout(width: 100, height: 100)
            .width(50).left(10)
        object2.apply()
        let frame2: CGRect = object2.view.frame
        XCTAssertEqual(frame2.minX, 10)
        XCTAssertEqual(frame2.minY, 0)
        XCTAssertEqual(frame2.width, 50)
        XCTAssertEqual(frame2.height, 100)

        let object3 = layout(width: 100, height: 100)
            .width(50).right(10)
        object3.apply()
        let frame3: CGRect = object3.view.frame
        XCTAssertEqual(frame3.minX, 40)
        XCTAssertEqual(frame3.minY, 0)
        XCTAssertEqual(frame3.width, 50)
        XCTAssertEqual(frame3.height, 100)
    }

    func testHeightLayout() {
        let object = layout(width: 100, height: 100)
            .height(50)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 100)
        XCTAssertEqual(frame.height, 50)

        let object1 = layout(width: 100, height: 100)
            .height(0.5)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 0)
        XCTAssertEqual(frame1.minY, 0)
        XCTAssertEqual(frame1.width, 100)
        XCTAssertEqual(frame1.height, 50)

        let object2 = layout(width: 100, height: 100)
            .height(50).top(10)
        object2.apply()
        let frame2: CGRect = object2.view.frame
        XCTAssertEqual(frame2.minX, 0)
        XCTAssertEqual(frame2.minY, 10)
        XCTAssertEqual(frame2.width, 100)
        XCTAssertEqual(frame2.height, 50)

        let object3 = layout(width: 100, height: 100)
            .height(50).bottom(10)
        object3.apply()
        let frame3: CGRect = object3.view.frame
        XCTAssertEqual(frame3.minX, 0)
        XCTAssertEqual(frame3.minY, 40)
        XCTAssertEqual(frame3.width, 100)
        XCTAssertEqual(frame3.height, 50)
    }

    func testRelativeWidthLayout() {
        let other = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        let object = layout(width: 100, height: 100)
            .width(50, view: other, edge: .width)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 100)
        XCTAssertEqual(frame.height, 100)

        let object1 = layout(width: 100, height: 100)
            .width(0.5, view: other, edge: .height)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 0)
        XCTAssertEqual(frame1.minY, 0)
        XCTAssertEqual(frame1.width, 25)
        XCTAssertEqual(frame1.height, 100)

        let object2 = layout(width: 100, height: 100)
            .width(50, view: other, edge: .width).left(10)
        object2.apply()
        let frame2: CGRect = object2.view.frame
        XCTAssertEqual(frame2.minX, 10)
        XCTAssertEqual(frame2.minY, 0)
        XCTAssertEqual(frame2.width, 100)
        XCTAssertEqual(frame2.height, 100)

        let object3 = layout(width: 100, height: 100)
            .width(0.5, view: other, edge: .height).right(10)
        object3.apply()
        let frame3: CGRect = object3.view.frame
        XCTAssertEqual(frame3.minX, 65)
        XCTAssertEqual(frame3.minY, 0)
        XCTAssertEqual(frame3.width, 25)
        XCTAssertEqual(frame3.height, 100)
    }

    func testRelativeHeightLayout() {
        let other = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        let object = layout(width: 100, height: 100)
            .height(50, view: other, edge: .height)
        object.apply()
        let frame: CGRect = object.view.frame
        XCTAssertEqual(frame.minX, 0)
        XCTAssertEqual(frame.minY, 0)
        XCTAssertEqual(frame.width, 100)
        XCTAssertEqual(frame.height, 100)

        let object1 = layout(width: 100, height: 100)
            .height(0.5, view: other, edge: .width)
        object1.apply()
        let frame1: CGRect = object1.view.frame
        XCTAssertEqual(frame1.minX, 0)
        XCTAssertEqual(frame1.minY, 0)
        XCTAssertEqual(frame1.width, 100)
        XCTAssertEqual(frame1.height, 25)

        let object2 = layout(width: 100, height: 100)
            .height(50, view: other, edge: .height).top(10)
        object2.apply()
        let frame2: CGRect = object2.view.frame
        XCTAssertEqual(frame2.minX, 0)
        XCTAssertEqual(frame2.minY, 10)
        XCTAssertEqual(frame2.width, 100)
        XCTAssertEqual(frame2.height, 100)

        let object3 = layout(width: 100, height: 100)
            .height(0.5, view: other, edge: .width).bottom(10)
        object3.apply()
        let frame3: CGRect = object3.view.frame
        XCTAssertEqual(frame3.minX, 0)
        XCTAssertEqual(frame3.minY, 65)
        XCTAssertEqual(frame3.width, 100)
        XCTAssertEqual(frame3.height, 25)
    }
}
