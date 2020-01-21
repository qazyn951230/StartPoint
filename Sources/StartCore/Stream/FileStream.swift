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
import Darwin.C

public final class FileStream: ByteStream, BufferStream, RandomAccessStream {
    public typealias WriteBuffer = UIntBuffer
    public typealias ReadBuffer = UIntBuffer
    public typealias Value = UInt8
    public typealias Index = Int
    public static let defaultBufferCapacity = 1024

    public let readable: Bool
    public let writable: Bool
    public var writeBuffer = UIntBuffer(capacity: FileStream.defaultBufferCapacity)
    public var readBuffer = UIntBuffer(capacity: FileStream.defaultBufferCapacity)
    public private(set) var error: Error?

    let behavior: Behavior
    let file: UnsafeMutablePointer<FILE>

    public var hasError: Bool {
        error != nil
    }

    public init(read file: UnsafeMutablePointer<FILE>, behavior: Behavior = Behavior.close) {
        self.file = file
        self.readable = true
        self.writable = false
        self.behavior = behavior
    }

    public init(write file: UnsafeMutablePointer<FILE>, behavior: Behavior = Behavior.close) {
        self.file = file
        self.readable = false
        self.writable = true
        self.behavior = behavior
    }

    public init(read path: Path) throws {
        guard let file = fopen(path.string, "rb") else {
            throw Errors.posix()
        }
        self.readable = true
        self.writable = false
        self.file = file
        self.behavior = .close
    }

    public init(write path: Path) throws {
        guard let file = fopen(path.string, "wb") else {
            throw Errors.posix()
        }
        self.readable = false
        self.writable = true
        self.file = file
        self.behavior = .close
    }

    deinit {
        if behavior == Behavior.close {
            fclose(file)
        }
    }

    public func write(pointer: UnsafePointer<UInt8>, size: Int) {
        guard writable, size > 0 else {
            return
        }
        let raw = UnsafeRawPointer(pointer)
        while true {
            let n = fwrite(raw, 1, size, file)
            if n == size {
                break
            } else {
                if errno != EINTR {
                    error = StartError.posix(errno)
                    break
                }
            }
        }
    }

    public func write(_ value: UInt8) {
        guard writable else {
            return
        }
        if writeBuffer.count + 1 > writeBuffer.capacity {
            self.flush()
        }
        assert(writeBuffer.count + 1 <= writeBuffer.capacity)
        writeBuffer.append(value)
    }

    public func write(_ data: Data) {
        guard writable else {
            return
        }
        data.withUnsafeBytes { (raw: UnsafeRawBufferPointer) -> Void in
            let buffer = raw.bindMemory(to: UInt8.self)
            if let base = buffer.baseAddress {
                self.write(pointer: base, size: buffer.count)
            }
        }
    }

    public func write<C>(_ value: C) where C: Collection, C.Element == UInt8 {
        guard writable && value.isNotEmpty else {
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

    public func write(_ string: String) {
        guard writable else {
            return
        }
        write(string, encoding: .utf8)
    }

    public func write(_ string: String, encoding: String.Encoding) {
        guard writable else {
            return
        }
        if let data = string.data(using: encoding) {
            self.write(data)
        } else {
            error = StartError.invalidStringEncoding(string, encoding)
        }
    }

    public func flush() {
        guard writable else {
            return
        }
        write(pointer: writeBuffer.start, size: writeBuffer.count)
        writeBuffer.removeAll(keepingCapacity: true)
        fflush(file)
    }
    
    public func seek(offset: Int, direction: SeekDirection) {
    }

    public func peek() -> UInt8 {
        0
    }

    public func peek(offset: Int) -> UInt8 {
        0
    }

    public func move() -> Bool {
        false
    }

    public func move(offset: Int) -> Bool {
        false
    }

    public func read() -> UInt8? {
        fatalError("read() has not been implemented")
    }

    public func read(count: Int) -> Data {
        fatalError("read(count:) has not been implemented")
    }

    public func readAll() -> Data {
        fatalError("readAll() has not been implemented")
    }

    public enum Behavior {
        case close
        case none
    }

    public static func standardError() -> FileStream {
        FileStream(write: stderr, behavior: .none)
    }

    public static func standardInput() -> FileStream {
        FileStream(read: stdin, behavior: .none)
    }

    public static func standardOutput() -> FileStream {
        FileStream(write: stdout, behavior: .none)
    }
}
