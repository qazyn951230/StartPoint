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

class ParseTests: XCTestCase {
    func parseTest<T: Equatable>(json: String, expect: T, file: StaticString = #file, line: UInt = #line,
                   method: (JSONParser) throws -> T) {
        json.withCString { pointer in
            let stream = ByteStream.int8(pointer)
            let buffer = json_buffer_create(1, 64)
            let parser = JSONParser(stream: stream, buffer: buffer, options: [])
            do {
                let result = try method(parser)
                XCTAssertEqual(result, expect, file: file, line: line)
            } catch let e {
                XCTAssertTrue(false, e.localizedDescription)
            }
        }
    }

    func testParseTrue() {
        parseTest(json: "true", expect: true) { parser in
            try parser.parseTrue()
            return json_buffer_bool(parser.buffer, 0)
        }
    }

    func testParseFalse() {
        parseTest(json: "false", expect: false) { parser in
            try parser.parseFalse()
            return json_buffer_bool(parser.buffer, 0)
        }
    }

    func testParseNumber() {
        parseTest(json: "0", expect: 0 as UInt32) { parser in
            try parser.parseNumber()
            return json_buffer_uint32(parser.buffer, 0)
        }
        parseTest(json: "123", expect: 123 as UInt32) { parser in
            try parser.parseNumber()
            return json_buffer_uint32(parser.buffer, 0)
        }
        parseTest(json: "2147483648", expect: 2147483648 as UInt32) { parser in
            try parser.parseNumber()
            return json_buffer_uint32(parser.buffer, 0)
        }
        parseTest(json: "4294967295", expect: 4294967295 as UInt32) { parser in
            try parser.parseNumber()
            return json_buffer_uint32(parser.buffer, 0)
        }

        parseTest(json: "-123", expect: -123 as Int32) { parser in
            try parser.parseNumber()
            return json_buffer_int32(parser.buffer, 0)
        }
        parseTest(json: "-2147483648", expect: -2147483648 as Int32) { parser in
            try parser.parseNumber()
            return json_buffer_int32(parser.buffer, 0)
        }

        parseTest(json: "4294967296", expect: 4294967296 as UInt64) { parser in
            try parser.parseNumber()
            return json_buffer_uint64(parser.buffer, 0)
        }
        parseTest(json: "18446744073709551615", expect: 18446744073709551615 as UInt64) { parser in
            try parser.parseNumber()
            return json_buffer_uint64(parser.buffer, 0)
        }

        parseTest(json: "-2147483649", expect: -2147483649 as Int64) { parser in
            try parser.parseNumber()
            return json_buffer_int64(parser.buffer, 0)
        }
        parseTest(json: "-9223372036854775808", expect: -9223372036854775808 as Int64) { parser in
            try parser.parseNumber()
            return json_buffer_int64(parser.buffer, 0)
        }
    }

    func testParseDouble() {
        func parse(_ json: String, _ value: Double, file: StaticString = #file, line: UInt = #line) {
            parseTest(json: json, expect: value, file: file, line: line) { parser in
                try parser.parseNumber()
                return json_buffer_double(parser.buffer, 0)
            }
        }
        parse("0.0", 0.0)
        parse("-0.0", 0.0)
        parse("1.0", 1.0)
        parse("-1.0", -1.0)
        parse("1.5", 1.5)
        parse("-1.5", -1.5)
        parse("3.1416", 3.1416)
        parse("0e100", 0.0)
        parse("1E10", 1E10)
        parse("1e10", 1e10)
        parse("1E+10", 1E+10)
        parse("1E-10", 1E-10)
        parse("-1E10", -1E10)
        parse("-1e10", -1e10)
        parse("-1E+10", -1E+10)
        parse("-1E-10", -1E-10)
        parse("1.234E+10", 1.234E+10)
        parse("1.234E-10", 1.234E-10)
        parse("1.79769e+308", 1.79769e+308)
//        parse("2.22507e-308", 2.22507e-308)
        parse("-1.79769e+308", -1.79769e+308)
//        parse("-2.22507e-308", -2.22507e-308)

        parse("0.999999999999999944488848768742172978818416595458984375", 1.0)
    }
}
