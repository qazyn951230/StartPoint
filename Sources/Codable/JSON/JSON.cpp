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

#include "JSON.h"
#include "JSON.hpp"

using namespace StartPoint;
using json = StartPoint::JSON<>;
using object_t = json::object_t;
using object_iterator = object_t::iterator;

SP_SIMPLE_CONVERSION(json, JSONRef);
SP_SIMPLE_CONVERSION(object_iterator, ObjectIteratorRef);

JSONRef json_create() {
    return wrap(new json);
}

JSONRef json_create_type(JSONType type) {
    return wrap(new json{type});
}

void json_free(JSONRef ref) {
    delete unwrap(ref);
}

JSONType json_type(JSONRef json) {
    return unwrap(json)->type();
}

bool json_is_int32(JSONRef json) {
    return unwrap(json)->isInt32();
}

bool json_is_int64(JSONRef json) {
    return unwrap(json)->isInt64();
}

bool json_is_uint32(JSONRef json) {
    return unwrap(json)->isUint();
}

bool json_is_uint64(JSONRef json) {
    return unwrap(json)->isUint64();
}

bool json_is_double(JSONRef json) {
    return unwrap(json)->isDouble();
}

bool json_is_bool(JSONRef json) {
    return unwrap(json)->isBool();
}

bool json_is_null(JSONRef json) {
    return unwrap(json)->isNull();
}

bool json_is_string(JSONRef json) {
    return unwrap(json)->isString();
}

bool json_is_array(JSONRef json) {
    return unwrap(json)->isArray();
}

bool json_is_object(JSONRef json) {
    return unwrap(json)->isObject();
}

uint32_t json_array_size(JSONRef json) {
    auto raw = unwrap(json)->asArray();
    if (raw != nullptr) {
        return static_cast<uint32_t>(raw->size());
    }
    return 0;
}

JSONRef json_array_get_index(JSONRef json, uint32_t index) {
    auto raw = unwrap(json)->asArray();
    if (raw != nullptr && index < raw->size()) {
        return wrap(raw->data() + index);
    }
    return nullptr;
}

uint32_t json_object_size(JSONRef json) {
    auto raw = unwrap(json)->asObject();
    if (raw != nullptr) {
        return static_cast<uint32_t>(raw->size());
    }
    return 0;
}

ObjectIteratorRef SP_NULLABLE json_object_iterator_begin(JSONRef json) {
    auto raw = unwrap(json)->asObject();
    if (raw != nullptr) {
        auto result = new object_iterator(raw->begin());
        return wrap(result);
    }
    return nullptr;
}

ObjectIteratorRef SP_NULLABLE json_object_iterator_end(JSONRef json) {
    auto raw = unwrap(json)->asObject();
    if (raw != nullptr) {
        auto result = new object_iterator(raw->end());
        return wrap(result);
    }
    return nullptr;
}

void json_object_iterator_free(ObjectIteratorRef SP_NULLABLE iterator) {
    delete unwrap(iterator);
}

void json_object_iterator_advance(ObjectIteratorRef* iterator) {
    auto raw = unwrap(*iterator);
    raw = raw + 1;
    *iterator = wrap(raw);
}

bool json_object_iterator_is_equal(ObjectIteratorRef lhs, ObjectIteratorRef rhs) {
    return (*unwrap(lhs)) == (*unwrap(rhs));
}

void* json_object_iterator_key(ObjectIteratorRef iterator, uint32_t* SP_NONNULL size) {
    auto raw = unwrap(iterator);
    auto& key = (*raw)->first;
    *size = static_cast<uint32_t>(key.size());
    return const_cast<char*>(key.data());
}

JSONRef json_object_iterator_value(ObjectIteratorRef iterator) {
    auto raw = unwrap(iterator);
    auto& value = (*raw)->second;
    return wrap(&value);
}

bool json_get_int32(JSONRef json, int32_t* SP_NONNULL result) {
    auto value = unwrap(json)->asInt32();
    if (value.has_value()) {
        *result = value.value();
        return true;
    }
    return false;
}

bool json_get_int64(JSONRef json, int64_t* SP_NONNULL result) {
    auto value = unwrap(json)->asInt64();
    if (value.has_value()) {
        *result = value.value();
        return true;
    }
    return false;
}

bool json_get_uint32(JSONRef json, uint32_t* SP_NONNULL result) {
    auto value = unwrap(json)->asUint32();
    if (value.has_value()) {
        *result = value.value();
        return true;
    }
    return false;
}

bool json_get_uint64(JSONRef json, uint64_t* SP_NONNULL result) {
    auto value = unwrap(json)->asUint64();
    if (value.has_value()) {
        *result = value.value();
        return true;
    }
    return false;
}

bool json_get_float(JSONRef json, float* SP_NONNULL result) {
    auto value = unwrap(json)->asFloat32();
    if (value.has_value()) {
        *result = value.value();
        return true;
    }
    return false;
}

bool json_get_double(JSONRef json, double* SP_NONNULL result) {
    auto value = unwrap(json)->asFloat64();
    if (value.has_value()) {
        *result = value.value();
        return true;
    }
    return false;
}

bool json_get_bool(JSONRef json, bool* SP_NONNULL result) {
    auto value = unwrap(json)->asBoolean();
    if (value.has_value()) {
        *result = value.value();
        return true;
    }
    return false;
}

void* json_get_string(JSONRef json, uint32_t* SP_NONNULL size) {
    auto value = unwrap(json)->asString();
    if (value != nullptr) {
        *size = static_cast<uint32_t>(value->size());
        return value->data();
    }
    *size = 0;
    return nullptr;
}
