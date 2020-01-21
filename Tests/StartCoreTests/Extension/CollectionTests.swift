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

class CollectionTests: XCTestCase {
    func testSplit() {
        let array = [1, 2, 3, 4]
        let result = array.chunked(size: 0)
        XCTAssertEqual(result, [] as [ArraySlice<Int>])

        let result1 = array.chunked(size: 1)
        XCTAssertEqual(result1, [[1], [2], [3], [4]] as [ArraySlice<Int>])

        let result2 = array.chunked(size: 2)
        XCTAssertEqual(result2, [[1, 2], [3, 4]] as [ArraySlice<Int>])

        let result3 = array.chunked(size: 3)
        XCTAssertEqual(result3, [[1, 2, 3], [4]] as [ArraySlice<Int>])

        let result4 = array.chunked(size: 4)
        XCTAssertEqual(result4, [[1, 2, 3, 4]] as [ArraySlice<Int>])

        let result5 = array.chunked(size: 5)
        XCTAssertEqual(result5, [[1, 2, 3, 4]] as [ArraySlice<Int>])
    }

    func testEmptyArraySplit() {
        let array = [] as [Int]
        for i in 0..<6 {
            let result = array.chunked(size: i)
            XCTAssertEqual(result, [] as [ArraySlice<Int>], "size: \(i)")
        }
    }

    func testEditDistance() {
        var from = [1, 2, 3]
        var to = [2, 4]
        XCTAssertEqual(from.editDistance(to: to, replace: true), 2)
        XCTAssertEqual(from.editDistance(to: to, replace: false), 3)

        from = [1, 2, 3, 4] // cafe
        to = [1, 5, 3, 3, 4, 4] // coffee
        XCTAssertEqual(from.editDistance(to: to, replace: true), 3)
        XCTAssertEqual(from.editDistance(to: to, replace: false), 4)
    }
}
