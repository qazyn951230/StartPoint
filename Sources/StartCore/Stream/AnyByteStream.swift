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

public class AnyByteStream: ByteStream, UnsafeRandomAccessStream {
    public typealias Index = Int
    public typealias Value = UInt8

    public var readable: Bool {
        false
    }

    public var writable: Bool {
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
    
    public func seek(offset: Int, direction: SeekDirection) {
        fatalError("seek(offset:direction:) has not been implemented")
    }
    
    public func peek(count: Int) -> UnsafePointer<UInt8>? {
        fatalError("peek(count:) has not been implemented")
    }
    
    public func peek(into pointer: UnsafeMutablePointer<UInt8>, count: Int) -> Bool {
        fatalError("peek(into:count:) has not been implemented")
    }
    
    public func peek(into pointer: UnsafeMutableBufferPointer<UInt8>, count: Int? = nil) -> Bool {
        fatalError("peek(into:count:) has not been implemented")
    }
    
    public func peek() -> UInt8 {
        fatalError("peek() has not been implemented")
    }

    public func peek(offset: Int) -> UInt8 {
        fatalError("peek(offset:) has not been implemented")
    }

    @discardableResult
    public func move() -> Bool {
        fatalError("move() has not been implemented")
    }
    
    @discardableResult
    public func move(offset: Int) -> Bool {
        fatalError("move(offset:) has not been implemented")
    }

    public func write(_ value: UInt8) {
        fatalError("write(_:) has not been implemented")
    }

    public func write<C>(_ value: C) where C : Collection, C.Element == UInt8 {
        fatalError("write(_:) has not been implemented")
    }

    public func flush() {
        fatalError("flush() has not been implemented")
    }

    public static func file(_ fileStream: FileStream) -> AnyByteStream {
        _AnyFileStream(file: fileStream)
    }

    public static func file(read file: UnsafeMutablePointer<FILE>, behavior: FileStream.Behavior = .close)
            -> AnyByteStream {
        _AnyFileStream(file: FileStream(read: file, behavior: behavior))
    }

    public static func file(write file: UnsafeMutablePointer<FILE>, behavior: FileStream.Behavior = .close)
            -> AnyByteStream {
        _AnyFileStream(file: FileStream(write: file, behavior: behavior))
    }

    public static func file(read path: Path) throws -> AnyByteStream {
        _AnyFileStream(file: try FileStream(read: path))
    }

    public static func file(write path: Path) throws -> AnyByteStream {
        _AnyFileStream(file: try FileStream(write: path))
    }
}

class _AnyFileStream: AnyByteStream {
    var file: FileStream

    override var readable: Bool {
        file.readable
    }

    override var writable: Bool {
        file.writable
    }

    init(file: FileStream) {
        self.file = file
    }

    override func read() -> UInt8? {
        file.read()
    }

    override func read(count: Int) -> Data {
        file.read(count: count)
    }

    override func readAll() -> Data {
        file.readAll()
    }

    override func write(_ value: UInt8) {
        file.write(value)
    }

    override func write<C>(_ value: C) where C : Collection, C.Element == UInt8 {
        file.write(value)
    }

    override func flush() {
        file.flush()
    }
}
