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

public extension Array {
    // TODO: Move to RandomAccessCollection or MutableCollection
    func object(at index: Int) -> Element? {
        guard index >= self.startIndex && index < self.endIndex else {
            return nil
        }
        return self[index]
    }

    // TODO: Move to RangeReplaceableCollection
    mutating func insert(any element: Element?, at index: Int) {
        if let object = element {
            insert(object, at: index)
        }
    }

    // TODO: Move to RangeReplaceableCollection
    mutating func append(any element: Element?) {
        if let object = element {
            append(object)
        }
    }

    // [1], 0..<0 => [2, 1]
    // [1], 0..<1 => [2]
    // [1], 1..<1 => [1, 2]
    // [1], 0...0 => [2]
    // [1], 1...1 => ERROR
    mutating func replace(at index: Int, with element: Element) {
        guard index >= self.startIndex && index < self.endIndex else {
            return
        }
        replaceSubrange(index...index, with: [element])
    }

    func replaced(at index: Int, with element: Element) -> Array<Element> {
        var this = self
        this.replace(at: index, with: element)
        return this
    }

    static func from(_ value: Element?...) -> Array<Element> {
        value.compactMap(Function.this)
    }

    static func generate(count: Int, _ generator: (Int) throws -> Element) rethrows -> Array<Element> {
        var result: [Element] = []
        for index in 0..<count {
            result.append(try generator(index))
        }
        return result
    }
}
