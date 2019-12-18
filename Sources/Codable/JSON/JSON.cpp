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

#include "JSON.hpp"
#include "Parser.hpp"

using namespace StartPoint;
using json = StartPoint::JSON<>;

JSONRef json_create() {
    return wrap(new json);
}

JSONRef json_create_copy(JSONRef other) {
    auto result = new json;
    *result = unwrap(other)->deepCopy();
    return wrap(result);
}

JSONRef json_create_type(JSONType type) {
    return wrap(new json{type});
}

JSONRef json_create_int32(int32_t value) {
    return wrap(new json{value});
}

JSONRef json_create_int64(int64_t value) {
    return wrap(new json{value});
}

JSONRef json_create_uint32(uint32_t value) {
    return wrap(new json{value});
}

JSONRef json_create_uint64(uint64_t value) {
    return wrap(new json{value});
}

JSONRef json_create_float(float value) {
    return wrap(new json{static_cast<double>(value)});
}

JSONRef json_create_double(double value) {
    return wrap(new json{value});
}

JSONRef json_create_bool(bool value) {
    return wrap(new json{value});
}

JSONRef json_create_string(const int8_t* data, uint32_t size) {
    if (size < 1) {
        std::string value{reinterpret_cast<const char*>(data)};
        return wrap(new json{std::move(value)});
    } else {
        std::string value{reinterpret_cast<const char*>(data), static_cast<size_t>(size)};
        return wrap(new json{std::move(value)});
    }
}

void json_reset_type(JSONRef json, JSONType type) {
    unwrap(json)->reset(type);
}

void json_free(JSONRef ref) {
    delete unwrap(ref);
}

void json_set_int32(JSONRef json, int32_t value) {
    unwrap(json)->set(value);
}

void json_set_int64(JSONRef json, int64_t value) {
    unwrap(json)->set(value);
}

void json_set_uint32(JSONRef json, uint32_t value) {
    unwrap(json)->set(value);
}

void json_set_uint64(JSONRef json, uint64_t value) {
    unwrap(json)->set(value);
}

void json_set_float(JSONRef json, float value) {
    unwrap(json)->set(static_cast<json::float64_t>(value));
}

void json_set_double(JSONRef json, double value) {
    unwrap(json)->set(value);
}

void json_set_bool(JSONRef json, bool value) {
    unwrap(json)->set(value);
}

void json_replace(JSONRef json, JSONRef source) {
    *unwrap(json) = std::move(*unwrap(source));
}

void json_replace_copy(JSONRef json, JSONRef source) {
    *unwrap(json) = unwrap(source)->deepCopy();
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

bool json_is_equal(JSONRef json, JSONRef other) {
    return (*unwrap(json)) == (*unwrap(other));
}

bool json_is_not_equal(JSONRef json, JSONRef other) {
    return (*unwrap(json)) != (*unwrap(other));
}

bool json_is_less_than(JSONRef json, JSONRef other) {
    return (*unwrap(json)) < (*unwrap(other));
}

bool json_is_greater_than(JSONRef json, JSONRef other) {
    return (*unwrap(json)) > (*unwrap(other));
}

bool json_is_less_than_or_equal(JSONRef json, JSONRef other) {
    return (*unwrap(json)) <= (*unwrap(other));
}

bool json_is_greater_than_or_equal(JSONRef json, JSONRef other) {
    return (*unwrap(json)) >= (*unwrap(other));
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

//void json_object_for_each(JSONRef json, json_object_for_each_t method) {
//    auto raw = unwrap(json)->asObject();
//    if (raw == nullptr) {
//        return;
//    }
//    auto begin = raw->begin();
//    const auto end = raw->end();
//    while (begin != end) {
//        auto& key = begin->first;
//        auto& value = begin->second;
//        method(key.data(), static_cast<uint32_t>(key.size()), wrap(&value));
//        begin++;
//    }
//}

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

//bool json_object_contains_key(JSONRef json, const int8_t* data) {
//    auto value = unwrap(json)->asObject();
//    if (value != nullptr) {
//        std::string key{reinterpret_cast<const char*>(data)};
//        // https://en.cppreference.com/w/cpp/container/map/find
//        return value->find(key) != value->end();
//    }
//    return false;
//}

JSONRef json_object_find_key(JSONRef json, const int8_t* data) {
//    auto value = unwrap(json)->asObject();
//    if (value != nullptr) {
//        std::string key{reinterpret_cast<const char*>(data)};
//        auto temp = value->find(key);
//        if (temp == value->end()) { // not find
//            return nullptr;
//        }
//        return wrap(&(temp->second));
//    }
//    return nullptr;
    auto value = unwrap(json)->asObject();
    if (value != nullptr) {
        std::string key{reinterpret_cast<const char*>(data)};
        auto temp = std::find_if(value->begin(), value->end(), [&](json::object_t::const_reference pair) {
            return pair.first == key;
        });
        if (temp == value->end()) { // not find
            return nullptr;
        }
        return wrap(&(temp->second));
    }
    return nullptr;
}

JSONRef json_parse_int8_data(const int8_t* data) {
    return json_parse_uint8_data_status(reinterpret_cast<const uint8_t*>(data), nullptr);
}

JSONRef json_parse_uint8_data(const uint8_t* data) {
    return json_parse_uint8_data_status(data, nullptr);
}

JSONRef SP_NULLABLE json_parse_int8_data_status(const int8_t* data, JSONParseStatus* SP_NULLABLE status) {
    return json_parse_uint8_data_status(reinterpret_cast<const uint8_t*>(data), status);
}

JSONRef SP_NULLABLE json_parse_uint8_data_status(const uint8_t* data, JSONParseStatus* SP_NULLABLE status) {
    if (status != nullptr) {
        *status = JSONParseStatusValueInvalid;
    }
    ByteStreams stream{data, 0};
    auto value = new json;
    Parser parser{*value, std::move(stream)};
    try {
        parser.parse();
        if (status != nullptr) {
            *status = JSONParseStatusSuccess;
        }
        return wrap(value);
    } catch (Parser::Error& error) {
        if (status != nullptr) {
            *status = error.status();
        }
        return nullptr;
    } catch (...) {
        return nullptr;
    }
}
