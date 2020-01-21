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

public protocol FileSystem {
    var current: Path { get set }

    func copy(from: Path, to: Path) throws
    func exists(_ path: Path) -> Bool
    func exists(directory path: Path) -> Bool
    func makeDirectory(_ path: Path) throws
    func makeDirectories(_ path: Path) throws
    func makeIterator(_ path: Path) throws -> DirectoryIterator
    func move(from: Path, to: Path) throws
    func readDirectory(_ path: Path) throws -> [Path]
    func readFile(at path: Path) throws -> Data
    func readSymbolicLink(at path: Path) throws -> Path
    func remove(_ path: Path) throws
    func status(for path: Path, follow: Bool) throws  -> FileStatus
}

public extension FileSystem {
    @inlinable
    func status(for path: Path) throws  -> FileStatus {
        try status(for: path, follow: false)
    }
}
