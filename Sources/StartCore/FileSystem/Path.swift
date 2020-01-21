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

#if canImport(Foundation)

import Foundation // For URL

#endif

// C++ 17 Path
// https://en.cppreference.com/w/cpp/filesystem/path
public final class Path: Codable, ExpressibleByStringLiteral, CustomStringConvertible {
    public typealias StringLiteralType = String
    public static let separator = "/"

    public let isAbsolute: Bool
    public let components: [String]
    public let string: String

    public var isRelative: Bool {
        !isAbsolute
    }

    lazy var _filename: String? = {
        if let last = components.last, last != "." && last != ".." {
            return last
        }
        return nil
    }()

    public var filename: String {
        _filename ?? ""
    }

    public lazy var name: String = {
        guard let name = _filename else {
            return ""
        }
        if let end = name.lastIndex(of: "."), end != name.startIndex {
            return String(name[..<end])
        } else {
            return name
        }
    }()

    public lazy var `extension`: String = {
        guard let name = _filename, let end = name.lastIndex(of: "."), end != name.startIndex else {
            return ""
        }
        return String(name[end...])
    }()

    public var parent: Path {
        let array: [String]
        if components.count > 1 {
            array = Array(components.dropLast())
        } else {
            array = isAbsolute ? [] : ["."]
        }
        return Path(absolute: isAbsolute, components: array)
    }

    public var lastComponent: String?  {
        components.last
    }

    public var isEmpty: Bool {
        !isAbsolute && components.isEmpty
    }

    public var isEmptyOrRoot: Bool {
        components.isEmpty
    }

    // CustomStringConvertible
    public var description: String {
        "<Path: \(string)>"
    }

    init(absolute: Bool, components: [String]) {
        self.isAbsolute = absolute
        self.components = components
        string = Path.assemble(absolute: absolute, components: components)
    }

    public init(_ value: String) {
        (isAbsolute, components) = Path.pathComponents(path: value)
        string = Path.assemble(absolute: isAbsolute, components: components)
    }

    // Codable
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        (isAbsolute, components) = Path.pathComponents(path: value)
        string = Path.assemble(absolute: isAbsolute, components: components)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }

    // ExpressibleByStringLiteral
    public convenience init(stringLiteral value: String) {
        self.init(value)
    }

    public func replace(filename: String) -> Path {
        precondition(!filename.isEmpty)
        if self.components.isEmpty {
            return self
        }
        var components = self.components
        components[components.endIndex - 1] = filename
        return Path(absolute: isAbsolute, components: components)
    }

    public func replace(name: String) -> Path {
        precondition(!name.isEmpty)
        if self.components.isEmpty {
            return self
        }
        var components = self.components
        components[components.endIndex - 1] = name + `extension`
        return Path(absolute: isAbsolute, components: components)
    }

    public func replace(`extension`: String?) -> Path {
        precondition(`extension` == nil || `extension`!.firstIndex(of: ".") == `extension`!.startIndex)
        if self.components.isEmpty || (name.isEmpty && `extension` == nil) {
            return self
        }
        var components = self.components
        components[components.endIndex - 1] = name + (`extension` ?? "")
        return Path(absolute: isAbsolute, components: components)
    }

    public func basename(`extension`: String? = nil) -> String {
        if components.isEmpty {
            return ""
        }
        var last = lastComponent ?? "."
        if let ext = `extension`, last != ext,
            let range = last.range(of: ext, options: [String.CompareOptions.backwards, .anchored]) {
            last.removeSubrange(range)
        }
        return last
    }

    public func normalize() -> Path {
        var result: [String] = []
        for component in components {
            switch component {
            case ".":
                continue
            case "..":
                if isAbsolute {
                    if result.count > 0 {
                        _ = result.popLast()
                    }
                } else {
                    if let first = result.first, first != ".." {
                        _ = result.popLast()
                    } else {
                        result.append(component)
                    }
                }
            default:
                result.append(component)
            }
        }
        if result.isEmpty {
            result = isAbsolute ? [] : ["."]
        }
        return Path(absolute: isAbsolute, components: result)
    }

    public func resolve(base: Path = FileSystems.darwin.current) -> Path {
        if isAbsolute {
            return normalize()
        } else {
            var components = base.components
            components.append(contentsOf: self.components)
            return Path(absolute: base.isAbsolute, components: components).normalize()
        }
    }

    public func join(_ path: String...) -> Path {
        if path.isEmpty {
            return self
        }
        var absolute = self.isAbsolute
        var components = self.components
        for p in path {
            let (a, c) = Path.pathComponents(path: p)
            if a {
                components = c
                absolute = a
            } else {
                components.append(contentsOf: c)
            }
        }
        return Path(absolute: absolute, components: components)
    }

    public func join(_ path: Path...) -> Path {
        join(paths: path)
    }

    public func join(paths: [Path]) -> Path {
        if paths.isEmpty {
            return self
        }
        var absolute = self.isAbsolute
        var components = self.components
        for path in paths {
            if path.isAbsolute {
                components = path.components
                absolute = path.isAbsolute
            } else {
                components.append(contentsOf: path.components)
            }
        }
        return Path(absolute: absolute, components: components)
    }

    public func relative(to other: Path) -> Path {
        Path.relative(from: self, to: other)
    }

    public static func join(_ path: Path...) -> Path {
        join(paths: path)
    }

    public static func join(paths: [Path]) -> Path {
        if paths.isEmpty {
            return Path(".")
        }
        var absolute = false
        var components: [String] = []
        for path in paths {
            if path.isAbsolute {
                components = path.components
                absolute = path.isAbsolute
            } else {
                components.append(contentsOf: path.components)
            }
        }
        return Path(absolute: absolute, components: components)
    }

    public static func relative(from: Path, to: Path) -> Path {
        var from = ArraySlice<String>(from.resolve().components)
        var to = ArraySlice<String>(to.resolve().components)
        let count = from.count < to.count ? from.count : to.count

        var i = 0
        while i < count {
            if let a = from.first, let b = to.first, a == b {
                from = from.dropFirst()
                to = to.dropFirst()
            } else {
                break
            }
            i += 1
        }

        var array = from.map { _ in
            ".."
        }
        array.append(contentsOf: to)
        return Path(absolute: false, components: array)
    }

    public static func pathComponents(path: String) -> (Bool, [String]) {
        func next(_ char: Character, in string: String, start: String.Index) -> String.Index {
            var current = start
            while current < string.endIndex, string[current] != char {
                current = string.index(after: current)
            }
            return current
        }

        func skipAll(_ char: Character, in string: String, start: String.Index) -> String.Index {
            var current = start
            while current < string.endIndex, string[current] == char {
                current = string.index(after: current)
            }
            return current
        }

        let separator: Character = Character(Path.separator)
        var start = skipAll(separator, in: path, start: path.startIndex)
        let end = path.endIndex
        let absolute = start != path.startIndex
        var current = start
        var components: [String] = []
        while current < end {
            current = next(separator, in: path, start: current)
            if start < current {
                components.append(String(path[start..<current]))
                start = skipAll(separator, in: path, start: current)
                current = start
            } else {
                break
            }
        }
        if current < end {
            components.append(String(path[current...]))
        }
        return (absolute, components)
    }

    @inline(__always)
    private static func assemble(absolute: Bool, components: [String]) -> String {
        if components.isEmpty {
            return absolute ? separator : ""
        }
        var array = components
        if absolute {
            array.insert("", at: 0)
        }
        return array.joined(separator: separator)
    }
}

extension Path: Hashable, Comparable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(string)
    }

    public static func ==(lhs: Path, rhs: Path) -> Bool {
        lhs.string == rhs.string
    }

    public static func < (lhs: Path, rhs: Path) -> Bool {
        if lhs.isAbsolute != rhs.isAbsolute {
            return lhs.string < rhs.string
        } else {
            return lhs.isAbsolute
        }
    }

    public static func > (lhs: Path, rhs: Path) -> Bool {
        if lhs.isAbsolute != rhs.isAbsolute {
            return lhs.string > rhs.string
        } else {
            return rhs.isAbsolute
        }
    }
}

public extension Path {

#if canImport(Foundation)

    convenience init?(fileURL url: URL) {
        guard url.isFileURL else {
            return nil
        }
        self.init(url.absoluteString)
    }

    func fileURL() -> URL {
        URL(fileURLWithPath: string)
    }

#endif // canImport(Foundation)

    static func +(lhs: Path, rhs: String) -> Path {
        lhs.join(Path(rhs))
    }

    static func +(lhs: Path, rhs: Path) -> Path {
        lhs.join(rhs)
    }

    static func +=(lhs: inout Path, rhs: String) {
        lhs = lhs.join(Path(rhs))
    }

    static func +=(lhs: inout Path, rhs: Path) {
        lhs = lhs.join(rhs)
    }
}

extension Path {
    var filenameIsDot: Bool {
        lastComponent == "."
    }

    var filenameIsDotDot: Bool {
        lastComponent == ".."
    }
}

public extension Path {
    func resolve(with fileSystem: FileSystem) throws -> Path {
        try fileSystem.readSymbolicLink(at: resolve(base: fileSystem.current))
    }
}
