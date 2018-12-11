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

public class JSON: Notated, Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    public static let null = JSONNull()
    public typealias Value = JSON

    init() {
        // Do nothing
    }

    public var raw: Any {
        return ""
    }

    public var arrayValue: [JSON]? {
        return nil
    }

    public var array: [JSON]  {
        return []
    }

    public var dictionaryValue: [String: JSON]? {
        return nil
    }

    public var dictionary: [String: JSON] {
        return [:]
    }

    public var boolValue: Bool? {
        return nil
    }

    public var bool: Bool {
        return false
    }

    public var stringValue: String? {
        return nil
    }

    public var string: String {
        return ""
    }

    public var doubleValue: Double? {
        return nil
    }

    public var double: Double {
        return 0
    }

    public var floatValue: Float? {
        return nil
    }

    public var float: Float {
        return 0
    }

    public var intValue: Int? {
        return nil
    }

    public var int: Int {
        return 0
    }

    public var int32Value: Int32? {
        return nil
    }

    public var int32: Int32 {
        return 0
    }

    public var int64Value: Int64? {
        return nil
    }

    public var int64: Int64 {
        return 0
    }

    public var uintValue: UInt? {
        return nil
    }

    public var uint: UInt {
        return 0
    }

    public var uint32Value: UInt32? {
        return nil
    }

    public var uint32: UInt32 {
        return 0
    }

    public var uint64Value: UInt64? {
        return nil
    }

    public var uint64: UInt64 {
        return 0
    }

    public var description: String {
        return "<JSON>"
    }

    public var debugDescription: String {
        return "<JSON: \(address(of: self))>"
    }

    func equals(to object: JSON) -> Bool {
        return self === object
    }

    public static func ==(lhs: JSON, rhs: JSON) -> Bool {
        return lhs.equals(to: rhs)
    }

    public subscript(index: Int) -> JSON {
        return JSON.null
    }

    public subscript(key: String) -> JSON {
        return JSON.null
    }

    public static func parse(_ value: String, option: ParserOption = []) throws -> JSON {
        return try value.withCString { pointer in
            let stream = ByteStream.int8(pointer)
            let parser = JSONParser(stream: stream, option: option)
            return try parser.parse()
        }
    }

    public static func parse(_ data: Data, option: ParserOption = []) throws -> JSON {
        return try data.withUnsafeBytes { (pointer: UnsafePointer<UInt8>) in
            let stream = ByteStream.uint8(pointer)
            let parser = JSONParser(stream: stream, option: option)
            return try parser.parse()
        }
    }
}
