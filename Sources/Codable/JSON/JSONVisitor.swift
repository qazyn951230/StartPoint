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

public protocol JSONVisitor {
    func visit(array value: [JSON])
    func visit(dictionary value: [String: JSON])
    func visit(dictionary value: [String: JSON], order: [String])
    func visitNull()
    func visit(string value: String)
    func visit(bool value: Bool)
    func visit(double value: Double)
    func visit(int value: Int32)
    func visit(int64 value: Int64)
    func visit(uint value: UInt32)
    func visit(uint64 value: UInt64)
}

public extension JSONVisitor {
    func visit(dictionary value: [String: JSON], order: [String]) {
        visit(dictionary: value)
    }
}

public extension JSON {
    func accept(visitor: JSONVisitor) {
        switch json_type(ref) {
        case JSONType.array:
            visitor.visit(array: array)
        case JSONType.object:
            visitor.visit(dictionary: dictionary)
        case JSONType.int:
            visitor.visit(int: int32)
        case JSONType.uint:
            visitor.visit(uint: uint32)
        case JSONType.int64:
            visitor.visit(int64: int64)
        case JSONType.uint64:
            visitor.visit(uint64: uint64)
        case JSONType.double:
            visitor.visit(double: double)
        case JSONType.string:
            visitor.visit(string: string)
        case JSONType.null:
            visitor.visitNull()
        case JSONType.true:
            visitor.visit(bool: true)
        case JSONType.false:
            visitor.visit(bool: false)
        @unknown default:
            break
        }
    }
}
