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

#ifndef START_POINT_QUEUE_HPP
#define START_POINT_QUEUE_HPP

#include <cstddef>
#include <cstdlib>
#include "Queue.h"

SP_CPP_FILE_BEGIN

class Queue final {
public:
    Queue(): _root(nullptr) {}

    ~Queue() {
        delete _root;
    }

    void* append(std::size_t size) {
        _root = reinterpret_cast<Node*>(::malloc(size + sizeOfNode));
        return _root + sizeOfNode;
    }

    void* SP_NULLABLE first() const {
        return _root != nullptr ? _root + sizeOfNode : nullptr;
    }

private:
    struct Node {
        Node* SP_NULLABLE next;
    };

    static constexpr auto sizeOfNode = sizeof(Node);

    Node* SP_NULLABLE _root;
};

SP_SIMPLE_CONVERSION(Queue, QueueRef);

SP_CPP_FILE_END

#endif // START_POINT_QUEUE_HPP
