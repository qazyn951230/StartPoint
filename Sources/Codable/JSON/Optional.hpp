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

#ifndef START_POINT_OPTIONAL_HPP
#define START_POINT_OPTIONAL_HPP

#include <cassert>
#include <type_traits>
#include "Config.h"

// Implementation base on LLVM::Optional

SP_CPP_FILE_BEGIN

namespace optional_detail {

struct in_place_t {};

// Storage for any type.
template<typename T, bool = std::is_trivially_copyable<T>::value>
class OptionalStorage {
    union {
        char empty;
        T value;
    };
    bool hasVal;

public:
    ~OptionalStorage() {
        reset();
    }

    OptionalStorage() noexcept : empty(), hasVal(false) {}

    OptionalStorage(OptionalStorage const& other) : OptionalStorage() {
        if (other.hasValue()) {
            emplace(other.value);
        }
    }

    OptionalStorage(OptionalStorage&& other) : OptionalStorage() {
        if (other.hasValue()) {
            emplace(std::move(other.value));
        }
    }

    template<class... Args>
    explicit OptionalStorage(in_place_t, Args&& ... args)
        : value(std::forward<Args>(args)...), hasVal(true) {
    }

    void reset() noexcept {
        if (hasVal) {
            value.~T();
            hasVal = false;
        }
    }

    bool hasValue() const noexcept {
        return hasVal;
    }

    T& getValue()& noexcept {
        assert(hasVal);
        return value;
    }

    T const& getValue() const& noexcept {
        assert(hasVal);
        return value;
    }

    T&& getValue()&& noexcept {
        assert(hasVal);
        return std::move(value);
    }

    template<class... Args>
    void emplace(Args&& ... args) {
        reset();
        ::new((void*) std::addressof(value)) T(std::forward<Args>(args)...);
        hasVal = true;
    }

    OptionalStorage& operator=(T const& y) {
        if (hasValue()) {
            value = y;
        } else {
            ::new((void*) std::addressof(value)) T(y);
            hasVal = true;
        }
        return *this;
    }

    OptionalStorage& operator=(T&& y) {
        if (hasValue()) {
            value = std::move(y);
        } else {
            ::new((void*) std::addressof(value)) T(std::move(y));
            hasVal = true;
        }
        return *this;
    }

    OptionalStorage& operator=(OptionalStorage const& other) {
        if (other.hasValue()) {
            if (hasValue()) {
                value = other.value;
            } else {
                ::new((void*) std::addressof(value)) T(other.value);
                hasVal = true;
            }
        } else {
            reset();
        }
        return *this;
    }

    OptionalStorage& operator=(OptionalStorage&& other) {
        if (other.hasValue()) {
            if (hasValue()) {
                value = std::move(other.value);
            } else {
                ::new((void*) std::addressof(value)) T(std::move(other.value));
                hasVal = true;
            }
        } else {
            reset();
        }
        return *this;
    }
};

template<typename T>
class OptionalStorage<T, true> {
    union {
        char empty;
        T value;
    };
    bool hasVal = false;

public:
    ~OptionalStorage() = default;

    OptionalStorage() noexcept : empty{} {}

    OptionalStorage(OptionalStorage const& other) = default;

    OptionalStorage(OptionalStorage&& other) = default;

    OptionalStorage& operator=(OptionalStorage const& other) = default;

    OptionalStorage& operator=(OptionalStorage&& other) = default;

    template<class... Args>
    explicit OptionalStorage(in_place_t, Args&& ... args)
        : value(std::forward<Args>(args)...), hasVal(true) {
    }

    void reset() noexcept {
        if (hasVal) {
            value.~T();
            hasVal = false;
        }
    }

    bool hasValue() const noexcept {
        return hasVal;
    }

    T& getValue()& noexcept {
        assert(hasVal);
        return value;
    }

    T const& getValue() const& noexcept {
        assert(hasVal);
        return value;
    }

    T&& getValue()&& noexcept {
        assert(hasVal);
        return std::move(value);
    }

    template<class... Args>
    void emplace(Args&& ... args) {
        reset();
        ::new((void*) std::addressof(value)) T(std::forward<Args>(args)...);
        hasVal = true;
    }

    OptionalStorage& operator=(T const& y) {
        if (hasValue()) {
            value = y;
        } else {
            ::new((void*) std::addressof(value)) T(y);
            hasVal = true;
        }
        return *this;
    }

    OptionalStorage& operator=(T&& y) {
        if (hasValue()) {
            value = std::move(y);
        } else {
            ::new((void*) std::addressof(value)) T(std::move(y));
            hasVal = true;
        }
        return *this;
    }
};

} // namespace optional_detail

template<typename T>
class Optional {
    optional_detail::OptionalStorage<T> Storage;

public:
    using value_type = T;

    constexpr Optional() {}

    Optional(const T& y) : Storage(optional_detail::in_place_t{}, y) {}

    Optional(const Optional& O) = default;

    Optional(T&& y) : Storage(optional_detail::in_place_t{}, std::move(y)) {}

    Optional(Optional&& O) = default;

    Optional& operator=(T&& y) {
        Storage = std::move(y);
        return *this;
    }

    Optional& operator=(Optional&& O) = default;

    // Create a new object by constructing it in place with the given arguments.
    template<typename... ArgTypes>
    void emplace(ArgTypes&& ... Args) {
        Storage.emplace(std::forward<ArgTypes>(Args)...);
    }

    static inline Optional create(const T* SP_NULLABLE y) {
        return y ? Optional(*y) : Optional();
    }

    Optional& operator=(const T& y) {
        Storage = y;
        return *this;
    }

    Optional& operator=(const Optional& O) = default;

    void reset() {
        Storage.reset();
    }

    const T* SP_NONNULL getPointer() const {
        return &Storage.getValue();
    }

    T* SP_NONNULL getPointer() {
        return &Storage.getValue();
    }

    const T& value() const& {
        return Storage.getValue();
    }

    T& value()& {
        return Storage.getValue();
    }

    explicit operator bool() const {
        return has_value();
    }

    bool has_value() const {
        return Storage.hasValue();
    }

    const T* SP_NONNULL operator->() const {
        return getPointer();
    }

    T* SP_NONNULL operator->() {
        return getPointer();
    }

    const T& operator*() const& {
        return value();
    }

    T& operator*()& {
        return value();
    }

    template<typename U>
    constexpr T value_or(U&& value) const& {
        return has_value() ? value() : std::forward<U>(value);
    }


    T&& value()&& {
        return std::move(Storage.getValue());
    }

    T&& operator*()&& {
        return std::move(Storage.getValue());
    }

    template<typename U>
    T value_or(U&& value)&& {
        return has_value() ? std::move(value()) : std::forward<U>(value);
    }

};

template<typename T, typename U>
bool operator==(const Optional<T>& X, const Optional<U>& Y) {
    if (X && Y)
        return *X == *Y;
    return X.has_value() == Y.has_value();
}

template<typename T, typename U>
bool operator!=(const Optional<T>& X, const Optional<U>& Y) {
    return !(X == Y);
}

template<typename T, typename U>
bool operator<(const Optional<T>& X, const Optional<U>& Y) {
    if (X && Y)
        return *X < *Y;
    return X.has_value() < Y.has_value();
}

template<typename T, typename U>
bool operator<=(const Optional<T>& X, const Optional<U>& Y) {
    return !(Y < X);
}

template<typename T, typename U>
bool operator>(const Optional<T>& X, const Optional<U>& Y) {
    return Y < X;
}

template<typename T, typename U>
bool operator>=(const Optional<T>& X, const Optional<U>& Y) {
    return !(X < Y);
}

template<typename T>
bool operator==(const Optional<T>& X, const T& Y) {
    return X && *X == Y;
}

template<typename T>
bool operator==(const T& X, const Optional<T>& Y) {
    return Y && X == *Y;
}

template<typename T>
bool operator!=(const Optional<T>& X, const T& Y) {
    return !(X == Y);
}

template<typename T>
bool operator!=(const T& X, const Optional<T>& Y) {
    return !(X == Y);
}

template<typename T>
bool operator<(const Optional<T>& X, const T& Y) {
    return !X || *X < Y;
}

template<typename T>
bool operator<(const T& X, const Optional<T>& Y) {
    return Y && X < *Y;
}

template<typename T>
bool operator<=(const Optional<T>& X, const T& Y) {
    return !(Y < X);
}

template<typename T>
bool operator<=(const T& X, const Optional<T>& Y) {
    return !(Y < X);
}

template<typename T>
bool operator>(const Optional<T>& X, const T& Y) {
    return Y < X;
}

template<typename T>
bool operator>(const T& X, const Optional<T>& Y) {
    return Y < X;
}

template<typename T>
bool operator>=(const Optional<T>& X, const T& Y) {
    return !(X < Y);
}

template<typename T>
bool operator>=(const T& X, const Optional<T>& Y) {
    return !(X < Y);
}

SP_CPP_FILE_END

#endif // START_POINT_OPTIONAL_HPP