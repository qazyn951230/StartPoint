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

#ifndef START_POINT_LINKED_LIST_H
#define START_POINT_LINKED_LIST_H

#if (__cplusplus)
#include <cstdint>
#else
#include <stdint.h>
#include <stdbool.h>
#endif

#include "Config.h"

SP_C_FILE_BEGIN

typedef struct SPOpaqueLinkedList* LinkedListRef;
typedef struct SPOpaqueLinkedListIterator* LinkedListIteratorRef;

LinkedListRef linked_list_create(size_t size);
void linked_list_free(LinkedListRef ref);

LinkedListIteratorRef linked_list_iterator_copy(LinkedListIteratorRef ref);
void linked_list_iterator_free(LinkedListIteratorRef ref);

void* linked_list_append(LinkedListRef list);
LinkedListIteratorRef linked_list_begin(LinkedListRef list);
LinkedListIteratorRef linked_list_end(LinkedListRef list);
void* SP_NULLABLE linked_list_first(LinkedListRef list);
void* SP_NULLABLE linked_list_last(LinkedListRef list);
NSInteger linked_list_count(LinkedListRef list);
bool linked_list_is_empty(LinkedListRef list);

void* SP_NULLABLE linked_list_iterator_element(LinkedListRef list, LinkedListIteratorRef iterator);
LinkedListIteratorRef linked_list_iterator_previous(LinkedListIteratorRef iterator);
LinkedListIteratorRef linked_list_iterator_next(LinkedListIteratorRef iterator);
bool linked_list_iterator_equal(LinkedListIteratorRef lhs, LinkedListIteratorRef rhs);
bool linked_list_iterator_less_then(LinkedListIteratorRef lhs, LinkedListIteratorRef rhs);
bool linked_list_iterator_greater_then(LinkedListIteratorRef lhs, LinkedListIteratorRef rhs);
NSInteger linked_list_iterator_distance(LinkedListIteratorRef start, LinkedListIteratorRef end);

SP_C_FILE_END

#endif // START_POINT_LINKED_LIST_H
