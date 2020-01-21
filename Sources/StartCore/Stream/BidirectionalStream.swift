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

public enum SeekDirection {
    case current
    case start
    case end
}

public protocol BidirectionalStream {
    associatedtype Index: Comparable

    func index(after i: Index) -> Index
    func index(before i: Index) -> Index
    func formIndex(after i: inout Index)
    func formIndex(before i: inout Index)
    func formIndex(_ i: inout Index, offsetBy distance: Int)

    func distance(from start: Index, to end: Index) -> Int

    func seek(position: Index)
    func seek(offset: Index, direction: SeekDirection)
}

public extension BidirectionalStream {
    @inlinable
    func seek(position: Index) {
        seek(offset: position, direction: .start)
    }

    @inlinable
    func formIndex(after i: inout Index) {
        i = index(after: i)
    }

    @inlinable
    func formIndex(before i: inout Index) {
        i = index(before: i)
    }

    @inlinable
    func formIndex(_ i: inout Index, offsetBy distance: Int) {
        var result = i
        if distance > 0 {
            for _ in 0..<distance {
                result = index(after: result)
            }
        } else if distance < 0 {
            for _ in distance..<0 {
                result = index(before: result)
            }
        }
        i = result
    }
}

public extension BidirectionalStream where Index: SignedInteger {
    @inlinable
    func index(after i: Index) -> Index {
        i + Index(1)
    }

    @inlinable
    func index(before i: Index) -> Index {
        i - Index(1)
    }

    func distance(from start: Index, to end: Index) -> Int {
        if start >= end {
            return Int(start - end)
        } else {
            return Int(end - start)
        }
    }
}
