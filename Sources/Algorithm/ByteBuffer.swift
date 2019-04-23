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

import Darwin.C

public final class ByteBuffer {
    private var start: UnsafeMutablePointer<UInt8>?
    private var end: UnsafeMutablePointer<UInt8>?
    private var current: UnsafeMutablePointer<UInt8>?
    private var initCapacity: Int

    public init(capacity: Int) {
        initCapacity = capacity
    }

    deinit {
        start?.deallocate()
    }

    public var isEmpty: Bool {
        return start == current
    }

    public var count: Int {
        guard let _start = start, let _current = current else {
            return 0
        }
        return _start.distance(to: _current)
    }

    public var capacity: Int {
        guard let _start = start, let _end = end else {
            return 0
        }
        return _start.distance(to: _end)
    }

    public func append(_ value: Int8) {
        let pointer = append(count: 1)
        pointer.pointee = UInt8(bitPattern: value)
    }

    public func append(_ value: UInt8) {
        let pointer = append(count: 1)
        pointer.pointee = value
    }

    public func append(count: Int = 1) -> UnsafeMutablePointer<UInt8> {
        reserve(count: count)
        return appendUnsafe(count: count)
    }

    public func appendUnsafe(count: Int = 1) -> UnsafeMutablePointer<UInt8> {
        assertNotNil(current)
        assertNotNil(end)
#if DEBUG
        guard let _current = current, let _end = end else {
            fatalError()
        }
        assertLessThanOrEqual(count, _current.distance(to: _end))
#else
        guard let _current = current else {
            fatalError()
        }
#endif
        let result = _current
        current = _current.advanced(by: count)
        return result
    }

    public func pop(count: Int) -> UnsafeMutablePointer<UInt8> {
        assertNotNil(current)
        assertGreaterThanOrEqual(self.count, count)
        guard let _current = current else {
            fatalError()
        }
        let result = _current.advanced(by: -count)
        current = result
        return result
    }

    public func reserve(count: Int = 1) {
        guard let _current = current, let _end = end else {
            expand(count: count)
            return
        }
        if count > _current.distance(to: _end) {
            expand(count: count)
        }
    }

    private func expand(count: Int) {
        var capacity: Int = 0
        if start == nil {
            capacity = initCapacity
        } else {
            capacity = self.capacity
            capacity += (capacity + 1) / 2
        }
        let toCount = self.count + count
        if  capacity < toCount {
            capacity = toCount
        }
        resize(to: capacity)
    }

    private func resize(to count: Int) {
        let _count = self.count
        let content = ByteBuffer.realloc(start, capacity, count)
        start = content
        current = content.advanced(by: _count)
        end = content.advanced(by: count)
    }

    private static func realloc(_ old: UnsafeMutablePointer<UInt8>?, _ oldSize: Int, _ size: Int)
        -> UnsafeMutablePointer<UInt8> {
        assertNotEqual(size, 0)
        if let _old = old {
            let result = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
            result.moveAssign(from: _old, count: oldSize)
            _old.deallocate()
            return result
        } else {
            return UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        }
    }
}
