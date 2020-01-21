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

#define SP_BYTE_ARRAY_USE_STD_STRING

#ifdef SP_BYTE_ARRAY_USE_STD_STRING

#include <string>

#endif

#include "ByteArray.h"
#include "ByteArray.hpp"
#include "IntToChar.hpp"

using array_t = StartPoint::ByteArray;
using char_t = array_t::char_t;
using size_t = array_t::size_t;

SP_SIMPLE_CONVERSION(array_t, ByteArrayRef);

ByteArrayRef byte_array_create() {
    return wrap(new array_t);
}

ByteArrayRef byte_array_create_size(uint32_t size) {
    return wrap(new array_t{static_cast<size_t>(size)});
}

void byte_array_add(ByteArrayRef array, uint8_t value) {
    unwrap(array)->append(static_cast<char_t>(value));
}

void byte_array_add2(ByteArrayRef array, uint8_t value1, uint8_t value2) {
    unwrap(array)->mutate(2, [&](char* buffer) {
        *buffer++ = static_cast<char_t>(value1);
        *buffer++ = static_cast<char_t>(value2);
        return buffer;
    });
}

void byte_array_add3(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3) {
    unwrap(array)->mutate(3, [&](char* buffer) {
        *buffer++ = static_cast<char_t>(value1);
        *buffer++ = static_cast<char_t>(value2);
        *buffer++ = static_cast<char_t>(value3);
        return buffer;
    });
}

void byte_array_add4(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4) {
    unwrap(array)->mutate(4, [&](char* buffer) {
        *buffer++ = static_cast<char_t>(value1);
        *buffer++ = static_cast<char_t>(value2);
        *buffer++ = static_cast<char_t>(value3);
        *buffer++ = static_cast<char_t>(value4);
        return buffer;
    });
}

void byte_array_add5(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4, uint8_t value5) {
    unwrap(array)->mutate(5, [&](char* buffer) {
        *buffer++ = static_cast<char_t>(value1);
        *buffer++ = static_cast<char_t>(value2);
        *buffer++ = static_cast<char_t>(value3);
        *buffer++ = static_cast<char_t>(value4);
        *buffer++ = static_cast<char_t>(value5);
        return buffer;
    });
}

void byte_array_add6(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4, uint8_t value5, uint8_t value6) {
    unwrap(array)->mutate(6, [&](char* buffer) {
        *buffer++ = static_cast<char_t>(value1);
        *buffer++ = static_cast<char_t>(value2);
        *buffer++ = static_cast<char_t>(value3);
        *buffer++ = static_cast<char_t>(value4);
        *buffer++ = static_cast<char_t>(value5);
        *buffer++ = static_cast<char_t>(value6);
        return buffer;
    });
}

void byte_array_add7(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4, uint8_t value5, uint8_t value6, uint8_t value7) {
    unwrap(array)->mutate(7, [&](char* buffer) {
        *buffer++ = static_cast<char_t>(value1);
        *buffer++ = static_cast<char_t>(value2);
        *buffer++ = static_cast<char_t>(value3);
        *buffer++ = static_cast<char_t>(value4);
        *buffer++ = static_cast<char_t>(value5);
        *buffer++ = static_cast<char_t>(value6);
        *buffer++ = static_cast<char_t>(value7);
        return buffer;
    });
}

void byte_array_add8(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4, uint8_t value5, uint8_t value6, uint8_t value7, uint8_t value8) {
    unwrap(array)->mutate(8, [&](char* buffer) {
        *buffer++ = static_cast<char_t>(value1);
        *buffer++ = static_cast<char_t>(value2);
        *buffer++ = static_cast<char_t>(value3);
        *buffer++ = static_cast<char_t>(value4);
        *buffer++ = static_cast<char_t>(value5);
        *buffer++ = static_cast<char_t>(value6);
        *buffer++ = static_cast<char_t>(value7);
        *buffer++ = static_cast<char_t>(value8);
        return buffer;
    });
}

void byte_array_add9(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4, uint8_t value5, uint8_t value6, uint8_t value7, uint8_t value8, uint8_t value9) {
    unwrap(array)->mutate(9, [&](char* buffer) {
        *buffer++ = static_cast<char_t>(value1);
        *buffer++ = static_cast<char_t>(value2);
        *buffer++ = static_cast<char_t>(value3);
        *buffer++ = static_cast<char_t>(value4);
        *buffer++ = static_cast<char_t>(value5);
        *buffer++ = static_cast<char_t>(value6);
        *buffer++ = static_cast<char_t>(value7);
        *buffer++ = static_cast<char_t>(value8);
        *buffer++ = static_cast<char_t>(value9);
        return buffer;
    });
}

void byte_array_add_n(ByteArrayRef array, uint8_t value, NSInteger count) {
    unwrap(array)->append(static_cast<char_t>(value), static_cast<size_t>(count));
}

void byte_array_copy(ByteArrayRef array, ByteArrayRef other) {
    auto raw = unwrap(other);
    if (raw->size() > 0) {
//        unwrap(array)->mutate(raw->size(), [raw](char* buffer) {
//            return static_cast<char*>(std::memcpy(buffer, raw->data(), raw->size()));
//        });
        unwrap(array)->append(raw->data(), raw->size());
    }
}

void byte_array_free(ByteArrayRef ref) {
    delete unwrap(ref);
}

const void* byte_array_data(ByteArrayRef array) {
    return unwrap(array)->data();
}

const uint8_t* byte_array_uint8_data(ByteArrayRef array) {
    return reinterpret_cast<const uint8_t*>(unwrap(array)->data());
}

void* byte_array_move_data(ByteArrayRef array) {
    return unwrap(array)->move();
}

uint8_t* byte_array_move_uint8_data(ByteArrayRef array) {
    return reinterpret_cast<uint8_t*>(unwrap(array)->move());
}

NSInteger byte_array_size(ByteArrayRef array) {
    return static_cast<NSInteger>(unwrap(array)->size());
}

void byte_array_write_int(ByteArrayRef array, NSInteger value) {
#if __LP64__ || 0 || NS_BUILD_32_LIKE_64
    byte_array_write_int64(array, value);
#else
    byte_array_write_int32(array, value);
#endif
}

void byte_array_write_int8(ByteArrayRef array, int8_t value) {
    byte_array_write_int32(array, static_cast<int32_t>(value));
}

void byte_array_write_int16(ByteArrayRef array, int16_t value) {
    byte_array_write_int32(array, static_cast<int32_t>(value));
}

// min -21'4748'3647
// max  21'4748'3648
void byte_array_write_int32(ByteArrayRef array, int32_t value) {
    unwrap(array)->mutate(11, [value](char* buffer) {
        return StartPoint::i32toa(value, buffer);
    });
}

// min -922'3372'0368'5477'5808
// max  922'3372'0368'5477'5807
void byte_array_write_int64(ByteArrayRef array, int64_t value) {
    unwrap(array)->mutate(20, [value](char* buffer) {
        return StartPoint::i64toa(value, buffer);
    });
}

void byte_array_write_uint(ByteArrayRef array, NSUInteger value) {
#if __LP64__ || 0 || NS_BUILD_32_LIKE_64
    byte_array_write_uint64(array, value);
#else
    byte_array_write_uint32(array, value);
#endif
}

void byte_array_write_uint8(ByteArrayRef array, uint8_t value) {
    byte_array_write_uint32(array, static_cast<uint32_t>(value));
}

void byte_array_write_uint16(ByteArrayRef array, uint16_t value) {
    byte_array_write_uint32(array, static_cast<uint16_t>(value));
}

// max 42'9496'7295
void byte_array_write_uint32(ByteArrayRef array, uint32_t value) {
    unwrap(array)->mutate(10, [value](char* buffer) {
        return StartPoint::u32toa(value, buffer);
    });
}

// max 1844'6744'0737'0955'1615
void byte_array_write_uint64(ByteArrayRef array, uint64_t value) {
    unwrap(array)->mutate(20, [value](char* buffer) {
        return StartPoint::u64toa(value, buffer);
    });
}

void byte_array_write_float(ByteArrayRef array, float value) {
    const std::string text = std::to_string(value);
    unwrap(array)->append(text.data(), text.size());
}

void byte_array_write_double(ByteArrayRef array, double value) {
    const std::string text = std::to_string(value);
    unwrap(array)->append(text.data(), text.size());
}

void byte_array_write_bool(ByteArrayRef array, bool value) {
    if (value) {
        unwrap(array)->append("true", 4);
    } else {
        unwrap(array)->append("false", 5);
    }
}

void byte_array_write_null(ByteArrayRef array) {
    unwrap(array)->append("null", 4);
}

void byte_array_write_int8_data(ByteArrayRef array, const int8_t* data, NSInteger size) {
    byte_array_write_uint8_data(array, reinterpret_cast<const uint8_t*>(data), size);
}

void byte_array_write_uint8_data(ByteArrayRef array, const uint8_t* data, NSInteger size) {
    if (size < 1) {
        auto temp = std::strlen(reinterpret_cast<const char*>(data));
        unwrap(array)->append(reinterpret_cast<const char*>(data), temp);
    } else {
        unwrap(array)->append(reinterpret_cast<const char*>(data), static_cast<array_t::size_t>(size));
    }
}