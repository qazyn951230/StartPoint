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
    let last: LinkedListIndexBox
    var current: LinkedListIndexBox

    init(_ box: LinkedListBox<Element>) {
        self.box = box
        current = box.begin
        last = box.end
    }

    init(_ box: LinkedListBox<Element>, start: LinkedListIndexBox, end: LinkedListIndexBox) {
        self.box = box
        current = start
        last = end
    }

    public mutating func next() -> Element? {
        if current == last {
            return nil
        }
        defer {
            current.next()
        }
        return box.element(from: current)
    }
}

@frozen
public struct LinkedListIndex: Comparable {
    @usableFromInline
    let box: LinkedListIndexBox

    @inlinable
    init(_ box: LinkedListIndexBox) {
        self.box = box
    }

    @inlinable
    public static func == (lhs: LinkedListIndex, rhs: LinkedListIndex) -> Bool {
        lhs.box == rhs.box
    }

    @inlinable
    public static func < (lhs: LinkedListIndex, rhs: LinkedListIndex) -> Bool {
        lhs.box < rhs.box
    }

    @inlinable
    public static func > (lhs: LinkedListIndex, rhs: LinkedListIndex) -> Bool {
        lhs.box > rhs.box
    }
}

@usableFromInline
class LinkedListIndexBox: Comparable {
    @usableFromInline
    let raw: LinkedListIteratorRef

    @inline(__always)
    init(_ raw: LinkedListIteratorRef) {
        self.raw = raw
    }

    deinit {
        linked_list_iterator_free(raw)
    }

    @inline(__always)
    @discardableResult
    func previous() -> LinkedListIndexBox {
        linked_list_iterator_previous(raw)
        return self
    }

    @inline(__always)
    @discardableResult
    func next() -> LinkedListIndexBox {
        linked_list_iterator_next(raw)
        return self
    }

    @inline(__always)
    func copy() -> LinkedListIndexBox {
        LinkedListIndexBox(linked_list_iterator_copy(raw))
    }

    func index(offsetBy distance: Int) -> LinkedListIndexBox {
        for _ in 0..<distance {
            next()
        }
        return self
    }

    func index(offsetBy distance: Int, limitedBy limit: LinkedListIndexBox) -> LinkedListIndexBox? {
        for _ in 0..<distance {
            if self > limit {
                return nil
            }
            next()
        }
        return self
    }

    func distance(to end: LinkedListIndexBox) -> Int {
        linked_list_iterator_distance(raw, end.raw)
    }

    @inline(__always)
    @usableFromInline
    static func == (lhs: LinkedListIndexBox, rhs: LinkedListIndexBox) -> Bool {
        linked_list_iterator_equal(lhs.raw, rhs.raw)
    }

    @inline(__always)
    @usableFromInline
    static func < (lhs: LinkedListIndexBox, rhs: LinkedListIndexBox) -> Bool {
        linked_list_iterator_less_then(lhs.raw, rhs.raw)
    }

    @inline(__always)
    @usableFromInline
    static func > (lhs: LinkedListIndexBox, rhs: LinkedListIndexBox) -> Bool {
        linked_list_iterator_greater_then(lhs.raw, rhs.raw)
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

    var begin: LinkedListIndexBox {
        LinkedListIndexBox(linked_list_begin(ref))
    }

    var end: LinkedListIndexBox {
        LinkedListIndexBox(linked_list_end(ref))
    }

    @inline(__always)
    func element(from index: LinkedListIndexBox) -> Element? {
        guard let raw = linked_list_iterator_element(ref, index.raw) else {
            return nil
        }
        let pointer = raw.bindMemory(to: Element.self, capacity: 1)
        return pointer.pointee
    }

    @inline(__always)
    func setElement(_ element: __owned Element, for index: LinkedListIndexBox) {
        guard let raw = linked_list_iterator_element(ref, index.raw) else {
            return
        }
        let pointer = raw.bindMemory(to: Element.self, capacity: 1)
        pointer.deinitialize(count: 1)
        pointer.initialize(to: element)
    }
}

@frozen
public struct LinkedListSlice<Element>: MutableCollection /*, _DestructorSafeContainer*/ {
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
    init(buffer: Buffer, start: LinkedListIndex, end: LinkedListIndex) {
        self.buffer = buffer
        startIndex = start
        endIndex = end
    }

    public var isEmpty: Bool {
        startIndex == endIndex
    }

    public var count: Int {
        linked_list_iterator_distance(startIndex.box.raw, endIndex.box.raw)
    }

    public func makeIterator() -> LinkedListIterator<Element> {
        LinkedListIterator(buffer, start: startIndex.box.copy(), end: endIndex.box.copy())
    }

    public func formIndex(after i: inout LinkedListIndex) {
        i.box.next()
    }

    public func index(after i: Index) -> Index {
        Index(i.box.copy().next())
    }

    public func index(_ i: Index, offsetBy distance: Int) -> Index {
        Index(i.box.copy().index(offsetBy: distance))
    }

    public func index(_ i: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index? {
        let box = i.box.copy().index(offsetBy: distance, limitedBy: limit.box)
        return box.map(Index.init)
    }

    public func distance(from start: Index, to end: Index) -> Int {
        start.box.distance(to: end.box)
    }

    public subscript(position: LinkedListIndex) -> Element {
        get {
            buffer.element(from: position.box)!
        }
        set {
            buffer.setElement(newValue, for: position.box)
        }
    }
}

@frozen
public struct LinkedList<Element>: MutableCollection /*, _DestructorSafeContainer*/ {
    @usableFromInline
    typealias Buffer = LinkedListBox<Element>

    public typealias Iterator = LinkedListIterator<Element>
    public typealias Index = LinkedListIndex
    public typealias SubSequence = LinkedListSlice<Element>

    @usableFromInline
    var buffer: Buffer

    @inlinable
    init(buffer: Buffer) {
        self.buffer = buffer
    }

    public var startIndex: Index {
        Index(buffer.begin)
    }

    public var endIndex: Index {
        Index(buffer.end)
    }

    public var isEmpty: Bool {
        linked_list_is_empty(buffer.ref)
    }

    public var count: Int {
        linked_list_count(buffer.ref)
    }

    public var underestimatedCount: Int {
        linked_list_count(buffer.ref)
    }

    public func makeIterator() -> LinkedListIterator<Element> {
        LinkedListIterator(buffer)
    }

    public func formIndex(after i: inout LinkedListIndex) {
        i.box.next()
    }

    public func index(after i: Index) -> Index {
        Index(i.box.copy().next())
    }

    public func index(_ i: Index, offsetBy distance: Int) -> Index {
        Index(i.box.copy().index(offsetBy: distance))
    }

    public func index(_ i: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index? {
        let box = i.box.copy().index(offsetBy: distance, limitedBy: limit.box)
        return box.map(Index.init)
    }

    public func distance(from start: Index, to end: Index) -> Int {
        start.box.distance(to: end.box)
    }

    public subscript(position: LinkedListIndex) -> Element {
        get {
            buffer.element(from: position.box)!
        }
        set {
            buffer.setElement(newValue, for: position.box)
        }
    }
}
