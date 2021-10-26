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

#ifndef START_POINT_DEFINE_COMPILER_H
#define START_POINT_DEFINE_COMPILER_H

/// COMPILER() - the compiler being used to build the project
#define COMPILER(SP_COMPILER) (defined SP_COMPILER_##SP_COMPILER && SP_COMPILER_##SP_COMPILER)

/// COMPILER_HAS_BUILTIN() - whether the compiler supports a particular clang builtin.
#ifdef __has_builtin
#   define COMPILER_HAS_BUILTIN(x) __has_builtin(x)
#else
#   define COMPILER_HAS_BUILTIN(x) 0
#endif

#ifdef __has_cpp_attribute
#   define COMPILER_HAS_CPP_ATTRIBUTE(x) __has_cpp_attribute(x)
#else
#   define COMPILER_HAS_CPP_ATTRIBUTE(x) 0
#endif

/// COMPILER_HAS_DECLSPEC() - whether the compiler supports a Microsoft style __declspec attribute.
/// https://clang.llvm.org/docs/LanguageExtensions.html#has-declspec-attribute
#ifdef __has_declspec_attribute
#   define COMPILER_HAS_DECLSPEC(x) __has_declspec_attribute(x)
#else
#   define COMPILER_HAS_DECLSPEC(x) 0
#endif

/// COMPILER_HAS_FEATURE() - whether the compiler supports a particular language or library feature.
/// http://clang.llvm.org/docs/LanguageExtensions.html#has-feature-and-has-extension
#ifdef __has_feature
#   define COMPILER_HAS_FEATURE(x) __has_feature(x)
#else
#   define COMPILER_HAS_FEATURE(x) 0
#endif

#ifdef __has_include
#   define COMPILER_HAS_INCLUDE(x) __has_include(x)
#else
#   define COMPILER_HAS_INCLUDE(x) 0
#endif

// COMPILER() - primary detection of the compiler being used to build the project, in alphabetical order

// COMPILER(CLANG) - Clang
#if defined(__clang__)
#   define SP_COMPILER_CLANG 1
#endif

// COMPILER(GCC_COMPATIBLE) - GNU Compiler Collection or compatibles
#if defined(__GNUC__)
#   define SP_COMPILER_GCC_COMPATIBLE 1
#endif

// COMPILER(GCC) - GNU Compiler Collection
// Note: This section must come after the Clang section since we check !COMPILER(CLANG) here.
#if COMPILER(GCC_COMPATIBLE) && !COMPILER(CLANG)
#   define SP_COMPILER_GCC 1
#endif

// COMPILER(MINGW) - MinGW GCC
#if defined(__MINGW32__)
#   define WTF_COMPILER_MINGW 1
#   include <_mingw.h>
#endif

// COMPILER(MINGW64) - mingw-w64 GCC - used as additional check to exclude mingw.org specific functions
// Note: This section must come after the MinGW section since we check COMPILER(MINGW) here.
#if COMPILER(MINGW) && defined(__MINGW64_VERSION_MAJOR) /* best way to check for mingw-w64 vs mingw.org */
#   define WTF_COMPILER_MINGW64 1
#endif

// COMPILER(MSVC) - Microsoft Visual C++
#if defined(_MSC_VER)
#   define WTF_COMPILER_MSVC 1
#endif

// COMPILER_SUPPORTS - additional compiler feature detection, in alphabetical order

// ASAN_ENABLED
#ifdef __SANITIZE_ADDRESS__
#   define ASAN_ENABLED 1
#else
#   define ASAN_ENABLED COMPILER_HAS_FEATURE(address_sanitizer)
#endif

// SUPPRESS_ASAN
#if ASAN_ENABLED
#   define SUPPRESS_ASAN __attribute__((no_sanitize_address))
#else
#   define SUPPRESS_ASAN
#endif

// Compiler-independent macros for various compiler features, in alphabetical order

// ALWAYS_INLINE
// In GCC functions marked with no_sanitize_address cannot call functions that are marked with
// always_inline and not marked with no_sanitize_address.
// Therefore, we need to give up on the enforcement of ALWAYS_INLINE when building with ASAN.
// https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
#if !defined(ALWAYS_INLINE) && COMPILER(GCC_COMPATIBLE) && defined(NDEBUG) && \
    !COMPILER(MINGW) && !(COMPILER(GCC) && ASAN_ENABLED)
#   define ALWAYS_INLINE inline __attribute__((__always_inline__))
#endif

#if !defined(ALWAYS_INLINE) && COMPILER(MSVC) && defined(NDEBUG)
#   define ALWAYS_INLINE __forceinline
#endif

#if !defined(ALWAYS_INLINE)
#   define ALWAYS_INLINE inline
#endif

#if COMPILER(MSVC)
#   define ALWAYS_INLINE_EXCEPT_MSVC inline
#else
#   define ALWAYS_INLINE_EXCEPT_MSVC ALWAYS_INLINE
#endif

// LIKELY
#if !defined(LIKELY) && COMPILER(GCC_COMPATIBLE)
#   define LIKELY(x) __builtin_expect(!!(x), 1)
#endif

#if !defined(LIKELY)
#   define LIKELY(x) (x)
#endif

// UNLIKELY
#if !defined(UNLIKELY) && COMPILER(GCC_COMPATIBLE)
#   define UNLIKELY(x) __builtin_expect(!!(x), 0)
#endif

#if !defined(UNLIKELY)
#   define UNLIKELY(x) (x)
#endif

#endif // START_POINT_DEFINE_COMPILER_H
