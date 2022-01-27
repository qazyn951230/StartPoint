// MIT License
//
// Copyright (c) 2021-present qazyn951230 qazyn951230@gmail.com
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

extension Collection {
    @inlinable
    public func chunked(size: Int) -> [SubSequence] {
        if isEmpty || size < 1 {
            return []
        }
        var result: [SubSequence] = []
        var start = startIndex
        var end = index(start, offsetBy: size)
        while end <= endIndex {
            let seq: SubSequence = self[start..<end]
            result.append(seq)
            start = end
            end = index(start, offsetBy: size)
        }
        if start != endIndex {
            let seq: SubSequence = self[start..<endIndex]
            result.append(seq)
        }
        return result
    }

    @inlinable
    @inline(__always)
    public var isNotEmpty: Bool {
        !isEmpty
    }

    @inlinable
    @inline(__always)
    public func at(_ index: Index) -> Element? {
        guard index >= startIndex && index < endIndex else {
            return nil
        }
        return self[index]
    }

    @inlinable
    @inline(__always)
    public func at(_ index: Index, or value: (Index) throws -> Element) rethrows -> Element {
        guard index >= startIndex && index < endIndex else {
            return try value(index)
        }
        return self[index]
    }

    @inlinable
    public func filterIndexed(_ isIncluded: (Element, Index) throws -> Bool) rethrows -> [Element] {
        if isEmpty {
            return []
        }
        var result: [Element] = []
        var i = startIndex
        repeat {
            if try isIncluded(self[i], i) {
                result.append(self[i])
            }
            i = index(after: i)
        } while i < endIndex
        return result
    }

    @inlinable
    public func mapIndexed<T>(_ transform: (Element, Index) throws -> T) rethrows -> [T] {
        if isEmpty {
            return []
        }
        var result: [T] = []
        var i = startIndex
        repeat {
            let t = try transform(self[i], i)
            result.append(t)
            i = index(after: i)
        } while i < endIndex
        return result
    }

    @inlinable
    @discardableResult
    public func map<C>(into collection: inout C, transform: (Element) throws -> C.Element) rethrows -> C
        where C: RangeReplaceableCollection {
        for element in self {
            collection.append(try transform(element))
        }
        return collection
    }

    @inlinable
    public func flatMapIndexed<SegmentOfResult>(_ transform: (Element, Index) throws -> SegmentOfResult) rethrows
            -> [SegmentOfResult.Element] where SegmentOfResult: Sequence {
        if isEmpty {
            return []
        }
        var result: [SegmentOfResult.Element] = []
        var i = startIndex
        repeat {
            let t = try transform(self[i], i)
            result.append(contentsOf: t)
            i = index(after: i)
        } while i < endIndex
        return result
    }

    @inlinable
    public func reduceIndexed<Result>(_ initialResult: Result,
        _ nextPartialResult: (Result, Index, Element) throws -> Result) rethrows -> Result {
        if isEmpty {
            return initialResult
        }
        var result = initialResult
        var i = startIndex
        repeat {
            result = try nextPartialResult(result, i, self[i])
            i = index(after: i)
        } while i < endIndex
        return result
    }

    @inlinable
    public func forEachIndexed(_ body: (Element, Index) throws -> Void) rethrows {
        if isEmpty {
            return
        }
        var i = startIndex
        repeat {
            try body(self[i], i)
            i = index(after: i)
        } while i < endIndex
    }
}
