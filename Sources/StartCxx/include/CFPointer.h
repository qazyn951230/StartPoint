// MIT License
//
// Copyright (c) 2021-present qazyn951230 qazyn951230@gmail.com
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

#ifndef START_POINT_CFPOINTER_H
#define START_POINT_CFPOINTER_H

#include "Compiler.h"
#include "Language.h"

#if SP_LANG_CXX

#if COMPILER_HAS_INCLUDE(<CoreFoundation/CFBase.h>)
#include <CoreFoundation/CFBase.h>
#include <memory>
#include <type_traits>

SP_CPP_FILE_BEGIN

template<typename T>
class CFPointer final {
private:
    static_assert(std::is_pointer_v<T>);
public:

    CFPointer() noexcept = default;

    ~CFPointer() noexcept {
        _release(_value);
    }

    CFPointer(std::nullptr_t) noexcept: _value(nullptr) {}

    explicit CFPointer(T SP_NULLABLE value) noexcept: _value(value) {
        _retain(_value);
    }

    CFPointer(const CFPointer& other) noexcept: _value(other._value) {
        _retain(_value);
    }

    CFPointer(CFPointer&& other) noexcept: _value(other._value) {
        other._value = nullptr;
    }

    CFPointer& operator=(const CFPointer& other) noexcept {
        _release(_value);
        _value = other._value;
        _retain(_value);
        return *this;
    }

    CFPointer& operator=(CFPointer&& other) noexcept {
        _release(_value);
        _value = other._value;
        return *this;
    }

    void reset() {
        _release(_value);
        _value = nullptr;
    }

    void reset(T value) {
        if (LIKELY(value != _value)) {
            _release(_value);
            _value = value;
            _retain(_value);
        }
    }

    T SP_NULLABLE operator*() const noexcept {
        return reinterpret_cast<T>(const_cast<void*>(_value));
    }

    explicit operator bool() const noexcept {
        return _value != nullptr;
    }

private:
    CFTypeRef SP_NULLABLE _value;

    CF_INLINE void _retain(CFTypeRef value) noexcept {
        if (value != nullptr) {
            CFRetain(value); // This value must not be NULL.
        }
    }

    CF_INLINE void _release(CFTypeRef value) noexcept {
        if (value != nullptr) {
            CFRelease(value); // This value must not be NULL.
        }
    }
};

SP_CPP_FILE_END

#endif // CoreFoundation.h

#endif // SP_LANG_CXX

#endif // START_POINT_CFPOINTER_H
