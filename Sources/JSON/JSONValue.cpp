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

#include "JSONValue.hpp"

SP_NAMESPACE_BEGIN

using namespace StartPoint;

JSONValue::JSONValue(int value) noexcept: data() {
    data.n.i64 = value;
    valueType = JSONValueTypeInt;
}

JSONValue::JSONValue(int64_t value) noexcept: data() {
    data.n.i64 = value;
    valueType = JSONValueTypeInt64;
}

JSONValue::JSONValue(JSONArray value) noexcept: data(value.list.data) {
    value.list.data = Data();
    value.list.valueType = JSONValueTypeArray;
}

bool JSONValue::isNull() const {
    return valueType == JSONValueTypeNull;
}

bool JSONValue::isFalse() const {
    return valueType & JSONValueTypeBool == JSONValueTypeFalse;
}

bool JSONValue::isTrue() const {
    return valueType & JSONValueTypeBool == JSONValueTypeTrue;
}

bool JSONValue::isBool() const {
    return valueType & JSONValueTypeBool != 0;
}

bool JSONValue::isObject() const {
    return valueType == JSONValueTypeObject;
}

bool JSONValue::isArray() const {
    return valueType == JSONValueTypeArray;
}

bool JSONValue::isNumber() const {
    return valueType & JSONValueTypeNumber != 0;
}

bool JSONValue::isInt() const {
    return valueType & JSONValueTypeNumber == JSONValueTypeInt;
}

bool JSONValue::isInt64() const {
    return valueType & JSONValueTypeNumber == JSONValueTypeInt64;
}

bool JSONValue::isUInt() const {
    return valueType & JSONValueTypeNumber == JSONValueTypeUInt;
}

bool JSONValue::isUInt64() const {
    return valueType & JSONValueTypeNumber == JSONValueTypeUInt64;
}

bool JSONValue::isDouble() const {
    return valueType & JSONValueTypeNumber == JSONValueTypeDouble;
}

bool JSONValue::isString() const {
    return valueType == JSONValueTypeString;
}

int JSONValue::asInt() const {
    assert(isInt());
    return static_cast<int>(data.n.i64);
}

int64_t JSONValue::asInt64() const {
    assert(isInt64());
    return data.n.i64;
}

uint JSONValue::asUInt() const {
    assert(isUInt());
    return static_cast<uint>(data.n.u64);
}

uint64_t JSONValue::asUInt64() const {
    assert(isUInt64());
    return data.n.u64;
}

SP_NAMESPACE_END
