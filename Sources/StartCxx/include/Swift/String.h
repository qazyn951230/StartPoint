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

#ifndef START_POINT_SWIFT_STRING_H
#define START_POINT_SWIFT_STRING_H

#include "../Language.h"

#if SP_LANG_CXX
#include <string>
#endif

SP_ASSUME_NONNULL_BEGIN

SP_EXTERN_C_BEGIN

typedef struct SPString* SPStringRef;

SPStringRef SPStringCreateWithCString(const char*);
void SPStringFree(SPStringRef SP_NULLABLE);

SP_EXTERN_C_END

#if SP_LANG_CXX

SP_NAME_SPACE_BEGIN

using String = std::string;

SP_SIMPLE_CONVERSION(String, SPStringRef)

SP_NAME_SPACE_END

#endif // SP_LANG_CXX

SP_ASSUME_NONNULL_END

#endif // START_POINT_SWIFT_STRING_H
