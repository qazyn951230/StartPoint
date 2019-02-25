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
import Foundation

public class DataStream: WritableStream {
    public typealias Value = Data

    init() {
        // Do nothing.
    }

    public func write(_ value: Data) throws {
        // Do nothing.
    }

    public func flush() throws {
        // Do nothing.
    }

    public func write(string value: String, encoding: String.Encoding = String.Encoding.utf8) throws {
        guard let data = value.data(using: .utf8) else {
            throw BasicError.invalidArgument
        }
        try write(data)
    }

    public func write(byte value: UInt8) throws {
        try write(bytes: [value])
    }

    public func write(bytes value: [UInt8]) throws {
        let data = Data(value)
        try write(data)
    }

    public static func standardOutput() -> DataStream {
        return FileStream(file: FileHandle.standardOutput)
    }

    public static func standardError() -> DataStream {
        return FileStream(file: FileHandle.standardError)
    }
}

public final class FileStream: DataStream {
    public typealias Value = Data

    let file: FileHandle

    public convenience init(path: String) throws {
        let manager = FileManager.default
        if !manager.fileExists(atPath: path) {
            if !manager.createFile(atPath: path, contents: nil) {
                throw BasicError.ioError
            }
        }
        guard let file = FileHandle(forWritingAtPath: path) else {
            throw BasicError.noSuchFile
        }
        self.init(file: file)
    }

    public init(file: FileHandle) {
        self.file = file
        super.init()
    }

    public override func write(_ value: Data) throws {
        file.write(value)
    }
}

public final class CFileStream: DataStream {
    static let capacity = 65536
    let file: UnsafeMutablePointer<FILE>
    let buffer: UnsafeMutablePointer<UInt8>
    var current: UnsafeMutablePointer<UInt8>
    var count = 0

    public init(path: String) throws {
        guard let _file = fopen(path, "w") else {
            throw BasicError.posixError()
        }
        file = _file
        buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: CFileStream.capacity)
        current = buffer
        super.init()
    }

    deinit {
        fclose(file)
        buffer.deallocate()
    }

    public override func flush() throws {
        if count < 1 {
            return
        }
        let raw = UnsafeRawPointer(buffer)
        _ = fwrite(raw, 1, count, file)
        current = buffer
        count = 0
    }

    public override func write(_ value: Data) throws {
        var iterator = value.makeIterator()
        while let next = iterator.next() {
            try write(byte: next)
        }
    }

    public override func write(byte value: UInt8) throws {
        let remain: Int = CFileStream.capacity - count
        if remain < 1 {
            try flush()
        }
        count += 1
        current.initialize(to: value)
        current = current.successor()
    }

    public override func write(bytes value: [UInt8]) throws {
        let remain: Int = CFileStream.capacity - count
        if remain < value.count {
            try flush()
        }
        count += value.count
        for item in value {
            current.initialize(to: item)
            current = current.successor()
        }
    }
}

public final class StringStream: DataStream {
    var _content: Data = Data()

    public override init() {
        super.init()
    }

    public var content: String {
        return String(data: _content, encoding: .utf8) ?? ""
    }

    public override func write(byte value: UInt8) throws {
        _content.append(value)
    }

    public override func write(bytes value: [UInt8]) throws {
        _content.append(contentsOf: value)
    }

    public override func write(_ value: Data) throws {
        _content.append(value)
    }
}
