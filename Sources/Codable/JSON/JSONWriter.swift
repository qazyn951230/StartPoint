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

public protocol JSONWriter: StructureWriter, JSONVisitor {
    func write(any value: JSONGenerator?)
    func write(_ value: JSONGenerator)
}

public extension JSONWriter {
    func write(any value: JSONGenerator?) {
        if let json = value?.generate() {
            json.accept(visitor: self)
        } else {
            writeNull()
        }
    }

    func write(_ value: JSONGenerator) {
        let json = value.generate()
        json.accept(visitor: self)
    }

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
