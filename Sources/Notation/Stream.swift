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

public protocol ReadableStream {
    associatedtype Value

    func take() -> Value
    func take(to offset: Int) -> [Value]

    func peek() -> Value
    func peek(offset: Int) -> Value
    func peek(at index: Int) -> Value

    func move() -> Bool
    func move(offset: Int) -> Bool
    func move(to index: Int) -> Bool

    subscript(index: Int) -> Value { get }
}

public extension ReadableStream {
    public func take() -> Value {
        let value = peek()
        _ = move()
        return value
    }

    func take(to offset: Int) -> [Value] {
        var result: [Value] = []
        for _ in 0..<offset {
            result.append(take())
        }
        return result
    }

    public subscript(index: Int) -> Value {
        get {
            return peek(at: index)
        }
    }
}

public protocol WritableStream {
    associatedtype Value

    func write(_ value: Value) throws
    func flush() throws
}
