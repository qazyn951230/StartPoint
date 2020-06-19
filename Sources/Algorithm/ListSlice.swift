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

public final class ListSlice<Element>: MutableCollection, RandomAccessCollection, RangeReplaceableCollection {
    public typealias Index = Int
    public typealias Iterator = IndexingIterator<ListSlice<Element>>
    public typealias SubSequence = ListSlice<Element>

    var store: ArraySlice<Element>

    public init() {
        store = []
    }

    init(slice: ArraySlice<Element>) {
        store = slice
    }

    public init<S>(_ elements: S) where S: Sequence, Element == S.Element {
        store = ArraySlice(elements)
    }

    public init(repeating repeatedValue: ListSlice.Element, count: Int) {
        store = ArraySlice(repeating: repeatedValue, count: count)
    }

    public var isEmpty: Bool {
        return store.isEmpty
    }

    public var count: Int {
        return store.count
    }

    public var startIndex: Int {
        return store.startIndex
    }

    public var endIndex: Int {
        return store.endIndex
    }

    public func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C)
        where C: Collection, Element == C.Element {
        store.replaceSubrange(subrange, with: newElements)
    }

    public func index(_ i: Int, offsetBy n: Int) -> Int {
        return store.index(i, offsetBy: n)
    }

    public func index(_ i: Int, offsetBy n: Int, limitedBy limit: Int) -> Int? {
        return store.index(i, offsetBy: n, limitedBy: limit)
    }

    public func distance(from start: Int, to end: Int) -> Int {
        return store.distance(from: start, to: end)
    }

    public func index(after i: Int) -> Int {
        return store.index(after: i)
    }

    public func formIndex(after i: inout Int) {
        store.formIndex(after: &i)
    }

    public subscript(index: Int) -> Element {
        get {
            return store[index]
        }
        set {
            store[index] = newValue
        }
    }

    public subscript(bounds: Range<Int>) -> ListSlice<Element> {
        get {
            return ListSlice(slice: store[bounds])
        }
        set {
            store[bounds] = newValue.store
        }
    }
}
