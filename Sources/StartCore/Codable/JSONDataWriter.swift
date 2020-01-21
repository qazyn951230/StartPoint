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

import Foundation
public class JSONDataWriter: JSONWriter {
    public typealias Output = Data

    public private(set) var data: ByteArrayRef
    private(set) var state: [State] = []
    public var sortKeys = false

    public var output: Data {
        Data(bytesNoCopy: UnsafeMutableRawPointer(mutating: byte_array_data(data)),
             count: byte_array_size(data), deallocator: Data.Deallocator.free)
    }

    public init() {
        data = byte_array_create()
    }

    deinit {
        byte_array_free(data)
    }

    var current: State {
        state.last ?? State.value
    }

    public func copyData() -> Data {
        Data(bytes: byte_array_data(data), count: byte_array_size(data))
    }

    /// ```swift
    /// self.startArray()
    /// for item in value {
    ///     self.writePrefix()
    ///     item.accept(visitor: self)
    ///     self.writeSuffix()
    /// }
    /// self.endArray()
    /// ```
    public func startArray() {
        state.append(State.array)
        byte_array_add(data, 0x5b) // [
    }

    public func endArray() {
        precondition(current == State.array || current == State.filledArray)
        byte_array_add(data, 0x5d) // ]
        state.removeLast()
    }

    /// ```swift
    /// self.startObject()
    /// for (key, item) in value {
    ///     self.writePrefix()
    ///     self.write(key)
    ///     self.writeInfix()
    ///     item.accept(visitor: self)
    ///     self.writeSuffix()
    /// }
    /// self.endObject()
    /// ```
    public func startObject() {
        state.append(State.object)
        byte_array_add(data, 0x7b) // {
    }

    public func endObject() {
        precondition(current == State.object || current == State.filledObject)
        byte_array_add(data, 0x7d) // }
        state.removeLast()
    }

    public func writePrefix() {
        precondition(current != State.key && current != State.value)
        switch current {
        case .array: // A empty ARRAY just started.
            break
        case .filledArray, .filledObject:
            byte_array_add(data, 0x2c) // ,
        case .object: // A empty OBJECT just started.
            break
        case .key, .value:
            break
        }
    }

    public func writeInfix() {
        precondition(current == State.key)
        byte_array_add(data, 0x3a) // :
    }

    public func writeSuffix() {
        switch current {
        case .array:
            state.removeLast()
            state.append(State.filledArray)
        case .object, .key:
            state.removeLast()
            state.append(State.filledObject)
        default:
            break
        }
    }

    public func writeNull() {
        byte_array_write_null(data)
    }

    private func write(key: String) {
        write(string: key)
    }

    private func write(string value: String) {
        byte_array_add(data, 0x22) // "
        value.withCString { pointer in
            byte_array_write_int8_data(data, pointer, 0)
        }
        byte_array_add(data, 0x22) // "
    }

    public func write(_ value: String) {
        switch current {
        case .object, .filledObject:
            state.append(State.key)
            write(key: value)
        case .key:
            state.removeLast()
            write(string: value)
        case .array, .filledArray, .value:
            write(string: value)
        }
    }

    public func write(_ value: Bool) {
        byte_array_write_bool(data, value)
    }

    public func write(_ value: Float) {
        byte_array_write_float(data, value)
    }

    public func write(_ value: Double) {
        byte_array_write_double(data, value)
    }

    public func write(_ value: Int32) {
        byte_array_write_int32(data, value)
    }

    public func write(_ value: Int64) {
        byte_array_write_int64(data, value)
    }

    public func write(_ value: UInt32) {
        byte_array_write_uint32(data, value)
    }

    public func write(_ value: UInt64) {
        byte_array_write_uint64(data, value)
    }

    public func visit(dictionary value: [String: JSON]) {
        if sortKeys {
            let keys = value.keys.sorted()
            visit(dictionary: value, order: keys)
        } else {
            self.startObject()
            for (key, item) in value {
                self.writePrefix()
                write(key)
                self.writeInfix()
                item.accept(visitor: self)
                self.writeSuffix()
            }
            self.endObject()
        }
    }

    public func visit(dictionary value: [String: JSON], order: [String]) {
        self.startObject()
        for key in order {
            self.writePrefix()
            write(key)
            self.writeInfix()
            if let item = value[key] {
                item.accept(visitor: self)
            } else {
                writeNull()
            }
            self.writeSuffix()
        }
        self.endObject()
    }

    enum State {
        case array
        case filledArray
        case object
        case filledObject
        case key
        case value
    }
}
