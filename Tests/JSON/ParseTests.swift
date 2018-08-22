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
    func parseTest(json: String, expect: JSON, file: StaticString = #file, line: UInt = #line,
                   method: (JSONParser<DataStream>) throws -> JSON) {
        let data = DataStream(data: json.data(using: .utf8)!)
        let parser: JSONParser<DataStream> = JSONParser(stream: data)
        do {
            let result = try method(parser)
            XCTAssertEqual(result, expect, file: file, line: line)
        } catch let e {
            XCTAssertTrue(false, e.localizedDescription)
        }
    }

    func testParseTrue() {
        parseTest(json: "true", expect: JSONBool(true)) { parser in
            try parser.parseTrue()
        }
    }

    func testParseFalse() {
        parseTest(json: "false", expect: JSONBool(false)) { parser in
            try parser.parseFalse()
        }
    }

    func testParseNumber() {
        parseTest(json: "0", expect: JSONUInt(0)) { parser in
            try parser.parseNumber()
        }
        parseTest(json: "123", expect: JSONUInt(123)) { parser in
            try parser.parseNumber()
        }
        parseTest(json: "2147483648", expect: JSONUInt(2147483648)) { parser in
            try parser.parseNumber()
        }
        parseTest(json: "4294967295", expect: JSONUInt(4294967295)) { parser in
            try parser.parseNumber()
        }

        parseTest(json: "-123", expect: JSONInt(-123)) { parser in
            try parser.parseNumber()
        }
        parseTest(json: "-2147483648", expect: JSONInt(-2147483648)) { parser in
            try parser.parseNumber()
        }

        parseTest(json: "4294967296", expect: JSONUInt64(4294967296)) { parser in
            try parser.parseNumber()
        }
        parseTest(json: "18446744073709551615", expect: JSONUInt64(18446744073709551615)) { parser in
            try parser.parseNumber()
        }

        parseTest(json: "-2147483649", expect: JSONInt64(-2147483649)) { parser in
            try parser.parseNumber()
        }
        parseTest(json: "-9223372036854775808", expect: JSONInt64(-9223372036854775808)) { parser in
            try parser.parseNumber()
        }
    }

    func testParseDouble() {
        func parse(_ json: String, _ value: Double, file: StaticString = #file, line: UInt = #line) {
            parseTest(json: json, expect: JSONDouble(value), file: file, line: line) { parser in
                try parser.parseNumber()
            }
        }
        parse("0.0", 0.0)
        parse("-0.0", 0.0)
        parse("1.0", 1.0)
        parse("-1.0", -1.0)
        parse("1.5", 1.5)
        parse("-1.5", -1.5)
        parse("3.1416", 3.1416)
//        parse("0e100", 0.0)
//        parse("1E10", 1E10)
//        parse("1e10", 1e10)
//        parse("1E+10", 1E+10)
//        parse("1E-10", 1E-10)
//        parse("-1E10", -1E10)
//        parse("-1e10", -1e10)
//        parse("-1E+10", -1E+10)
//        parse("-1E-10", -1E-10)
//        parse("1.234E+10", 1.234E+10)
//        parse("1.234E-10", 1.234E-10)
//        parse("1.79769e+308", 1.79769e+308)
//        parse("2.22507e-308", 2.22507e-308)
//        parse("-1.79769e+308", -1.79769e+308)
//        parse("-2.22507e-308", -2.22507e-308)

//        parse("0.999999999999999944488848768742172978818416595458984375", 1.0)
    }
}
