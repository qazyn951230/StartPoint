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

#ifndef START_POINT_ATOMIC_NUMBERS_H
#define START_POINT_ATOMIC_NUMBERS_H

#include <stdlib.h>
#include <stdbool.h>
#include <stdatomic.h>
#include <Language.h>
#include "MemoryOrder.h"

SP_ASSUME_NONNULL_BEGIN

#define SP_ATOMIC_TYPE_CREATE(swift_type, swift_name, raw_type, atomic_type)                                    \
typedef struct spa_atomic_##swift_name* SPA##swift_type##Ref;                                                   \
static inline SPA##swift_type##Ref spa_##swift_name##_create(raw_type value) {                                  \
    atomic_##atomic_type* result = (atomic_##atomic_type*)malloc(sizeof(atomic_##atomic_type));                 \
    atomic_init(result, value);                                                                                 \
    return SP_POINTER_CAST(SPA##swift_type##Ref, result);                                                       \
}                                                                                                               \
static inline void spa_##swift_name##_init(SPA##swift_type##Ref ref, raw_type value) {                          \
    atomic_##atomic_type* result = SP_POINTER_CAST(atomic_##atomic_type*, ref);                                 \
    atomic_init(result, value);                                                                                 \
}                                                                                                               \
static inline void spa_##swift_name##_free(SPA##swift_type##Ref ref) {                                          \
    free(SP_POINTER_CAST(atomic_##atomic_type*, ref));                                                          \
}                                                                                                               \
static inline size_t spa_##swift_name##_required_size() {                                                       \
    return sizeof(atomic_##atomic_type);                                                                        \
}                                                                                                               \
static inline bool spa_##swift_name##_is_lock_free(SPA##swift_type##Ref ref) {                                  \
    return atomic_is_lock_free(SP_POINTER_CAST(atomic_##atomic_type*, ref));                                    \
}                                                                                                               \

#define SP_ATOMIC_TYPE_STORE(swift_type, swift_name, raw_type, atomic_type)                                     \
static inline void spa_##swift_name##_store(SPA##swift_type##Ref ref, raw_type value) {                         \
    return atomic_store(SP_POINTER_CAST(atomic_##atomic_type*, ref), value);                                    \
}                                                                                                               \
static inline void spa_##swift_name##_store_explicit(SPA##swift_type##Ref ref, raw_type value,                  \
                                                     SPMemoryOrder order) {                                     \
    return atomic_store_explicit(SP_POINTER_CAST(atomic_##atomic_type*, ref), value, order);                    \
}                                                                                                               \

#define SP_ATOMIC_TYPE_LOAD(swift_type, swift_name, raw_type, atomic_type)                                      \
static inline raw_type spa_##swift_name##_load(SPA##swift_type##Ref ref) {                                      \
    return atomic_load(SP_POINTER_CAST(atomic_##atomic_type*, ref));                                            \
}                                                                                                               \
static inline raw_type spa_##swift_name##_load_explicit(SPA##swift_type##Ref ref,                               \
                                                     SPMemoryOrder order) {                                     \
    return atomic_load_explicit(SP_POINTER_CAST(atomic_##atomic_type*, ref), order);                            \
}                                                                                                               \

#define SP_ATOMIC_TYPE_EXCHANGE(swift_type, swift_name, raw_type, atomic_type)                                  \
static inline raw_type spa_##swift_name##_exchange(SPA##swift_type##Ref ref, raw_type value) {                  \
    return atomic_exchange(SP_POINTER_CAST(atomic_##atomic_type*, ref), value);                                 \
}                                                                                                               \
static inline raw_type spa_##swift_name##_exchange_explicit(SPA##swift_type##Ref ref, raw_type value,           \
                                                     SPMemoryOrder order) {                                     \
    return atomic_exchange_explicit(SP_POINTER_CAST(atomic_##atomic_type*, ref), value, order);                 \
}                                                                                                               \

#define SP_ATOMIC_TYPE_COMPARE_STRONG(swift_type, swift_name, raw_type, atomic_type)                            \
static inline bool spa_##swift_name##_compare_strong(SPA##swift_type##Ref ref, raw_type expected,               \
                                               raw_type desired) {                                              \
    raw_type value = expected;                                                                                  \
    return atomic_compare_exchange_strong(SP_POINTER_CAST(atomic_##atomic_type*, ref), &value, desired);        \
}                                                                                                               \
static inline bool spa_##swift_name##_compare_strong_explicit(SPA##swift_type##Ref ref,                         \
                   raw_type expected, raw_type desired, SPMemoryOrder success, SPMemoryOrder fail) {            \
    raw_type value = expected;                                                                                  \
    return atomic_compare_exchange_strong_explicit(SP_POINTER_CAST(atomic_##atomic_type*, ref), &value,         \
                                                  desired, success, fail);                                      \
}                                                                                                               \

#define SP_ATOMIC_TYPE_COMPARE_WEAK(swift_type, swift_name, raw_type, atomic_type)                              \
static inline bool spa_##swift_name##_compare_weak(SPA##swift_type##Ref ref, raw_type expected,                 \
                                               raw_type desired) {                                              \
    raw_type value = expected;                                                                                  \
    return atomic_compare_exchange_weak(SP_POINTER_CAST(atomic_##atomic_type*, ref), &value, desired);          \
}                                                                                                               \
static inline bool spa_##swift_name##_compare_weak_explicit(SPA##swift_type##Ref ref,                           \
                   raw_type expected, raw_type desired, SPMemoryOrder success, SPMemoryOrder fail) {            \
    raw_type value = expected;                                                                                  \
    return atomic_compare_exchange_weak_explicit(SP_POINTER_CAST(atomic_##atomic_type*, ref), &value,           \
                                                  desired, success, fail);                                      \
}                                                                                                               \

#define SP_ATOMIC_TYPE_FETCH(swift_type, swift_name, raw_type, atomic_type, action)                             \
static inline raw_type spa_##swift_name##_##action(SPA##swift_type##Ref ref, raw_type value) {                  \
    return atomic_fetch_##action(SP_POINTER_CAST(atomic_##atomic_type*, ref), value);                           \
}                                                                                                               \
static inline raw_type spa_##swift_name##_##action##_explicit(SPA##swift_type##Ref ref, raw_type value,         \
                                                     SPMemoryOrder order) {                                     \
    return atomic_fetch_##action##_explicit(SP_POINTER_CAST(atomic_##atomic_type*, ref), value, order);         \
}                                                                                                               \

#define SP_ATOMIC_TYPE_OPERATION(swift_type, swift_name, raw_type, atomic_type)                                 \
SP_ATOMIC_TYPE_STORE(swift_type, swift_name, raw_type, atomic_type)                                             \
SP_ATOMIC_TYPE_LOAD(swift_type, swift_name, raw_type, atomic_type)                                              \
SP_ATOMIC_TYPE_EXCHANGE(swift_type, swift_name, raw_type, atomic_type)                                          \
SP_ATOMIC_TYPE_COMPARE_STRONG(swift_type, swift_name, raw_type, atomic_type)                                    \
SP_ATOMIC_TYPE_COMPARE_WEAK(swift_type, swift_name, raw_type, atomic_type)                                      \
SP_ATOMIC_TYPE_FETCH(swift_type, swift_name, raw_type, atomic_type, add)                                        \
SP_ATOMIC_TYPE_FETCH(swift_type, swift_name, raw_type, atomic_type, sub)                                        \
SP_ATOMIC_TYPE_FETCH(swift_type, swift_name, raw_type, atomic_type, or)                                         \
SP_ATOMIC_TYPE_FETCH(swift_type, swift_name, raw_type, atomic_type, xor)                                        \
SP_ATOMIC_TYPE_FETCH(swift_type, swift_name, raw_type, atomic_type, and)                                        \

#define SP_MAKE_ATOMIC_TYPE(swift_type, swift_name, raw_type, atomic_type)                                      \
SP_ATOMIC_TYPE_CREATE(swift_type, swift_name, raw_type, atomic_type)                                            \
SP_ATOMIC_TYPE_OPERATION(swift_type, swift_name, raw_type, atomic_type)                                         \

// C11 => #define bool _Bool,
// after expanded from macro `atomic_bool` => `atomic__Bool`
SP_ATOMIC_TYPE_CREATE(Bool, bool, bool, bool)
SP_ATOMIC_TYPE_STORE(Bool, bool, bool, bool)
SP_ATOMIC_TYPE_LOAD(Bool, bool, bool, bool)
SP_ATOMIC_TYPE_EXCHANGE(Bool, bool, bool, bool)
SP_ATOMIC_TYPE_COMPARE_STRONG(Bool, bool, bool, bool)
SP_ATOMIC_TYPE_COMPARE_WEAK(Bool, bool, bool, bool)
SP_ATOMIC_TYPE_FETCH(Bool, bool, bool, bool, add)
SP_ATOMIC_TYPE_FETCH(Bool, bool, bool, bool, sub)
SP_ATOMIC_TYPE_FETCH(Bool, bool, bool, bool, or)
SP_ATOMIC_TYPE_FETCH(Bool, bool, bool, bool, xor)
SP_ATOMIC_TYPE_FETCH(Bool, bool, bool, bool, and)

SP_MAKE_ATOMIC_TYPE(Int8, int8, signed char, schar)
SP_MAKE_ATOMIC_TYPE(UInt8, uint8, unsigned char, uchar)
SP_MAKE_ATOMIC_TYPE(Int16, int16, short, short)
SP_MAKE_ATOMIC_TYPE(UInt16, uint16, unsigned short, ushort)
SP_MAKE_ATOMIC_TYPE(Int32, int32, int, int)
SP_MAKE_ATOMIC_TYPE(UInt32, uint32, unsigned int, uint)
SP_MAKE_ATOMIC_TYPE(Int, int, long, long)
SP_MAKE_ATOMIC_TYPE(UInt, uint, unsigned long, ulong)
SP_MAKE_ATOMIC_TYPE(Int64, int64, long long, llong)
SP_MAKE_ATOMIC_TYPE(UInt64, uint64, unsigned long long, ullong)

#undef SP_ATOMIC_TYPE_CREATE
#undef SP_ATOMIC_TYPE_STORE
#undef SP_ATOMIC_TYPE_LOAD
#undef SP_ATOMIC_TYPE_EXCHANGE
#undef SP_ATOMIC_TYPE_COMPARE_STRONG
#undef SP_ATOMIC_TYPE_COMPARE_WEAK
#undef SP_ATOMIC_TYPE_FETCH
#undef SP_MAKE_ATOMIC_TYPE
#undef SP_ATOMIC_TYPE_OPERATION

/**
 * @see: https://en.cppreference.com/w/c/atomic/ATOMIC_LOCK_FREE_consts
 */
typedef SP_CLOSED_ENUM(int, SPAtomicLockFree) {
    SPAtomicLockFreeNever = 0,
    SPAtomicLockFreeSometimes = 1,
    SPAtomicLockFreeAlways = 2,
} SP_SWIFT_NAME(AtomicLockFree);

static inline SPAtomicLockFree spa_bool_type_is_lock_free() {
    return (SPAtomicLockFree) ATOMIC_BOOL_LOCK_FREE;
}

static inline SPAtomicLockFree spa_int8_type_is_lock_free() {
    return (SPAtomicLockFree) ATOMIC_CHAR_LOCK_FREE;
}

static inline SPAtomicLockFree spa_uint8_type_is_lock_free() {
    return (SPAtomicLockFree) ATOMIC_CHAR_LOCK_FREE;
}

static inline SPAtomicLockFree spa_int16_type_is_lock_free() {
    return (SPAtomicLockFree) ATOMIC_SHORT_LOCK_FREE;
}

static inline SPAtomicLockFree spa_uint16_type_is_lock_free() {
    return (SPAtomicLockFree) ATOMIC_SHORT_LOCK_FREE;
}

static inline SPAtomicLockFree spa_int32_type_is_lock_free() {
    return (SPAtomicLockFree) ATOMIC_INT_LOCK_FREE;
}

static inline SPAtomicLockFree spa_uint32_type_is_lock_free() {
    return (SPAtomicLockFree) ATOMIC_INT_LOCK_FREE;
}

static inline SPAtomicLockFree spa_int_type_is_lock_free() {
    return (SPAtomicLockFree) ATOMIC_LONG_LOCK_FREE;
}

static inline SPAtomicLockFree spa_uint_type_is_lock_free() {
    return (SPAtomicLockFree) ATOMIC_LONG_LOCK_FREE;
}

static inline SPAtomicLockFree spa_int64_type_is_lock_free() {
    return (SPAtomicLockFree) ATOMIC_LLONG_LOCK_FREE;
}

static inline SPAtomicLockFree spa_uint64_type_is_lock_free() {
    return (SPAtomicLockFree) ATOMIC_LLONG_LOCK_FREE;
}

SP_ASSUME_NONNULL_END

#endif // START_POINT_ATOMIC_NUMBERS_H
