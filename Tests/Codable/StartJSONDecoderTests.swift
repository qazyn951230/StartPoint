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

class StartJSONDecoderTests: XCTestCase {
    func decode<T>(_ json: String, decoded: T, file: StaticString = #file,
                   line: UInt = #line) where T: Decodable & Equatable {
        do {
            let data = json.data(using: .utf8) ?? Data()
            let decoder = StartPoint.StartJSONDecoder()
            let value = try decoder.decode(T.self, from: data)
            XCTAssertEqual(value, decoded, file: file, line: line)
        } catch {
            XCTFail("decode failed", file: file, line: line)
        }
    }
    
    func testDecodeNull() {
        decode("null", decoded: nil as Int?)
        decode("null", decoded: nil as Int8?)
        decode("null", decoded: nil as Int16?)
        decode("null", decoded: nil as Int32?)
        decode("null", decoded: nil as Int64?)
        decode("null", decoded: nil as UInt?)
        decode("null", decoded: nil as UInt8?)
        decode("null", decoded: nil as UInt16?)
        decode("null", decoded: nil as UInt32?)
        decode("null", decoded: nil as UInt64?)
        decode("null", decoded: nil as Double?)
        decode("null", decoded: nil as Float?)
        decode("null", decoded: nil as Bool?)
        decode("null", decoded: nil as String?)
        decode("null", decoded: nil as [String]?)
        decode("null", decoded: nil as [String: String]?)
    }

    func testDecodeBool() {
        decode("true", decoded: true)
        decode("false", decoded: false)
        decode("[true, false]", decoded: [true, false] as [Bool])
    }
    
    func testDecodeInt() {
        decode("0", decoded: 0 as Int)
        decode("0", decoded: 0 as Int8)
        decode("0", decoded: 0 as Int16)
        decode("0", decoded: 0 as Int32)
        decode("0", decoded: 0 as Int64)

        decode("\(Int.min)", decoded: Int(Int.min))
        decode("\(Int.max)", decoded: Int(Int.max))
        decode("\(Int8.min)", decoded: Int(Int8.min))
        decode("\(Int8.max)", decoded: Int(Int8.max))
        decode("\(Int16.min)", decoded: Int(Int16.min))
        decode("\(Int16.max)", decoded: Int(Int16.max))
        decode("\(Int32.min)", decoded: Int(Int32.min))
        decode("\(Int32.max)", decoded: Int(Int32.max))
#if arch(x86_64) || arch(arm64)
        decode("\(Int64.min)", decoded: Int(Int64.min))
        decode("\(Int64.max)", decoded: Int(Int64.max))
#endif
        
        decode("\(Int8.min)", decoded: Int8(Int8.min))
        decode("\(Int8.max)", decoded: Int8(Int8.max))

        decode("\(Int8.min)", decoded: Int16(Int8.min))
        decode("\(Int8.max)", decoded: Int16(Int8.max))
        decode("\(Int16.min)", decoded: Int16(Int16.min))
        decode("\(Int16.max)", decoded: Int16(Int16.max))
        
#if arch(i386) || arch(arm)
        decode("\(Int.min)", decoded: Int32(Int.min))
        decode("\(Int.max)", decoded: Int32(Int.max))
#endif
        decode("\(Int8.min)", decoded: Int32(Int8.min))
        decode("\(Int8.max)", decoded: Int32(Int8.max))
        decode("\(Int16.min)", decoded: Int32(Int16.min))
        decode("\(Int16.max)", decoded: Int32(Int16.max))
        decode("\(Int32.min)", decoded: Int32(Int32.min))
        decode("\(Int32.max)", decoded: Int32(Int32.max))

        decode("\(Int.min)", decoded: Int64(Int.min))
        decode("\(Int.max)", decoded: Int64(Int.max))
        decode("\(Int8.min)", decoded: Int64(Int8.min))
        decode("\(Int8.max)", decoded: Int64(Int8.max))
        decode("\(Int16.min)", decoded: Int64(Int16.min))
        decode("\(Int16.max)", decoded: Int64(Int16.max))
        decode("\(Int32.min)", decoded: Int64(Int32.min))
        decode("\(Int32.max)", decoded: Int64(Int32.max))
        decode("\(Int64.min)", decoded: Int64(Int64.min))
        decode("\(Int64.max)", decoded: Int64(Int64.max))
    }
    
    func testDecodeString() {
        decode("\"true\"", decoded: "true")
        decode("\"false\"", decoded: "false")
    }

#if TEST_PERFORMANCE
    func testUnicode() {
        let stream = FileByteStream(path: "/Users/yangnan/Documents/Cpp/rapidjson/bin/data/sample.json")
        let buffer = json_buffer_create(240, 4096)
        let parser = JSONParser(stream: stream, buffer: buffer, options: [])
        XCTAssertNoThrow(try parser.parse())
//        json_buffer_print(buffer)
        json_buffer_free(buffer)
    }

    func testPerformance() {
        let stream = FileByteStream(path: "/Users/yangnan/Documents/Cpp/rapidjson/bin/data/sample.json")
        let buffer = json_buffer_create(240, 4096)
        measure {
            stream.move(offset: 0, seek: .start)
            let parser = JSONParser(stream: stream, buffer: buffer, options: [])
            try? parser.parse()
        }
//        json_buffer_print(buffer)
        json_buffer_free(buffer)
    }
#endif
}
