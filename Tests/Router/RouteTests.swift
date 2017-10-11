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

import XCTest
@testable import StartPoint

class RouteTests: XCTestCase {
    func testBasicMatch() {
        let root: Route<Int> = Route.root(domain: nil)
        let page: Route<Int> = Route.create("product/type/id", value: 1)
        root.append(page)

        XCTAssertTrue(root.match(path: "product/type/id"))
        XCTAssertTrue(root.match(path: "/product/type/id"))
        XCTAssertTrue(root.match(path: "product/type/id/"))
        XCTAssertFalse(root.match(path: "/product/type/idd"))
        XCTAssertFalse(root.match(path: "product/type"))
        XCTAssertFalse(root.match(path: "//type/id"))
        XCTAssertFalse(root.match(path: "/product/id"))
    }

    func testPlaceholderMatch() {
        let root: Route<Int> = Route.root(domain: nil)
        let page: Route<Int> = Route.create("product/:type/:id", value: 1)
        root.append(page)

        XCTAssertTrue(root.match(path: "product/new/1"))
        // TODO: :id => number
        XCTAssertTrue(root.match(path: "/product/foo/bar"))
    }
}
