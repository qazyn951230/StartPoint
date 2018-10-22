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

#ifndef STARTPOINT_JSONVALUE_HPP
#define STARTPOINT_JSONVALUE_HPP

#import "Config.h"

NS_ASSUME_NONNULL_BEGIN
SP_NAMESPACE_BEGIN

struct JSONKeyedValue;
class JSONValue;

class JSONArray {
public:
    friend class JSONValue;
private:
    JSONValue& list;
};

typedef enum : NSUInteger {
    JSONValueTypeNull   = 0b0000'0000'0000,
    JSONValueTypeFalse  = 0b0000'0000'0001,
    JSONValueTypeTrue   = 0b0000'0000'0010,
    JSONValueTypeBool   = 0b0000'0000'0011,
    JSONValueTypeObject = 0b0000'0000'0100,
    JSONValueTypeArray  = 0b0000'0000'1000,
    JSONValueTypeInt    = 0b0000'0001'0000,
    JSONValueTypeInt64  = 0b0000'0010'0000,
    JSONValueTypeUInt   = 0b0000'0100'0000,
    JSONValueTypeUInt64 = 0b0000'1000'0000,
    JSONValueTypeDouble = 0b0001'0000'0000,
    JSONValueTypeNumber = 0b0001'1111'0000,
    JSONValueTypeString = 0b0010'0000'0000,
} JSONValueType;

class JSONValue {
public:
    struct String {
        const char* value;
        size_t size;
    };

    struct ShortString {
#define SS_MAX_SIZE 1024
        char value[SS_MAX_SIZE];
#undef SS_MAX_SIZE
    };

    union Number {
        int64_t i64;
        uint64_t u64;
        double d;
    };

    struct Object {
        size_t size;
        size_t capacity;
        JSONKeyedValue* list;
    };

    struct Array {
        size_t size;
        size_t capacity;
        JSONValue* list;
    };

    explicit JSONValue(int value) noexcept;
    explicit JSONValue(int64_t value) noexcept;
    explicit JSONValue(JSONArray value) noexcept;

    bool isNull() const;
    bool isFalse() const;
    bool isTrue() const;
    bool isBool() const;
    bool isObject() const;
    bool isArray() const;
    bool isNumber() const;
    bool isInt() const;
    bool isInt64() const;
    bool isUInt() const;
    bool isUInt64() const;
    bool isDouble() const;
    bool isString() const;

    int asInt() const;
    int64_t asInt64() const;
    uint asUInt() const;
    uint64_t asUInt64() const;
private:
    union Data {
        String s;
        ShortString ss;
        Number n;
        Object o;
        Array a;
    };

    Data data;
    JSONValueType valueType;
};

struct JSONKeyedValue {
    JSONValue name;
    JSONValue value;
};

SP_NAMESPACE_END
NS_ASSUME_NONNULL_END

#endif //STARTPOINT_JSONVALUE_HPP
