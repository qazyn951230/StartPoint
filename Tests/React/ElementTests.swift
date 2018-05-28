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

class ElementTests: ElementTestCase {
    func createElement() -> Element<UIView> {
        let element = Element<UIView>()
        element.layout.size(width: 100, height: 100)
        return element
    }

    func testLayoutSubelement() {
        let element = Element<UIView>()
        for _ in 0..<10 {
            element.addChild(createElement())
        }
        element.layout()
        let view = element.buildView()
        for item in view.subviews {
            XCTAssertEqual(item.frame.size, CGSize(width: 100, height: 100))
        }
    }

    func testAsyncLayoutSubelement() {
        let element = Element<UIView>()
        for _ in 0..<10 {
            element.addChild(createElement())
        }
        runOffThread {
            element.layout()
        }
        let view = element.buildView()
        for item in view.subviews {
            XCTAssertEqual(item.frame.size, CGSize(width: 100, height: 100))
        }
    }

    func testReLayoutElement() {
        let element = Element<UIView>()
        element.layout(width: 100, height: 100)
        XCTAssertEqual(element._frame, Rect(x: 0, y: 0, width: 100, height: 100))
        let view = element.buildView()
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 100, height: 100))

        element.layout(width: 200, height: 200)
        XCTAssertEqual(element._frame, Rect(x: 0, y: 0, width: 200, height: 200))
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 200, height: 200))
    }

    func testAsyncReLayoutElement() {
        let element = Element<UIView>()
        runOffThread {
            element.layout(width: 100, height: 100)
        }
        XCTAssertEqual(element._frame, Rect(x: 0, y: 0, width: 100, height: 100))
        let view = element.buildView()
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 100, height: 100))

        runOffThread {
            element.layout(width: 200, height: 200)
        }
        XCTAssertEqual(element._frame, Rect(x: 0, y: 0, width: 200, height: 200))
        let predicate = NSPredicate { (object, _) in
            guard let view = object as? UIView else {
                return false
            }
            return (view.frame == CGRect(x: 0, y: 0, width: 200, height: 200))
        }
        expectation(for: predicate, evaluatedWith: view)
        waitForExpectations(timeout: 1)
    }

    func testReLayoutSubelement() {
        let element = Element<UIView>()
        for _ in 0..<10 {
            element.addChild(createElement())
        }
        element.layout()
        let view = element.buildView()
        for item in view.subviews {
            XCTAssertEqual(item.frame.size, CGSize(width: 100, height: 100))
        }
        element.children.forEach { sub in
            sub.layout.size(float: 20)
        }
        element.layout()
        for item in view.subviews {
            XCTAssertEqual(item.frame.size, CGSize(width: 20, height: 20))
        }
    }

    func testAsyncReLayoutSubelement() {
        let element = Element<UIView>()
        for _ in 0..<10 {
            element.addChild(createElement())
        }
        runOffThread {
            element.layout()
        }
        let view = element.buildView()
        for item in view.subviews {
            XCTAssertEqual(item.frame.size, CGSize(width: 100, height: 100))
        }
        element.children.forEach { sub in
            sub.layout.size(float: 20)
        }
        runOffThread {
            element.layout()
        }
        let predicate = NSPredicate { (object, _) in
            guard let view = object as? UIView else {
                return false
            }
            for item in view.subviews {
                let flag = item.frame.size == CGSize(width: 20, height: 20)
                if !flag {
                    return false
                }
            }
            return true
        }
        expectation(for: predicate, evaluatedWith: view)
        waitForExpectations(timeout: 1)
    }
}
