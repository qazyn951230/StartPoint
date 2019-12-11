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

//    public func move(from: Path, to: Path) throws {
//
//    }
//
//    public func remove(_ path: Path) throws {
//
//    }
}

public enum FileType {
    case regular
    case directory
    case symbolicLink
    case block
    case character
    case socket
    case unknown

    public init(_ value: FileAttributeType) {
        switch value {
        case .typeBlockSpecial:
            self = .block
        case .typeCharacterSpecial:
            self = .character
        case .typeDirectory:
            self = .directory
        case .typeRegular:
            self = .regular
        case .typeSocket:
            self = .socket
        case .typeSymbolicLink:
            self = .symbolicLink
        case .typeUnknown:
            fallthrough
        default:
            self = .unknown
        }
    }
}

public struct FilePermission: OptionSet {
    public typealias RawValue = UInt16

    public let rawValue: UInt16

    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }

    public init(_ value: UInt16) {
        rawValue = value
    }

    public static let none = FilePermission(0o0000)
    public static let ownerRead = FilePermission(0o0400)
    public static let ownerWrite = FilePermission(0o0200)
    public static let ownerExecute = FilePermission(0o0100)
    public static let ownerAll = FilePermission(0o0700)
    public static let groupRead = FilePermission(0o0040)
    public static let groupWrite = FilePermission(0o0020)
    public static let groupExecute = FilePermission(0o0010)
    public static let groupAll = FilePermission(0o0070)
    public static let othersRead = FilePermission(0o0004)
    public static let othersWrite = FilePermission(0o0002)
    public static let othersExecute = FilePermission(0o0001)
    public static let othersAll = FilePermission(0o0007)
    public static let read = FilePermission(0o0444)
    public static let write = FilePermission(0o0222)
    public static let execute = FilePermission(0o0111)
    public static let setUserId = FilePermission(0o4000)
    public static let setGroupId = FilePermission(0o2000)
    public static let stickyBit = FilePermission(0o1000)
    public static let all = FilePermission(0o0777)
    public static let mask = FilePermission(0o7777)
    public static let unknown = FilePermission(0xffff)
}

// http://en.cppreference.com/w/cpp/filesystem/file_status
public struct FileStatus {
    let type: FileType
    let permission: FilePermission
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

    // https://en.cppreference.com/w/cpp/filesystem/status
    public func status(for path: Path, resolveSymbolicLink: Bool = false) throws -> FileStatus {
        var p = path.string
        if resolveSymbolicLink {
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

    public func enumerator(at path: Path) -> DirectoryIterator {
        if let raw = manager.enumerator(atPath: path.string) {
            return DirectoryIterator(FoundationDirectoryIterator(raw, fileSystem: self))
        } else {
            return DirectoryIterator(fileSystem: self)
        }
    }

    public func copy(from: Path, to: Path) throws {
        try manager.copyItem(atPath: from.string, toPath: to.string)
    }

    public func exists(_ path: Path) -> Bool {
        return manager.fileExists(atPath: path.string)
    }

    public func exists(directory path: Path) -> Bool {
        var bool = ObjCBool(false)
        let exists = manager.fileExists(atPath: path.string, isDirectory: &bool)
        return exists && bool.boolValue
    }

    public func readDirectory(_ path: Path) throws -> [Path] {
        let temp = try manager.contentsOfDirectory(atPath: path.string)
        return temp.map { p in
            path.join(Path(p))
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

    public func move(from: Path, to: Path) throws {
        try manager.moveItem(atPath: from.string, toPath: to.string)
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

    public func remove(at path: Path) throws {
        try manager.removeItem(atPath: path.string)
    }

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
