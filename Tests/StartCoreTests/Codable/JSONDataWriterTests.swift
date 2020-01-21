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

extension JSONDataWriter {
    var text: String {
        String(bytesNoCopy: UnsafeMutableRawPointer(mutating: byte_array_data(data)),
            length: byte_array_size(data), encoding: .utf8, freeWhenDone: false)!
    }
}

class JSONDataWriterTests: XCTestCase {
    func testWriteArray() {
        let array = [1, 0, -10]
        let writer = JSONDataWriter()
        writer.startArray()
        for item in array {
            writer.writePrefix()
            writer.write(item)
            writer.writeSuffix()
        }
        writer.endArray()
        XCTAssertEqual(writer.text, "[1,0,-10]")
    }

    func testWriteArrayNestArray() {
        let array = [1, 0, -10]
        let writer = JSONDataWriter()
        writer.startArray()
        for _ in array {
            writer.writePrefix()
            writer.startArray()
            for item in array {
                writer.writePrefix()
                writer.write(item)
                writer.writeSuffix()
            }
            writer.endArray()
            writer.writeSuffix()
        }
        writer.endArray()
        XCTAssertEqual(writer.text, "[[1,0,-10],[1,0,-10],[1,0,-10]]")
    }

    func testWriteObject() {
        let map = ["A": 1, "B": 2, "C": 3]
        let writer = JSONDataWriter()
        writer.startObject()
        // map is unordered
        for key in ["A", "B", "C"] {
            writer.writePrefix()
            writer.write(key)
            writer.writeInfix()
            writer.write(map[key]!)
            writer.writeSuffix()
        }
        writer.endObject()
        XCTAssertEqual(writer.text, "{\"A\":1,\"B\":2,\"C\":3}")
    }

    static var allTests = [
        ("testWriteArray", testWriteArray),
        ("testWriteArrayNestArray", testWriteArrayNestArray),
        ("testWriteObject", testWriteObject),
    ]
}
