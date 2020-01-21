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

class JSONEncoderTests: XCTestCase {
    func encode<T>(_ value: T, _ encoder: StartJSONEncoder? = nil) -> String where T: Encodable {
        let encoder = encoder ?? StartJSONEncoder()
        let data = try! encoder.encode(value)
        return String(data: data, encoding: .utf8)!
    }

    func testEncodeInt() {
        XCTAssertEqual(encode(Int.min), "\(Int.min)")
        XCTAssertEqual(encode(Int.max), "\(Int.max)")
        XCTAssertEqual(encode(Int8.min), "\(Int8.min)")
        XCTAssertEqual(encode(Int8.max), "\(Int8.max)")
        XCTAssertEqual(encode(Int16.min), "\(Int16.min)")
        XCTAssertEqual(encode(Int16.max), "\(Int16.max)")
        XCTAssertEqual(encode(Int32.min), "\(Int32.min)")
        XCTAssertEqual(encode(Int32.max), "\(Int32.max)")
        XCTAssertEqual(encode(Int64.min), "\(Int64.min)")
        XCTAssertEqual(encode(Int64.max), "\(Int64.max)")
        XCTAssertEqual(encode(UInt32.min), "\(UInt32.min)")
        XCTAssertEqual(encode(UInt32.max), "\(UInt32.max)")
        XCTAssertEqual(encode(UInt64.min), "\(UInt64.min)")
        XCTAssertEqual(encode(UInt64.max), "\(UInt64.max)")
    }

    func testEncodeArray() {
        XCTAssertEqual(encode([] as [String]), "[]")
        XCTAssertEqual(encode([1]), "[1]")
        XCTAssertEqual(encode([1, 2]), "[1,2]")
        XCTAssertEqual(encode([[1, 3], [2, 4]] as [[Int]]), "[[1,3],[2,4]]")
        XCTAssertEqual(encode(["[1, 3], [2, 4]] as [[Int]"]), "[\"[1, 3], [2, 4]] as [[Int]\"]")
    }

    // SJEncoder.encode<T>(_:), T => Foobar
    // SJEncoder.container<Foobar.CodingKeys>(keyedBy:)
    // SJEKeyedContainer.encode<Int>(_:forKey:), key => CodingKeys(stringValue: "a", intValue: nil)
    // SJEKeyedContainer.encode<T>(_:forKey:), T => Swift.Array<Swift.Int>, key => CodingKeys(stringValue: "b", intValue: nil)
    // SJEncoder.encode<T>(_:), T => Swift.Array<Swift.Int>
    // SJEncoder.unkeyedContainer()
    // SJEUnkeyedContainer.encode<T>(_:), T => Swift.Int
    // SJEncoder.singleValueContainer()
    // SJESingleContainer.encode<Int>(_:)
    // SJEUnkeyedContainer.encode<T>(_:), T => Swift.Int
    // SJEncoder.singleValueContainer()
    // SJESingleContainer.encode<Int>(_:)
    func testFoobar() {
        struct Foobar: Codable {
            let a = 12
            let b = [3, 4]
        }

        let encoder = StartJSONEncoder()
        encoder.outputFormatting = [JSONEncoder.OutputFormatting.sortedKeys]
        XCTAssertEqual(encode(Foobar(), encoder), "{\"a\":12,\"b\":[3,4]}")
    }

    static var allTests = [
        ("testEncodeInt", testEncodeInt),
        ("testEncodeArray", testEncodeArray),
        ("testFoobar", testFoobar),
    ]
}
