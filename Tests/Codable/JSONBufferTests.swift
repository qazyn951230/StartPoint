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

private func append(_ buffer: JSONBufferRef, string: String, count: Int? = nil) {
    string.withCString { (pointer: UnsafePointer<Int8>) in
        let _count = count ?? strlen(pointer)
        let index = json_buffer_start_string(buffer)
        json_buffer_append_string(buffer, pointer, _count)
        json_buffer_end_string(buffer, index)
    }
}

private func string(_ buffer: JSONBufferRef, index: Int) -> String {
    var count: Int = 0
    let bytes = json_buffer_string(buffer, index, &count)
    if count < 1 {
        return ""
    }
    let data = Data(bytesNoCopy: bytes, count: count, deallocator: .none)
    return String(data: data, encoding: .utf8) ?? ""
}

private func keyIndex(_ buffer: JSONBufferRef, _ object: Int, key: String) -> Int? {
    var index = 0
    if json_buffer_key_index_check(buffer, object, key, &index) {
        return index
    }
    return nil
}

private func key(_ buffer: JSONBufferRef, _ object: Int, _ index: Int) -> String {
    var count = 0
    if let value  = json_buffer_key_index(buffer, object, index, &count) {
        let bytes =  UnsafeMutableRawPointer(mutating: value)
        let data = Data(bytesNoCopy: bytes, count: count, deallocator: .none)
        return String(data: data, encoding: .utf8) ?? ""
    }
    return ""
}

class JSONBufferTests: XCTestCase {
    var buffer: JSONBufferRef = json_buffer_create(5, 256)

    override func tearDown() {
        json_buffer_free(buffer)
        buffer = json_buffer_create(5, 256)
    }

    func testAddInt32() {
        json_buffer_append_int32(buffer, 0)
        json_buffer_append_int32(buffer, Int32.min)
        json_buffer_append_int32(buffer, Int32.max)

        XCTAssertEqual(json_buffer_count(buffer), 3)
        XCTAssertEqual(json_buffer_int32(buffer, 0), 0)
        XCTAssertEqual(json_buffer_int32(buffer, 1), Int32.min)
        XCTAssertEqual(json_buffer_int32(buffer, 2), Int32.max)
    }

    func testAddInt64() {
        json_buffer_append_int64(buffer, 0)
        json_buffer_append_int64(buffer, Int64.min)
        json_buffer_append_int64(buffer, Int64.max)

        XCTAssertEqual(json_buffer_count(buffer), 3)
        XCTAssertEqual(json_buffer_int64(buffer, 0), 0)
        XCTAssertEqual(json_buffer_int64(buffer, 1), Int64.min)
        XCTAssertEqual(json_buffer_int64(buffer, 2), Int64.max)
    }
    
    func testAddUInt32() {
        json_buffer_append_uint32(buffer, 0)
        json_buffer_append_uint32(buffer, UInt32.min)
        json_buffer_append_uint32(buffer, UInt32.max)
        
        XCTAssertEqual(json_buffer_count(buffer), 3)
        XCTAssertEqual(json_buffer_uint32(buffer, 0), 0)
        XCTAssertEqual(json_buffer_uint32(buffer, 1), UInt32.min)
        XCTAssertEqual(json_buffer_uint32(buffer, 2), UInt32.max)
    }
    
    func testAddUInt64() {
        json_buffer_append_uint64(buffer, 0)
        json_buffer_append_uint64(buffer, UInt64.min)
        json_buffer_append_uint64(buffer, UInt64.max)
        
        XCTAssertEqual(json_buffer_count(buffer), 3)
        XCTAssertEqual(json_buffer_uint64(buffer, 0), 0)
        XCTAssertEqual(json_buffer_uint64(buffer, 1), UInt64.min)
        XCTAssertEqual(json_buffer_uint64(buffer, 2), UInt64.max)
    }

    func testAddString() {
        append(buffer, string: "")
        append(buffer, string: "\"\"")
        append(buffer, string: "\"Hello\\nWorld\"")
        append(buffer, string: "\"\u{0000}\"", count: 3)

        XCTAssertEqual(string(buffer, index: 0), "")
        XCTAssertEqual(string(buffer, index: 1), "\"\"")
        XCTAssertEqual(string(buffer, index: 2), "\"Hello\\nWorld\"")
        XCTAssertEqual(string(buffer, index: 3), "\"\u{0000}\"")
    }

    func testEmptyArray() {
        let raw = json_buffer_start_array(buffer)
        json_buffer_end_array(buffer, raw, 0)
        let array = json_buffer_array(buffer, 0)
        defer {
            json_array_free(array)
        }
        
        XCTAssertEqual(json_array_count(array), 0)
    }

    func testArray() {
        let raw = json_buffer_start_array(buffer)
        json_buffer_append_int32(buffer, Int32.min)
        json_buffer_append_int64(buffer, Int64.min)
        json_buffer_end_array(buffer, raw, 2)
        let array = json_buffer_array(buffer, 0)
        defer {
            json_array_free(array)
        }
        let index = json_array_index(array) + 1

        XCTAssertEqual(json_array_count(array), 2)
        XCTAssertEqual(json_buffer_int32(buffer, index), Int32.min)
        XCTAssertEqual(json_buffer_int64(buffer, index + 1), Int64.min)
    }

//    func testEmptyObject() {
//        var index = JSONIndex()
//        json_buffer_start_object(buffer, &index)
//        json_buffer_end_object(buffer, &index, 0)
//        let object = json_buffer_object(buffer, 0)
//        defer {
//            json_object_free(object)
//        }
//
//        XCTAssertEqual(json_object_count(object), 0)
//    }
//
//    func testObject() {
//        var index = JSONIndex()
//        _ = json_buffer_start_object(buffer, &index)
//        append(buffer, string: "1")
//        json_buffer_append_int32(buffer, Int32.min)
//        append(buffer, string: "2")
//        json_buffer_append_int64(buffer, Int64.min)
//        json_buffer_end_object(buffer, &index, 2)
//        let object = json_buffer_object(buffer, 0)
//        defer {
//            json_object_free(object)
//        }
//        let index = json_object_index(object)
//
//        XCTAssertEqual(json_object_count(object), 2)
//        XCTAssertEqual(keyIndex(buffer, index, key: "1"), index + 1)
//        XCTAssertEqual(keyIndex(buffer, index, key:  "2"), index + 3)
//        XCTAssertEqual(string(buffer, index: index + 1), "1")
//        XCTAssertEqual(json_buffer_int32(buffer, index + 2), Int32.min)
//        XCTAssertEqual(string(buffer, index: index + 3), "2")
//        XCTAssertEqual(json_buffer_int64(buffer, index + 4), Int64.min)
//    }
//
//    func testObjectIndexCheck() {
//        _ = json_buffer_start_object(buffer)
//        append(buffer, string: "1") // 1
//        json_buffer_append_int32(buffer, Int32.min)
//        json_buffer_append_int64(buffer, Int64.min)
//        append(buffer, string: "2") // 2
//        let i = json_buffer_start_array(buffer)
//        json_buffer_append_uint64(buffer, UInt64.min)
//        json_buffer_append_uint32(buffer, UInt32.min)
//        json_buffer_end_array(buffer, i, 2)
//        json_buffer_end_object(buffer, 0, 2)
//        let object = json_buffer_object(buffer, 0)
//        defer {
//            json_object_free(object)
//        }
//        let index = json_object_index(object)
//
//        XCTAssertEqual(json_object_count(object), 2)
////        XCTAssertEqual(keyIndex(buffer, index, key: "1"), index + 1)
////        XCTAssertEqual(keyIndex(buffer, index, key:  "2"), index + 4)
//        XCTAssertEqual(string(buffer, index: index + 1), "1")
//        XCTAssertEqual(string(buffer, index: index + 4), "2")
//        XCTAssertEqual(key(buffer, index, 0), "1")
//        XCTAssertEqual(key(buffer, index, 1), "2")
//    }
//
//    func testCopy() {
//        json_buffer_append_int64(buffer, -12345)
//        json_buffer_append_int64(buffer, 12345)
//        append(buffer, string: "\"\"")
//        append(buffer, string: "\"Hello\\nWorld\"")
//        let other = json_buffer_copy(buffer, 1, 2)
//        defer {
//            json_buffer_free(other)
//        }
//
//        XCTAssertEqual(json_buffer_count(buffer), 4)
//        XCTAssertEqual(json_buffer_int64(buffer, 0), -12345)
//        XCTAssertEqual(json_buffer_int64(buffer, 1), 12345)
//        XCTAssertEqual(string(buffer, index: 2), "\"\"")
//        XCTAssertEqual(string(buffer, index: 3), "\"Hello\\nWorld\"")
//
//        XCTAssertEqual(json_buffer_count(other), 2)
//        XCTAssertEqual(json_buffer_int64(other, 0), 12345)
//        XCTAssertEqual(string(other, index: 1), "\"\"")
//    }
//
//    func testCopyArray() {
//        json_buffer_start_array(buffer)
//        json_buffer_append_int64(buffer, -12345)
//        json_buffer_append_int64(buffer, 12345)
//        json_buffer_end_array(buffer, 0, 2)
//        let array = json_buffer_array(buffer, 0)
//        let other = json_buffer_copy_array(buffer, array)
//        json_array_free(array)
//        defer {
//            json_buffer_free(other)
//        }
//
//        XCTAssertEqual(json_buffer_count(other), 3)
//        XCTAssertEqual(json_buffer_int64(other, 1), -12345)
//        XCTAssertEqual(json_buffer_int64(other, 2), 12345)
//    }
//
//    func testCopyObject() {
//        json_buffer_start_object(buffer)
//        append(buffer, string: "1")
//        json_buffer_append_int64(buffer, -12345)
//        append(buffer, string: "2")
//        json_buffer_append_int64(buffer, 12345)
//        json_buffer_end_object(buffer, 0, 4)
//        let object = json_buffer_object(buffer, 0)
//        let other = json_buffer_copy_object(buffer, object)
//        json_object_free(object)
//        defer {
//            json_buffer_free(other)
//        }
//
//        XCTAssertEqual(json_buffer_count(other), 5)
//        XCTAssertEqual(keyIndex(other, 0, key: "1"), 1)
//        XCTAssertEqual(keyIndex(other, 0, key:  "2"), 3)
//        XCTAssertEqual(string(other, index: 1), "1")
//        XCTAssertEqual(json_buffer_int64(other, 2), -12345)
//        XCTAssertEqual(string(other, index: 3), "2")
//        XCTAssertEqual(json_buffer_int64(other, 4), 12345)
//    }
}
