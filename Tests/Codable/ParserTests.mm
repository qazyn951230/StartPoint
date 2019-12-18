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

#import <XCTest/XCTest.h>
#import <limits> // for std::numeric_limits<int64_t>::min()
#import "Parser.hpp"

#define testParseString(data, result) (XCTAssertTrue(parseString(data) == std::string{result}))

#define testParseArray(data, result) (XCTAssertTrue(parseArray(data) == (result)))

#define testParseObject(data, result) (XCTAssertTrue(parseObject(data) == (result)))

using json = StartPoint::JSON<>;
using array = json::array_t;
using map = json::object_t;
using namespace StartPoint;

@interface ParserTests : XCTestCase

@end

@implementation ParserTests

json parse(const char* data) {
    ByteStreams stream{reinterpret_cast<const uint8_t*>(data), 0};
    json result;
    Parser parser{result, std::move(stream)};
    parser.parse();
    return result;
}

int32_t parseInt32(const char* data) {
    auto value = parse(data);
    return value.int32();
}

int64_t parseInt64(const char* data) {
    auto value = parse(data);
    return value.int64();
}

uint32_t parseUint32(const char* data) {
    auto value = parse(data);
    return value.uint32();
}

uint64_t parseUint64(const char* data) {
    auto value = parse(data);
    return value.uint64();
}

double parseDouble(const char* data) {
    auto value = parse(data);
    return value.float64();
}

std::string parseString(const char* data) {
    auto value = parse(data);
    return std::move(*value.asString());
}

array parseArray(const char* data) {
    auto value = parse(data);
    return std::move(*value.asArray());
}

map parseObject(const char* data) {
    auto value = parse(data);
    return std::move(*value.asObject());
}

- (void)testParseTrue {
    auto value = parse("true");
    XCTAssertEqual(value.type(), JSONTypeTrue);
    XCTAssertEqual(value.boolean(), YES);
}

- (void)testParseFalse {
    auto value = parse("false");
    XCTAssertEqual(value.type(), JSONTypeFalse);
    XCTAssertEqual(value.boolean(), NO);
}

- (void)testParseInt32Simple {
    auto value = parse("-1");
    XCTAssertEqual(value.type(), JSONTypeInt);
    XCTAssertEqual(value.int32(), -1);
}

- (void)testParseUint32Simple {
    auto value = parse("0");
    XCTAssertEqual(value.type(), JSONTypeUint);
    XCTAssertEqual(value.uint32(), 0u);
}

- (void)testParseInt64Simple {
    auto value = parse("-2147483649"); // Int32.min = -2147483648
    XCTAssertEqual(value.type(), JSONTypeInt64);
    XCTAssertEqual(value.int64(), -2147483649ll);
}

- (void)testParseUint64Simple {
    auto value = parse("4294967296"); // UInt32.max = 4294967295
    XCTAssertEqual(value.type(), JSONTypeUint64);
    XCTAssertEqual(value.uint64(), 4294967296llu);
}

- (void)testParseDoubleSimple {
    auto value = parse("0.1");
    XCTAssertEqual(value.type(), JSONTypeDouble);
    XCTAssertEqual(value.float64(), 0.1);
}

// Int32.min = -2147483648
// Int32.max = 2147483647
- (void)testParseInt32 {
    XCTAssertEqual(parseInt32("-1"), -1);
    XCTAssertEqual(parseInt32("-2147483648"), -2147483648);
}

// UInt32.min = 0
// UInt32.max = 4294967295
- (void)testParseUint32 {
    XCTAssertEqual(parseUint32("0"), 0u);
    XCTAssertEqual(parseUint32("4294967295"), 4294967295u);
    // Int32.max + 1
    XCTAssertEqual(parseUint32("2147483648"), 2147483648u);
}

// Int64.min = -9223372036854775808
// Int64.max = 9223372036854775807
- (void)testParseInt64 {
    // Stupid Xcode 11 says "integer literal is too large to be represented in
    //  a signed integer type, interpreting as unsigned" ???
    // XCTAssertEqual(parseInt64("-9223372036854775808"), -9223372036854775808ll);
    XCTAssertEqual(parseInt64("-9223372036854775808"), std::numeric_limits<int64_t>::min());
    // Int32.min - 1
    XCTAssertEqual(parseInt64("-2147483649"), -2147483649ll);
}

// UInt64.min = 0
// UInt64.max = 18446744073709551615
- (void)testParseUint64 {
    XCTAssertEqual(parseUint64("18446744073709551615"), 18446744073709551615llu);
    // UInt32.max + 1
    XCTAssertEqual(parseUint64("4294967296"), 4294967296llu);
    // Int64.max + 1
    XCTAssertEqual(parseUint64("9223372036854775808"), 9223372036854775808llu);
}

- (void)testParseDouble {
    XCTAssertEqual(parseDouble("0.0"), 0.0);
    XCTAssertEqual(parseDouble("-0.0"), -0.0);
    XCTAssertEqual(parseDouble("0e100"), 0.0);
    XCTAssertEqual(parseDouble("1.0"), 1.0);
    XCTAssertEqual(parseDouble("-1.0"), -1.0);
    XCTAssertEqual(parseDouble("1.5"), 1.5);
    XCTAssertEqual(parseDouble("-1.5"), -1.5);

    XCTAssertEqual(parseDouble("1E10"), 1E10);
    XCTAssertEqual(parseDouble("1e10"), 1e10);
    XCTAssertEqual(parseDouble("1E+10"), 1E+10);
    XCTAssertEqual(parseDouble("1e+10"), 1e+10);
    XCTAssertEqual(parseDouble("-1E10"), -1E10);
    XCTAssertEqual(parseDouble("-1e10"), -1e10);
    XCTAssertEqual(parseDouble("-1E+10"), -1E+10);
    XCTAssertEqual(parseDouble("-1e+10"), -1e+10);
    XCTAssertEqual(parseDouble("1.234E+10"), 1.234E+10);
    XCTAssertEqual(parseDouble("1.234e-10"), 1.234e-10);

    XCTAssertEqual(parseDouble("3.1415926535897931"), 3.1415926535897931); // Double.pi
    XCTAssertEqual(parseDouble("1.7976931348623157E+308"), 1.7976931348623157E+308); // Double.greatestFiniteMagnitude
    XCTAssertEqual(parseDouble("0.00000000000000022204460492503131"), 0.00000000000000022204460492503131); // Double.ulpOfOne
    XCTAssertEqual(parseDouble("4.9406564584124654E-324"), 4.9406564584124654E-324); // Double.leastNonzeroMagnitude
    XCTAssertEqual(parseDouble("2.2250738585072014E-308"), 2.2250738585072014E-308); // Double.leastNormalMagnitude
}

- (void)testParseString {
    testParseString(R"("")", "");
    testParseString(R"("Hello")", "Hello");
    testParseString(R"("Hello\nWorld")", "Hello\nWorld");
    testParseString(R"("\"\\\/\b\f\n\r\t")", "\"\\/\b\f\n\r\t");
    testParseString(R"("\u0001")", "\x01");
    testParseString(R"("\u000a")", "\n");
    testParseString(R"("\u000e")", "\x0e");
    testParseString(R"("\u00b0")", "°");
    testParseString(R"("\u0c00")", "ఀ");
    testParseString(R"("\ud000")", "퀀");
    testParseString(R"("\ud80c\udc60")", u8"\U00013060"); // https://unicode-table.com/en/13060/
    testParseString(R"("𓁠")", "𓁠");
}

- (void)testParseArray {
    testParseArray(R"([])", array{});
    testParseArray(R"([1])", array{json{1u}});
    testParseArray(R"([-1, []])", (array{json{-1}, json{JSONTypeArray}}));
}

- (void)testParseObject {
    testParseObject(R"({})", map{});
    testParseObject(R"({"1": 1})", (map{{"1", json{1u}}}));
    testParseObject(R"({"11": "234", "null": "false"})", (map{{"11", json{std::string{"234"}}}, {"null", json{std::string{"false"}}}}));
}

//- (void)testParsingSamplePerformance {
//    auto bundle = [NSBundle bundleWithIdentifier:@"com.undev.StartPointTests"];
//    auto path = [bundle URLForResource:@"sample" withExtension:@"json"];
//    auto data = [NSData dataWithContentsOfURL:path options:0 error:nil];
//    [self measureBlock:^{
//        ByteStreams stream{reinterpret_cast<const uint8_t*>(data.bytes), 0};
//        json result;
//        Parser parser{result, std::move(stream)};
//        parser.parse();
//    }];
//}

@end
