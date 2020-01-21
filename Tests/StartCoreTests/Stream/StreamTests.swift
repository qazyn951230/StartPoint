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

//class StreamTests: XCTestCase {
//    func testDataStream() {
//        let value = "foobar➕😁".data(using: .utf8)!
//        let array: [UInt8] =  value.withUnsafeBytes { (raw: UnsafeRawBufferPointer) in
//            guard let pointer = raw.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
//                return []
//            }
//            let stream = ByteStream.uint8(pointer)
//            var array: [UInt8] = []
//            while stream.peek() > 0 {
//                array.append(stream.peek())
//                stream.move()
//            }
//            return array
//        }
//        let result: [UInt8] = [102, 111, 111, 98, 97, 114, 226, 158, 149, 240, 159, 152, 129]
//        XCTAssertEqual(array, result)
//    }
//
//    func testStringStream() {
//        let value = "foobar➕😁"
//        let array: [UInt8] =  value.withCString { pointer in
//            let stream = ByteStream.int8(pointer)
//            var array: [UInt8] = []
//            while stream.peek() > 0 {
//                array.append(stream.peek())
//                stream.move()
//            }
//            return array
//        }
//        let result: [UInt8] = [102, 111, 111, 98, 97, 114, 226, 158, 149, 240, 159, 152, 129]
//        XCTAssertEqual(array, result)
//    }
//}
