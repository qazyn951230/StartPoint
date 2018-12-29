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

public class ByteStream: ReadableStream {
    public typealias Value = UInt8

    public func peek() -> UInt8 {
        return 0
    }

    public func peek(offset: Int) -> UInt8 {
        return 0
    }

    public func peek(at index: Int) -> UInt8 {
        return 0
    }

    @discardableResult
    public func move() -> Bool {
        return false
    }

    @discardableResult
    public func move(offset: Int) -> Bool {
        return false
    }

    @discardableResult
    public func move(to index: Int) -> Bool {
        return false
    }

    public func next() -> UInt8 {
        move()
        return peek()
    }

    public static func int8(_ source: UnsafePointer<Int8>) -> ByteStream {
        return _Int8Stream(source: source)
    }

    public static func uint8(_ source: UnsafePointer<UInt8>) -> ByteStream {
        return _UInt8Stream(source: source)
    }

    public static func file(_ path: String) -> ByteStream {
        return _FileStream(path: path)
    }
}

final class _Int8Stream: ByteStream {
    let source: UnsafePointer<Int8>
    var current: UnsafePointer<Int8>

    init(source: UnsafePointer<Int8>) {
        self.source = source
        current = source
    }

    override func peek() -> UInt8 {
        return UInt8(bitPattern: current.pointee)
    }

    override func peek(offset: Int) -> UInt8 {
        return super.peek(offset: offset)
    }

    override func peek(at index: Int) -> UInt8 {
        return super.peek(at: index)
    }

    @discardableResult
    override func move() -> Bool {
        current = current.successor()
        return true
    }

    @discardableResult
    override func move(offset: Int) -> Bool {
        current = current.advanced(by: offset)
        return true
    }

    @discardableResult
    override func move(to index: Int) -> Bool {
        current = source.advanced(by: index)
        return true
    }
}

final class _UInt8Stream: ByteStream {
    let source: UnsafePointer<UInt8>
    var current: UnsafePointer<UInt8>

    init(source: UnsafePointer<UInt8>) {
        self.source = source
        current = source
    }

    override func peek() -> UInt8 {
        return current.pointee
    }

    override func peek(offset: Int) -> UInt8 {
        return super.peek(offset: offset)
    }

    override func peek(at index: Int) -> UInt8 {
        return super.peek(at: index)
    }

    @discardableResult
    override func move() -> Bool {
        current = current.successor()
        return true
    }

    @discardableResult
    override func move(offset: Int) -> Bool {
        current = current.advanced(by: offset)
        return true
    }

    @discardableResult
    override func move(to index: Int) -> Bool {
        current = source.advanced(by: index)
        return true
    }
}

final class _FileStream: ByteStream {
    var bytes: UnsafeMutableRawPointer?
    var current: UnsafeMutableRawPointer?
    var index: Int = 0
    var count: Int = 0

    init(path: String) {
        guard let file = fopen(path, "rb") else {
            return
        }
        defer {
            fclose(file)
        }
        if fseeko(file, 0, SEEK_END) != 0 {
            return
        }
        let size = ftello(file)
        if fseeko(file, 0, SEEK_SET) != 0 {
            return
        }
        guard size > 0 && size < Int32.max else {
            return
        }
        count = Int(size)
        bytes = UnsafeMutableRawPointer.allocate(byteCount: count, alignment: MemoryLayout<UInt8>.alignment)
        count = fread(bytes, 1, count, file)
        current = bytes
    }

    deinit {
        bytes?.deallocate()
    }

    override func peek() -> UInt8 {
        guard count > 0, let c = current else {
            return 0
        }
        return c.load(as: UInt8.self)
    }

    override func peek(offset: Int) -> UInt8 {
        guard let c = current?.advanced(by: offset) else {
            return 0
        }
        return c.load(as: UInt8.self)
    }

    override func peek(at index: Int) -> UInt8 {
        guard let c = bytes?.advanced(by: index) else {
            return 0
        }
        return c.load(as: UInt8.self)
    }

    @discardableResult
    override func move() -> Bool {
        guard count > 0, index < count else {
            return false
        }
        index += 1
        current = current?.advanced(by: 1)
        return false
    }

    override func move(offset: Int) -> Bool {
        guard count > 0, index + offset <= count else {
            return false
        }
        index += offset
        current = current?.advanced(by: index)
        return true
    }

    override func move(to index: Int) -> Bool {
        guard count > 0, index < count else {
            return false
        }
        self.index = index
        current = bytes?.advanced(by: index)
        return true
    }
}