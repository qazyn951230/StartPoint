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
}

public struct FileSystems {
    public static var `default`: FileSystem {
        darwin
    }

    public static let darwin: DarwinFileSystem = DarwinFileSystem()

    public static let foundation: FoundationFileSystem = FoundationFileSystem()
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
            throw Errors.darwin()
        }
    }
}

public struct FoundationFileSystem: FileSystem {
    let manager: FileManager

    public init(fileManager: FileManager = FileManager.default) {
        manager = fileManager
    }

    public var current: Path {
        get {
            Path(manager.currentDirectoryPath)
        }
        set {
            _ = manager.changeCurrentDirectoryPath(newValue.string)
        }
    }

    public func copy(from: Path, to: Path) throws {
        try manager.copyItem(atPath: from.string, toPath: to.string)
    }

    public func move(from: Path, to: Path) throws {
        try manager.moveItem(atPath: from.string, toPath: to.string)
    }

    public func remove(_ path: Path) throws {
        try manager.removeItem(atPath: path.string)
    }

    @discardableResult
    public func trash(_ path: Path) throws -> Path? {
        var result: NSURL?
        try manager.trashItem(at: path.fileURL(), resultingItemURL: &result)
        return (result as URL?).flatMap(Path.init(fileURL:))
    }
}
