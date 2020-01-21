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
#import <limits>
#import "JSON.hpp"

using json_t = StartPoint::JSON<>;
using array_t = json_t::array_t;
using object_t = json_t::object_t;
using namespace StartPoint;

@interface JSONTests : XCTestCase

@end

@implementation JSONTests

- (void)testMove {
    auto foo = [&]() {
        auto first = json_t{JSONTypeArray};
        XCTAssertTrue(first.isArray());
        auto second = std::move(first);
        XCTAssertTrue(first.isNull());
        XCTAssertTrue(second.isArray());
    };
    auto foo2 = [&]() {
        auto first = json_t{JSONTypeArray};
        first.appendValue(1);
        first.appendValue(JSONTypeArray);
        XCTAssertTrue(first.isArray());
        XCTAssertEqual(first.asArray()->size(), 2u);
        auto second = std::move(first);
        XCTAssertTrue(first.isNull());
        XCTAssertTrue(second.isArray());
        XCTAssertEqual(second.asArray()->size(), 2u);
    };
    XCTAssertNoThrow(foo());
    XCTAssertNoThrow(foo2());
}

- (void)testDealloc {
    XCTAssertNoThrow((std::vector<json_t>{json_t{JSONTypeArray}}));
    auto first = json_t{JSONTypeArray};
    XCTAssertNoThrow((std::vector<json_t>{std::move(first)}));
    auto foo = [&]() {
        auto list = std::vector<json_t>{};
        list.emplace_back(JSONTypeArray);
    };
    XCTAssertNoThrow(foo());
    auto foo2 = [&]() {
        auto list = std::vector<json_t>{};
        auto second = json_t{JSONTypeArray};
        list.push_back(std::move(second));
    };
    XCTAssertNoThrow(foo2());
    auto foo3 = [&]() {
        auto list = std::vector<json_t>{};
        auto third = json_t{JSONTypeArray};
        list.push_back(third);
    };
    XCTAssertNoThrow(foo3());
}

- (void)testInt32 {
    auto min = std::numeric_limits<int32_t>::min();
    XCTAssertEqual(json_t{min}.int32(), min);

    auto max = std::numeric_limits<int32_t>::max();
    XCTAssertEqual(json_t{max}.int32(), max);
}

- (void)testUint32 {
    auto min = std::numeric_limits<uint32_t>::min();
    XCTAssertEqual(json_t{min}.uint32(), min);

    auto max = std::numeric_limits<uint32_t>::max();
    XCTAssertEqual(json_t{max}.uint32(), max);
}

- (void)testInt64 {
    auto min = std::numeric_limits<int64_t>::min();
    XCTAssertEqual(json_t{min}.int64(), min);

    auto max = std::numeric_limits<int64_t>::max();
    XCTAssertEqual(json_t{max}.int64(), max);
}

- (void)testUint64 {
    auto min = std::numeric_limits<uint64_t>::min();
    XCTAssertEqual(json_t{min}.uint64(), min);

    auto max = std::numeric_limits<uint64_t>::max();
    XCTAssertEqual(json_t{max}.uint64(), max);
}

- (void)testFloat64 {
    auto min = std::numeric_limits<double>::min();
    XCTAssertEqual(json_t{min}.float64(), min);

    auto max = std::numeric_limits<double>::max();
    XCTAssertEqual(json_t{max}.float64(), max);
}

- (void)testBool {
    XCTAssertTrue(json_t{true}.boolean());
    XCTAssertFalse(json_t{false}.boolean());
}

- (void)testNull {
    XCTAssertTrue(json_t{}.isNull());
}

@end
