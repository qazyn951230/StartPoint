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

#ifndef START_POINT_LINKED_LIST_HPP
#define START_POINT_LINKED_LIST_HPP

#include <cstddef>
#include <cstdlib>
#include <cassert>
#include "LinkedList.h"

SP_CPP_FILE_BEGIN

class LinkedList final {
public:
    struct Node {
        Node* previous;
        Node* next;

        Node(): previous(this), next(this) {}
    };

    struct Iterator {
        Node* node;
        std::size_t index;

        Iterator(): node(nullptr), index(0) {}

        Iterator(const Iterator&) = default;

        Iterator& operator=(const Iterator&) = default;

        Iterator(Iterator&&) noexcept = default;

        Iterator& operator=(Iterator&&) = default;

        explicit Iterator(Node* node, std::size_t index) noexcept : node(node), index(index) {}

        Node& operator*() const {
            return *node;
        }

        Node* operator->() const {
            return node;
        }

        Iterator& operator++() {
            node = node->next;
            index += 1;
            return *this;
        }

        Iterator operator++(int) {
            Iterator temp(*this);
            ++(*this);
            return temp;
        }

        Iterator& operator--() {
            node = node->previous;
            index -= 1;
            return *this;
        }

        Iterator operator--(int) {
            Iterator temp(*this);
            --(*this);
            return temp;
        }

        bool operator>(const Iterator& rhs) {
            return index > rhs.index;
        }

        bool operator<(const Iterator& rhs) {
            return index < rhs.index;
        }

        bool operator==(const Iterator& rhs) {
            assert((node == rhs.node) == (index == rhs.index));
            return node == rhs.node;
        }

        bool operator!=(const Iterator& rhs) {
            assert((node == rhs.node) == (index == rhs.index));
            return node != rhs.node;
        }
    };

    using iterator = Iterator;
    using const_iterator = const Iterator;

    LinkedList(std::size_t size): _last(), _size(size), _count(0) {}

    ~LinkedList() {
        removeAll();
    }

    [[nodiscard]] bool isEmpty() const noexcept {
        return _count == 0;
    }

    std::size_t count() const noexcept {
        return _count;
    }

    void* SP_NULLABLE element(const iterator& index) const {
        return element(index.node);
    }

    void* SP_NULLABLE element(Node* node) const {
        return node == &_last ? nullptr : node + _size;
    }

    void* append() {
        auto node = newNode();
        _count += 1;
        node->next = &_last;
        node->previous = _last.previous;
        node->previous->next = node;
        _last.previous = node;
        return elementOf(node);
    }

    iterator first() noexcept {
        return iterator{_last.next, 0};
    }

    iterator last() noexcept {
        return iterator{&_last, _count};
    }

    void removeAll() noexcept {
        if (isEmpty()) {
            return;
        }
        auto first = _last.next;
        auto last = &_last;
        unlink(first, last->previous);
        _count = 0;
        while (first != last) {
            auto node = first;
            first = first->next;
            ::free(node);
        }
    }

private:
    static const auto sizeOfNode = sizeof(Node);
    
    constexpr auto sizeOfElement() const {
        return sizeOfNode + _size;
    }

    inline Node* newNode() {
        return reinterpret_cast<Node*>(::malloc(sizeOfElement()));
    }

    inline void unlink(Node* start, Node* end) {
        start->previous->next = end->next;
        end->next->previous = start->previous;
    }

    inline void* elementOf(Node* node) const {
        return node + _size;
    }

    const std::size_t _size;
    Node _last;
    std::size_t _count;
};

SP_SIMPLE_CONVERSION(LinkedList, LinkedListRef);
SP_SIMPLE_CONVERSION(LinkedList::Iterator, LinkedListIteratorRef);

SP_CPP_FILE_END

#endif // START_POINT_LINKED_LIST_HPP
