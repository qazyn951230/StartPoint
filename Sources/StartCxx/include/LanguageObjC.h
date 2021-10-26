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

#ifndef START_POINT_DEFINE_LANGUAGE_OBJC_H
#define START_POINT_DEFINE_LANGUAGE_OBJC_H

// Foundation & CoreFoundation compatible marcos

// Enums and Options
#if !defined(CF_ENUM)

// Copied from .../CoreFoundation.framework/Headers/CFAvailability.h
#if __has_attribute(enum_extensibility)
#   define __CF_ENUM_ATTRIBUTES __attribute__((enum_extensibility(open)))
#   define __CF_CLOSED_ENUM_ATTRIBUTES __attribute__((enum_extensibility(closed)))
#   define __CF_OPTIONS_ATTRIBUTES __attribute__((flag_enum,enum_extensibility(open)))
#else
#   define __CF_ENUM_ATTRIBUTES
#   define __CF_CLOSED_ENUM_ATTRIBUTES
#   define __CF_OPTIONS_ATTRIBUTES
#endif // __has_attribute(enum_extensibility)

#define __CF_ENUM_GET_MACRO(_1, _2, NAME, ...) NAME

#ifndef CF_OPEN_SOURCE
#   define __CF_ENUM_FIXED_IS_AVAILABLE (__cplusplus && __cplusplus >= 201103L && \
    (__has_extension(cxx_strong_enums) || __has_feature(objc_fixed_enum))) ||     \
    (!__cplusplus && __has_feature(objc_fixed_enum))
#else
#   define __CF_ENUM_FIXED_IS_AVAILABLE (__cplusplus && __cplusplus >= 201103L && \
    (__has_extension(cxx_strong_enums) || __has_feature(objc_fixed_enum))) ||     \
    (!__cplusplus && (__has_feature(objc_fixed_enum) || __has_extension(cxx_fixed_enum)))
#endif // CF_OPEN_SOURCE

#if __CF_ENUM_FIXED_IS_AVAILABLE
#   define __CF_NAMED_ENUM(_type, _name)     enum __CF_ENUM_ATTRIBUTES _name : _type _name; enum _name : _type
#   define __CF_ANON_ENUM(_type)             enum __CF_ENUM_ATTRIBUTES : _type
#   define CF_CLOSED_ENUM(_type, _name)      enum __CF_CLOSED_ENUM_ATTRIBUTES _name : _type _name; enum _name : _type
#   if (__cplusplus)
#       define CF_OPTIONS(_type, _name) _type _name; enum __CF_OPTIONS_ATTRIBUTES : _type
#   else
#       define CF_OPTIONS(_type, _name) enum __CF_OPTIONS_ATTRIBUTES _name : _type _name; enum _name : _type
#   endif
#else
#   define __CF_NAMED_ENUM(_type, _name) _type _name; enum
#   define __CF_ANON_ENUM(_type) enum
#   define CF_CLOSED_ENUM(_type, _name) _type _name; enum
#   define CF_OPTIONS(_type, _name) _type _name; enum
#endif // __CF_ENUM_FIXED_IS_AVAILABLE

#define CF_ENUM(...) __CF_ENUM_GET_MACRO(__VA_ARGS__, __CF_NAMED_ENUM, __CF_ANON_ENUM, )(__VA_ARGS__)

#if __has_attribute(swift_wrapper)
#   define _CF_TYPED_ENUM __attribute__((swift_wrapper(enum)))
#else
#   define _CF_TYPED_ENUM
#endif

#if __has_attribute(swift_wrapper)
#   define _CF_TYPED_EXTENSIBLE_ENUM __attribute__((swift_wrapper(struct)))
#else
#   define _CF_TYPED_EXTENSIBLE_ENUM
#endif

#if DEPLOYMENT_RUNTIME_SWIFT
#   define CF_STRING_ENUM
#   define CF_EXTENSIBLE_STRING_ENUM

#   define CF_TYPED_ENUM
#   define CF_TYPED_EXTENSIBLE_ENUM
#else
#   define CF_STRING_ENUM _CF_TYPED_ENUM
#   define CF_EXTENSIBLE_STRING_ENUM _CF_TYPED_EXTENSIBLE_ENUM

#   define CF_TYPED_ENUM _CF_TYPED_ENUM
#   define CF_TYPED_EXTENSIBLE_ENUM _CF_TYPED_EXTENSIBLE_ENUM
#endif

#define __CF_ERROR_ENUM_GET_MACRO(_1, _2, NAME, ...) NAME

#if ((__cplusplus && __cplusplus >= 201103L && (__has_extension(cxx_strong_enums) || __has_feature(objc_fixed_enum))) \
    || (!__cplusplus && __has_feature(objc_fixed_enum))) && __has_attribute(ns_error_domain)
#   define __CF_NAMED_ERROR_ENUM(_domain, _name)     \
    enum __attribute__((ns_error_domain(_domain))) _name : CFIndex _name; enum _name : CFIndex
#   define __CF_ANON_ERROR_ENUM(_domain)             \
    enum __attribute__((ns_error_domain(_domain))) : CFIndex
#else
#   define __CF_NAMED_ERROR_ENUM(_domain, _name) __CF_NAMED_ENUM(CFIndex, _name)
#   define __CF_ANON_ERROR_ENUM(_domain) __CF_ANON_ENUM(CFIndex)
#endif

#define CF_ERROR_ENUM(...) \
    __CF_ERROR_ENUM_GET_MACRO(__VA_ARGS__, __CF_NAMED_ERROR_ENUM, __CF_ANON_ERROR_ENUM)(__VA_ARGS__)

#endif // defined(CF_ENUM)

//  Copied from ../Foundation.framework/Headers/NSObjCRuntime.h
#define SP_ENUM(...) CF_ENUM(__VA_ARGS__)
#define SP_OPTIONS(_type, _name) CF_OPTIONS(_type, _name)
#define SP_CLOSED_ENUM(_type, _name) CF_CLOSED_ENUM(_type, _name)
#define SP_STRING_ENUM _CF_TYPED_ENUM
#define SP_EXTENSIBLE_STRING_ENUM _CF_TYPED_EXTENSIBLE_ENUM
#define SP_TYPED_ENUM _CF_TYPED_ENUM
#define SP_TYPED_EXTENSIBLE_ENUM _CF_TYPED_EXTENSIBLE_ENUM

#define SP_ERROR_ENUM(...) CF_ERROR_ENUM(__VA_ARGS__)

// Copied from .../usr/include/objc/NSObjCRuntime.h
#if COMPILER_HAS_INCLUDE(<NSObjCRuntime.h>)

#include <NSObjCRuntime.h>

#else

#if __LP64__ || 0 || NS_BUILD_32_LIKE_64
typedef long NSInteger;
typedef unsigned long NSUInteger;
#else
typedef int NSInteger;
typedef unsigned int NSUInteger;
#endif // __LP64__ || 0 || NS_BUILD_32_LIKE_64

#endif // !__has_include(<NSObjCRuntime.h>)

#endif // START_POINT_DEFINE_LANGUAGE_OBJC_H
