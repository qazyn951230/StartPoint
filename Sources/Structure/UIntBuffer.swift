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

public final class UIntBuffer: MemoryBuffer {
    public typealias Element = UInt8

    public private(set) var start: UnsafePointer<UInt8>
    public private(set) var end: UnsafePointer<UInt8>
    private(set) var current: UnsafeMutablePointer<UInt8>

    public init(capacity: Int) {
        current = UnsafeMutablePointer<UInt8>.allocate(capacity: capacity)
        start = UnsafePointer(current)
        end = UnsafePointer(current).advanced(by: capacity)
    }

    deinit {
        start.deallocate()
    }

    public var count: Int {
        start.distance(to: current)
    }

    public func reserveCapacity(_ minimumCapacity: Int) {
        guard minimumCapacity > capacity else {
            return
        }
        let temp = UnsafeMutablePointer<UInt8>.allocate(capacity: minimumCapacity)
        let oldStart = UnsafeMutablePointer(mutating: start)
        let oldCount = count
        temp.moveAssign(from: oldStart, count: oldCount)
        start = UnsafePointer(temp)
        end = start.advanced(by: minimumCapacity)
        current = temp.advanced(by: oldCount)
    }

    public func append(_ newElement: UInt8) {
        precondition(UnsafePointer(current).distance(to: end) >= 1)
        current.pointee = newElement
        current = current.advanced(by: 1)
    }

    public func append<S>(contentsOf newElements: S) where S : Sequence, S.Element == UInt8  {
        var iterator = newElements.makeIterator()
        while let next = iterator.next() {
            self.append(next)
        }
    }

    public func removeAll(keepingCapacity keepCapacity: Bool) {
        current = UnsafeMutablePointer(mutating: start)
    }
}
