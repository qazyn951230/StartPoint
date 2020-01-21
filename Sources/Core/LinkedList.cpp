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

#include "LinkedList.hpp"

using namespace StartPoint;

LinkedListRef linked_list_create(size_t size) {
    return wrap(new LinkedList(size));
}

void linked_list_free(LinkedListRef ref) {
    delete unwrap(ref);
}

LinkedListIteratorRef linked_list_iterator_copy(LinkedListIteratorRef ref) {
    auto temp = new LinkedList::iterator{*unwrap(ref)};
    return wrap(temp);
}

void linked_list_iterator_free(LinkedListIteratorRef ref) {
    delete unwrap(ref);
}

void* linked_list_append(LinkedListRef list) {
    return unwrap(list)->append();
}

LinkedListIteratorRef linked_list_begin(LinkedListRef list) {
    auto temp = new LinkedList::iterator;
    *temp = unwrap(list)->first();
    return wrap(temp);
}

LinkedListIteratorRef linked_list_end(LinkedListRef list) {
    auto temp = new LinkedList::iterator;
    *temp = unwrap(list)->last();
    return wrap(temp);
}

void* linked_list_first(LinkedListRef list) {
    auto raw = unwrap(list);
    return raw->element(raw->first());
}

void* linked_list_last(LinkedListRef list) {
    auto raw = unwrap(list);
    return raw->element(raw->last());
}

NSInteger linked_list_count(LinkedListRef list) {
    return static_cast<NSInteger>(unwrap(list)->count());
}

bool linked_list_is_empty(LinkedListRef list) {
    return unwrap(list)->isEmpty();
}

void* linked_list_iterator_element(LinkedListRef list, LinkedListIteratorRef iterator) {
    auto raw = unwrap(iterator);
    return unwrap(list)->element(raw->node);
}

LinkedListIteratorRef linked_list_iterator_previous(LinkedListIteratorRef iterator) {
    auto raw = unwrap(iterator);
    raw->operator--(1);
    return iterator;
}

LinkedListIteratorRef linked_list_iterator_next(LinkedListIteratorRef iterator) {
    auto raw = unwrap(iterator);
    raw->operator++(1);
    return iterator;
}

bool linked_list_iterator_equal(LinkedListIteratorRef lhs, LinkedListIteratorRef rhs) {
    return unwrap(lhs)->operator==(*unwrap(rhs));
}

bool linked_list_iterator_less_then(LinkedListIteratorRef lhs, LinkedListIteratorRef rhs) {
    return unwrap(lhs)->operator<(*unwrap(rhs));
}

bool linked_list_iterator_greater_then(LinkedListIteratorRef lhs, LinkedListIteratorRef rhs) {
    return unwrap(lhs)->operator>(*unwrap(rhs));
}

NSInteger linked_list_iterator_distance(LinkedListIteratorRef start, LinkedListIteratorRef end) {
    auto left = unwrap(start);
    auto right = unwrap(end);
    if (left->index > right->index) {
        return -static_cast<NSInteger>(left->index - right->index);
    } else {
        return static_cast<NSInteger>(right->index - left->index);
    }
}
