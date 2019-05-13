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

#ifndef __START_POINT_JSON_BUFFER_H
#define __START_POINT_JSON_BUFFER_H

#include <stdint.h>
#include <stddef.h>
#include "Config.h"

SP_C_FILE_BEGIN

typedef SP_ENUM(uint8_t, JSONType) {
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

union Number {
    struct I {
        int32_t int32;
        char padding[4];
    } i;
    struct U {
        uint32_t uint32;
        char padding[4];
    } u;
    int64_t int64;
    uint64_t uint64;
    double floating;
};

struct JSONIndex {
    JSONType type;
    size_t start;
    size_t end;
    union Number value;
};

typedef struct OpaqueJSONBuffer* JSONBufferRef;
typedef struct OpaqueJSONArray* JSONArrayRef;
typedef struct OpaqueJSONObject* JSONObjectRef;

JSONBufferRef json_buffer_create(size_t count, size_t size);
void json_buffer_free(JSONBufferRef buffer);
bool json_buffer_is_empty(JSONBufferRef buffer);
size_t json_buffer_count(JSONBufferRef buffer);
JSONBufferRef json_buffer_copy(JSONBufferRef buffer, size_t start, size_t count);
JSONBufferRef json_buffer_copy_all(JSONBufferRef buffer);
JSONBufferRef json_buffer_copy_array(JSONBufferRef buffer, JSONArrayRef array);
JSONBufferRef json_buffer_copy_object(JSONBufferRef buffer, JSONObjectRef object);
JSONType json_buffer_value_type(JSONBufferRef buffer, size_t index);
void json_buffer_print(JSONBufferRef buffer);

void json_buffer_append_int32(JSONBufferRef buffer, int32_t value);
void json_buffer_append_int64(JSONBufferRef buffer, int64_t value);
void json_buffer_append_uint32(JSONBufferRef buffer, uint32_t value);
void json_buffer_append_uint64(JSONBufferRef buffer, uint64_t value);
void json_buffer_append_double(JSONBufferRef buffer, double value);
void json_buffer_append_bool(JSONBufferRef buffer, bool value);
void json_buffer_append_char(JSONBufferRef buffer, unsigned char value);
void json_buffer_append_string(JSONBufferRef buffer, const char* value, size_t count);
void json_buffer_append_null(JSONBufferRef buffer);

size_t json_buffer_start_string(JSONBufferRef buffer);
void json_buffer_end_string(JSONBufferRef buffer, size_t index);
size_t json_buffer_start_array(JSONBufferRef buffer);
void json_buffer_end_array(JSONBufferRef buffer, size_t index, size_t count);
size_t json_buffer_start_object(JSONBufferRef buffer);
void json_buffer_end_object(JSONBufferRef buffer, size_t index, size_t count);

struct JSONIndex json_buffer_index(JSONBufferRef buffer, size_t atIndex);
bool json_buffer_is_null(JSONBufferRef buffer, size_t index);
int32_t json_buffer_int32(JSONBufferRef buffer, size_t index);
int64_t json_buffer_int64(JSONBufferRef buffer, size_t index);
uint32_t json_buffer_uint32(JSONBufferRef buffer, size_t index);
uint64_t json_buffer_uint64(JSONBufferRef buffer, size_t index);
double json_buffer_double(JSONBufferRef buffer, size_t index);
bool json_buffer_bool(JSONBufferRef buffer, size_t index);
void* json_buffer_string(JSONBufferRef buffer, size_t index, size_t* SP_NULLABLE count);
JSONArrayRef json_buffer_array_create(JSONBufferRef buffer, size_t index, bool resolve);
JSONObjectRef json_buffer_object_create(JSONBufferRef buffer, size_t index, bool resolve);
bool json_buffer_key_index(JSONBufferRef buffer, JSONObjectRef object, size_t key_index,
                           char* SP_NULLABLE key, size_t* result);
bool json_buffer_key_index_check(JSONBufferRef buffer, JSONObjectRef object, const char* key, size_t* result);

JSONArrayRef json_array_create();
void json_array_free(JSONArrayRef array);
size_t json_array_count(JSONArrayRef array);
size_t json_array_index(JSONArrayRef array);

JSONObjectRef json_object_create();
void json_object_free(JSONObjectRef object);
size_t json_object_count(JSONObjectRef object);
size_t json_object_index(JSONObjectRef object);

SP_C_FILE_END

#endif // __START_POINT_JSON_BUFFER_H
