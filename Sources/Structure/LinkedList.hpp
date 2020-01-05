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
        Node* SP_NULLABLE previous;
        Node* SP_NULLABLE next;

        Node(): previous(nullptr), next(nullptr) {}
    };

    using iterator = Node*;
    using const_iterator = const Node*;

    LinkedList(std::size_t size): _first(nullptr), _last(nullptr), _size(size) {}

    ~LinkedList() {
        removeAll();
    }

    void* SP_NULLABLE element(Node* SP_NULLABLE node) const {
        return node != nullptr ? node + _size : nullptr;
    }

    void* append() {
        auto node = newNode();
        if (_last == nullptr) {
            _first = node;
            _last = node;
        } else {
            node->previous = _last;
            _last = node;
        }
        return element(node);
    }

    iterator SP_NULLABLE first() {
        return _first;
    }

    iterator SP_NULLABLE last() {
        return _last;
    }

    void removeAll() {
        assert(_first != nullptr || _last == _first);
        auto last = _last;
        _first = nullptr;
        _last = nullptr;
        if (last == nullptr) {
            return;
        }
        last = last->previous;
        while (last != nullptr) {
            ::free(last->next);
            last = last->previous;
        }
    }

private:
    static const auto sizeOfNode = sizeof(Node);
    
    constexpr auto sizeOfElement() const {
        return sizeOfNode + _size;
    }

    Node* newNode() {
        return reinterpret_cast<Node*>(::malloc(sizeOfElement()));
    }

    const std::size_t _size;
    Node* SP_NULLABLE _first;
    Node* SP_NULLABLE _last;
};

SP_SIMPLE_CONVERSION(LinkedList, LinkedListRef);
SP_SIMPLE_CONVERSION(LinkedList::Node, LinkedListIteratorRef);

SP_CPP_FILE_END

#endif // START_POINT_LINKED_LIST_HPP
