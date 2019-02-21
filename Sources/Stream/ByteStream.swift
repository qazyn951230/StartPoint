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

    public var available: Bool {
        return false
    }

    public func peek() -> UInt8 {
        return 0
    }

    public func peek(offset: Int) -> UInt8 {
        return 0
    }

    public func move() {
        // Do nothing.
    }

    public func move(offset: Int) {
        // Do nothing.
    }

    public static func int8(_ source: UnsafePointer<Int8>) -> ByteStream {
        return Int8Stream(source: source)
    }

    public static func uint8(_ source: UnsafePointer<UInt8>) -> ByteStream {
        return UInt8Stream(source: source)
    }

    public static func file(_ path: String) -> ByteStream {
        return FileByteStream(path: path)
    }
}

final class Int8Stream: ByteStream {
    let source: UnsafePointer<Int8>
    let size: Int
    let nullTerminated: Bool
    var index: Int = 0
    var current: UnsafePointer<Int8>
    var terminated: Bool = false

    init(source: UnsafePointer<Int8>, size: Int = 0) {
        self.source = source
        self.size = size
        current = source
        nullTerminated = size < 1
    }

    override var available: Bool {
        return nullTerminated ? terminated : index < size
    }

    override func peek() -> UInt8 {
        return available ? UInt8(bitPattern: current.pointee) : 0
    }

    override func peek(offset: Int) -> UInt8 {
        var result: Int8 = 0
        if nullTerminated {
            var i = 0
            var t = current
            while i < offset {
                t = t.successor()
                if t.pointee == 0 {
                    return 0
                }
                i += 1
            }
            result = t.pointee
        } else {
            if index + offset < size {
                result = current.advanced(by: offset).pointee
            } else {
                return 0
            }
        }
        return UInt8(bitPattern: result)
    }

    override func move() {
        guard available else {
            return
        }
        current = current.successor()
        if nullTerminated {
            terminated = current.pointee == 0
        } else {
            index += 1
        }
    }

    override func move(offset: Int) {
        if nullTerminated {
            if terminated {
                return
            }
            var i = 0
            var t = current
            while i < offset {
                t = t.successor()
                if t.pointee == 0 {
                    terminated = true
                    break
                }
                i += 1
            }
            if !terminated {
                current = current.advanced(by: offset)
            }
        } else {
            if index + offset < size {
                current = current.advanced(by: offset)
                index += offset
            }
        }
    }
}

final class UInt8Stream: ByteStream {
    let source: UnsafePointer<UInt8>
    let size: Int
    let nullTerminated: Bool
    var index: Int = 0
    var current: UnsafePointer<UInt8>
    var terminated: Bool = false

    init(source: UnsafePointer<UInt8>, size: Int = 0) {
        self.source = source
        self.size = size
        current = source
        nullTerminated = size < 1
    }

    override var available: Bool {
        return nullTerminated ? terminated : index < size
    }

    override func peek() -> UInt8 {
        return available ? current.pointee : 0
    }

    override func peek(offset: Int) -> UInt8 {
        var result: UInt8 = 0
        if nullTerminated {
            var i = 0
            var t = current
            while i < offset {
                t = t.successor()
                if t.pointee == 0 {
                    return 0
                }
                i += 1
            }
            result = t.pointee
        } else {
            if index + offset < size {
                result = current.advanced(by: offset).pointee
            } else {
                return 0
            }
        }
        return result
    }

    override func move() {
        guard available else {
            return
        }
        current = current.successor()
        if nullTerminated {
            terminated = current.pointee == 0
        } else {
            index += 1
        }
    }

    override func move(offset: Int) {
        if nullTerminated {
            if terminated {
                return
            }
            var i = 0
            var t = current
            while i < offset {
                t = t.successor()
                if t.pointee == 0 {
                    terminated = true
                    break
                }
                i += 1
            }
            if !terminated {
                current = current.advanced(by: offset)
            }
        } else {
            if index + offset < size {
                current = current.advanced(by: offset)
                index += offset
            }
        }
    }
}

final class FileByteStream: ByteStream {
    let bytes: UnsafeMutableRawPointer
    let count: Int
    var current: UnsafeMutableRawPointer
    var index: Int = 0

    init(path: String) {
        let (content, size) = FileByteStream.open(path: path)
        bytes = content ?? UnsafeMutableRawPointer.allocate(byteCount: 1, alignment: MemoryLayout<UInt8>.alignment)
        count = content == nil ? 0 : size
        current = bytes
    }

    deinit {
        bytes.deallocate()
    }

    override var available: Bool {
        return index < count
    }

    override func peek() -> UInt8 {
        guard available else {
            return 0
        }
        return current.load(as: UInt8.self)
    }

    override func peek(offset: Int) -> UInt8 {
        if index + offset < count {
            let c = current.advanced(by: offset)
            return c.load(as: UInt8.self)
        } else {
            return 0
        }
    }

    override func move() {
        guard available else {
            return
        }
        current = current.advanced(by: 1)
        index += 1
    }

    override func move(offset: Int) {
        if index + offset < count {
            current = current.advanced(by: offset)
            index += offset
        }
    }

    private static func open(path: String) -> (UnsafeMutableRawPointer?, Int) {
        guard let file = fopen(path, "rb") else {
            return (nil, 0)
        }
        defer {
            fclose(file)
        }
        if fseeko(file, 0, SEEK_END) != 0 {
            return (nil, 0)
        }
        let size = ftello(file)
        if fseeko(file, 0, SEEK_SET) != 0 {
            return (nil, 0)
        }
        guard size > 0 && size < Int32.max else {
            return (nil, 0)
        }
        var count = Int(size)
        let bytes = UnsafeMutableRawPointer.allocate(byteCount: count, alignment: MemoryLayout<UInt8>.alignment)
        count = fread(bytes, 1, count, file)
        return (bytes, count)
    }
}