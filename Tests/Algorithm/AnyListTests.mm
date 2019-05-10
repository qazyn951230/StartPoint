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
#import <StartPoint/AnyList.hpp>

using namespace StartPoint;

struct AnyValue {
    int32_t i32;
    int64_t i64;
};

@interface AnyListTests : XCTestCase

@end

@implementation AnyListTests

- (void)testListConstruct {
    AnyList list;
    XCTAssert(list.empty() == true);
    XCTAssert(list.first<char>() == nullptr);
    XCTAssert(list.last<char>() == nullptr);

    AnyList<> list2(32);
    XCTAssert(list2.empty() == false);
    XCTAssert(list2.size() == 0, @"%lu", list2.size());
    XCTAssert(list2.capacity() == 32, @"%lu", list2.capacity());
    XCTAssert(list2.first<char>() != nullptr);
    XCTAssert(list2.last<char>() != nullptr);
}

- (void)testListAppend {
    AnyList list(3 * sizeof(AnyValue));
    AnyValue value1 = {12, 34};
    list.append(value1);
    list.append(AnyValue{56, 78});
    auto value3 = list.first<AnyValue>();
    XCTAssert(value3->i32 == 12);
    XCTAssert(value3->i64 == 34);
    value3 += 1;
    XCTAssert(value3->i32 == 56);
    XCTAssert(value3->i64 == 78);
}

@end
