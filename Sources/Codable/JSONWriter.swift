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

public enum SortMethod {
    case none
    case alphabet
    case indexed
    case combined
}

public protocol JSONWriterType: JSONVisitor {
    var stream: DataStream { get }
    var level: Int { get }
    var hasIntent: Bool { get }

    func writeIntent()
    func write(_ string: String)
    func write(_ byte: UInt8)
    func flush() throws
    func newline()
    func comma()
}

public extension JSONWriterType {
    public func writeIntent() {
        if hasIntent && level > 0 {
            let intent = Array<UInt8>(repeating: 0x20, count: level * 2)
            try? stream.write(bytes: intent)
        }
    }

    public func write(_ data: Data) {
        try? stream.write(data)
    }

    public func write(_ string: String) {
        try? stream.write(string: string)
    }

    public func write(_ byte: UInt8) {
        try? stream.write(byte: byte)
    }

    public func flush() throws {
        try stream.flush()
    }

    public func newline() {
        write(0x0a)
    }

    public func comma() {
        write(0x2c)
    }
}

public final class JSONWriter: JSONWriterType {
    public let stream: DataStream
    public let hasIntent: Bool
    public private(set) var level = 0
    let compact: Bool
    let ordered: Bool
    var state: [State] = []

    public init(stream: DataStream) {
        self.stream = stream
        hasIntent = true
        compact = true
        ordered = true
    }

    public init(stream: DataStream, options: Options) {
        self.stream = stream
        hasIntent = options.contains(.pretty)
        compact = options.contains(.compact)
        ordered = options.contains(.ordered)
    }

    public func visit(_ value: JSON) {
        // Do nothing.
    }

    public func visit(array value: JSONArray) {
        if value.value.isEmpty {
            write("[]")
            return
        }
        write("[\n")
        state.append(.array)
        level += 1
        var line = false
        for item in value.value {
            if line {
                comma()
                newline()
            } else {
                line.toggle()
            }
            writeIntent()
            item.accept(visitor: self)
        }
        level -= 1
        write("\n")
        writeIntent()
        write("]")
        _ = state.removeLast()
    }

    public func visit(dictionary value: JSONObject) {
        if value.value.isEmpty {
            write("{}")
            return
        }
        write("{\n")
        state.append(.object)
        level += 1
        var line = false
        for (key, item) in value.value {
            if line {
                comma()
                newline()
            } else {
                line.toggle()
            }
            writeIntent()
            write("\"")
            write(key)
            write("\": ")
            item.accept(visitor: self)
        }
        level -= 1
        write("\n")
        writeIntent()
        write("}")
        _ = state.removeLast()
    }

    public func visit(null value: JSONNull) {
        write("null")
    }

    public func visit(string value: JSONString) {
        write("\"")
        write(value.value)
        write("\"")
    }

    public func visit(bool value: JSONBool) {
        write(String(value.value))
    }

    public func visit(double value: JSONDouble) {
        write(String(value.value))
    }

    public func visit(int value: JSONInt) {
        write(String(value.value))
    }

    public func visit(int64 value: JSONInt64) {
        write(String(value.value))
    }

    public func visit(uint value: JSONUInt) {
        write(String(value.value))
    }

    public func visit(uint64 value: JSONUInt64) {
        write(String(value.value))
    }

    public struct Options: OptionSet {
        public let rawValue: Int32

        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let pretty = Options(rawValue: 1 << 0)
        public static let compact = Options(rawValue: 1 << 1)
        public static let ordered = Options(rawValue: 1 << 2)
    }

    enum State {
        case array
        case object
    }

    public static func write(_ json: JSON, stream: DataStream, options: Options? = nil) throws {
        let writer: JSONWriter
        if let _options = options {
            writer = JSONWriter(stream: stream, options: _options)
        } else {
            writer = JSONWriter(stream: stream)
        }
        json.accept(visitor: writer)
        writer.newline()
        try writer.flush()
    }
}

public final class JSONPlistWriter: JSONWriterType {
    public let stream: DataStream
    public let hasIntent: Bool = true
    public let sorted: Bool = true
    public private(set) var level = 0

    public init(stream: DataStream) {
        self.stream = stream
    }

    public func writeIntent() {
        if hasIntent && level > 0 {
            let intent = Array<UInt8>(repeating: 0x20, count: level * 4)
            try? stream.write(bytes: intent)
        }
    }

    public func header() {
        write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
        write("<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" ")
        write("\"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n")
        write("<plist version=\"1.0\">\n")
    }

    public func footer() {
        write("</plist>")
    }

    public func visit(_ value: JSON) {
        // Do nothing.
    }

    public func visit(array value: JSONArray) {
        let array = value.value
        if array.isEmpty {
            write("<array/>")
            return
        }
        write("<array>\n")
        level += 1
        for item in array.sorted() {
            if !item.exists {
                continue
            }
            writeIntent()
            item.accept(visitor: self)
            newline()
        }
        level -= 1
        writeIntent()
        write("</array>")
    }

    public func visit(dictionary value: JSONObject) {
        let map = value.value
        if map.isEmpty {
            write("<dict/>")
            return
        }
        write("<dict>\n")
        level += 1
        let keys = map.keys.sorted()
        for key in keys {
            if let item = map[key] {
                if !item.exists {
                    continue
                }
                writeIntent()
                write("<key>")
                write(key)
                write("</key>\n")
                writeIntent()
                item.accept(visitor: self)
                newline()
            }
        }
        level -= 1
        writeIntent()
        write("</dict>")
    }

    public func visit(null value: JSONNull) {
        // Do nothing.
    }

    public func visit(string value: JSONString) {
        write("<string>")
        write(JSONPlistWriter.encodingString(value.value))
        write("</string>")
    }

    public func visit(bool value: JSONBool) {
        if value.value {
            write("<true/>")
        } else {
            write("<false/>")
        }
    }

    public func visit(double value: JSONDouble) {
        write("<real>")
        write(String(value.value))
        write("</real>")
    }

    public func visit(int value: JSONInt) {
        write("<integer>")
        write(String(value.value))
        write("</integer>")
    }

    public func visit(int64 value: JSONInt64) {
        write("<integer>")
        write(String(value.value))
        write("</integer>")
    }

    public func visit(uint value: JSONUInt) {
        write("<integer>")
        write(String(value.value))
        write("</integer>")
    }

    public func visit(uint64 value: JSONUInt64) {
        write("<integer>")
        write(String(value.value))
        write("</integer>")
    }

    public static func write(_ json: JSON, stream: DataStream) throws {
        let writer = JSONPlistWriter(stream: stream)
        writer.header()
        json.accept(visitor: writer)
        writer.newline()
        writer.footer()
        try writer.flush()
    }

    public static func encodingString(_ value: String) -> Data {
        var result = Data()
        for char in value {
            switch char {
            case "<": // &lt;
                result.append(contentsOf: [0x26, 0x6c, 0x74, 0x3b])
            case ">": // &gt;
                result.append(contentsOf: [0x26, 0x67, 0x74, 0x3b])
            case "&": // &amp;
                result.append(contentsOf: [0x26, 0x61, 0x6d, 0x70, 0x3b])
            case "'": // &apos;
                result.append(contentsOf: [0x26, 0x61, 0x70, 0x6f, 0x73, 0x3b])
            case "\"": // &quot;
                result.append(contentsOf: [0x26, 0x71, 0x75, 0x6f, 0x74, 0x3b])
            default:
                // FIXME: String => Character => String
                if let temp = String(char).data(using: .utf8) {
                    result.append(temp)
                }
            }
        }
        return result
    }
}
