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

#include <vector>
#include <string>
#include <optional>
#include <cmath> // for std::round
#include "Config.h"
#include "JSON.h"

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
    using float_t = double;
    using string_t = std::string;
    using array_t = std::vector<value_t>;
    using object_t = std::vector<value_t>;

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
        float_t floating;

        Data() : uint64() {}

        explicit Data(const JSONType type) : uint64() {
            switch (type) {
                case JSONTypeObject:
                    object = JSON::create<object_t>();
                case JSONTypeArray:
                    array = JSON::create<array_t>();
                case JSONTypeString:
                    string = JSON::create<string_t>();
                default:
                    break;
            }
        }

        explicit Data(const string_t& value) : uint64() {
            string = JSON::create(value);
        }

        explicit Data(string_t&& value) : uint64() {
            string = JSON::create(value);
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

    explicit JSON(const float_t value) : _type(JSONTypeDouble), _data() {
        _data.floating = value;
        assert_invariant();
    }

    explicit JSON(const bool_t value) : _type(value ? JSONTypeTrue : JSONTypeFalse), _data() {
        assert_invariant();
    }

    explicit JSON(std::nullptr_t value = nullptr) : _type(JSONTypeNull), _data() {
        assert_invariant();
    }

    JSON(const JSON& other) : _type(other._type), _data(other._data) {
        other.assert_invariant();
        assert_invariant();
    }

    JSON(JSON&& other) noexcept : _type(std::move(other._type)), _data(std::move(other._data)) {
        other.assert_invariant();
        assert_invariant();
        other._type = JSONTypeNull;
        other._data = {};
    }

    ~JSON() noexcept {
        assert_invariant();
        _data.destroy(_type);
    }

    JSON& operator=(const JSON& other) {
        other.assert_invariant();
        std::swap(_type, other._type);
        std::swap(_data, other._data);
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
        return _type == JSONTypeString || _type == JSONTypeArray || _type == JSONTypeObject;
    }

    [[nodiscard]] auto int32() const noexcept {
        assert(isInt32());
        return _data.i.int32;
    }

    [[nodiscard]] std::optional<int32_t> asInt32() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return _data.i.int32;
            case JSONTypeUint:
                return _data.u.uint32 > static_cast<uint32_t>(max<int32_t>()) ?
                       std::nullopt : std::optional{static_cast<int32_t>(_data.u.uint32)};
            case JSONTypeDouble: {
                auto value = _data.floating;
                if (value > static_cast<float_t>(min<int32_t>()) &&
                    value < static_cast<float_t>(max<int32_t>()) &&
                    isEqual(value, std::round(value))) {
                    return static_cast<int32_t>(value);
                }
                return std::nullopt;
            }
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

    [[nodiscard]] auto int64() const noexcept {
        assert(isInt64());
        return _data.int64;
    }

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
            case JSONTypeDouble: {
                auto value = _data.floating;
                if (value > static_cast<float_t>(min<int64_t>()) &&
                    value < static_cast<float_t>(max<int64_t>()) &&
                    isEqual(value, std::round(value))) {
                    return static_cast<int64_t>(value);
                }
                return std::nullopt;
            }
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return std::nullopt;
        }
    }

    [[nodiscard]] auto uint32() const noexcept {
        assert(isUint());
        return _data.u.uint32;
    }

    [[nodiscard]] std::optional<uint32_t> asUint32() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return std::nullopt; // mast < 0
            case JSONTypeUint:
                return _data.u.uint32;
            case JSONTypeDouble: {
                auto value = _data.floating;
                if (isGreaterOrEqual(value, 0.0) &&
                    value < static_cast<float_t>(max<uint32_t>()) &&
                    isEqual(value, std::round(value))) {
                    return static_cast<uint32_t>(value);
                }
                return std::nullopt;
            }
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

    [[nodiscard]] auto uint64() const noexcept {
        assert(isUint64());
        return _data.uint64;
    }

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
            case JSONTypeDouble: {
                auto value = _data.floating;
                if (value > static_cast<float_t>(min<int64_t>()) &&
                    value < static_cast<float_t>(max<int64_t>()) &&
                    isEqual(value, std::round(value))) {
                    return static_cast<int64_t>(value);
                }
                return std::nullopt;
            }
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return std::nullopt;
        }
    }

    [[nodiscard]] auto float64() const noexcept {
        assert(isDouble());
        return _data.floating;
    }

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
                return static_cast<float>(_data.floating);
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return std::nullopt;
        }
    }

    [[nodiscard]] std::optional<float_t> asFloat64() const noexcept {
        switch (_type) {
            case JSONTypeInt:
                return static_cast<float_t>(_data.i.int32);
            case JSONTypeUint:
                return static_cast<float_t>(_data.u.uint32);
            case JSONTypeInt64:
                return static_cast<float_t>(_data.int64);
            case JSONTypeUint64:
                return static_cast<float_t>(_data.uint64);
            case JSONTypeDouble:
                return _data.floating;
            case JSONTypeNull:
            case JSONTypeTrue:
            case JSONTypeFalse:
            case JSONTypeString:
            case JSONTypeArray:
            case JSONTypeObject:
                return std::nullopt;
        }
    }

    [[nodiscard]] auto boolean() const noexcept {
        assert(isBool());
        return _type == JSONTypeTrue;
    }

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

    void appendChar(const uint8_t value) {
        append(static_cast<char>(value));
    }

    void append(const char value) {
        assert(_type == JSONTypeString);
        if (_data.string->empty()) {
            _data.string->reserve(defaultStringCapacity);
        }
        _data.string->push_back(value);
    }

    void append(const string_t& value) {
        assert(_type == JSONTypeString);
        if (_data.string->empty()) {
            _data.string->reserve(std::min(defaultStringCapacity, static_cast<std::size_t>(value.size())));
        }
        _data.string->append(value);
    }

    value_t& append(const value_t& value) {
        assert(_type == JSONTypeArray || _type == JSONTypeObject);
        _data.array->push_back(value);
        return _data.array->back();
    }

    value_t& append(value_t&& value) {
        assert(_type == JSONTypeArray || _type == JSONTypeObject);
        _data.array->push_back(std::move(value));
        return _data.array->back();
    }

    template<typename ...Args>
    value_t& appendValue(Args&& ...args) {
        assert(_type == JSONTypeArray || _type == JSONTypeObject);
        _data.array->emplace_back(std::forward<Args>(args)...);
        return _data.array->back();
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
    static const size_t defaultStringCapacity = 16;
    static const uint64_t doubleMaxUPL = 4ull;
    static const uint64_t doubleBitMask = 0x8000'0000'0000'0000ull;

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

SP_CPP_FILE_END

#endif // START_POINT_JSON_HPP
