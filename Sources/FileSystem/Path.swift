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

// C++ 17 Path
// https://en.cppreference.com/w/cpp/filesystem/path
public final class Path: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public static let separator = "/"

    public let absolute: Bool
    public let components: [String]

    init(absolute: Bool, components: [String]) {
        self.absolute = absolute
        self.components = components
    }

    public init(_ value: String) {
        (absolute, components) = Path.pathComponents(path: value)
    }

    public convenience init(stringLiteral value: String) {
        self.init(value)
    }

    public lazy var string: String = {
        var components = self.components
        if absolute {
            components.insert("", at: 0)
        }
        return components.joined(separator: Path.separator)
    }()

    lazy var _filename: String? = {
        if let last = components.last {
            return (last != "." && last != "..") ? last : nil
        }
        return nil
    }()

    public var filename: String {
        _filename ?? ""
    }

    public lazy var name: String = {
        guard let name = _filename, let end = name.firstIndex(of: ".") else {
            return ""
        }
        return String(name[..<end])
    }()

    public lazy var `extension`: String = {
        guard let name = _filename, let end = name.lastIndex(of: ".") else {
            return ""
        }
        return String(name[end...])
    }()

    public var parent: Path {
        let array: [String]
        if components.count > 1 {
            array = Array(components.dropLast())
        } else {
            array = absolute ? [] : ["."]
        }
        return Path(absolute: absolute, components: array)
    }

    public func normalize() -> Path {
        var result: [String] = []
        for component in components {
            switch component {
            case ".":
                continue
            case "..":
                if absolute {
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
            result = absolute ? [] : ["."]
        }
        return Path(absolute: absolute, components: result)
    }

    public func resolve(base: Path) -> Path {
        if absolute {
            return normalize()
        } else {
            var components = base.components
            components.append(contentsOf: self.components)
            return Path(absolute: base.absolute, components: components).normalize()
        }
    }

    public func join(_ path: String...) -> Path {
        join(paths: path)
    }

    public func join(paths: [String]) -> Path {
        if paths.isEmpty {
            return self
        }
        var absolute = self.absolute
        var components = self.components
        for path in paths {
            if path.isEmpty {
                continue
            }
            let (a, c) = Path.pathComponents(path: path)
            if a {
                components = c
                absolute = a
            } else {
                components.append(contentsOf: c)
            }
        }
        return Path(absolute: absolute, components: components)
    }

    public func join(paths: [Path]) -> Path {
        if paths.isEmpty {
            return self
        }
        var absolute = self.absolute
        var components = self.components
        for path in paths {
            if path.absolute {
                components = path.components
                absolute = path.absolute
            } else {
                components.append(contentsOf: path.components)
            }
        }
        return Path(absolute: absolute, components: components)
    }

    public static func join(_ path: String...) -> Path {
        join(paths: path)
    }

    public static func join(paths: [String]) -> Path {
        if paths.isEmpty {
            return Path("")
        }
        var absolute = false
        var components: [String] = []
        for path in paths {
            if path.isEmpty {
                continue
            }
            let (a, c) = Path.pathComponents(path: path)
            if a {
                components = c
                absolute = a
            } else {
                components.append(contentsOf: c)
            }
        }
        return Path(absolute: absolute, components: components)
    }

    public static func join(paths: [Path]) -> Path {
        if paths.isEmpty {
            return Path("")
        }
        var absolute = false
        var components: [String] = []
        for path in paths {
            if path.absolute {
                components = path.components
                absolute = path.absolute
            } else {
                components.append(contentsOf: path.components)
            }
        }
        return Path(absolute: absolute, components: components)
    }

    public func relative(to other: Path) -> Path {
        Path.relative(from: self, to: other)
    }

    public static func relative(from: Path, to: Path) -> Path {
        var from = ArraySlice<String>(from.resolve(base: Path.currentWorkingPath).components)
        var to = ArraySlice<String>(to.resolve(base: Path.currentWorkingPath).components)
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

    @inline(__always)
    private static func next(_ char: Character, in string: String, start: String.Index) -> String.Index {
        var current = start
        while current < string.endIndex, string[current] != char {
            current = string.index(after: current)
        }
        return current
    }

    @inline(__always)
    private static func skipAll(_ char: Character, in string: String, start: String.Index) -> String.Index {
        var current = start
        while current < string.endIndex, string[current] == char {
            current = string.index(after: current)
        }
        return current
    }

    public static func pathComponents(path: String) -> (Bool, [String]) {
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

    public static var currentWorkingPath: Path {
        let size = Int(PATH_MAX)
        let data = UnsafeMutablePointer<Int8>.allocate(capacity: size)
        getcwd(data, size)
        let text = String(utf8String: data)
        data.deallocate()
        return Path(text ?? "/")
    }
}

extension Path: CustomStringConvertible {
    public var description: String {
        string
    }
}

extension Path {
    public convenience init?(fileURL url: URL) {
        guard url.isFileURL else {
            return nil
        }
        self.init(url.absoluteString)
    }

    public func fileURL() -> URL {
        URL(fileURLWithPath: string)
    }
}

extension Path: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(absolute)
        hasher.combine(components)
    }

    public static func +(lhs: Path, rhs: String) -> Path {
        lhs.join(rhs)
    }

    public static func +(lhs: Path, rhs: Path) -> Path {
        lhs.join(paths: [rhs])
    }

    public static func +=(lhs: inout Path, rhs: String) {
        lhs = lhs.join(rhs)
    }

    public static func +=(lhs: inout Path, rhs: Path) {
        lhs = lhs.join(paths: [rhs])
    }

    public static func ==(lhs: Path, rhs: Path) -> Bool {
        lhs.absolute == rhs.absolute && lhs.components == rhs.components
    }
}
