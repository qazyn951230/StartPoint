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

@frozen
public struct LinkedListIterator<Element>: IteratorProtocol {
    let box: LinkedListBox<Element>

    var current: LinkedListIteratorRef?

    init(_ box: LinkedListBox<Element>) {
        self.box = box
        current = linked_list_make_iterator(box.ref)
    }

    public mutating func next() -> Element? {
        let _raw = linked_list_iterator_element(box.ref, current)
        current = linked_list_iterator_next(current)
        guard let raw = _raw else {
            return nil
        }
        let pointer = raw.bindMemory(to: Element.self, capacity: 1)
        return pointer.pointee
    }
}

@frozen
public struct LinkedListIndex: Comparable {
    @usableFromInline
    let raw: LinkedListIteratorRef?

    @usableFromInline
    init(_ raw: LinkedListIteratorRef?) {
        self.raw = raw
    }

    public static func == (lhs: LinkedListIndex, rhs: LinkedListIndex) -> Bool {
        guard let left = lhs.raw, let right = rhs.raw else {
            return true
        }
        return linked_list_iterator_equal(left, right)
    }

    public static func < (lhs: LinkedListIndex, rhs: LinkedListIndex) -> Bool {
        guard let left = lhs.raw, let right = rhs.raw else {
            return false
        }
        return linked_list_iterator_less_then(left, right)
    }

    public static func > (lhs: LinkedListIndex, rhs: LinkedListIndex) -> Bool {
        guard let left = lhs.raw, let right = rhs.raw else {
            return false
        }
        return linked_list_iterator_greater_then(left, right)
    }
}

@usableFromInline
final class LinkedListBox<Element> {
    let ref: LinkedListRef

    init() {
        ref = linked_list_create(MemoryLayout<Element>.size)
    }

    deinit {
        linked_list_free(ref)
    }

//    var first: Element? {
//        guard let raw = linked_list_first(ref) else {
//            return nil
//        }
//        let pointer = raw.bindMemory(to: Element.self, capacity: 1)
//        return pointer.pointee
//    }
//
//    var last: Element? {
//        guard let raw = linked_list_last(ref) else {
//            return nil
//        }
//        let pointer = raw.bindMemory(to: Element.self, capacity: 1)
//        return pointer.pointee
//    }
//
//    func append(_ newElement: __owned Element) {
//        let raw = linked_list_append(ref)
//        let pointer = raw.bindMemory(to: Element.self, capacity: 1)
//        pointer.initialize(to: newElement)
//    }
}

@frozen
public struct LinkedListSlice<Element>: Collection /*, _DestructorSafeContainer*/ {
    @usableFromInline
    typealias Buffer = LinkedListBox<Element>

    public typealias Iterator = LinkedListIterator<Element>
    public typealias Index = LinkedListIndex
    public typealias SubSequence = LinkedListSlice<Element>

    @usableFromInline
    var buffer: Buffer

    public let startIndex: Index
    public let endIndex: Index

    @inlinable
    init(buffer: Buffer, start: LinkedListIteratorRef?, end: LinkedListIteratorRef?) {
        self.buffer = buffer
        startIndex = LinkedListIndex(start)
        endIndex = LinkedListIndex(end)
    }

    public var isEmpty: Bool {
        true
    }

    public var count: Int {
        0
    }

    public func makeIterator() -> LinkedListIterator<Element> {
        LinkedListIterator(buffer)
    }
    
    public func index(after i: LinkedListIndex) -> LinkedListIndex {
        index(i, offsetBy: 1)
    }

    public func index(_ i: Index, offsetBy distance: Int) -> Index {
        var raw = i.raw
        for _ in 0..<distance {
            if raw == nil {
                break
            }
            raw = linked_list_iterator_next(raw)
        }
        return Index(raw)
    }

    public func index(_ i: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index? {
        var raw = i.raw
        for _ in 0..<distance {
            if raw == nil || linked_list_iterator_equal(raw, limit.raw) {
                break
            }
            raw = linked_list_iterator_next(raw)
        }
        return Index(raw)
    }

    public func distance(from start: Index, to end: Index) -> Int {
        0
    }
    
    public subscript(position: LinkedListIndex) -> Element {
        get {
            precondition(position.raw != nil)
            let raw = linked_list_iterator_element(buffer.ref, position.raw!)!
            let pointer = raw.bindMemory(to: Element.self, capacity: 1)
            return pointer.pointee
        }
    }
}

@frozen
public struct LinkedList<Element>: Sequence /*, _DestructorSafeContainer*/ {
    @usableFromInline
    typealias Buffer = LinkedListBox<Element>

    public typealias Iterator = LinkedListIterator<Element>

    @usableFromInline
    var buffer: Buffer

    @inlinable
    init(buffer: Buffer) {
        self.buffer = buffer
    }

    public func makeIterator() -> LinkedListIterator<Element> {
        LinkedListIterator(buffer)
    }
}
