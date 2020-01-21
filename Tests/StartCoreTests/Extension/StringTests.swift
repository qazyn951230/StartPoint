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

@testable import StartCore
import XCTest

class StringTests: XCTestCase {
    func testSplit() {
        let string = "1234"
        let result = string.chunked(size: 0)
        XCTAssertEqual(result, [] as [Substring])

        let result1 = string.chunked(size: 1)
        XCTAssertEqual(result1, ["1", "2", "3", "4"] as [Substring])

        let result2 = string.chunked(size: 2)
        XCTAssertEqual(result2, ["12", "34"] as [Substring])

        let result3 = string.chunked(size: 3)
        XCTAssertEqual(result3, ["123", "4"] as [Substring])

        let result4 = string.chunked(size: 4)
        XCTAssertEqual(result4, ["1234"] as [Substring])

        let result5 = string.chunked(size: 5)
        XCTAssertEqual(result5, ["1234"] as [Substring])
    }

    func testEmptySplit() {
        let string = String.empty
        for i in 0..<6 {
            let result = string.chunked(size: i)
            XCTAssertEqual(result, [] as [Substring], "size: \(i)")
        }
    }

    func testEditDistance() {
        var from = "abc"
        var to = "bd"
        XCTAssertEqual(from.editDistance(other: to, replace: true), 2)
        XCTAssertEqual(from.editDistance(other: to, replace: false), 3)

        from = "cafe"
        to = "coffee"
        XCTAssertEqual(from.editDistance(other: to, replace: true), 3)
        XCTAssertEqual(from.editDistance(other: to, replace: false), 4)
    }
}
