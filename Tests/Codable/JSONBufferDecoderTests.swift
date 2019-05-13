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

extension String: CodingKey {
    public var intValue: Int? { return nil }
    public var stringValue: String { return self }
    
    public init?(intValue: Int) {
        return nil
    }

    public init?(stringValue: String) {
        self = stringValue
    }
}

extension Int: CodingKey {
    public var intValue: Int? { return self }
    public var stringValue: String { return "" }
    
    public init?(intValue: Int) {
        self = intValue
    }
    
    public init?(stringValue: String) {
        return nil
    }
}

//class JSONBufferDecoderTests: XCTestCase {
//    var buffer: JSONBufferRef = json_buffer_create(5, 256)
//    
//    func decode(_ json: String) {
//        json.withCString { pointer -> Void in
//            let stream = ByteStream.int8(pointer)
//            let parser = JSONParser(stream: stream, buffer: buffer, options: [])
//            try? parser.parse()
//        }
//    }
//    
//    override func tearDown() {
//        json_buffer_free(buffer)
//        buffer = json_buffer_create(5, 256)
//    }
//
//    func testDecodeKeyPathSingle() {
//        let json = """
//{
//  "a": {
//    "b": {
//      "c": {
//        "d": "hello"
//      }
//    }
//  }
//}
//"""
//        decode(json)
//        let decoder = JSONBufferDecoder(buffer: buffer)
//        var keyPath: [CodingKey] = []
//        keyPath.append("a")
//        keyPath.append("b")
//        keyPath.append("c")
//        keyPath.append("d")
//        let container = try! decoder.singleValueContainer(keyPath: keyPath)
//        let result = try! container.decode(String.self)
//        XCTAssertEqual(result, "hello")
//    }
//    
//    func testDecodeKeyPathSingle2() {
//        let json = """
//{
//  "a": [
//    {
//      "b": "hello"
//    },
//    {
//      "c": {
//        "d": "hello"
//      }
//    }
//  ]
//}
//"""
//        decode(json)
//        let decoder = JSONBufferDecoder(buffer: buffer)
//        var keyPath: [CodingKey] = []
//        keyPath.append("a")
//        keyPath.append(1)
//        keyPath.append("c")
//        keyPath.append("d")
//        let container = try! decoder.singleValueContainer(keyPath: keyPath)
//        let result = try! container.decode(String.self)
//        XCTAssertEqual(result, "hello")
//    }
//}
