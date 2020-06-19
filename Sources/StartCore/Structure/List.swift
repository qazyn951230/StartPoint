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

public final class List<Element>: MutableCollection {
    public typealias Index = Int
    // IndexingIterator<Element>, Element: Collection
    public typealias Iterator = IndexingIterator<List<Element>>
    public typealias SubSequence = ListSlice<Element>

    @usableFromInline
    var store: [Element]

    @inlinable
    public init() {
        store = []
    }

    // RangeReplaceableCollection
    @inlinable
    public init<S>(_ elements: S) where S : Sequence, Element == S.Element {
        store = Array(elements)
    }

    @inlinable
    public init(repeating repeatedValue: Element, count: Int) {
        store = Array(repeating: repeatedValue, count: count)
    }
    // RangeReplaceableCollection

    // Collection
    public var isEmpty: Bool {
        store.isEmpty
    }

    public var count: Int {
        store.count
    }

    public var startIndex: Index {
        store.startIndex
    }

    public var endIndex: Index {
        store.endIndex
    }

    public subscript(position: Index) -> Element {
        get { // MutableCollection only
            store[position]
        }
        set(newValue) {
            store[position] = newValue
        }
    }

    @inlinable
    public func distance(from start: Int, to end: Int) -> Int {
        store.distance(from: start, to: end)
    }

    @inlinable
    public func index(after i: Index) -> Index {
        store.index(after: i)
    }

    @inlinable
    public func index(_ i: Int, offsetBy distance: Int) -> Int {
        store.index(i, offsetBy: distance)
    }

    @inlinable
    public func index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int? {
        store.index(i, offsetBy: distance, limitedBy: limit)
    }
    // Collection

    // MutableCollection & RandomAccessCollection & RangeReplaceableCollection
    public subscript(bounds: Range<Int>) -> ListSlice<Element> {
        get {
            return ListSlice(slice: store[bounds])
        }
        set {
            store[bounds] = newValue.store
        }
    }
    // MutableCollection & RandomAccessCollection & RangeReplaceableCollection
}

extension List: RandomAccessCollection {}

extension List: RangeReplaceableCollection {
    @inlinable
    public func append(_ newElement: Element) {
        store.append(newElement)
    }
}
