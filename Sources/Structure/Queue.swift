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

public final class Queue<Element> {
    private let _queue: QueueRef
    
    public var first: Element? {
        guard let raw = queue_first(_queue) else {
            return nil
        }
        let pointer = raw.bindMemory(to: Element.self, capacity: 1)
        return pointer.pointee
    }
    
    public init() {
        _queue = queue_create()
    }
    
    deinit {
        queue_free(_queue)
    }
    
    public func append(_ newElement: Element) {
        let raw = queue_append(_queue, MemoryLayout<Element>.size)
        let pointer = raw.bindMemory(to: Element.self, capacity: 1)
        pointer.initialize(to: newElement)
    }
}
