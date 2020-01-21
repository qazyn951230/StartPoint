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

public final class FoundationFileSystem: FileSystem {
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

    public func status(for path: Path, follow: Bool = false) throws -> FileStatus {
        var p = path.string
        if follow {
            p = try manager.destinationOfSymbolicLink(atPath: p)
        }
        let map = try manager.attributesOfItem(atPath: p)
        var type = FileType.unknown
        var permission = FilePermission.unknown
        if let _type = map[FileAttributeKey.type] as? String {
            let _type2 = FileAttributeType(rawValue: _type)
            type = FileType(_type2)
        }
        if let _permission = map[FileAttributeKey.posixPermissions] as? NSNumber {
            permission = FilePermission(_permission.uint16Value)
        }
        return FileStatus(type: type, permission: permission)
    }

    public func copy(from: Path, to: Path) throws {
        try manager.copyItem(atPath: from.string, toPath: to.string)
    }

    public func exists(_ path: Path) -> Bool {
        manager.fileExists(atPath: path.string)
    }

    public func exists(directory path: Path) -> Bool {
        var bool = ObjCBool(false)
        let exists = manager.fileExists(atPath: path.string, isDirectory: &bool)
        return exists && bool.boolValue
    }

    public func makeDirectory(_ path: Path) throws {
        if exists(directory: path) {
            return
        }
        try manager.createDirectory(atPath: path.string, withIntermediateDirectories: false)
    }

    public func makeDirectories(_ path: Path) throws {
        if exists(directory: path) {
            return
        }
        try manager.createDirectory(atPath: path.string, withIntermediateDirectories: true)
    }

    public func makeIterator(_ path: Path) throws -> DirectoryIterator {
        guard let enumerator = manager.enumerator(at: path.fileURL(), includingPropertiesForKeys: nil,
            options: .skipsSubdirectoryDescendants) else {
            throw StartError.message("Cannot enumerator: \(path.string)")
        }
        let temp = FoundationDirectoryIterator(enumerator, fileSystem: self)
        return DirectoryIterator(temp)
    }

    public func move(from: Path, to: Path) throws {
        try manager.moveItem(atPath: from.string, toPath: to.string)
    }

    public func readDirectory(_ path: Path) throws -> [Path] {
        let temp = try manager.contentsOfDirectory(atPath: path.string)
        return temp.map { p in
            path.join(p)
        }
    }

    public func readFile(at path: Path) throws -> Data {
        // manager.contents(atPath:) ignore errors.
        try Data(contentsOf: path.fileURL())
    }

    public func readSymbolicLink(at path: Path) throws -> Path {
        let p = try manager.destinationOfSymbolicLink(atPath: path.string)
        return Path(p)
    }

    public func remove(_ path: Path) throws {
        try manager.removeItem(atPath: path.string)
    }

    @available(OSX 10.8, iOS 11.0, *)
    @discardableResult
    public func trash(at path: Path) throws -> Path? {
        var result: NSURL?
        try manager.trashItem(at: path.fileURL(), resultingItemURL: &result)
        return (result as URL?).flatMap(Path.init(fileURL:))
    }

    public func writeFile(at path: Path, data: Data) throws {
        let success = manager.createFile(atPath: path.string, contents: data)
        if !success {
            throw FileSystemError.writeFailed
        }
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
        return url.flatMap { DirectoryEntry(url: $0, fileSystem: self.fileSystem) }
    }
}
