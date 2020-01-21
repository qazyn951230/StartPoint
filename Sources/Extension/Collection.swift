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

public extension Collection {
    @inlinable
    func chunked(size: Int) -> [SubSequence] {
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


    @inline(__always)
    var isNotEmpty: Bool {
        !isEmpty
    }

    @inline(__always)
    func at(_ index: Index) -> Element? {
        guard index >= startIndex && index < endIndex else {
            return nil
        }
        return self[index]
    }

    @inline(__always)
    func at(_ index: Index, or value: (Index) throws -> Element) rethrows -> Element {
        guard index >= startIndex && index < endIndex else {
            return try value(index)
        }
        return self[index]
    }

    @inlinable
    func filterIndexed(_ isIncluded: (Element, Index) throws -> Bool) rethrows -> [Element] {
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
    func mapIndexed<T>(_ transform: (Element, Index) throws -> T) rethrows -> [T] {
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
    func reduceIndexed<Result>(_ initialResult: Result,
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
    func forEachIndexed(_ body: (Element, Index) throws -> Void) rethrows {
        if isEmpty {
            return
        }
        var i = startIndex
        repeat {
            try body(self[i], i)
            i = index(after: i)
        } while i < endIndex
    }

    @available(*, deprecated, renamed: "chunked(size:)")
    func split(upTo count: Int) -> [SubSequence] {
        chunked(size: count)
    }
}

extension Collection where Element: Equatable, Index == Int {
    // The algorithm implemented below is the "classic"
    // dynamic-programming algorithm for computing the Levenshtein
    // distance, which is described here:
    //
    //   http://en.wikipedia.org/wiki/Levenshtein_distance
    //
    // Although the algorithm is typically described using an m x n
    // array, only one row plus one element are used at a time, so this
    // implementation just keeps one vector for the row.  To update one entry,
    // only the entries to the left, top, and top-left are needed.  The left
    // entry is in Row[x-1], the top entry is what's in Row[x] from the last
    // iteration, and the top-left entry is stored in Previous.
    // Copy from .../llvm/include/llvm/ADT/edit_distance.h
    func editDistance<Other>(to: Other, replace allowReplacement: Bool, max: Int = 0) -> Int
        where Other: Collection, Other.Index == Index, Other.Element == Element {
        var row = Array<Int>.generate(count: to.count + 1) { $0 }
        let a = self.startIndex
        let b = to.startIndex
        let m = self.endIndex
        let n = to.endIndex
        var y =  a + 1
        var x = b + 1
        while y <= m {
            row[0] = y - a
            var best = row[0]
            var previous = y - 1
            x = b + 1
            while x <= n {
                let oldRow = row[x - b]
                if allowReplacement {
                    row[x - b] = Swift.min(
                        previous + ((self[y - 1] == to[x - 1]) ? 0 : 1),
                        Swift.min(row[x - 1 - b], row[x - b]) + 1)
                } else {
                    if self[y - 1] == to[x - 1] {
                        row[x - b] = previous
                    } else {
                        row[x - b] = Swift.min(row[x - 1 - b], row[x - b]) + 1
                    }
                }
                previous = oldRow
                best = Swift.min(best, row[x - b])
                x += 1
            }
            if max > 0 && best > max {
                return max
            }
            y += 1
        }
        return row[to.count]
    }
}

//extension Collection where Element: Equatable, Index: Hashable {
//    func editDistance<Other>(to: Other, allowReplacement: Bool, max: Int = 0) -> Int
//        where Other: Collection, Other.Index == Index, Other.Element == Element {
//        var row = Dictionary<Other.Index, Int>.generate(count: to.count) { i in
//            let next = to.index(to.startIndex, offsetBy: i)
//            return (next, i)
//        }
//        let a = self.startIndex
//        let b = to.startIndex
//        let m = self.endIndex
//        let n = to.endIndex
//        var y = self.index(after: a)
//        var x = to.index(after: b)
//        while y <= m {
//            row[b] = self.distance(from: y, to: a)
//            var best = row[b, default: 0]
//            var previous = to.index(y, offsetBy: -1)
//            while x <= n {
//                let oldRow = row[x]
//                if allowReplacement {
//                    row[x] = Swift.min(
//                        previous + ((self[y - 1] == to[x - 1]) ? 0 : 1),
//                        Swift.min(row[x - 1 - b], row[x - b]) + 1)
//                } else {
//                    if self[y - 1] == to[x - 1] {
//                        row[x] = previous
//                    } else {
//                        row[x] = Swift.min(row[to.index(x, offsetBy: -1), default: 0],
//                            row[x, default: 0]) + 1
//                    }
//                }
//                previous = oldRow
//                best = Swift.min(best, row[x, default: 0])
//                x = to.index(after: x)
//            }
//            if max > 0 && best > max {
//                return max
//            }
//            y = self.index(after: y)
//        }
//        return row[to.count]
//    }
//}
