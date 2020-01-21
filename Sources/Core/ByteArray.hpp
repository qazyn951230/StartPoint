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

#ifndef START_POINT_BYTE_ARRAY_HPP
#define START_POINT_BYTE_ARRAY_HPP

#include <cstdint>
#include <cstddef>
#include <memory>
#include <algorithm>
#include <type_traits>
#include "Config.h"

SP_CPP_FILE_BEGIN

class ByteArray {
public:
    using char_t = char;
    using size_t = std::size_t;

    ByteArray(size_t capacity = defaultCapacity): _start(nullptr), _end(nullptr), _current(nullptr) {
        if (capacity > 1) {
            _start = ByteArray::malloc(capacity);
            _end = _start + capacity;
            _current = _start;
        }
    }

    ByteArray(const ByteArray&) = delete;

    ByteArray(ByteArray&&) = delete;

    ByteArray& operator=(const ByteArray&) = delete;

    ByteArray& operator=(ByteArray&&) = delete;

    ~ByteArray() {
        ByteArray::free(_start);
        _start = nullptr;
        _end = nullptr;
        _current = nullptr;
    }

    char* SP_NULLABLE data() noexcept {
        return _start;
    }

    const char* SP_NULLABLE data() const noexcept {
        return _start;
    }

    size_t size() const noexcept {
        assert(_current >= _start);
        return static_cast<size_t>(_current - _start);
    }

    size_t capacity() const noexcept {
        assert(_end >= _start);
        return static_cast<size_t>(_end - _start);
    }

    char* move() noexcept  {
        auto result = _start;
        _start = nullptr;
        _end = nullptr;
        _current = nullptr;
        return result;
    }

    // template<typename T, std::enable_if_t<std::is_function<T>::value, int> = 0>
    template<typename T>
    inline void mutate(const size_t requiredSize, T method) {
        // https://en.cppreference.com/w/cpp/types/result_of
//        using foo = typename std::result_of<T(char)>;
//        static_assert(std::is_same<decltype(foo::type), char*>::value);
        if (requiredSize > static_cast<size_t>(_end - _current)) {
            expand(requiredSize);
        }
        assert(static_cast<size_t>(_end - _current) >= requiredSize);
        _current = method(_current);
    }

    void reserve(size_t size) {
        if (size > static_cast<size_t>(_end - _current)) {
            expand(size);
        }
    }

    void append(const char_t value) {
        reserve(1);
        *_current++ = value;
    }

    void append(const char_t value, size_t count) {
        reserve(count);
        std::memset(_current, static_cast<int>(value), count * sizeof(char_t));
        _current += count;
    }

    void append(const char_t* SP_NULLABLE value, size_t count) {
        if (value == nullptr) {
            return;
        }
        reserve(count);
        std::memcpy(_current, value, count * sizeof(char_t));
        _current += count;
    }

private:
    static const size_t defaultCapacity = 64;

    char_t* SP_NULLABLE _start;
    char_t* SP_NULLABLE _end;
    char_t* SP_NULLABLE _current;

    void expand(const size_t requiredSize) {
        const auto size = this->size();
        const auto capacity = this->capacity();
        auto nextSize = capacity + std::max(capacity, requiredSize);
        _start = ByteArray::realloc(_start, nextSize);
        _current = _start + size;
        _end = _start + nextSize;
    }

    static inline char_t* SP_NONNULL malloc(const size_t size) {
        assert(size != 0);
        return static_cast<char_t*>(std::malloc(sizeof(char) * size));
    }

    static inline char_t* SP_NONNULL realloc(char_t* SP_NULLABLE pointer, const size_t size) {
        assert(size != 0);
        if (pointer == nullptr) {
            return ByteArray::malloc(size);
        }
        return static_cast<char*>(std::realloc(pointer, size));
    }

    static inline void free(char_t* SP_NULLABLE pointer) {
        if (pointer == nullptr) {
            return;
        }
        return std::free(pointer);
    }
};

SP_CPP_FILE_END


#endif // START_POINT_BYTE_ARRAY_HPP
