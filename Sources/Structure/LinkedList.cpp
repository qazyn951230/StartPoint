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

void* linked_list_append(LinkedListRef list) {
    return unwrap(list)->append();
}

LinkedListIteratorRef linked_list_begin(LinkedListRef list) {
    return wrap(unwrap(list)->first());
}

LinkedListIteratorRef linked_list_end(LinkedListRef list) {
    return wrap(unwrap(list)->last());
}

void* linked_list_first(LinkedListRef list) {
    auto raw = unwrap(list);
    return raw->element(raw->first());
}

void* linked_list_last(LinkedListRef list) {
    auto raw = unwrap(list);
    return raw->element(raw->last());
}

LinkedListIteratorRef linked_list_make_iterator(LinkedListRef list) {
    auto raw = unwrap(list);
    return wrap(raw->first());
}

void* linked_list_iterator_element(LinkedListRef list, LinkedListIteratorRef iterator) {
    auto raw = unwrap(iterator);
    return raw == nullptr ? nullptr : unwrap(list)->element(raw);
}

LinkedListIteratorRef linked_list_iterator_previous(LinkedListIteratorRef iterator) {
    auto raw = unwrap(iterator);
    return raw == nullptr ? nullptr : wrap(raw->previous);
}

LinkedListIteratorRef linked_list_iterator_next(LinkedListIteratorRef iterator) {
    auto raw = unwrap(iterator);
    return raw == nullptr ? nullptr : wrap(raw->next);
}

bool linked_list_iterator_equal(LinkedListIteratorRef lhs, LinkedListIteratorRef rhs) {
    return lhs == rhs;
}

bool linked_list_iterator_less_then(LinkedListIteratorRef lhs, LinkedListIteratorRef rhs) {
    if (lhs == nullptr || rhs == nullptr || lhs == rhs) {
        return false;
    }
    auto left = unwrap(lhs);
    const auto right = unwrap(rhs);
    while (left->previous != nullptr) {
        if (left->previous == right) {
            return true;
        } else {
            left = left->previous;
        }
    }
    left = unwrap(lhs);
    while (left->next != nullptr) {
        if (left->next == right) {
            return false;
        } else {
            left = left->next;
        }
    }
    return false;
}

bool linked_list_iterator_greater_then(LinkedListIteratorRef lhs, LinkedListIteratorRef rhs) {
    if (lhs == nullptr || rhs == nullptr || lhs == rhs) {
        return false;
    }
    auto left = unwrap(lhs);
    const auto right = unwrap(rhs);
    while (left->previous != nullptr) {
        if (left->previous == right) {
            return false;
        } else {
            left = left->previous;
        }
    }
    left = unwrap(lhs);
    while (left->next != nullptr) {
        if (left->next == right) {
            return true;
        } else {
            left = left->next;
        }
    }
    return false;
}