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

public protocol JSONWriter: class {
    associatedtype Output

    var output: Output { get }

    func writeNull()

    func startArray()
    func endArray()

    func startObject()
    func endObject()

    func writePrefix()
    func writeInfix()
    func writeSuffix()

    func write(any value: String?)
    func write(any value: Bool?)
    func write(any value: Float?)
    func write(any value: Double?)
    func write(any value: Int?)
    func write(any value: Int8?)
    func write(any value: Int16?)
    func write(any value: Int32?)
    func write(any value: Int64?)
    func write(any value: UInt?)
    func write(any value: UInt8?)
    func write(any value: UInt16?)
    func write(any value: UInt32?)
    func write(any value: UInt64?)

    func write(_ value: String)
    func write(_ value: Bool)
    func write(_ value: Float)
    func write(_ value: Double)
    func write(_ value: Int)
    func write(_ value: Int8)
    func write(_ value: Int16)
    func write(_ value: Int32)
    func write(_ value: Int64)
    func write(_ value: UInt)
    func write(_ value: UInt8)
    func write(_ value: UInt16)
    func write(_ value: UInt32)
    func write(_ value: UInt64)

    func write(any value: JSONWritable?)
    func write(_ value: JSONWritable)
}

public extension JSONWriter {
    func write(_ value: Int) {
#if arch(arm64) || arch(x86_64)
        self.write(Int64(value))
#else
        self.write(Int32(value))
#endif
    }

    func write(_ value: Int8) {
        self.write(Int32(value))
    }

    func write(_ value: Int16) {
        self.write(Int32(value))
    }

    func write(_ value: UInt) {
#if arch(arm64) || arch(x86_64)
        self.write(UInt64(value))
#else
        self.write(UInt32(value))
#endif
    }

    func write(_ value: UInt8) {
        self.write(UInt32(value))
    }

    func write(_ value: UInt16) {
        self.write(UInt32(value))
    }

    func write(_ value: JSONWritable) {
        value.write(to: self)
    }

    func write(any value: String?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Bool?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Float?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Double?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Int?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Int8?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Int16?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Int32?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Int64?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: UInt?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: UInt8?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: UInt16?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: UInt32?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: UInt64?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: JSONWritable?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }
}

public extension JSONWriter where Output == Never {
    var output: Output {
        fatalError()
    }
}

public extension JSONWriter where Self: JSONVisitor {
    func visit(array value: [JSON]) {
        self.startArray()
        for item in value {
            self.writePrefix()
            item.accept(visitor: self)
            self.writeSuffix()
        }
        self.endArray()
    }

    func visit(dictionary value: [String: JSON]) {
        self.startObject()
        for (key, item) in value {
            self.writePrefix()
            write(key)
            self.writeInfix()
            item.accept(visitor: self)
            self.writeSuffix()
        }
        self.endObject()
    }

    func visit(dictionary value: [String: JSON], order: [String]) {
        self.startObject()
        for key in order {
            self.writePrefix()
            write(key)
            self.writeInfix()
            if let item = value[key] {
                item.accept(visitor: self)
            } else {
                writeNull()
            }
            self.writeSuffix()
        }
        self.endObject()
    }

    func visitNull() {
        writeNull()
    }

    func visit(string value: String) {
        write(value)
    }

    func visit(bool value: Bool) {
        write(value)
    }

    func visit(double value: Double) {
        write(value)
    }

    func visit(int value: Int32) {
        write(value)
    }

    func visit(int64 value: Int64) {
        write(value)
    }

    func visit(uint value: UInt32) {
        write(value)
    }

    func visit(uint64 value: UInt64) {
        write(value)
    }
}

public protocol JSONWritable {
    func write<Writer>(to writer: Writer) where Writer: JSONWriter
}

public class JSONDataWriter: JSONWriter, JSONVisitor {
    public typealias Output = ByteArrayRef

    public private(set) var data: ByteArrayRef
    private(set) var state: [State] = []
    public var sortKeys = false

    public var output: ByteArrayRef {
        data
    }

    public init() {
        data = byte_array_create()
    }

    deinit {
        byte_array_free(data)
    }

    var current: State {
        state.last ?? State.value
    }

    /// ```swift
    /// self.startArray()
    /// for item in value {
    ///     self.writePrefix()
    ///     item.accept(visitor: self)
    ///     self.writeSuffix()
    /// }
    /// self.endArray()
    /// ```
    public func startArray() {
        state.append(State.array)
        byte_array_add(data, 0x5b) // [
    }

    public func endArray() {
        precondition(current == State.array || current == State.filledArray)
        byte_array_add(data, 0x5d) // ]
        state.removeLast()
    }

    /// ```swift
    /// self.startObject()
    /// for (key, item) in value {
    ///     self.writePrefix()
    ///     self.write(key)
    ///     self.writeInfix()
    ///     item.accept(visitor: self)
    ///     self.writeSuffix()
    /// }
    /// self.endObject()
    /// ```
    public func startObject() {
        state.append(State.object)
        byte_array_add(data, 0x7b) // {
    }

    public func endObject() {
        precondition(current == State.object || current == State.filledObject)
        byte_array_add(data, 0x7d) // }
        state.removeLast()
    }

    public func writePrefix() {
        precondition(current != State.key && current != State.value)
        switch current {
        case .array: // A empty ARRAY just started.
            break
        case .filledArray, .filledObject:
            byte_array_add(data, 0x2c) // ,
        case .object: // A empty OBJECT just started.
            break
        case .key, .value:
            break
        }
    }

    public func writeInfix() {
        precondition(current == State.key)
        byte_array_add(data, 0x3a) // :
    }

    public func writeSuffix() {
        switch current {
        case .array:
            state.removeLast()
            state.append(State.filledArray)
        case .object, .key:
            state.removeLast()
            state.append(State.filledObject)
        default:
            break
        }
    }

    public func writeNull() {
        byte_array_write_null(data)
    }

    private func write(key: String) {
        write(string: key)
    }

    private func write(string value: String) {
        byte_array_add(data, 0x22) // "
        value.withCString { pointer in
            byte_array_write_int8_data(data, pointer, 0)
        }
        byte_array_add(data, 0x22) // "
    }

    public func write(_ value: String) {
        switch current {
        case .object, .filledObject:
            state.append(State.key)
            write(key: value)
        case .key:
            state.removeLast()
            write(string: value)
        case .array, .filledArray, .value:
            write(string: value)
        }
    }

    public func write(_ value: Bool) {
        byte_array_write_bool(data, value)
    }

    public func write(_ value: Float) {
        byte_array_write_float(data, value)
    }

    public func write(_ value: Double) {
        byte_array_write_double(data, value)
    }

    public func write(_ value: Int32) {
        byte_array_write_int32(data, value)
    }

    public func write(_ value: Int64) {
        byte_array_write_int64(data, value)
    }

    public func write(_ value: UInt32) {
        byte_array_write_uint32(data, value)
    }

    public func write(_ value: UInt64) {
        byte_array_write_uint64(data, value)
    }
    
    public func visit(dictionary value: [String: JSON]) {
        if sortKeys {
            let keys = value.keys.sorted()
            visit(dictionary: value, order: keys)
        } else {
            self.startObject()
            for (key, item) in value {
                self.writePrefix()
                write(key)
                self.writeInfix()
                item.accept(visitor: self)
                self.writeSuffix()
            }
            self.endObject()
        }
    }

    public func visit(dictionary value: [String: JSON], order: [String]) {
        self.startObject()
        for key in order {
            self.writePrefix()
            write(key)
            self.writeInfix()
            if let item = value[key] {
                item.accept(visitor: self)
            } else {
                writeNull()
            }
            self.writeSuffix()
        }
        self.endObject()
    }

    enum State {
        case array
        case filledArray
        case object
        case filledObject
        case key
        case value
    }
}

//public enum SortMethod {
//    case none
//    case alphabet
//    case indexed
//    case combined
//}
//
//public protocol JSONWriterType: JSONVisitor {
//    var stream: DataStream { get }
//    var level: Int { get }
//    var hasIntent: Bool { get }
//
//    func writeIntent()
//    func write(_ string: String)
//    func write(_ byte: UInt8)
//    func flush() throws
//    func newline()
//    func comma()
//}
//
//public extension JSONWriterType {
//    func writeIntent() {
//        if hasIntent && level > 0 {
//            let intent = Array<UInt8>(repeating: 0x20, count: level * 2)
//            try? stream.write(bytes: intent)
//        }
//    }
//
//    func write(_ data: Data) {
//        try? stream.write(data)
//    }
//
//    func write(_ string: String) {
//        try? stream.write(string: string)
//    }
//
//    func write(_ byte: UInt8) {
//        try? stream.write(byte: byte)
//    }
//
//    func flush() throws {
//        try stream.flush()
//    }
//
//    func newline() {
//        write(0x0a)
//    }
//
//    func comma() {
//        write(0x2c)
//    }
//}
//public final class JSONWriter: JSONWriterType {
//    public let stream: DataStream
//    public let hasIntent: Bool
//    public private(set) var level = 0
//    let compact: Bool
//    let ordered: Bool
//    var state: [State] = []
//
//    public init(stream: DataStream) {
//        self.stream = stream
//        hasIntent = true
//        compact = true
//        ordered = true
//    }
//
//    public init(stream: DataStream, options: Options) {
//        self.stream = stream
//        hasIntent = options.contains(.pretty)
//        compact = options.contains(.compact)
//        ordered = options.contains(.ordered)
//    }
//
//    public func visit(_ value: JSON) {
//        // Do nothing.
//    }
//
//    public func visit(array value: JSONArray) {
//        if value.isEmpty {
//            write("[]")
//            return
//        }
//        write("[\n")
//        state.append(.array)
//        level += 1
//        var line = false
//        for item in value.array {
//            if line {
//                comma()
//                newline()
//            } else {
//                line.toggle()
//            }
//            writeIntent()
//            item.accept(visitor: self)
//        }
//        level -= 1
//        write("\n")
//        writeIntent()
//        write("]")
//        _ = state.removeLast()
//    }
//
//    public func visit(dictionary value: JSONObject) {
//        if value.isEmpty {
//            write("{}")
//            return
//        }
//        write("{\n")
//        state.append(.object)
//        level += 1
//        var line = false
//        for (key, item) in value.dictionary {
//            if line {
//                comma()
//                newline()
//            } else {
//                line.toggle()
//            }
//            writeIntent()
//            write("\"")
//            write(key)
//            write("\": ")
//            item.accept(visitor: self)
//        }
//        level -= 1
//        write("\n")
//        writeIntent()
//        write("}")
//        _ = state.removeLast()
//    }
//
//    public func visit(null value: JSONNull) {
//        write("null")
//    }
//
//    public func visit(string value: String) {
//        write("\"")
//        write(value)
//        write("\"")
//    }
//
//    public func visit(bool value: Bool) {
//        write(String(value))
//    }
//
//    public func visit(double value: Double) {
//        write(String(value))
//    }
//
//    public func visit(int value: Int32) {
//        write(String(value))
//    }
//
//    public func visit(int64 value: Int64) {
//        write(String(value))
//    }
//
//    public func visit(uint value: UInt32) {
//        write(String(value))
//    }
//
//    public func visit(uint64 value: UInt64) {
//        write(String(value))
//    }
//
//    public struct Options: OptionSet {
//        public let rawValue: Int32
//
//        public init(rawValue: Int32) {
//            self.rawValue = rawValue
//        }
//
//        public static let pretty = Options(rawValue: 1 << 0)
//        public static let compact = Options(rawValue: 1 << 1)
//        public static let ordered = Options(rawValue: 1 << 2)
//    }
//
//    enum State {
//        case array
//        case object
//    }
//
//    public static func write(_ json: JSON, stream: DataStream, options: Options? = nil) throws {
//        let writer: JSONWriter
//        if let _options = options {
//            writer = JSONWriter(stream: stream, options: _options)
//        } else {
//            writer = JSONWriter(stream: stream)
//        }
//        json.accept(visitor: writer)
//        writer.newline()
//        try writer.flush()
//    }
//}
//
//public final class JSONPlistWriter: JSONWriterType {
//    public let stream: DataStream
//    public let hasIntent: Bool = true
//    public let sorted: Bool = true
//    public private(set) var level = 0
//
//    public init(stream: DataStream) {
//        self.stream = stream
//    }
//
//    public func writeIntent() {
//        if hasIntent && level > 0 {
//            let intent = Array<UInt8>(repeating: 0x20, count: level * 4)
//            try? stream.write(bytes: intent)
//        }
//    }
//
//    public func header() {
//        write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
//        write("<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" ")
//        write("\"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n")
//        write("<plist version=\"1.0\">\n")
//    }
//
//    public func footer() {
//        write("</plist>")
//    }
//
//    public func visit(_ value: JSON) {
//        // Do nothing.
//    }
//
//    public func visit(array value: JSONArray) {
//        let array = value.array
//        if array.isEmpty {
//            write("<array/>")
//            return
//        }
//        write("<array>\n")
//        level += 1
//        for item in array.sorted() {
//            if !item.exists {
//                continue
//            }
//            writeIntent()
//            item.accept(visitor: self)
//            newline()
//        }
//        level -= 1
//        writeIntent()
//        write("</array>")
//    }
//
//    public func visit(dictionary value: JSONObject) {
//        let map = value.dictionary
//        if map.isEmpty {
//            write("<dict/>")
//            return
//        }
//        write("<dict>\n")
//        level += 1
//        let keys = map.keys.sorted()
//        for key in keys {
//            if let item = map[key] {
//                if !item.exists {
//                    continue
//                }
//                writeIntent()
//                write("<key>")
//                write(key)
//                write("</key>\n")
//                writeIntent()
//                item.accept(visitor: self)
//                newline()
//            }
//        }
//        level -= 1
//        writeIntent()
//        write("</dict>")
//    }
//
//    public func visit(null value: JSONNull) {
//        // Do nothing.
//    }
//
//    public func visit(string value: String) {
//        write("<string>")
//        write(JSONPlistWriter.encodingString(value))
//        write("</string>")
//    }
//
//    public func visit(bool value: Bool) {
//        if value {
//            write("<true/>")
//        } else {
//            write("<false/>")
//        }
//    }
//
//    public func visit(double value: Double) {
//        write("<real>")
//        write(String(value))
//        write("</real>")
//    }
//
//    public func visit(int value: Int32) {
//        write("<integer>")
//        write(String(value))
//        write("</integer>")
//    }
//
//    public func visit(int64 value: Int64) {
//        write("<integer>")
//        write(String(value))
//        write("</integer>")
//    }
//
//    public func visit(uint value: UInt32) {
//        write("<integer>")
//        write(String(value))
//        write("</integer>")
//    }
//
//    public func visit(uint64 value: UInt64) {
//        write("<integer>")
//        write(String(value))
//        write("</integer>")
//    }
//
//    public static func write(_ json: JSON, stream: DataStream) throws {
//        let writer = JSONPlistWriter(stream: stream)
//        writer.header()
//        json.accept(visitor: writer)
//        writer.newline()
//        writer.footer()
//        try writer.flush()
//    }
//
//    public static func encodingString(_ value: String) -> Data {
//        var result = Data()
//        for char in value {
//            switch char {
//            case "<": // &lt;
//                result.append(contentsOf: [0x26, 0x6c, 0x74, 0x3b])
//            case ">": // &gt;
//                result.append(contentsOf: [0x26, 0x67, 0x74, 0x3b])
//            case "&": // &amp;
//                result.append(contentsOf: [0x26, 0x61, 0x6d, 0x70, 0x3b])
//            case "'": // &apos;
//                result.append(contentsOf: [0x26, 0x61, 0x70, 0x6f, 0x73, 0x3b])
//            case "\"": // &quot;
//                result.append(contentsOf: [0x26, 0x71, 0x75, 0x6f, 0x74, 0x3b])
//            default:
//                // FIXME: String => Character => String
//                if let temp = String(char).data(using: .utf8) {
//                    result.append(temp)
//                }
//            }
//        }
//        return result
//    }
//}
