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

public protocol InStream {
    associatedtype Value

    func next() -> Value
    func take() -> Value
    func take(size: Int) -> [Value]

    func peek() -> Value
    func peek(offset: Int) -> Value

    func move() -> Bool
    func move(offset: Int) -> Bool
}

public extension InStream {
    func next() -> Value {
        _ = move()
        return peek()
    }

    func take() -> Value {
        let value = peek()
        _ = move()
        return value
    }

    func take(size: Int) -> [Value] {
        precondition(size > -1)
        var result: [Value] = []
        for _ in 0..<size {
            result.append(take())
        }
        return result
    }
}

public protocol OutStream {
    associatedtype Value

    mutating func write(_ value: Value) throws
    mutating func flush() throws
}

public enum SeekOffset {
    case current
    case start
    case end
}

public protocol RandomAccessStream: InStream {
    func move(offset: Int, seek: SeekOffset) -> Bool
    func peek(offset: Int, seek: SeekOffset) -> Value

    subscript(position: Int) -> Value { get }
}

public extension RandomAccessStream {
    func peek(offset: Int) -> Value {
        self.peek(offset: offset, seek: .current)
    }

    func move(offset: Int) -> Bool {
        self.move(offset: offset, seek: .current)
    }

    subscript(position: Int) -> Value {
        self.peek(offset: position, seek: .start)
    }
}
