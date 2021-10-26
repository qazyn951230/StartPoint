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

#ifndef START_POINT_DEFINE_LANGUAGE_CXX_H
#define START_POINT_DEFINE_LANGUAGE_CXX_H

#define SP_ASSUME_NONNULL_BEGIN _Pragma("clang assume_nonnull begin")
#define SP_ASSUME_NONNULL_END   _Pragma("clang assume_nonnull end")

#if SP_LANG_CXX
#   define SP_EXTERN_C_BEGIN   extern "C" {
#   define SP_EXTERN_C_END     }
#else
#   define SP_EXTERN_C_BEGIN
#   define SP_EXTERN_C_END
#endif

#if SP_LANG_CXX
#   define SP_C_FILE_BEGIN  SP_ASSUME_NONNULL_BEGIN \
                            SP_EXTERN_C_BEGIN
#   define SP_C_FILE_END    SP_EXTERN_C_END \
                            SP_ASSUME_NONNULL_END
#else
#   define SP_C_FILE_BEGIN  SP_ASSUME_NONNULL_BEGIN
#   define SP_C_FILE_END    SP_ASSUME_NONNULL_END
#endif

#if SP_LANG_CXX
#   define SP_CPP_NAME_SPACE_BEGIN(NAME) namespace NAME {
#   define SP_CPP_NAME_SPACE_END    }
#else
#   define SP_CPP_NAME_SPACE_BEGIN(NAME)
#   define SP_CPP_NAME_SPACE_END
#endif

#if SP_LANG_CXX
#   define CPP_FILE_BEGIN(NAME) SP_ASSUME_NONNULL_BEGIN \
                                SP_CPP_NAME_SPACE_BEGIN(NAME)
#   define CPP_FILE_END         SP_CPP_NAME_SPACE_END \
                                SP_ASSUME_NONNULL_END
#else
#   define CPP_FILE_BEGIN(NAME) SP_ASSUME_NONNULL_BEGIN
#   define CPP_FILE_END         SP_ASSUME_NONNULL_END
#endif

#define SP_CPP_FILE_BEGIN   CPP_FILE_BEGIN(sp)
#define SP_CPP_FILE_END     CPP_FILE_END

#define SP_NAME_SPACE_BEGIN SP_CPP_NAME_SPACE_BEGIN(sp)
#define SP_NAME_SPACE_END   SP_CPP_NAME_SPACE_END

// ------------- NULLABLE ------------------
// http://clang.llvm.org/docs/AttributeReference.html#nullability-attributes
// A nullable pointer to non-null pointers to const characters.
// const char *join_strings(const char * _Nonnull * _Nullable strings, unsigned n);
#if defined(__clang__)
// int fetch(int * SP_NONNULL ptr);
#define SP_NONNULL _Nonnull
#define SP_NULL_UNSPECIFIED _Null_unspecified
// int fetch_or_zero(int * SP_NULLABLE ptr);
#define SP_NULLABLE _Nullable
#else
#define SP_NONNULL
#define SP_NULL_UNSPECIFIED
#define SP_NULLABLE
#endif // defined(__clang__)
// ------------- NULLABLE ------------------

#if SP_LANG_CXX

#define SP_SIMPLE_CONVERSION(CxxType, CRef)                     \
inline CxxType *unwrap(CRef value) {                            \
    return reinterpret_cast<CxxType*>(value);                   \
}                                                               \
                                                                \
inline CRef wrap(const CxxType* value) {                        \
    return reinterpret_cast<CRef>(const_cast<CxxType*>(value)); \
}                                                               \

#define SP_STATIC_CONVERSION(TARGET, SOURCE)                    \
inline TARGET unwrap(const SOURCE& value) {                     \
    return static_cast<TARGET>(value);                          \
}                                                               \
                                                                \
inline SOURCE wrap(const TARGET& value) {                       \
    return static_cast<SOURCE>(value);                          \
}                                                               \

#define SP_POINTER_CAST(type, source) (reinterpret_cast<type>(source))

#else // SP_LANG_CXX

#define SP_SIMPLE_CONVERSION(CxxType, CRef)                     \
inline CxxType *unwrap(CRef value) {                            \
    return (CxxType*)(value);                                   \
}                                                               \
                                                                \
inline CRef wrap(const CxxType* value) {                        \
    return (CRef)(const_cast<CxxType*>(value));                 \
}                                                               \

#define SP_STATIC_CONVERSION(TARGET, SOURCE)                    \
inline TARGET unwrap(const SOURCE& value) {                     \
    return (TARGET)(value);                                     \
}                                                               \
                                                                \
inline SOURCE wrap(const TARGET& value) {                       \
    return (SOURCE)(value);                                     \
}                                                               \

#define SP_POINTER_CAST(type, source) ((type)(source))

#endif // SP_LANG_CXX

#endif // START_POINT_DEFINE_LANGUAGE_CXX_H
