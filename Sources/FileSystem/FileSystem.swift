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
//    func move(from: Path, to: Path) throws
//    func remove(_ path: Path) throws
}

public struct DarwinFileSystem: FileSystem {
    public var current: Path {
        get {
            let size = Int(PATH_MAX)
            let data = UnsafeMutablePointer<Int8>.allocate(capacity: size)
            getcwd(data, size)
            let text = String(utf8String: data)
            data.deallocate()
            return Path(text ?? "/")
        }
        set {
            _ = newValue.string.withCString(chdir)
        }
    }

    public func copy(from: Path, to: Path) throws {
        let state = copyfile_state_alloc()
        let flag = copyfile_flags_t(COPYFILE_ALL | COPYFILE_RECURSIVE | COPYFILE_NOFOLLOW_SRC)
        let status = copyfile(from.string, to.string, state, flag)
        copyfile_state_free(state)
        if status < 0 {
            throw Errors.posix()
        }
    }

//    public func move(from: Path, to: Path) throws {
//
//    }
//
//    public func remove(_ path: Path) throws {
//
//    }
}

public struct DirectoryEntry {
    let path: Path
    let fileSystem: FileSystem

    public init(path: Path, fileSystem: FileSystem) {
        self.path = path
        self.fileSystem = fileSystem
    }

    public init?(url: URL, fileSystem: FileSystem) {
        guard let path = Path(fileURL: url) else {
            return nil
        }
        self.path = path
        self.fileSystem = fileSystem
    }
}

public struct DirectoryIterator: IteratorProtocol {
    public typealias Element = DirectoryEntry

    let fileSystem: FileSystem
    let delegate: () -> DirectoryEntry?

    init(fileSystem: FileSystem) {
        self.fileSystem = fileSystem
        delegate = Function.alwaysNil
    }

    init(_ foundation: FoundationDirectoryIterator) {
        fileSystem = foundation.fileSystem
        delegate = foundation.next
    }

    public mutating func next() -> DirectoryEntry? {
        delegate()
    }
}

class FoundationDirectoryIterator: IteratorProtocol {
    public typealias Element = DirectoryEntry

    let fileSystem: FileSystem
    let enumerator: FileManager.DirectoryEnumerator

    init(_ enumerator: FileManager.DirectoryEnumerator, fileSystem: FileSystem) {
        self.enumerator = enumerator
        self.fileSystem = fileSystem
    }

    public func next() -> DirectoryEntry? {
        var url: URL? = enumerator.nextObject() as? URL
        while url == nil {
            if let raw = enumerator.nextObject() {
                url = raw as? URL
            } else {
                break
            }
        }
        return url.flatMap {
            DirectoryEntry(url: $0, fileSystem: self.fileSystem)
        }
    }
}
