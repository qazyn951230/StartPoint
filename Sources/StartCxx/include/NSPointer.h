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

#ifndef START_POINT_NSPOINTER_H
#define START_POINT_NSPOINTER_H

#include "Language.h"

#if SP_LANG_OBJCXX

#include <Foundation/NSObject.h>
#include <cstddef>
#include <type_traits>
#include "Features.h"
#include "Typing.h"

SP_CPP_FILE_BEGIN

template<typename T>
class NSPointer {
public:
    using element_t = T;
    using pointer_t = std::add_pointer_t<element_t>;
    // using const_pointer_t = std::add_const_t<pointer_t>;
    using reference_t = std::add_lvalue_reference_t<element_t>;

    constexpr NSPointer() noexcept = default;

    constexpr NSPointer(std::nullptr_t) noexcept: _value(nullptr) {}

    constexpr explicit NSPointer(T* value) noexcept: _value(value) {}

#if SP_OBJC_HAS_ARC

#endif // SP_OBJC_HAS_ARC

    pointer_t get() const noexcept {
        return _value;
    }

    pointer_t operator->() const noexcept {
        return _value;
    }

private:
    T* _value;
};

template<typename T>
NSPointer<T> ns_ptr(T* value) {
    return {value};
}

SP_CPP_FILE_END

#endif // SP_LANG_OBJCXX

#endif // START_POINT_NSPOINTER_H
