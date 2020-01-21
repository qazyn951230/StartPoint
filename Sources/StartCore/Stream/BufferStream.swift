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

public protocol BufferOutputStream: OutputStream {
    associatedtype WriteBuffer: Buffer

    var writeBuffer: WriteBuffer { get set }
}

extension BufferOutputStream where WriteBuffer.Element == Value {
    public mutating func write(_ value: Value) {
        if writeBuffer.count + 1 > writeBuffer.capacity {
            self.flush()
        }
        assert(writeBuffer.count + 1 <= writeBuffer.capacity)
        writeBuffer.append(value)
    }
}

extension BufferOutputStream where WriteBuffer.Element == Value, Self: ByteOutputStream {
    public mutating func write<C>(_ value: C) where C: Collection, C.Element == Value {
        if value.isEmpty {
            return
        }
        if writeBuffer.count + value.count <= writeBuffer.capacity {
            writeBuffer.append(contentsOf: value)
            return
        }
        // buffer.count + value.count > buffer.capacity
        self.flush()
        let max = value.endIndex
        var start = value.startIndex
        var end = value.index(start, offsetBy: writeBuffer.capacity, limitedBy: max)
        while let _end = end {
            writeBuffer.append(contentsOf: value[start..<_end])
            self.flush()
            start = _end
            end = value.index(start, offsetBy: writeBuffer.capacity, limitedBy: max)
        }
        if start != max {
            writeBuffer.append(contentsOf: value[start..<max])
        }
    }
}

public protocol BufferInputStream: InputStream {
    associatedtype ReadBuffer: Buffer
    var readBuffer: ReadBuffer { get set }
}

public typealias BufferStream = BufferInputStream & BufferOutputStream
