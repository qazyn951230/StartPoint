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

public protocol ByteOutputStream: OutputStream, TextOutputStream {
    associatedtype Value = UInt8

    mutating func write(_ data: Data)
    mutating func write(_ string: String, encoding: String.Encoding)
}

public extension ByteOutputStream where Value == UInt8 {
    mutating func write(_ data: Data) {
        data.withUnsafeBytes { (raw: UnsafeRawBufferPointer) -> Void in
            let buffer = raw.bindMemory(to: UInt8.self)
            buffer.forEach { value in
                self.write(value)
            }
        }
    }

    mutating func write(_ string: String, encoding: String.Encoding) {
        if let data = string.data(using: encoding) {
            write(data)
        }
    }

    mutating func write(_ string: String) {
        write(string, encoding: .utf8)
    }
}

public protocol ByteInputSteam: InputStream {
    associatedtype Value = UInt8

    mutating func read(count: Int) -> Data
    mutating func readAll() -> Data
}

public typealias ByteStream = ByteOutputStream & ByteInputSteam