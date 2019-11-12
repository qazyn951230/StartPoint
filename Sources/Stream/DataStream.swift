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

public protocol DataOutStream: OutStream {
    associatedtype Value = UInt8
    associatedtype Output

    var output: Output { get }

    mutating func write(data value: Data) throws
    mutating func write(string value: String, encoding: String.Encoding) throws
    mutating func write(bytes value: [UInt8]) throws
    mutating func write(bytes value: UnsafePointer<Int8>, count: Int) throws
    mutating func write(bytes value: UnsafePointer<UInt8>, count: Int) throws
}

public extension DataOutStream where Value == UInt8 {
    mutating func write(bytes value: [UInt8]) throws {
        for item in value {
            try self.write(item)
        }
    }
}

public extension DataOutStream {
    mutating func write(string value: String, encoding: String.Encoding) throws {
        guard let data = value.data(using: encoding) else {
            return
        }
        try self.write(data: data)
    }

    mutating func write(bytes value: UnsafePointer<Int8>, count: Int) throws {
        let next = UnsafeRawPointer(value).assumingMemoryBound(to: UInt8.self)
        try self.write(bytes: next, count: count)
    }

    mutating func write(data value: Data) throws {
        try value.withUnsafeBytes { (raw: UnsafeRawBufferPointer) in
            guard let pointer = raw.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                return
            }
            try self.write(bytes: pointer, count: raw.count)
        }
    }
}

public class ByteArrayStream: DataOutStream {
    public typealias Output = ByteArrayRef
    public let output: ByteArrayRef

    public init() {
        output = byte_array_create()
    }

    deinit {
        byte_array_free(output)
    }

    public func write(_ value: UInt8) throws {
        byte_array_add(output, value)
    }

    public func write(bytes value: UnsafePointer<UInt8>, count: Int) throws {
        if count < 1 {
            return
        }
        byte_array_write_uint8_data(output, value, count)
    }

    public func flush() throws {
        // Do noting
    }
}
