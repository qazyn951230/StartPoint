// MIT License
//
// Copyright (c) 2017 qazyn951230 qazyn951230@gmail.com
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

public protocol LogDestination {
    func write(message: String)
    func close()
}

public struct FileLogDestination: LogDestination {
    private let file: FileHandle

    public init(fileHandle: FileHandle) {
        self.file = fileHandle
    }

    public init(path: URL) throws {
        let file = try FileHandle(forWritingTo: path)
        self.init(fileHandle: file)
    }

    public func write(message: String) {
        if let data = message.data(using: .utf8) {
            file.write(data)
        }
    }

    public func close() {
        file.closeFile()
    }

    public static func standardOutput() -> FileLogDestination {
        return FileLogDestination(fileHandle: FileHandle.standardOutput)
    }

    public static func standardError() -> FileLogDestination {
        return FileLogDestination(fileHandle: FileHandle.standardError)
    }
}