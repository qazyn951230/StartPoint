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

#ifndef START_POINT_JSON_H
#define START_POINT_JSON_H

#if (__cplusplus)
#include <cstdint>
#else
#include <stdint.h>
#include <stdbool.h>
#endif

#if defined(__OBJC2__)
#import <Foundation/Foundation.h>
#endif

#include "Config.h"

SP_C_FILE_BEGIN

typedef SP_ENUM(uint16_t, JSONType) {
    JSONTypeNull,
    JSONTypeTrue,
    JSONTypeFalse,
    JSONTypeInt,
    JSONTypeInt64,
    JSONTypeUint,
    JSONTypeUint64,
    JSONTypeDouble,
    JSONTypeString,
    JSONTypeArray,
    JSONTypeObject,
};

typedef SP_ENUM(uint8_t, JSONParseStatus) {
    JSONParseStatusSuccess,
    JSONParseStatusValueInvalid,
    JSONParseStatusInvalidEncoding,
    JSONParseStatusMissQuotationMark,
    JSONParseStatusStringEscapeInvalid,
    JSONParseStatusStringUnicodeSurrogateInvalid,
    JSONParseStatusStringUnicodeEscapeInvalidHex,
    JSONParseStatusObjectMissName,
    JSONParseStatusObjectMissColon,
    JSONParseStatusObjectMissCommaOrCurlyBracket,
    JSONParseStatusArrayMissCommaOrSquareBracket,
    JSONParseStatusNumberMissFraction,
    JSONParseStatusNumberTooBig,
    JSONParseStatusNumberMissExponent,
};

typedef struct SPOpaqueJSON* JSONRef;

JSONRef json_create();
JSONRef json_create_copy(JSONRef other);
JSONRef json_create_type(JSONType type);
JSONRef json_create_int32(int32_t value);
JSONRef json_create_int64(int64_t value);
JSONRef json_create_uint32(uint32_t value);
JSONRef json_create_uint64(uint64_t value);
JSONRef json_create_float(float value);
JSONRef json_create_double(double value);
JSONRef json_create_bool(bool value);
JSONRef json_create_string(const int8_t* data, uint32_t size);
void json_reset_type(JSONRef json, JSONType type);
void json_free(JSONRef ref);

void json_set_int32(JSONRef json, int32_t value);
void json_set_int64(JSONRef json, int64_t value);
void json_set_uint32(JSONRef json, uint32_t value);
void json_set_uint64(JSONRef json, uint64_t value);
void json_set_float(JSONRef json, float value);
void json_set_double(JSONRef json, double value);
void json_set_bool(JSONRef json, bool value);
void json_replace(JSONRef json, JSONRef source);
void json_replace_copy(JSONRef json, JSONRef source);

JSONType json_type(JSONRef json);
bool json_is_int32(JSONRef json);
bool json_is_int64(JSONRef json);
bool json_is_uint32(JSONRef json);
bool json_is_uint64(JSONRef json);
bool json_is_double(JSONRef json);
bool json_is_bool(JSONRef json);
bool json_is_null(JSONRef json);
bool json_is_string(JSONRef json);
bool json_is_array(JSONRef json);
bool json_is_object(JSONRef json);

bool json_is_equal(JSONRef json, JSONRef other);
bool json_is_not_equal(JSONRef json, JSONRef other);
bool json_is_less_than(JSONRef json, JSONRef other);
bool json_is_greater_than(JSONRef json, JSONRef other);
bool json_is_less_than_or_equal(JSONRef json, JSONRef other);
bool json_is_greater_than_or_equal(JSONRef json, JSONRef other);

uint32_t json_array_size(JSONRef json);
JSONRef SP_NULLABLE json_array_get_index(JSONRef json, uint32_t index);

uint32_t json_object_size(JSONRef json);

#if defined(__OBJC2__)
typedef void (^json_object_for_each_t)(const void*, uint32_t size, JSONRef json);
void json_object_for_each(JSONRef json, SP_NOESCAPE json_object_for_each_t method);
#endif

#if defined(__OBJC2__)
NSArray<NSString *>* json_object_all_key(JSONRef json);
#endif

bool json_get_int32(JSONRef json, int32_t* result);
bool json_get_int64(JSONRef json, int64_t* result);
bool json_get_uint32(JSONRef json, uint32_t* result);
bool json_get_uint64(JSONRef json, uint64_t* result);
bool json_get_float(JSONRef json, float* result);
bool json_get_double(JSONRef json, double* result);
bool json_get_bool(JSONRef json, bool* result);
void* json_get_string(JSONRef json, uint32_t* size);

//bool json_object_contains_key(JSONRef json, const int8_t* data);
JSONRef SP_NULLABLE json_object_find_key(JSONRef json, const int8_t* data);

JSONRef SP_NULLABLE json_parse_int8_data(const int8_t* data);
JSONRef SP_NULLABLE json_parse_uint8_data(const uint8_t* data);

JSONRef SP_NULLABLE json_parse_int8_data_status(const int8_t* data, JSONParseStatus* SP_NULLABLE status);
JSONRef SP_NULLABLE json_parse_uint8_data_status(const uint8_t* data, JSONParseStatus* SP_NULLABLE status);

#if defined(__OBJC2__)
typedef void (^json_to_string_t)(const uint8_t*, NSInteger size);
void json_int_to_string(NSInteger value, SP_NOESCAPE json_to_string_t method);
void json_int8_to_string(int8_t value, SP_NOESCAPE json_to_string_t method);
void json_int16_to_string(int16_t value, SP_NOESCAPE json_to_string_t method);
void json_int32_to_string(int32_t value, SP_NOESCAPE json_to_string_t method);
void json_int64_to_string(int64_t value, SP_NOESCAPE json_to_string_t method);

void json_uint_to_string(NSUInteger value, SP_NOESCAPE json_to_string_t method);
void json_uint8_to_string(uint8_t value, SP_NOESCAPE json_to_string_t method);
void json_uint16_to_string(uint16_t value, SP_NOESCAPE json_to_string_t method);
void json_uint32_to_string(uint32_t value, SP_NOESCAPE json_to_string_t method);
void json_uint64_to_string(uint64_t value, SP_NOESCAPE json_to_string_t method);

void json_float_to_string(float value, SP_NOESCAPE json_to_string_t method);
void json_double_to_string(double value, SP_NOESCAPE json_to_string_t method);
#endif

SP_C_FILE_END

#endif // START_POINT_JSON_H
