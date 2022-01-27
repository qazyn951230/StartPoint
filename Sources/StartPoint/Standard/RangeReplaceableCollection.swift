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

extension RangeReplaceableCollection {
    /// Note: `popFirst()` requires`Self == Self.SubSequence`
    @inlinable
    public mutating func removeFirstOrNil() -> Element? {
        let t = first
        if t != nil {
            _ = removeFirst()
        }
        return t
    }

    @inlinable
    public mutating func insert(any element: Element?, at index: Index) {
        if let object = element {
            insert(object, at: index)
        }
    }

    @inlinable
    public mutating func append(any element: Element?) {
        if let object = element {
            append(object)
        }
    }

    // [1], 0..<0 => [2, 1]
    // [1], 0..<1 => [2]
    // [1], 1..<1 => [1, 2]
    // [1], 0...0 => [2]
    // [1], 1...1 => ERROR
    @inlinable
    public mutating func replace(at index: Index, with element: Element) {
        guard index >= startIndex && index < endIndex else {
            return
        }
        replaceSubrange(index...index, with: [element])
    }

    @inlinable
    public func replaced(at index: Index, with element: Element) -> [Element] {
        var this = self
        this.replace(at: index, with: element)
        return Array(this)
    }
}

extension RangeReplaceableCollection where Element: Equatable {
    @inlinable
    @discardableResult
    public mutating func removeFirst(of value: Element) -> Element? {
        guard let index = firstIndex(of: value) else {
            return nil
        }
        return remove(at: index)
    }
}
