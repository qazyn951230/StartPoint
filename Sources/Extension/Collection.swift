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
    public var isNotEmpty: Bool {
        return !isEmpty
    }

    public func mapIndex<T>(_ transform: (Self.Element, Self.Index) throws -> T) rethrows -> [T] {
        guard !isEmpty else {
            return []
        }
        var result = [T]()
        var i = startIndex
        repeat {
            let t = try transform(self[i], i)
            result.append(t)
            i = index(after: i)
        } while i < endIndex
        return result
    }

    public func forEachIndex(_ body: (Self.Element, Self.Index) throws -> Void) rethrows {
        guard !isEmpty else {
            return
        }
        var i = startIndex
        repeat {
            try body(self[i], i)
            i = index(after: i)
        } while i < endIndex
    }

    public func split(upTo count: Int) -> [Self.SubSequence] {
        guard isNotEmpty && count > 0 else {
            return []
        }
        var result: [Self.SubSequence] = []
        var start = startIndex
        var end = index(start, offsetBy: count)
        while true {
            if end < endIndex {
                let seq: Self.SubSequence = self[start..<end]
                result.append(seq)
                if index(after: end) > endIndex {
                    break
                }
            } else {
                let seq: Self.SubSequence = self[start..<endIndex]
                result.append(seq)
                break
            }
            start = end
            end = index(start, offsetBy: count)
        }
        return result
    }
}

public extension String {
    public func split(upTo count: Int) -> [Substring] {
        guard isNotEmpty && count > 0 else {
            return []
        }
        var result: [Substring] = []
        var start = startIndex
        var _end = index(start, offsetBy: count, limitedBy: endIndex)
        if _end == nil {
            return [self[start..<endIndex]]
        }
        while true {
            guard let end = _end else {
                break
            }
            if end < endIndex {
                let seq: Substring = self[start..<end]
                result.append(seq)
                if index(after: end) > endIndex {
                    break
                }
            } else {
                let seq: Substring = self[start..<endIndex]
                result.append(seq)
                break
            }
            start = end
            _end = index(start, offsetBy: count, limitedBy: endIndex)
            if _end == nil && end < endIndex {
                _end = endIndex
            }
        }
        return result
    }
}

public extension Sequence where Element: Hashable {
    public var hashValue: Int {
        return reduce(0) { (result: Int, next: Element) in
            result & next.hashValue
        }
    }
}
