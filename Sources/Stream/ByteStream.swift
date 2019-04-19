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

#if DEBUG
    public var consumedText: String {
        return ""
    }
#endif

    public var effective: Bool {
        return false
    }

    public func peek() -> UInt8 {
        return 0
    }

    public func peek(offset: Int) -> UInt8 {
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

public final class Int8Stream: ByteStream {
    public let source: UnsafePointer<Int8>
    public let size: Int
    public let nullTerminated: Bool
    var index: Int = 0
    var current: UnsafePointer<Int8>
    var terminated: Bool = false

#if DEBUG
    public override var consumedText: String {
        let count = source.distance(to: current)
        let data = Data(bytes: UnsafeRawPointer(source), count: count)
        return String(data: data, encoding: .utf8) ?? ""
    }
#endif

    public init(source: UnsafePointer<Int8>, size: Int = 0) {
        self.source = source
        self.size = size
        current = source
        nullTerminated = size < 1
    }

    public override var effective: Bool {
        return nullTerminated ? !terminated : index < size
    }

    public override func peek() -> UInt8 {
        return effective ? UInt8(bitPattern: current.pointee) : 0
    }

    public override func peek(offset: Int) -> UInt8 {
        if nullTerminated {
            var t = current
            for _ in 0 ..< offset {
                t = t.successor()
                if t.pointee == 0 {
                    break
                }
            }
            return UInt8(bitPattern: t.pointee)
        } else {
            if index + offset < size {
                return UInt8(bitPattern: current.advanced(by: offset).pointee)
            } else {
                return 0
            }
        }
    }

    @discardableResult
    public override func move() -> Bool {
        if nullTerminated {
            if terminated {
                return false
            }
            current = current.advanced(by: 1)
            terminated = current.pointee == 0
            return true
        } else {
            current = current.advanced(by: 1)
            index += 1
            return effective
        }
    }

    @discardableResult
    public override func move(offset: Int) -> Bool {
        if nullTerminated {
            if terminated {
                return false
            }
            var t = current
            for _ in 0 ..< offset {
                t = t.successor()
                if t.pointee == 0 {
                    return false
                }
            }
            current = t
            terminated = current.pointee == 0
            return true
        } else {
            if index + offset < size {
                current = current.advanced(by: offset)
                index += offset
            }
            return effective
        }
    }
}

public final class UInt8Stream: ByteStream {
    public let source: UnsafePointer<UInt8>
    public let size: Int
    public let nullTerminated: Bool
    var index: Int = 0
    var current: UnsafePointer<UInt8>
    var terminated: Bool = false

#if DEBUG
    public override var consumedText: String {
        let count = source.distance(to: current)
        let data = Data(bytes: UnsafeRawPointer(source), count: count)
        return String(data: data, encoding: .utf8) ?? ""
    }
#endif

    public init(source: UnsafePointer<UInt8>, size: Int = 0) {
        self.source = source
        self.size = size
        current = source
        nullTerminated = size < 1
    }

    public override var effective: Bool {
        return nullTerminated ? !terminated : index < size
    }

    public override func peek() -> UInt8 {
        return effective ? current.pointee : 0
    }

    public override func peek(offset: Int) -> UInt8 {
        if nullTerminated {
            var t = current
            for _ in 0 ..< offset {
                t = t.successor()
                if t.pointee == 0 {
                    break
                }
            }
            return t.pointee
        } else {
            if index + offset < size {
                return current.advanced(by: offset).pointee
            } else {
                return 0
            }
        }
    }

    @discardableResult
    public override func move() -> Bool {
        if nullTerminated {
            if terminated {
                return false
            }
            current = current.advanced(by: 1)
            terminated = current.pointee == 0
            return true
        } else {
            current = current.advanced(by: 1)
            index += 1
            return effective
        }
    }

    @discardableResult
    public override func move(offset: Int) -> Bool {
        if nullTerminated {
            if terminated {
                return false
            }
            var t = current
            for _ in 0 ..< offset {
                t = t.successor()
                if t.pointee == 0 {
                    return false
                }
            }
            current = t
            terminated = current.pointee == 0
            return true
        } else {
            if index + offset < size {
                current = current.advanced(by: offset)
                index += offset
            }
            return effective
        }
    }
}
