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

#ifndef __START_POINT_ANY_LIST_HPP
#define __START_POINT_ANY_LIST_HPP

#if (__cplusplus)

#include <memory>
#include <vector>
#include "Config.h"

SP_CPP_FILE_BEGIN

template<typename Allocator = std::allocator<char>>
class AnyList final {
public:
    typedef Allocator allocator_type;
    typedef typename allocator_type::size_type size_type;

    inline explicit AnyList() noexcept(noexcept(allocator_type())):
        _start(nullptr), _end(nullptr), _current(nullptr), _allocator() {
    }

    inline explicit AnyList(const allocator_type &allocator) noexcept:
        _start(nullptr), _end(nullptr), _current(nullptr), _allocator(allocator) {
    }

    inline explicit AnyList(size_type count, const allocator_type &allocator = allocator_type()) noexcept:
        _allocator(allocator) {
        _start = doAllocate(count);
        _end = _start + count;
        _current = _start;
    }

    template<typename T, typename std::enable_if_t<std::is_pod<T>::value, int> = 0>
    inline AnyList(T *SP_NONNULL begin, T *SP_NONNULL end,
                   const allocator_type &allocator = allocator_type()) noexcept : _allocator(allocator) {
        const auto count = static_cast<size_type>(end - begin);
        _start = doAllocate(count);
        _end = _start + count;
        _current = _start;
        append<T>(begin, end);
    }

    inline AnyList(AnyList &&other) noexcept:
        _start(other._start), _end(other._end), _current(other._current), _allocator(std::move(other._allocator)) {
        other._start = nullptr;
        other._end = nullptr;
        other._current = nullptr;
    }

    inline ~AnyList() {
        doDeallocate(_start, _end);
    }

    template<typename T>
    inline T *SP_NULLABLE first() noexcept {
        return reinterpret_cast<T*>(_start);
    }

    template<typename T>
    inline const T *SP_NULLABLE first() const noexcept {
        return reinterpret_cast<T*>(_start);
    }

    template<typename T>
    inline T *SP_NULLABLE last() noexcept {
        return reinterpret_cast<T*>(_end);
    }

    template<typename T>
    inline const T *SP_NULLABLE last() const noexcept {
        return reinterpret_cast<T*>(_end);
    }

    inline bool empty() const noexcept {
        return _start == _end;
    }

    inline size_type size() const noexcept {
        return static_cast<size_type>(_current - _start);
    }

    inline size_type capacity() const noexcept {
        return static_cast<size_type>(_end - _start);
    }

    inline void shrink() {
        if (_current != _end) {
            doDeallocate(_current, _end);
            _end = _current;
        }
    }

    template<typename T, typename std::enable_if_t<std::is_pod<T>::value, int> = 0>
    inline void append(const T &value) {
        reserve<T>();
        ::new(_current) T(value);
        _current += sizeof(T);
    }

    template<typename T, typename std::enable_if_t<std::is_pod<T>::value, int> = 0>
    inline void append(T &&value) {
        reserve<T>();
        ::new(_current) T(std::move(value));
        _current += sizeof(T);
    }

    template<typename T, typename std::enable_if_t<std::is_pod<T>::value, int> = 0>
    inline T& append() {
        reserve<T>();
        auto last = _current;
        ::new(_current) T();
        _current += sizeof(T);
        return reinterpret_cast<T*>(last);
    }

    template<typename T, typename R, typename... Args, typename std::enable_if_t<std::is_pod<T>::value, int> = 0>
    inline T *SP_NONNULL appendInPlace(R *SP_NONNULL position, Args &&... args) {
        const auto n = position + sizeof(R) - _start;
        reserve<T>();
        ::new(_current) T(std::forward<Args>(args)...);
        _current += sizeof(T);
        return reinterpret_cast<T*>(_start + n);
    }

    template<typename T, typename std::enable_if_t<std::is_pod<T>::value, int> = 0>
    inline void append(T *SP_NONNULL start, T *SP_NONNULL end) {
        reserve<T>(static_cast<size_type>(end - start));
        const auto n = sizeof(T);
        T* index = start;
        while (index < end) {
            ::new(_current) T(*index);
            _current += n;
            index += 1;
        }
    }

    template<typename T, typename std::enable_if_t<std::is_pod<T>::value, int> = 0>
    inline void append(T *SP_NONNULL start, size_type count) {
        reserve<T>(count);
        const auto n = sizeof(T);
        T* index = start;
        const auto end = start + count;
        while (index < end) {
            ::new(_current) T(*index);
            _current += n;
            index += 1;
        }
    }

    template<typename T>
    inline T& at(size_type offset) {
        assert(static_cast<size_type>(_end - _start) >= offset);
        auto result = reinterpret_cast<T*>(_start + offset);
        return *result;
    }

    template<typename T>
    inline const T& at(size_type offset) const {
        assert(static_cast<size_type>(_end - _start) >= offset);
        auto result = reinterpret_cast<T*>(_start + offset);
        return *result;
    }

    inline char *SP_NULLABLE data() noexcept {
        return _start;
    }

    inline char *SP_NULLABLE data() const noexcept {
        return _start;
    }

    inline AnyList& operator=(const AnyList &rhs) {
        if (this != &rhs) {
            doDeallocate(_start, _end);
            auto size = rhs._end - rhs._start;
            _start = doAllocate(static_cast<size_type>(size));
            _current = std::uninitialized_move(rhs._start, rhs._current, _start);
            _end = _start + size;
        }
        return *this;
    }

    template<typename T>
    inline T& operator[](size_type offset) {
        assert(static_cast<size_type>(_end - _start) >= offset);
        return reinterpret_cast<T*>(_start + offset);
    }

    template<typename T>
    inline const T& operator[](size_type offset) const {
        assert(static_cast<size_type>(_end - _start) >= offset);
        return reinterpret_cast<T*>(_start + offset);
    }

private:
    template<typename T>
    void reserve(size_type size = 1) {
        if ((_end - _current) < static_cast<std::ptrdiff_t>(sizeof(T))) {
            expand<T>(size);
        }
    }

    template<typename T>
    inline void expand(size_type size) {
        const auto oldSize = static_cast<size_type>(_end - _start);
        const auto newSize = newCapacity<T>(oldSize, size);
        char *const newStart = doAllocate(newSize);
        char *const newCurrent = std::uninitialized_move(_start, _current, newStart);
        doDeallocate(_start, _current);
        _start = newStart;
        _current = newCurrent;
        _end = newStart + newSize;
    }

    template<typename T>
    inline size_type newCapacity(size_type current, size_type size) {
        size_type capacity = current * 2;
        size_type required = current + sizeof(T) * size;
        if (capacity < required) {
            capacity = required;
        }
        return capacity;
    }

    inline char *SP_NULLABLE doAllocate(size_type size) {
        if (SP_UNLIKELY(size >= 0x80000000)) {
            printf("AnyList::doAllocate -- improbably large request.");
        }
        if (SP_LIKELY(size)) {
            auto p = _allocator.allocate(size);
            assert(p != nullptr);
            return p;
        } else {
            return nullptr;
        }
    }

    inline void doDeallocate(char *SP_NULLABLE start, char *SP_NULLABLE end) {
        if (start != nullptr) {
            _allocator.deallocate(start, static_cast<size_type>(end - start));
        }
    }

    char *_start;
    char *_end;
    char *_current;
    allocator_type _allocator;
};

SP_CPP_FILE_END

#endif // __cplusplus

#endif // __START_POINT_ANY_LIST_HPP
