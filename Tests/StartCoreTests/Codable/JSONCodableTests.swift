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

#if canImport(CoreGraphics)
import CoreGraphics
#endif

class JSONCodableTests: XCTestCase {
    func code<T>(_ value: T, _ encoder: StartJSONEncoder? = nil,  _ decoder: StartJSONDecoder? = nil,
                 file: StaticString = #file, line: UInt = #line) where T: Codable & Equatable {
        let e = encoder ?? StartJSONEncoder()
        let data = try! e.encode(value)
        let d = decoder ?? StartJSONDecoder()
        // print(String(data: data, encoding: .utf8) ?? "NULL")
        let result = try! d.decode(T.self, from: data)
        XCTAssertEqual(result, value, file: file, line: line)
    }

#if canImport(CoreGraphics)
    func testCoreGraphics() {
        code(CGPoint(x: 128, y: 256))
        code(CGPoint(x: 128.256, y: 256.128))

        code(CGRect(x: 12, y: 34, width: 56, height: 78))
        code(CGRect(x: 12.1, y: 34.2, width: 56.3, height: 78.4))

        code(CGSize(width: 9082, height: 1833))
        code(CGSize(width: 9082.8292, height: 1793.1833))
    }

    static var allTests = [
        ("testCoreGraphics", testCoreGraphics),
    ]
#endif
}
