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

public final class JSONWriter: JSONVisitor {
    let stream: DataStream
    let pretty: Bool
    let compact: Bool
    let ordered: Bool
    var level = 0
    var state: [State] = []

    public init(stream: DataStream) {
        self.stream = stream
        pretty = true
        compact = true
        ordered = true
    }

    public init(stream: DataStream, options: Options) {
        self.stream = stream
        pretty = options.contains(.pretty)
        compact = options.contains(.compact)
        ordered = options.contains(.ordered)
    }

    func writeIntent() {
        if pretty && level > 0 {
            let intent = Array<UInt8>(repeating: 0x20, count: level * 2)
            try? stream.write(bytes: intent)
        }
    }

    func write(_ string: String) {
        try? stream.write(string: string)
    }

    func write(_ byte: UInt8) {
        try? stream.write(byte: byte)
    }

    func flush() throws {
        try stream.flush()
    }

    func newline() {
        write(0x0a)
    }

    func comma() {
        write(0x2c)
    }

    public func visit(_ value: JSON) {
        assertionFailure("Error state")
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
