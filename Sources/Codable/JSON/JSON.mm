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

#import "JSON.hpp"

using namespace StartPoint;
using json = StartPoint::JSON<>;

void json_object_for_each(JSONRef json, SP_NOESCAPE json_object_for_each_t method) {
    auto raw = unwrap(json)->asObject();
    if (raw == nullptr) {
        return;
    }
    auto begin = raw->begin();
    const auto end = raw->end();
    while (begin != end) {
        auto& key = begin->first;
        auto& value = begin->second;
        method(key.data(), static_cast<uint32_t>(key.size()), wrap(&value));
        begin++;
    }
}

NSArray<NSString*>* json_object_all_key(JSONRef json) {
    auto raw = unwrap(json)->asObject();
    if (raw == nullptr) {
        return [NSArray array];
    }
    NSMutableArray<NSString*>* result = [[NSMutableArray alloc] initWithCapacity:static_cast<NSUInteger>(raw->size())];
    auto begin = raw->begin();
    const auto end = raw->end();
    while (begin != end) {
        auto& key = begin->first;
        NSString* t = [[NSString alloc] initWithBytesNoCopy:const_cast<char*>(key.data())
                                                     length:static_cast<NSUInteger>(key.size())
                                                   encoding:NSUTF8StringEncoding
                                               freeWhenDone:false];
        [result addObject:t ?: @""];
        begin++;
    }
    return result;
}

void json_int_to_string(NSInteger value, SP_NOESCAPE json_to_string_t method) {
#if __LP64__ || 0 || NS_BUILD_32_LIKE_64
    json_int64_to_string(value, method);
#else
    json_int32_to_string(value, method);
#endif
}

void json_int8_to_string(int8_t value, SP_NOESCAPE json_to_string_t method) {
    const auto text = std::to_string(static_cast<int32_t>(value));
    method(reinterpret_cast<const uint8_t*>(text.data()), static_cast<NSInteger>(text.size()));
}

void json_int16_to_string(int16_t value, SP_NOESCAPE json_to_string_t method) {
    const auto text = std::to_string(static_cast<int32_t>(value));
    method(reinterpret_cast<const uint8_t*>(text.data()), static_cast<NSInteger>(text.size()));
}

void json_int32_to_string(int32_t value, SP_NOESCAPE json_to_string_t method) {
    const auto text = std::to_string(value);
    method(reinterpret_cast<const uint8_t*>(text.data()), static_cast<NSInteger>(text.size()));
}

void json_int64_to_string(int64_t value, SP_NOESCAPE json_to_string_t method) {
    const auto text = std::to_string(value);
    method(reinterpret_cast<const uint8_t*>(text.data()), static_cast<NSInteger>(text.size()));
}

void json_uint_to_string(NSUInteger value, SP_NOESCAPE json_to_string_t method) {
#if __LP64__ || 0 || NS_BUILD_32_LIKE_64
    json_uint64_to_string(value, method);
#else
    json_uint32_to_string(value, method);
#endif
}

void json_uint8_to_string(uint8_t value, SP_NOESCAPE json_to_string_t method) {
    const auto text = std::to_string(static_cast<uint32_t>(value));
    method(reinterpret_cast<const uint8_t*>(text.data()), static_cast<NSInteger>(text.size()));
}

void json_uint16_to_string(uint16_t value, SP_NOESCAPE json_to_string_t method) {
    const auto text = std::to_string(static_cast<uint32_t>(value));
    method(reinterpret_cast<const uint8_t*>(text.data()), static_cast<NSInteger>(text.size()));
}

void json_uint32_to_string(uint32_t value, SP_NOESCAPE json_to_string_t method) {
    const auto text = std::to_string(value);
    method(reinterpret_cast<const uint8_t*>(text.data()), static_cast<NSInteger>(text.size()));
}

void json_uint64_to_string(uint64_t value, SP_NOESCAPE json_to_string_t method) {
    const auto text = std::to_string(value);
    method(reinterpret_cast<const uint8_t*>(text.data()), static_cast<NSInteger>(text.size()));
}

void json_float_to_string(float value, SP_NOESCAPE json_to_string_t method) {
    const auto text = std::to_string(value);
    method(reinterpret_cast<const uint8_t*>(text.data()), static_cast<NSInteger>(text.size()));
}

void json_double_to_string(double value, SP_NOESCAPE json_to_string_t method) {
    const auto text = std::to_string(value);
    method(reinterpret_cast<const uint8_t*>(text.data()), static_cast<NSInteger>(text.size()));
}
