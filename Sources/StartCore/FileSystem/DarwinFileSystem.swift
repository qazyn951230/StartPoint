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

public final class DarwinFileSystem: FileSystem {
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

    public func status(for path: Path, follow: Bool = false) throws  -> FileStatus {
        let (stat, code) = _status(for: path, follow: follow)
        switch code {
        case 0:
            return FileStatus(stat)
        case ENOENT, ENOTDIR:
            return FileStatus.notFound
        default:
            throw Errors.posix()
        }
    }

    @inline(__always)
    func _status(for path: Path, follow: Bool)  -> (stat, Int32) {
        var temp: stat = stat()
        let code: Int32
        if follow {
            code = lstat(path.string, &temp)
        } else {
            code = stat(path.string, &temp)
        }
        return (temp, code)
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

    public func exists(_ path: Path) -> Bool {
        if let value = try? status(for: path) {
            return value.type != FileType.notFound
        }
        return false
    }

    public func exists(directory path: Path) -> Bool {
        if let value = try? status(for: path) {
            return value.type == FileType.directory
        }
        return false
    }

    public func makeDirectory(_ path: Path) throws {
        if mkdir(path.string, S_IRWXU | S_IRWXG | S_IRWXO) == 0 {
            return
        }
        let code = errno
        if exists(directory: path) {
            return
        }
        throw StartError.posix(code)
    }

    public func makeDirectories(_ path: Path) throws {
        if path.isEmpty {
            return
        }
        if path.filenameIsDot || path.filenameIsDotDot {
            return try makeDirectories(path.parent)
        }
        let value = try status(for: path)
        if value.type == FileType.directory {
            return
        }
        let parent = path.parent
        if !parent.isEmpty {
            let value2 = try status(for: parent)
            if value2.type == FileType.notFound {
                try makeDirectories(parent)
            }
        }
        return try makeDirectory(path)
    }

    public func makeIterator(_ path: Path) throws -> DirectoryIterator {
        let temp = try DarwinDirectoryIterator(path: path, fileSystem: self)
        return DirectoryIterator(temp)
    }

    public func move(from: Path, to: Path) throws {
        if rename(from.string, to.string) != 0 {
            throw Errors.posix()
        }
    }

    public func readDirectory(_ path: Path) throws -> [Path] {
        let value = path.resolve().string
        guard let dir = opendir(value) else {
            throw Errors.posix()
        }
        defer {
            closedir(dir)
        }
        var paths: [Path] = []
        while let dp = readdir(dir) {
            if let name = String.decodeFixedArray(dp.pointee, keyPath: \Darwin.dirent.d_name, count: 256),
               name != "." && name != ".." {
                paths.append(path.join(name))
            }
        }
        return paths
    }

    public func readFile(at path: Path) throws -> Data {
        // TODO: readFile(at:)
        try Data(contentsOf: path.fileURL())
    }
    
    public func readSymbolicLink(at path: Path) throws -> Path {
        let size = Int(PATH_MAX)
        let data = UnsafeMutablePointer<Int8>.allocate(capacity: size)
        defer {
            data.deallocate()
        }
        let used = readlink(path.string, data, size)
        if used == -1 {
            throw Errors.posix()
        }
        let text = String(bytesNoCopy: UnsafeMutableRawPointer(data),
                          length: used, encoding: .utf8, freeWhenDone: false)
        return Path(text ?? "")
    }

    public func remove(_ path: Path) throws {
        let value = try status(for: path)
        if value.type == FileType.notFound {
            return
        }
        if value.type == FileType.directory {
            if rmdir(path.string) != 0 {
                throw Errors.posix()
            }
        } else {
            if unlink(path.string) != 0 {
                throw Errors.posix()
            }
        }
    }
}

class DarwinDirectoryIterator: IteratorProtocol {
    public typealias Element = DirectoryEntry

    let root: Path
    let fileSystem: FileSystem
    var dir: UnsafeMutablePointer<DIR>?
    var buffer: dirent
    var current: Path?

    init(path: Path, fileSystem: FileSystem) throws {
        let next = path.normalize()
        if next.isEmpty {
            throw StartError.message("Empty path")
        }
        if let _dir = opendir(next.string) {
            dir = _dir
        } else {
            throw Errors.posix()
        }
        root = next
        buffer = dirent()
        current = root.join(".")
        self.fileSystem = fileSystem
        try increment()
    }

    deinit {
        try? close()
    }

    private func increment() throws {
        while true {
            let filename = try move()
            if dir == nil {
                return
            }
            if filename != "." && filename != ".." {
                current = current?.replace(filename: filename ?? "")
                break
            }
        }
    }

    private func move() throws -> String? {
        guard let dir = self.dir else {
            return nil
        }
        var result: UnsafeMutablePointer<dirent>?
        let code = readDir(dir, buffer: &buffer, to: &result)
        if code != 0 {
            throw StartError.posix(code)
        }
        if let next = result?.pointee {
            return String.decodeFixedArray(next, keyPath: \dirent.d_name, count: Int(next.d_reclen))
        } else {
            try close()
            return nil
        }
    }

    // `result` set to `nil` on end of directory
    @inline(__always)
    private func readDir(_ dir: UnsafeMutablePointer<DIR>, buffer: UnsafeMutablePointer<dirent>,
                         to result: inout UnsafeMutablePointer<dirent>?) -> Int32 {
        if sysconf(_SC_THREAD_SAFE_FUNCTIONS) >= 0 {
            var target: UnsafeMutablePointer<dirent>? = result
            let code = withUnsafeMutablePointer(to: &target) {
                (foo: UnsafeMutablePointer<UnsafeMutablePointer<dirent>?>) in
                    readdir_r(dir, buffer, foo)
                }
            result = target
            return code
        }
        errno = 0
        let next: UnsafeMutablePointer<dirent>? = readdir(dir)
        result = next
        if next == nil {
            return errno
        } else {
            return 0
        }
    }

    @inline(__always)
    private func close() throws {
        guard let dir = self.dir else {
            return
        }
        let code = closedir(dir)
        self.dir = nil
        if code != 0 {
            throw Errors.posix()
        }
    }

    public func next() -> DirectoryEntry? {
        if dir == nil {
            return nil
        }
        let entry = current.map { DirectoryEntry(path: $0, fileSystem: fileSystem) }
        try? increment()
        return entry
    }
}
