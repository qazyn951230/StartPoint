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

#ifndef START_POINT_JSON_HPP
#define START_POINT_JSON_HPP

#ifndef SP_JSON_MAP_TYPE
// 1 vector 2 map 3 unordered_map
#define SP_JSON_MAP_TYPE 1
#endif

#ifndef SP_JSON_SUPPORT_IOS_10
// std::optional<T>.value() not available on iOS 10, iOS 11, macOS 10.13
#define SP_JSON_SUPPORT_IOS_10 1
#endif

#include <vector>
#include <string>
#include <cmath> // for std::round
#include "Config.h"
#include "JSON.h"

#if (SP_JSON_MAP_TYPE != 1)
#include <unordered_map>
#endif

#if (SP_JSON_SUPPORT_IOS_10)
#include "Optional.hpp"
#else
#include <optional>
#endif

SP_CPP_FILE_BEGIN

template<template<typename> typename Allocator = std::allocator>
class JSON final {
public:
    using value_t = JSON;
    using bool_t = bool;
    using int32_t = std::int32_t;
    using uint32_t = std::uint32_t;
    using int64_t = std::int64_t;
    using uint64_t = std::uint64_t;
    using float64_t = double;
    using string_t = std::string;
    using array_t = std::vector<value_t>;

#if (SP_JSON_MAP_TYPE == 3)
    using object_t = std::unordered_map<std::string, value_t>;
#else
    using object_t = std::vector<std::pair<std::string, value_t>>;
#endif

    union Data {
        object_t* SP_NULLABLE object;
        array_t* SP_NULLABLE array;
        string_t* SP_NULLABLE string;
        struct {
            char padding[4];
            int32_t int32;
        } i;
        int64_t int64;
        struct {
            char padding[4];
            uint32_t uint32;
        } u;
        uint64_t uint64;
        float64_t float64;

        Data() : uint64() {}

        Data(const Data& other) = delete;

        Data(Data&& other) noexcept: uint64(other.uint64) {}

        Data& operator=(const Data&) = delete;

        Data& operator=(Data&& other) noexcept {
            std::swap(uint64, other.uint64);
            return *this;
        }

        Data(const Data& other, const JSONType type): uint64(other.uint64) {
            switch (type) {
                case JSONTypeObject:
                    object = JSON::create<object_t>(*other.object);
                    break;
                case JSONTypeArray:
                    array = JSON::create<array_t>(*other.array);
                    break;
                case JSONTypeString:
                    string = JSON::create<string_t>(*other.string);
                    break;
                default:
                    break;
            }
        }

        explicit Data(const JSONType type) : uint64() {
            switch (type) {
                case JSONTypeObject:
                    object = JSON::create<object_t>();
                    break;
                case JSONTypeArray:
                    array = JSON::create<array_t>();
                    break;
                case JSONTypeString:
                    string = JSON::create<string_t>();
                    break;
                default:
                    break;
            }
        }

        explicit Data(const string_t& value) : uint64() {
            string = JSON::create<string_t>(value);
        }

        explicit Data(string_t&& value) : uint64() {
            string = JSON::create<string_t>(std::move(value));
        }
        
        void copy(const Data& other, const JSONType type) {
            uint64 = other.uint64;
            switch (type) {
                case JSONTypeObject:
                    object = JSON::create<object_t>(*other.object);
                    break;
                case JSONTypeArray:
                    array = JSON::create<array_t>(*other.array);
                    break;
                case JSONTypeString:
                    string = JSON::create<string_t>(*other.string);
                    break;
                default:
                    break;
            }
        }

        void destroy(JSONType type) noexcept {
            switch (type) {
                case JSONTypeObject:
                    JSON::destroy(object);
                    break;
                case JSONTypeArray:
                    JSON::destroy(array);
                    break;
                case JSONTypeString:
                    JSON::destroy(string);
                    break;
                default:
                    break;
            }
        }
    };

    explicit JSON(const JSONType type) : _type(type), _data(type) {
        assert_invariant();
    }

    explicit JSON(const int32_t value) : _type(JSONTypeInt), _data() {
        _data.i.int32 = value;
        assert_invariant();
    }

    explicit JSON(const int64_t value) : _type(JSONTypeInt64), _data() {
        _data.int64 = value;
        assert_invariant();
    }

    explicit JSON(const uint32_t value) : _type(JSONTypeUint), _data() {
        _data.u.uint32 = value;
        assert_invariant();
    }

    explicit JSON(const uint64_t value) : _type(JSONTypeUint64), _data() {
        _data.uint64 = value;
        assert_invariant();
    }

    explicit JSON(const float64_t value) : _type(JSONTypeDouble), _data() {
        _data.float64 = value;
        assert_invariant();
    }

    explicit JSON(const bool_t value) : _type(value ? JSONTypeTrue : JSONTypeFalse), _data() {
        assert_invariant();
    }

    explicit JSON(const string_t& value) : _type(JSONTypeString), _data(value) {
        assert_invariant();
    }

    explicit JSON(string_t&& value) : _type(JSONTypeString), _data(std::move(value)) {
        assert_invariant();
    }

    explicit JSON(std::nullptr_t value = nullptr) : _type(JSONTypeNull), _data() {
        assert_invariant();
    }

    JSON(const JSON& other) : _type(other._type), _data(other._data, other._type) {
        other.assert_invariant();
        assert_invariant();
    }

    JSON(JSON&& other) noexcept : _type(std::move(other._type)), _data(std::move(other._data)) {
        other.assert_invariant();
        assert_invariant();
        other._type = JSONTypeNull;
        other._data.uint64 = 0;
    }

    ~JSON() noexcept {
        assert_invariant();
        _data.destroy(_type);
    }

    JSON& operator=(const JSON& other) {
        other.assert_invariant();
        _type = other._type;
        _data.copy(other._data, other._type);
        assert_invariant();
        return *this;
    }

    JSON& operator=(JSON&& other) noexcept {
        other.assert_invariant();
        std::swap(_type, other._type);
        std::swap(_data, other._data);
        assert_invariant();
        return *this;
    }

    [[nodiscard]] JSONType type() const noexcept {
        return _type;
    }

    [[nodiscard]] bool isNull() const noexcept {
        return _type == JSONTypeNull;
    }

    [[nodiscard]] bool isBool() const noexcept {
        return _type == JSONTypeTrue || _type == JSONTypeFalse;
    }

    [[nodiscard]] bool isInt32() const noexcept {
        return _type == JSONTypeInt;
    }

    [[nodiscard]] bool isInt64() const noexcept {
        return _type == JSONTypeInt64;
    }

    [[nodiscard]] bool isUint() const noexcept {
        return _type == JSONTypeUint;
    }

    [[nodiscard]] bool isUint64() const noexcept {
        return _type == JSONTypeUint64;
    }

    [[nodiscard]] bool isDouble() const noexcept {
        return _type == JSONTypeDouble;
    }

    [[nodiscard]] bool isString() const noexcept {
        return _type == JSONTypeString;
    }

    [[nodiscard]] bool isArray() const noexcept {
        return _type == JSONTypeArray;
    }

    [[nodiscard]] bool isObject() const noexcept {
        return _type == JSONTypeObject;
    }

    [[nodiscard]] bool isComplex() const noexcept {
        return _type == JSONTypeArray || _type == JSONTypeObject;
    }

    [[nodiscard]] auto int32() const noexcept {
        assert(isInt32());
        return _data.i.int32;
    }

#if (SP_JSON_SUPPORT_IOS_10)
    [[nodiscard]] Optional<int32_t> asInt32() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return _data.i.int32;
            case JSONTypeUint:
                return _data.u.uint32 > static_cast<uint32_t>(max<int32_t>()) ?
                    Optional<int32_t>{} : Optional{static_cast<int32_t>(_data.u.uint32)};
            case JSONTypeDouble: // A double json value always > int32_t::max or has fractional part
            case JSONTypeInt64: // A int64_t / uint64_t json value always > int32_t::max
            case JSONTypeUint64:
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return Optional<int32_t>{};
        }
    }
#else
    [[nodiscard]] std::optional<int32_t> asInt32() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return _data.i.int32;
            case JSONTypeUint:
                return _data.u.uint32 > static_cast<uint32_t>(max<int32_t>()) ?
                       std::nullopt : std::optional{static_cast<int32_t>(_data.u.uint32)};
            case JSONTypeDouble: // A double json value always > int32_t::max or has fractional part
            case JSONTypeInt64: // A int64_t / uint64_t json value always > int32_t::max
            case JSONTypeUint64:
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return std::nullopt;
        }
    }
#endif

    [[nodiscard]] auto int64() const noexcept {
        assert(isInt64());
        return _data.int64;
    }

#if (SP_JSON_SUPPORT_IOS_10)
    [[nodiscard]] Optional<int64_t> asInt64() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return static_cast<int64_t>(_data.i.int32);
            case JSONTypeUint:
                return static_cast<int64_t>(_data.u.uint32);
            case JSONTypeInt64:
                return _data.int64;
            case JSONTypeUint64:
                return _data.uint64 > static_cast<uint64_t>(max<int64_t>()) ?
                    Optional<int64_t>{} : Optional{static_cast<int64_t>(_data.uint64)};
            case JSONTypeDouble: // A double json value always > int64_t::max or has fractional part
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return Optional<int64_t>{};
        }
    }
#else
    [[nodiscard]] std::optional<int64_t> asInt64() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return static_cast<int64_t>(_data.i.int32);
            case JSONTypeUint:
                return static_cast<int64_t>(_data.u.uint32);
            case JSONTypeInt64:
                return _data.int64;
            case JSONTypeUint64:
                return _data.uint64 > static_cast<uint64_t>(max<int64_t>()) ?
                       std::nullopt : std::optional{static_cast<int64_t>(_data.uint64)};
            case JSONTypeDouble: // A double json value always > int64_t::max or has fractional part
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return std::nullopt;
        }
    }
#endif

    [[nodiscard]] auto uint32() const noexcept {
        assert(isUint());
        return _data.u.uint32;
    }

#if (SP_JSON_SUPPORT_IOS_10)
    [[nodiscard]] Optional<uint32_t> asUint32() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return Optional<uint32_t>{}; // mast < 0
            case JSONTypeUint:
                return _data.u.uint32;
            case JSONTypeDouble: // A double json value always > uint32_t::max or has fractional part
            case JSONTypeInt64: // A int64_t / uint64_t json value always > uint32_t::max
            case JSONTypeUint64:
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return Optional<uint32_t>{};
        }
    }
#else
    [[nodiscard]] std::optional<uint32_t> asUint32() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return std::nullopt; // mast < 0
            case JSONTypeUint:
                return _data.u.uint32;
            case JSONTypeDouble: // A double json value always > uint32_t::max or has fractional part
            case JSONTypeInt64: // A int64_t / uint64_t json value always > uint32_t::max
            case JSONTypeUint64:
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return std::nullopt;
        }
    }
#endif

    [[nodiscard]] auto uint64() const noexcept {
        assert(isUint64());
        return _data.uint64;
    }

#if (SP_JSON_SUPPORT_IOS_10)
    [[nodiscard]] Optional<uint64_t> asUint64() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return static_cast<uint64_t>(_data.i.int32);
            case JSONTypeUint:
                return static_cast<uint64_t>(_data.u.uint32);
            case JSONTypeInt64:
                return Optional<uint64_t>{}; // mast < 0
            case JSONTypeUint64:
                return _data.uint64;
            case JSONTypeDouble: // A double json value always > uint64_t::max or has fractional part
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return Optional<uint64_t>{};
        }
    }
#else
    [[nodiscard]] std::optional<uint64_t> asUint64() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return static_cast<uint64_t>(_data.i.int32);
            case JSONTypeUint:
                return static_cast<uint64_t>(_data.u.uint32);
            case JSONTypeInt64:
                return std::nullopt; // mast < 0
            case JSONTypeUint64:
                return _data.uint64;
            case JSONTypeDouble: // A double json value always > uint64_t::max or has fractional part
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return std::nullopt;
        }
    }
#endif

    [[nodiscard]] auto float64() const noexcept {
        assert(isDouble());
        return _data.float64;
    }

#if (SP_JSON_SUPPORT_IOS_10)
    [[nodiscard]] Optional<float> asFloat32() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return static_cast<float>(_data.i.int32);
            case JSONTypeUint:
                return static_cast<float>(_data.u.uint32);
            case JSONTypeInt64:
                return static_cast<float>(_data.int64);
            case JSONTypeUint64:
                return static_cast<float>(_data.uint64);
            case JSONTypeDouble:
                return static_cast<float>(_data.float64);
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return Optional<float>{};
        }
    }
#else
    [[nodiscard]] std::optional<float> asFloat32() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return static_cast<float>(_data.i.int32);
            case JSONTypeUint:
                return static_cast<float>(_data.u.uint32);
            case JSONTypeInt64:
                return static_cast<float>(_data.int64);
            case JSONTypeUint64:
                return static_cast<float>(_data.uint64);
            case JSONTypeDouble:
                return static_cast<float>(_data.float64);
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return std::nullopt;
        }
    }
#endif

#if (SP_JSON_SUPPORT_IOS_10)
    [[nodiscard]] Optional<float64_t> asFloat64() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return static_cast<float64_t>(_data.i.int32);
            case JSONTypeUint:
                return static_cast<float64_t>(_data.u.uint32);
            case JSONTypeInt64:
                return static_cast<float64_t>(_data.int64);
            case JSONTypeUint64:
                return static_cast<float64_t>(_data.uint64);
            case JSONTypeDouble:
                return _data.float64;
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return Optional<float64_t>{};
        }
    }
#else
    [[nodiscard]] std::optional<float64_t> asFloat64() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return static_cast<float64_t>(_data.i.int32);
            case JSONTypeUint:
                return static_cast<float64_t>(_data.u.uint32);
            case JSONTypeInt64:
                return static_cast<float64_t>(_data.int64);
            case JSONTypeUint64:
                return static_cast<float64_t>(_data.uint64);
            case JSONTypeDouble:
                return _data.float64;
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return std::nullopt;
        }
    }
#endif

    [[nodiscard]] auto boolean() const noexcept {
        assert(isBool());
        return _type == JSONTypeTrue;
    }

#if (SP_JSON_SUPPORT_IOS_10)
    [[nodiscard]] Optional<bool> asBoolean() const noexcept {
        switch (_type) {
            case JSONTypeTrue:
                return true;
            case JSONTypeFalse:
                return false;
            case JSONTypeInt:
            case JSONTypeUint:
            case JSONTypeInt64:
            case JSONTypeUint64:
            case JSONTypeDouble:
            case JSONTypeNull:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return Optional<bool>{};
        }
    }
#else
    [[nodiscard]] std::optional<bool> asBoolean() const noexcept {
        switch (_type) {
            case JSONTypeTrue:
                return true;
            case JSONTypeFalse:
                return false;
            case JSONTypeInt:
            case JSONTypeUint:
            case JSONTypeInt64:
            case JSONTypeUint64:
            case JSONTypeDouble:
            case JSONTypeNull:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return std::nullopt;
        }
    }
#endif

    [[nodiscard]] string_t* SP_NULLABLE asString() const noexcept {
        if (isString()) {
            return _data.string;
        }
        return nullptr;
    }

    [[nodiscard]] array_t* SP_NULLABLE asArray() const noexcept {
        if (isArray()) {
            return _data.array;
        }
        return nullptr;
    }

    [[nodiscard]] object_t* SP_NULLABLE asObject() const noexcept {
        if (isObject()) {
            return _data.object;
        }
        return nullptr;
    }

    JSON deepCopy() const {
        JSON result;
        switch (_type) {
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeInt:
            case JSONTypeUint:
            case JSONTypeInt64:
            case JSONTypeUint64:
            case JSONTypeDouble:
            case JSONTypeNull:
            case JSONTypeString:
                result = *this;
                break;
            case JSONTypeArray: {
                result = JSON(JSONTypeArray);
                array_t array = *result._data.array;
                for (const auto& item: *_data.array) {
                    array.push_back(std::move(item.deepCopy()));
                }
            }
                break;
            case JSONTypeObject: {
#if (SP_JSON_MAP_TYPE == 3)
                result = JSON(JSONTypeObject);
                object_t map = *result._data.object;
                for (const auto& item: *_data.object) {
                    map[item.first] = std::move(item.second.deepCopy());
                }
#else
                result = JSON(JSONTypeObject);
                object_t map = *result._data.object;
                for (const auto& item: *_data.object) {
                    string_t key = item.first;
                    value_t value = item.second.deepCopy();
                    map.emplace_back(std::pair{std::move(key), std::move(value)});
                }
#endif
            }
                break;
        }
        return result;
    }

    void reset(JSONType type) {
        assert_invariant();
        _data.destroy(_type);
        _type = type;
        _data = std::move(Data(_type));
    }

    void set(const int32_t value) {
        assert(!(isString() || isArray() || isObject()));
        _type = JSONTypeInt;
        _data.i.int32 = value;
    }

    void set(const uint32_t value) {
        assert(!(isString() || isArray() || isObject()));
        _type = JSONTypeUint;
        _data.u.uint32 = value;
    }

    void set(const int64_t value) {
        assert(!(isString() || isArray() || isObject()));
        _type = JSONTypeInt64;
        _data.int64 = value;
    }

    void set(const uint64_t value) {
        assert(!(isString() || isArray() || isObject()));
        _type = JSONTypeUint64;
        _data.uint64 = value;
    }

    void set(const double_t value) {
        assert(!(isString() || isArray() || isObject()));
        _type = JSONTypeDouble;
        _data.float64 = value;
    }

    void set(const bool_t value) {
        assert(!(isString() || isArray() || isObject()));
        _type = value ? JSONTypeTrue : JSONTypeFalse;
        _data.uint64 = 0llu;
    }

    void append(const uint8_t value) {
        assert(_type == JSONTypeString);
        if (_data.string->empty()) {
            _data.string->reserve(defaultStringCapacity);
        }
        _data.string->push_back(static_cast<char>(value));
    }

    void append(const uint8_t* value, size_t count) {
        assert(_type == JSONTypeString);
        if (_data.string->empty()) {
            _data.string->reserve(std::min(defaultStringCapacity, count));
        }
        _data.string->append(reinterpret_cast<const char*>(value), count);
    }

    // *end not included.
    void append(const uint8_t* start, const uint8_t* end) {
        assert(_type == JSONTypeString);
        assert(end > start);
        if (_data.string->empty()) {
            _data.string->reserve(std::min(defaultStringCapacity, static_cast<size_t>(end - start)));
        }
        _data.string->append(reinterpret_cast<const char*>(start), reinterpret_cast<const char*>(end));
    }

    void append(const string_t& value) {
        assert(_type == JSONTypeString);
        if (_data.string->empty()) {
            _data.string->reserve(std::min(defaultStringCapacity, static_cast<std::size_t>(value.size())));
        }
        _data.string->append(value);
    }

    value_t& append(const value_t& value) {
        assert(_type == JSONTypeArray);
        _data.array->push_back(value);
        return _data.array->back();
    }

    value_t& append(value_t&& value) {
        assert(_type == JSONTypeArray);
        _data.array->push_back(std::move(value));
        return _data.array->back();
    }

    template<typename ...Args>
    value_t& appendValue(Args&& ...args) {
        assert(_type == JSONTypeArray);
        _data.array->emplace_back(std::forward<Args>(args)...);
        return _data.array->back();
    }

#if (SP_JSON_MAP_TYPE == 1)
    typename object_t::reference append(string_t&& key, value_t&& value) {
        assert(_type == JSONTypeObject);
        return _data.object->emplace_back(std::pair{std::move(key), std::move(value)});
    }
#else
    std::pair<typename object_t::iterator, bool> append(value_t&& key, value_t&& value) {
        assert(_type == JSONTypeObject);
        auto temp = std::move(key);
        return _data.object->insert({std::move(*temp._data.string), std::move(value)});
    }

    std::pair<typename object_t::iterator, bool> append(string_t&& key, value_t&& value) {
        assert(_type == JSONTypeObject);
        return _data.object->insert({std::move(key), std::move(value)});
    }
#endif

    bool operator==(const JSON& other) const noexcept {
        if (_type != other._type) {
            if (isDouble() || other.isDouble()) {
                auto lhs = asFloat64();
                auto rhs = other.asFloat64();
                if (!lhs || !rhs) {
                    return false;
                }
                return isEqual(lhs.value(), rhs.value());
            } else if (isUint64() || isUint64()) {
                auto lhs = asUint64();
                auto rhs = other.asUint64();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() == rhs.value();
            } else if (isInt64() || other.isInt64()) {
                auto lhs = asInt64();
                auto rhs = other.asInt64();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() == rhs.value();
            } else if (isUint() || other.isUint()) {
                auto lhs = asUint32();
                auto rhs = other.asUint32();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() == rhs.value();
            } else if (isInt32() || other.isInt32()) {
                auto lhs = asInt32();
                auto rhs = other.asInt32();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() == rhs.value();
            } else {
                return false;
            }
        }
        switch (_type) {
            case JSONTypeInt:
                return _data.i.int32 == other._data.i.int32;
            case JSONTypeUint:
                return _data.u.uint32 == other._data.u.uint32;
            case JSONTypeInt64:
                return _data.int64 == other._data.int64;
            case JSONTypeUint64:
                return _data.uint64 == other._data.uint64;
            case JSONTypeDouble:
                return _data.float64 == _data.float64;
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
                return true;
            case JSONTypeString:
                return (*_data.string) == (*other._data.string);
            case JSONTypeArray:
                return (*_data.array) == (*other._data.array);
            case JSONTypeObject:
                return (*_data.object) == (*other._data.object);
        }
    }

    bool operator!=(const JSON& other) const noexcept {
        return !(operator==(other));
    }

    bool operator>(const JSON& other) const noexcept {
        if (_type != other._type) {
            if (isDouble() || other.isDouble()) {
                auto lhs = asFloat64();
                auto rhs = other.asFloat64();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() > rhs.value();
            } else if (isUint64() || isUint64()) {
                auto lhs = asUint64();
                auto rhs = other.asUint64();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() > rhs.value();
            } else if (isInt64() || other.isInt64()) {
                auto lhs = asInt64();
                auto rhs = other.asInt64();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() > rhs.value();
            } else if (isUint() || other.isUint()) {
                auto lhs = asUint32();
                auto rhs = other.asUint32();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() > rhs.value();
            } else if (isInt32() || other.isInt32()) {
                auto lhs = asInt32();
                auto rhs = other.asInt32();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() > rhs.value();
            } else {
                return false;
            }
        }
        switch (_type) {
            case JSONTypeInt:
                return _data.i.int32 > other._data.i.int32;
            case JSONTypeUint:
                return _data.u.uint32 > other._data.u.uint32;
            case JSONTypeInt64:
                return _data.int64 > other._data.int64;
            case JSONTypeUint64:
                return _data.uint64 > other._data.uint64;
            case JSONTypeDouble:
                return _data.float64 > _data.float64;
            case JSONTypeNull:
                return false;
            case JSONTypeTrue:
            case JSONTypeFalse: {
                return boolean() > other.boolean();
            }
            case JSONTypeString:
                return (*_data.string) > (*other._data.string);
            case JSONTypeArray:
                return (*_data.array) > (*other._data.array);
            case JSONTypeObject:
                return false;
        }
    }

    bool operator<(const JSON& other) const noexcept {
        if (_type != other._type) {
            if (isDouble() || other.isDouble()) {
                auto lhs = asFloat64();
                auto rhs = other.asFloat64();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() < rhs.value();
            } else if (isUint64() || isUint64()) {
                auto lhs = asUint64();
                auto rhs = other.asUint64();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() < rhs.value();
            } else if (isInt64() || other.isInt64()) {
                auto lhs = asInt64();
                auto rhs = other.asInt64();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() < rhs.value();
            } else if (isUint() || other.isUint()) {
                auto lhs = asUint32();
                auto rhs = other.asUint32();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() < rhs.value();
            } else if (isInt32() || other.isInt32()) {
                auto lhs = asInt32();
                auto rhs = other.asInt32();
                if (!lhs || !rhs) {
                    return false;
                }
                return lhs.value() < rhs.value();
            } else {
                return false;
            }
        }
        switch (_type) {
            case JSONTypeInt:
                return _data.i.int32 < other._data.i.int32;
            case JSONTypeUint:
                return _data.u.uint32 < other._data.u.uint32;
            case JSONTypeInt64:
                return _data.int64 < other._data.int64;
            case JSONTypeUint64:
                return _data.uint64 < other._data.uint64;
            case JSONTypeDouble:
                return _data.float64 < _data.float64;
            case JSONTypeNull:
                return false;
            case JSONTypeTrue:
            case JSONTypeFalse: {
                return boolean() < other.boolean();
            }
            case JSONTypeString:
                return (*_data.string) < (*other._data.string);
            case JSONTypeArray:
                return (*_data.array) < (*other._data.array);
            case JSONTypeObject:
                return false;
        }
    }

    bool operator>=(const JSON& other) const noexcept {
        return !(other.operator<(*this));
    }

    bool operator<=(const JSON& other) const noexcept {
        return !(other.operator>(*this));
    }

    template<typename T, typename ...Args>
    static T* SP_NONNULL create(Args&& ...args) {
        Allocator<T> allocator;
        using traits = std::allocator_traits<Allocator<T>>;
        auto p = traits::allocate(allocator, 1);
        traits::construct(allocator, p, std::forward<Args>(args)...);
        assert(p != nullptr);
        return p;
    }

    template<typename T>
    static void destroy(T* SP_NULLABLE pointer) {
        if (pointer == nullptr) {
            return;
        }
        Allocator<T> allocator;
        using traits = std::allocator_traits<Allocator<T>>;
        traits::destroy(allocator, pointer);
        traits::deallocate(allocator, pointer, 1);
    }

private:
    static constexpr size_t defaultStringCapacity = 16;
    static constexpr uint64_t doubleMaxUPL = 4ull;
    static constexpr uint64_t doubleBitMask = 0x8000'0000'0000'0000ull;

    template<typename Number>
    static constexpr Number max() {
        return std::numeric_limits<Number>::max();
    }

    template<typename Number>
    static constexpr Number min() {
        return std::numeric_limits<Number>::min();
    }

    static constexpr uint64_t magnitude(const uint64_t& number) {
        return (doubleBitMask & number) ? (~number + 1) : (doubleBitMask | number);
    }

    // https://github.com/google/googletest/blob/master/googletest/include/gtest/internal/gtest-internal.h
    // https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/
    static bool isEqual(double_t& lhs, double_t rhs) {
        if (std::isnan(lhs) || std::isnan(rhs)) {
            return false;
        }
        const auto left = magnitude(*reinterpret_cast<uint64_t*>(&lhs));
        const auto right = magnitude(*reinterpret_cast<uint64_t*>(&rhs));
        const auto distance = left >= right ? (left - right) : (right - left);
        return distance <= doubleMaxUPL;
    }

    static bool isGreaterOrEqual(double_t& lhs, double_t rhs) {
        return lhs > rhs || isEqual(lhs, rhs);
    }

    JSONType _type = JSONTypeNull;
    Data _data = {};

    void assert_invariant() const noexcept {
        assert(_type != JSONTypeObject || _data.object != nullptr);
        assert(_type != JSONTypeArray || _data.array != nullptr);
        assert(_type != JSONTypeString || _data.string != nullptr);
    }
};

SP_SIMPLE_CONVERSION(JSON<>, JSONRef);

SP_CPP_FILE_END

#endif // START_POINT_JSON_HPP
