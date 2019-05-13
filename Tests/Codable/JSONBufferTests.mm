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
#import "JSONBuffer.hpp"

using namespace StartPoint;

@interface JSONBufferTests : XCTestCase

@end

@implementation JSONBufferTests

- (void)testSimpleJSONIndex {
    JSONBuffer buffer(8, 32);
    buffer.append(INT32_MAX);
    buffer.append(INT64_MAX);
    buffer.append(UINT32_MAX);
    buffer.append(UINT64_MAX);
    buffer.append(true);
    buffer.append(false);
    buffer.append(56.78);
    buffer.appendNull();

    JSONIndex* index = buffer.indexAt(0);
    XCTAssert(index->type == JSONTypeInt);
    XCTAssert(index->start == 0);
    XCTAssert(index->end == 0);
    XCTAssert(index->value.i.int32 == INT32_MAX);

    index += 1;
    XCTAssert(index->type == JSONTypeInt64);
    XCTAssert(index->start == 0);
    XCTAssert(index->end == 0);
    XCTAssert(index->value.int64 == INT64_MAX);

    index += 1;
    XCTAssert(index->type == JSONTypeUint);
    XCTAssert(index->start == 0);
    XCTAssert(index->end == 0);
    XCTAssert(index->value.u.uint32 == UINT32_MAX);

    index += 1;
    XCTAssert(index->type == JSONTypeUint64);
    XCTAssert(index->start == 0);
    XCTAssert(index->end == 0);
    XCTAssert(index->value.uint64 == UINT64_MAX);

    index += 1;
    XCTAssert(index->type == JSONTypeTrue);
    XCTAssert(index->start == 0);
    XCTAssert(index->end == 0);
    XCTAssert(index->value.int64 == 0);

    index += 1;
    XCTAssert(index->type == JSONTypeFalse);
    XCTAssert(index->start == 0);
    XCTAssert(index->end == 0);
    XCTAssert(index->value.int64 == 0);

    index += 1;
    XCTAssert(index->type == JSONTypeDouble);
    XCTAssert(index->start == 0);
    XCTAssert(index->end == 0);
    XCTAssert(index->value.floating == 56.78);

    index += 1;
    XCTAssert(index->type == JSONTypeNull);
    XCTAssert(index->start == 0);
    XCTAssert(index->end == 0);
    XCTAssert(index->value.int64 == 0);
}

- (void)testStringJSONIndex {
    JSONBuffer buffer(4, 128);
    auto raw = buffer.startString();
    buffer.endString(raw);
    raw = buffer.startString();
    buffer.appendString("hello", 5);
    buffer.endString(raw);
    raw = buffer.startString();
    buffer.appendString("hello\nworld", 11);
    buffer.endString(raw);
    raw = buffer.startString();
    const char* v = "中文✔️の_(:з」∠)_";
    buffer.appendString(v, strlen(v));
    buffer.endString(raw);

    JSONIndex* index = buffer.indexAt(0);
    XCTAssert(index->type == JSONTypeString);
    XCTAssert(index->start == 0);
    XCTAssert(index->end == 0);
    XCTAssert(strncmp(buffer.string(0, nullptr), "", 0) == 0);

    index += 1;
    XCTAssert(index->type == JSONTypeString);
    XCTAssert(index->start == 0);
    XCTAssert(index->end == 5);
    XCTAssert(strncmp(buffer.string(1, nullptr), "hello", 5) == 0);

    index += 1;
    XCTAssert(index->type == JSONTypeString);
    XCTAssert(index->start == 5);
    XCTAssert(index->end == 16);
    XCTAssert(strncmp(buffer.string(2, nullptr), "hello\nworld", 11) == 0);

    index += 1;
    XCTAssert(index->type == JSONTypeString);
    XCTAssert(index->start == 16);
    XCTAssert(index->end == 16 + strlen(v));
    XCTAssert(strncmp(buffer.string(3, nullptr), v, strlen(v)) == 0);
}

- (void)testSimpleArrayIndex {
    JSONBuffer buffer(4, 32);
    auto raw = buffer.startArray();
    buffer.append(INT32_MIN);
    buffer.append(true);
    buffer.append(100.001);
    buffer.endArray(raw, 3);

    JSONIndex& index = buffer.index(0);
    XCTAssert(index.type == JSONTypeArray);
    XCTAssert(index.start == 0);
    XCTAssert(index.end == 0);
    XCTAssert(static_cast<size_t>(index.value.int64) == 3);
}

- (void)testNestArrayIndex {
    JSONBuffer buffer(4, 32);
    auto raw = buffer.startArray();
    buffer.append(INT32_MIN);
    buffer.append(true);
    auto raw2 = buffer.startArray();
    buffer.append(UINT32_MAX);
    auto raw3 = buffer.startString();
    buffer.appendString("12123", 5);
    buffer.endString(raw3);
    buffer.append(UINT64_MAX);
    buffer.endArray(raw2, 3);
    buffer.append(100.001);
    buffer.endArray(raw, 5);

    JSONIndex& index = buffer.index(0);
    XCTAssert(index.type == JSONTypeArray);
    XCTAssert(index.start == 0);
    XCTAssert(index.end == 5);
    XCTAssert(static_cast<size_t>(index.value.int64) == 5);

    index = buffer.index(3);
    XCTAssert(index.type == JSONTypeArray);
    XCTAssert(index.start == 0);
    XCTAssert(index.end == 5);
    XCTAssert(static_cast<size_t>(index.value.int64) == 3);
}

- (void)testSimpleArrayItem {
    JSONBuffer buffer(4, 32);
    auto raw = buffer.startArray();
    buffer.append(INT32_MIN);
    buffer.append(true);
    buffer.append(100.001);
    buffer.endArray(raw, 3);

    JSONArray array;
    buffer.array(0, array, true);

    auto item = array.item;
    XCTAssert(*(item++) == 1);
    XCTAssert(*(item++) == 2);
    XCTAssert(*(item++) == 3);

    delete[] array.item;
}

// [
//    INT32_MIN,
//    true,
//    [
//      UINT32_MAX,
//      "12123",
//      UINT64_MAX
//    ],
//    100.001
// ]
- (void)testNestArrayItem {
    JSONBuffer buffer(4, 32);
    auto raw = buffer.startArray(); // 0
    buffer.append(INT32_MIN); // 1
    buffer.append(true); // 2
    auto raw2 = buffer.startArray(); // 3
    buffer.append(UINT32_MAX); // 4
    auto raw3 = buffer.startString(); // 5
    buffer.appendString("12123", 5);
    buffer.endString(raw3);
    buffer.append(UINT64_MAX); // 6
    buffer.endArray(raw2, 3);
    buffer.append(100.001); // 7
    buffer.endArray(raw, 4);

    JSONArray array;
    buffer.array(0, array, true);

    auto item = array.item;
    XCTAssert(*(item++) == 1);
    XCTAssert(*(item++) == 2);
    XCTAssert(*(item++) == 3);
    XCTAssert(*(item++) == 7);

    delete[] array.item;
}

- (void)testSimpleObjectItem {
    JSONBuffer buffer(4, 32);
    auto raw = buffer.startObject(); // 0
    buffer.append("a", 1); // 1
    buffer.append(INT32_MIN); // 2
    buffer.append("b", 1); // 3
    buffer.append(true); // 4
    buffer.append("c", 1); // 5
    buffer.append(100.001); // 6
    buffer.endObject(raw, 3);

    JSONObject object;
    buffer.object(0, object, true);

    auto item = object.item;
    XCTAssert(*(item++) == 1);
    XCTAssert(*(item++) == 3);
    XCTAssert(*(item++) == 5);

    delete[] object.item;
}

// {
//    "a": INT32_MIN,
//    "b": true,
//    "c": {
//      "d": UINT32_MAX,
//      "e": 12123",
//      "f": UINT64_MAX
//    },
//    "g": 100.001
// }
- (void)testNestObjectItem {
    JSONBuffer buffer(4, 32);
    auto raw = buffer.startObject(); // 0
    buffer.append("a", 1); // 1
    buffer.append(INT32_MIN); // 2
    buffer.append("b", 1); // 3
    buffer.append(true); // 4
    buffer.append("c", 1); // 5
    auto raw2 = buffer.startObject(); // 6
    buffer.append("d", 1); // 7
    buffer.append(UINT32_MAX); // 8
    buffer.append("e", 1); // 9
    buffer.append("12123", 5); // 10
    buffer.append("f", 1); // 11
    buffer.append(UINT64_MAX); // 12
    buffer.endObject(raw2, 3);
    buffer.append("g", 1); // 13
    buffer.append(100.001); // 14
    buffer.endObject(raw, 4);

    JSONObject object;
    buffer.object(0, object, true);

    auto item = object.item;
    XCTAssert(*(item++) == 1);
    XCTAssert(*(item++) == 3);
    XCTAssert(*(item++) == 5);
    XCTAssert(*(item++) == 13);

    delete[] object.item;
}

@end
