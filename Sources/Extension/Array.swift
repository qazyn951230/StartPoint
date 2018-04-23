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
    public func object(at index: Int) -> Element? {
        guard index >= self.startIndex && index < self.endIndex else {
            return nil
        }
        return self[index]
    }

    // TODO: Move to RangeReplaceableCollection
    public mutating func insert(nil element: Element?, at index: Int) {
        if let object = element {
            insert(object, at: index)
        }
    }

    // TODO: Move to RangeReplaceableCollection
    public mutating func append(nil element: Element?) {
        if let object = element {
            append(object)
        }
    }

    // TODO: Move to Sequence
    public static func from(_ value: Element?...) -> Array<Element> {
        return value.compactMap(Function.this)
    }
}
