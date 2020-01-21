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

class JSONDecoderTests: XCTestCase {
    func decode<T>(_ value: String, as type: T.Type, decoder: StartJSONDecoder? = nil) -> T where T: Decodable {
        let decoder = decoder ?? StartJSONDecoder()
        return try! decoder.decode(T.self, from: value.data(using: .utf8)!)
    }

    func decodeError<T>(_ value: String, as type: T.Type, decoder: StartJSONDecoder? = nil) throws where T: Decodable {
        let decoder = decoder ?? StartJSONDecoder()
        _ = try decoder.decode(T.self, from: value.data(using: .utf8)!)
    }

    func testDecodeInt() {
        XCTAssertEqual(decode("1", as: Int.self), 1)
    }

    func testDecodeArray() {
        XCTAssertEqual(decode("[1, 3]", as: [Int].self), [1, 3])
    }

    func testDecodeNullArray() {
        XCTAssertEqual(decode("[null, null]", as: [Int?].self), [nil, nil])
    }

    func testDecodeMixedArray() {
        XCTAssertEqual(decode("[null, 9]", as: [Int?].self), [nil, 9])
    }

    func testDecodeCustomArray() {
        struct Foobar: Decodable, Equatable {
            let array: [Int?]

            init(_ array: [Int?]) {
                self.array = array
            }

            init(from decoder: Decoder) throws {
                var container = try decoder.unkeyedContainer()
                var array: [Int?] = []
                while !container.isAtEnd {
                    let value = try container.decodeIfPresent(Int.self)
                    array.append(value)
                }
                self.array = array
            }
        }

        XCTAssertEqual(decode("[null, 9]", as: Foobar.self), Foobar([nil, 9]))
    }

    func testDecodeArrayCodingPath() {
        do {
            try decodeError("[1, \"1\"]", as: [Int].self)
        } catch let DecodingError.typeMismatch(_, context) {
            let result = context.codingPath.map { $0.intValue ?? -1 }
            XCTAssertEqual(result, [1])
        } catch {
            XCTAssertTrue(false)
        }
    }

    static var allTests = [
        ("testDecodeInt", testDecodeInt),
        ("testDecodeArray", testDecodeArray),
        ("testDecodeNullArray", testDecodeNullArray),
        ("testDecodeMixedArray", testDecodeMixedArray),
        ("testDecodeCustomArray", testDecodeCustomArray),
        ("testDecodeArrayCodingPath", testDecodeArrayCodingPath),
    ]
}
