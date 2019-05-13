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

public protocol JSONVisitor {
    func visit(_ value: JSON)
    func visit(array value: JSONArray)
    func visit(dictionary value: JSONObject)
    func visit(null value: JSONNull)
    func visit(string value: String)
    func visit(bool value: Bool)
    func visit(double value: Double)
    func visit(int value: Int32)
    func visit(int64 value: Int64)
    func visit(uint value: UInt32)
    func visit(uint64 value: UInt64)
}

public extension JSONVisitor {
    func visit(array value: JSONArray) {
        visit(value)
    }

    func visit(dictionary value: JSONObject) {
        visit(value)
    }

    func visit(null value: JSONNull) {
        visit(value)
    }

    func visit(string value: String) {
        // Do nothing
    }

    func visit(bool value: Bool) {
        // Do nothing
    }

    func visit(double value: Double) {
        // Do nothing
    }

    func visit(int value: Int32) {
        // Do nothing
    }

    func visit(int64 value: Int64) {
        // Do nothing
    }

    func visit(uint value: UInt32) {
        // Do nothing
    }

    func visit(uint64 value: UInt64) {
        // Do nothing
    }
}

public class JSON: Codable, TypeNotated, Comparable, CustomStringConvertible {
    public static let null = JSONNull()
    public typealias Value = JSON
    public var order: Int = 0

    init() {
        // Do nothing
    }

    public required init(from decoder: Decoder) throws {
        // Do nothing
    }

    public func encode(to encoder: Encoder) throws {
        // Do nothing
    }

    public var raw: Any {
        return ""
    }

    public var exists: Bool {
        return true
    }

    public var arrayValue: [JSON]? {
        return nil
    }

    public var array: [JSON] {
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
        return ""
    }

    public func accept(visitor: JSONVisitor) {
        visitor.visit(self)
    }

    func equals(other: JSON) -> Bool {
        return self === other
    }

    func less(other: JSON) -> Bool {
        return false
    }

    func greater(other: JSON) -> Bool {
        return !lessOrEqual(other: other)
    }

    func lessOrEqual(other: JSON) -> Bool {
        return equals(other: other) || less(other: other)
    }

    func greaterOrEqual(other: JSON) -> Bool {
        return equals(other: other) || greater(other: other)
    }

    public static func ==(lhs: JSON, rhs: JSON) -> Bool {
        return lhs.equals(other: rhs)
    }

    public static func <(lhs: JSON, rhs: JSON) -> Bool {
        return lhs.less(other: rhs)
    }

    public static func <=(lhs: JSON, rhs: JSON) -> Bool {
        return lhs.lessOrEqual(other: rhs)
    }

    public static func >(lhs: JSON, rhs: JSON) -> Bool {
        return lhs.greater(other: rhs)
    }

    public static func >=(lhs: JSON, rhs: JSON) -> Bool {
        return lhs.greaterOrEqual(other: rhs)
    }

    public subscript(typed index: Int) -> JSON {
        return JSON.null
    }

    public subscript(typed key: String) -> JSON {
        return JSON.null
    }

    public func item(at index: Int) -> Notated {
        return self[index]
    }

    public func item(key: String) -> Notated {
        return self[key]
    }

    public static func parse(_ value: String, option: JSONParser.Options = []) throws -> JSON {
        return try value.withCString { pointer in
            let stream = ByteStream.int8(pointer)
            let buffer = json_buffer_create(24, 4096)
            let parser = JSONParser(stream: stream, buffer: buffer, options: option)
            try parser.parse()
            return JSON.create(from: buffer, index: 0)
        }
    }

    public static func parse(_ data: Data, option: JSONParser.Options = []) throws -> JSON {
        return try data.withUnsafeBytes { (raw: UnsafeRawBufferPointer) in
            guard let pointer = raw.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                return JSON.null
            }
            let stream = ByteStream.uint8(pointer)
            let buffer = json_buffer_create(24, 4096)
            let parser = JSONParser(stream: stream, buffer: buffer, options: option)
            try parser.parse()
            return JSON.create(from: buffer, index: 0)
        }
    }

    public static func array() -> JSONArray {
        return JSONArray()
    }

    public static func object() -> JSONObject {
        return JSONObject()
    }

    static func create(from buffer: JSONBufferRef, index: Int) -> JSON {
        return JSON.null
//        switch json_buffer_value_type(buffer, index) {
//        case JSONType.null:
//            return JSONNull.null
//        case JSONType.array:
//            let temp = json_buffer_array_(buffer, index)
//            let other = json_buffer_copy_array(buffer, temp)
//            json_array_free(temp)
//            return JSONArray(buffer: other)
//        case JSONType.object:
//            let temp = json_buffer_object(buffer, index)
//            let other = json_buffer_copy_object(buffer, temp)
//            json_object_free(temp)
//            return JSONObject(buffer: other)
//        default:
//            let other = json_buffer_copy(buffer, index, 1)
//            return JSONValue(buffer: other)
//        }
    }

//    static func create(from value: Any, nullable: Bool) -> JSON? {
//        switch value {
//        case let string as String:
//            return JSONString(string)
//        case let bool as Bool:
//            return JSONBool(bool)
//        case let int32 as Int32:
//            return JSONInt(int32)
//        case let int64 as Int64:
//            return JSONInt64(int64)
//        case let int as Int:
//            return JSONInt64(Int64(int))
//        case let uint32 as UInt32:
//            return JSONUInt(uint32)
//        case let uint64 as UInt64:
//            return JSONUInt64(uint64)
//        case let uint as UInt:
//            return JSONUInt64(UInt64(uint))
//        case let double as Double:
//            return JSONDouble(double)
//        case let float as Float:
//            return JSONDouble(Double(float))
//        case let int8 as Int8:
//            return JSONInt(Int32(int8))
//        case let int16 as Int16:
//            return JSONInt(Int32(int16))
//        case let uint8 as UInt8:
//            return JSONUInt(UInt32(uint8))
//        case let uint16 as UInt16:
//            return JSONUInt(UInt32(uint16))
//        case is NSNull:
//            return JSON.null
//        case let array as [Any]:
//            return create(from: array, nullable: nullable)
//        case let map as [String: Any]:
//            return create(from: map, nullable: nullable)
//        default:
//            return nil
//        }
//    }

//    static func create(from value: [Any], nullable: Bool) -> JSON? {
//        if nullable {
//            let array =  value.map { (v: Any) -> JSON in
//                return JSON.create(from: v, nullable: nullable) ?? JSON.null
//            }
//            return JSONArray(array)
//        } else {
//            let array = value.compactMap { (v: Any) -> JSON? in
//                return JSON.create(from: v, nullable: nullable)
//            }
//            return JSONArray(array)
//        }
//    }
//
//    public static func create(from value: [String: Any], nullable: Bool) -> JSON? {
//        if nullable {
//            let map = value.mapValues { (v: Any) -> JSON in
//                return JSON.create(from: v, nullable: nullable) ?? JSON.null
//            }
//            return JSONObject(map)
//        } else {
//            let map = value.compactMapValues { (v: Any) -> JSON? in
//                return JSON.create(from: v, nullable: nullable)
//            }
//            return JSONObject(map)
//        }
//    }
}
