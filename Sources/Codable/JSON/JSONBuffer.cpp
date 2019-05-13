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

#include <iostream>
#include "JSONBuffer.hpp"

SP_SIMPLE_CONVERSION(JSONBuffer, JSONBufferRef);
SP_SIMPLE_CONVERSION(JSONArray, JSONArrayRef);
SP_SIMPLE_CONVERSION(JSONObject, JSONObjectRef);

SP_C_FILE_BEGIN

JSONBufferRef json_buffer_create(size_t count, size_t size) {
    auto buffer = new JSONBuffer(count, size);
    return wrap(buffer);
}

void json_buffer_free(JSONBufferRef buffer) {
    delete unwrap(buffer);
}

JSONBufferRef json_buffer_copy(JSONBufferRef buffer, size_t start, size_t count) {
    auto result = unwrap(buffer)->copy(start, count);
    return wrap(result);
}

JSONBufferRef json_buffer_copy_all(JSONBufferRef buffer) {
    auto result = unwrap(buffer)->copy(0, unwrap(buffer)->count());
    return wrap(result);
}

JSONBufferRef json_buffer_copy_array(JSONBufferRef buffer, JSONArrayRef array) {
    auto raw = unwrap(array);
    return json_buffer_copy(buffer, raw->index, raw->count + 1);
}

JSONBufferRef json_buffer_copy_object(JSONBufferRef buffer, JSONObjectRef object) {
    auto raw = unwrap(object);
    return json_buffer_copy(buffer, raw->index, raw->count + 1);
}

bool json_buffer_is_empty(JSONBufferRef buffer) {
    auto raw = unwrap(buffer);
    if (raw->empty()) {
        return true;
    }
    auto& i = raw->index(0);
    switch (i.type) {
        case JSONTypeArray:
        case JSONTypeObject:
            return i.value.int64 != 0;
        default:
            return false;
    }
}

size_t json_buffer_count(JSONBufferRef buffer) {
    return unwrap(buffer)->count();
}

JSONType json_buffer_value_type(JSONBufferRef buffer, size_t index) {
    if (unwrap(buffer)->count() < 1) {
        return JSONTypeNull;
    }
    return unwrap(buffer)->index(index).type;
}

void json_buffer_print(JSONBufferRef buffer) {
    unwrap(buffer)->printContent(std::cout);
}

void json_buffer_append_int32(JSONBufferRef buffer, int32_t value) {
    unwrap(buffer)->append(value);
}

void json_buffer_append_uint32(JSONBufferRef buffer, uint32_t value) {
    unwrap(buffer)->append(value);
}

void json_buffer_append_int64(JSONBufferRef buffer, int64_t value) {
    unwrap(buffer)->append(value);
}

void json_buffer_append_uint64(JSONBufferRef buffer, uint64_t value) {
    unwrap(buffer)->append(value);
}

void json_buffer_append_double(JSONBufferRef buffer, double value) {
    unwrap(buffer)->append(value);
}

void json_buffer_append_bool(JSONBufferRef buffer, bool value) {
    unwrap(buffer)->append(value);
}

void json_buffer_append_char(JSONBufferRef buffer, unsigned char value) {
    unwrap(buffer)->appendString(value);
}

void json_buffer_append_string(JSONBufferRef buffer, const char* value, size_t count) {
    unwrap(buffer)->appendString(value, count);
}

void json_buffer_append_null(JSONBufferRef buffer) {
    unwrap(buffer)->appendNull();
}

size_t json_buffer_start_string(JSONBufferRef buffer) {
    return unwrap(buffer)->startString();
}

void json_buffer_end_string(JSONBufferRef buffer, size_t index) {
    unwrap(buffer)->endString(index);
}

size_t json_buffer_start_array(JSONBufferRef buffer) {
    return unwrap(buffer)->startArray();
}

void json_buffer_end_array(JSONBufferRef buffer, size_t index, size_t count) {
    unwrap(buffer)->endArray(index, count);
}

size_t json_buffer_start_object(JSONBufferRef buffer) {
    return unwrap(buffer)->startObject();
}

void json_buffer_end_object(JSONBufferRef buffer, size_t index, size_t count) {
    unwrap(buffer)->endObject(index, count);
}

JSONIndex json_buffer_index(JSONBufferRef buffer, size_t atIndex) {
    return unwrap(buffer)->index(atIndex);
}

bool json_buffer_is_null(JSONBufferRef buffer, size_t index) {
    auto temp = unwrap(buffer)->index(index);
    return temp.type == JSONTypeNull;
}

int32_t json_buffer_int32(JSONBufferRef buffer, size_t index) {
    Number result;
    unwrap(buffer)->number(index, result);
    return result.i.int32;
}

int64_t json_buffer_int64(JSONBufferRef buffer, size_t index) {
    Number result;
    unwrap(buffer)->number(index, result);
    return result.int64;
}

uint32_t json_buffer_uint32(JSONBufferRef buffer, size_t index) {
    Number result;
    unwrap(buffer)->number(index, result);
    return result.u.uint32;
}

uint64_t json_buffer_uint64(JSONBufferRef buffer, size_t index) {
    Number result;
    unwrap(buffer)->number(index, result);
    return result.uint64;
}

double json_buffer_double(JSONBufferRef buffer, size_t index) {
    Number result;
    unwrap(buffer)->number(index, result);
    return result.floating;
}

bool json_buffer_bool(JSONBufferRef buffer, size_t index) {
    auto& temp = unwrap(buffer)->index(index);
    switch (temp.type) {
        case JSONTypeTrue:
            return true;
        case JSONTypeFalse:
            return false;
        default:
            return false;
    }
}

void* json_buffer_string(JSONBufferRef buffer, size_t index, size_t* SP_NULLABLE count) {
    auto result = unwrap(buffer)->string(index, count);
    return reinterpret_cast<void*>(result);
}

JSONArrayRef json_buffer_array_create(JSONBufferRef buffer, size_t index, bool resolve) {
    auto value = new JSONArray();
    unwrap(buffer)->array(index, *value, resolve);
    return wrap(value);
}

JSONObjectRef json_buffer_object_create(JSONBufferRef buffer, size_t index, bool resolve) {
    auto value = new JSONObject();
    unwrap(buffer)->object(index, *value, resolve);
    return wrap(value);
}

bool json_buffer_key_index(JSONBufferRef buffer, JSONObjectRef object, size_t key_index,
                           char* SP_NULLABLE key, size_t* result) {
    size_t* item = unwrap(object)->item;
    if (item != nullptr || unwrap(object)->count <= key_index) {
        return false;
    }
    size_t count = 0;
    key = unwrap(buffer)->string(*(item + key_index), &count);
    if (key != nullptr) {
        *result = count;
        return true;
    }
    return false;
}

bool json_buffer_key_index_check(JSONBufferRef buffer, JSONObjectRef object, const char* key, size_t* result) {
    auto temp = unwrap(object);
    auto raw = unwrap(buffer);
    if (temp->item == nullptr) {
        raw->resolveObject(*temp);
    }
    size_t* item = temp->item;
    assert(item != nullptr);
    auto end = item + temp->count;
    size_t count = 0;
    while (item < end) {
        auto value = raw->string(*item, &count);
        if (value != nullptr && memcmp(key, value, count) == 0) {
            *result = *item;
            return true;
        }
        item += 1;
    }
    return false;
}

JSONArrayRef json_array_create() {
    auto value = new JSONArray();
    return wrap(value);
}

void json_array_free(JSONArrayRef array) {
    auto raw = unwrap(array);
    delete[] raw->item;
    delete raw;
}

size_t json_array_count(JSONArrayRef array) {
    return unwrap(array)->count;
}

size_t json_array_index(JSONArrayRef array) {
    return unwrap(array)->index;
}

JSONObjectRef json_object_create() {
    auto value = new JSONObject();
    return wrap(value);
}

void json_object_free(JSONObjectRef object) {
    auto raw = unwrap(object);
    delete[] raw->item;
    delete raw;
}

size_t json_object_count(JSONObjectRef object) {
    return unwrap(object)->count;
}

size_t json_object_index(JSONObjectRef object) {
    return unwrap(object)->index;
}

SP_C_FILE_END
