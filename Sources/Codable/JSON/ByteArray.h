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

#ifndef START_POINT_BYTE_ARRAY_H
#define START_POINT_BYTE_ARRAY_H

#if defined(__OBJC2__)
#import <Foundation/Foundation.h>
#endif

#if (__cplusplus)

#include <cstdint>

#else
#include <stdint.h>
#include <stdbool.h>
#endif

#include "Config.h"

SP_C_FILE_BEGIN

typedef struct SPOpaqueByteArray* ByteArrayRef;

ByteArrayRef byte_array_create();
ByteArrayRef byte_array_create_size(uint32_t size);
void byte_array_free(ByteArrayRef SP_NULLABLE ref);

const void* byte_array_data(ByteArrayRef array);
const uint8_t* byte_array_uint8_data(ByteArrayRef array);

void* byte_array_move_data(ByteArrayRef array);
uint8_t* byte_array_move_uint8_data(ByteArrayRef array);

NSInteger byte_array_size(ByteArrayRef array);

void byte_array_add(ByteArrayRef array, uint8_t value);
void byte_array_add2(ByteArrayRef array, uint8_t value1, uint8_t value2);
void byte_array_add3(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3);
void byte_array_add4(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4);
void byte_array_add5(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4, uint8_t value5);
void byte_array_add6(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4, uint8_t value5, uint8_t value6);
void byte_array_add7(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4, uint8_t value5, uint8_t value6, uint8_t value7);
void byte_array_add8(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4, uint8_t value5, uint8_t value6, uint8_t value7, uint8_t value8);
void byte_array_add9(ByteArrayRef array, uint8_t value1, uint8_t value2, uint8_t value3,
    uint8_t value4, uint8_t value5, uint8_t value6, uint8_t value7, uint8_t value8, uint8_t value9);
void byte_array_add_n(ByteArrayRef array, uint8_t value, NSInteger count);

void byte_array_copy(ByteArrayRef array, ByteArrayRef other);

void byte_array_write_int(ByteArrayRef array, NSInteger value);
void byte_array_write_int8(ByteArrayRef array, int8_t value);
void byte_array_write_int16(ByteArrayRef array, int16_t value);
void byte_array_write_int32(ByteArrayRef array, int32_t value);
void byte_array_write_int64(ByteArrayRef array, int64_t value);

void byte_array_write_uint(ByteArrayRef array, NSUInteger value);
void byte_array_write_uint8(ByteArrayRef array, uint8_t value);
void byte_array_write_uint16(ByteArrayRef array, uint16_t value);
void byte_array_write_uint32(ByteArrayRef array, uint32_t value);
void byte_array_write_uint64(ByteArrayRef array, uint64_t value);

void byte_array_write_float(ByteArrayRef array, float value);
void byte_array_write_double(ByteArrayRef array, double value);

void byte_array_write_bool(ByteArrayRef array, bool value);

void byte_array_write_null(ByteArrayRef array);

void byte_array_write_int8_data(ByteArrayRef array, const int8_t* data, NSInteger size);
void byte_array_write_uint8_data(ByteArrayRef array, const uint8_t* data, NSInteger size);

SP_C_FILE_END


#endif // START_POINT_BYTE_ARRAY_H
