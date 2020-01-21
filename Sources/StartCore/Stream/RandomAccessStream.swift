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

public protocol RandomAccessStream: InputStream, BidirectionalStream {
    mutating func next() -> Value
    mutating func take() -> Value
    mutating func take(count: Int) -> [Value]

    mutating func peek() -> Value
    mutating func peek(offset: Int) -> Value

    mutating func move() -> Bool
    mutating func move(offset: Int) -> Bool
}

public extension RandomAccessStream {
    mutating func next() -> Value {
        _ = move()
        return peek()
    }

    mutating func take() -> Value {
        let value = peek()
        _ = move()
        return value
    }

    mutating func take(count: Int) -> [Value] {
        precondition(count > -1)
        var result: [Value] = []
        for _ in 0..<count {
            result.append(take())
        }
        return result
    }
}

public protocol UnsafeRandomAccessStream: RandomAccessStream {
    mutating func peek(count: Int) -> UnsafePointer<UInt8>?
    mutating func peek(into pointer: UnsafeMutablePointer<UInt8>, count: Int) -> Bool
    mutating func peek(into pointer: UnsafeMutableBufferPointer<UInt8>, count: Int?) -> Bool
}

public extension UnsafeRandomAccessStream {
    mutating func peek(into pointer: UnsafeMutablePointer<UInt8>, count: Int) -> Bool {
        guard count > 0 else {
            return true
        }
        guard let raw = self.peek(count: count) else {
            return false
        }
        pointer.assign(from: raw, count: count)
        return true
    }

    mutating func peek(into pointer: UnsafeMutableBufferPointer<UInt8>, count: Int? = nil) -> Bool {
        let temp = count ?? pointer.count
        guard temp > 0 else {
            return true
        }
        guard let raw = self.peek(count: temp) else {
            return false
        }
        pointer.baseAddress?.assign(from: raw, count: temp)
        return true
    }
}
