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

#ifndef START_POINT_SP_MEMORY_ORDER_H
#define START_POINT_SP_MEMORY_ORDER_H

#include <Language.h>

#if (__cplusplus)
#include <atomic>
#else
#include <stdatomic.h>
#endif

#if (__cplusplus)

typedef SP_CLOSED_ENUM(int, SPMemoryOrder) {
    SPMemoryOrderRelaxed = std::memory_order::memory_order_relaxed,
    SPMemoryOrderConsume = std::memory_order::memory_order_consume,
    SPMemoryOrderAcquire = std::memory_order::memory_order_acquire,
    SPMemoryOrderRelease = std::memory_order::memory_order_release,
    SPMemoryOrderAcquireAndRelease = std::memory_order::memory_order_acq_rel,
    SPMemoryOrderSequentiallyConsistent = std::memory_order::memory_order_seq_cst,
} SP_SWIFT_NAME(MemoryOrder);

#else

typedef SP_CLOSED_ENUM(int, SPMemoryOrder) {
    SPMemoryOrderRelaxed = memory_order_relaxed,
    SPMemoryOrderConsume = memory_order_consume,
    SPMemoryOrderAcquire = memory_order_acquire,
    SPMemoryOrderRelease = memory_order_release,
    SPMemoryOrderAcquireAndRelease = memory_order_acq_rel,
    SPMemoryOrderSequentiallyConsistent = memory_order_seq_cst,
} SP_SWIFT_NAME(MemoryOrder);

#endif // SP_LANG_CXX

#endif // START_POINT_SP_MEMORY_ORDER_H
