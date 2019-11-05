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
#import "JSON.hpp"

using json = StartPoint::JSON<>;
using array = json::array_t;
using map = json::object_t;
using namespace StartPoint;

@interface JSONTests : XCTestCase

@end

@implementation JSONTests

- (void)testMove {
    auto foo = [&]() {
        auto first = json{JSONTypeArray};
        auto second = std::move(first);
        XCTAssertTrue(second.isArray());
    };
    XCTAssertNoThrow(foo());
}

- (void)testMove2 {
    auto foo = [&]() {
        auto first = json{JSONTypeArray};
        first.appendValue(1);
        first.appendValue(JSONTypeArray);
        auto second = std::move(first);
        XCTAssertTrue(second.isArray());
    };
    XCTAssertNoThrow(foo());
}

- (void)testDealloc {
    XCTAssertNoThrow((std::vector<json>{json{JSONTypeArray}}));
    auto first = json{JSONTypeArray};
    XCTAssertNoThrow((std::vector<json>{std::move(first)}));
    auto foo = [&]() {
        auto list = std::vector<json>{};
        list.emplace_back(JSONTypeArray);
    };
    XCTAssertNoThrow(foo());
    auto foo2 = [&]() {
        auto list = std::vector<json>{};
        auto first = json{JSONTypeArray};
        list.push_back(std::move(first));
    };
    XCTAssertNoThrow(foo2());
    auto foo3 = [&]() {
        auto list = std::vector<json>{};
        auto first = json{JSONTypeArray};
        list.push_back(first);
    };
    XCTAssertNoThrow(foo3());
}

@end
