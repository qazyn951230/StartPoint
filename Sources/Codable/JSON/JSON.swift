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
    func visit(array value: [JSON])
    func visit(dictionary value: [String: JSON])
    func visit(null value: JSON)
    func visit(key value: String)
    func visit(string value: String)
    func visit(bool value: Bool)
    func visit(double value: Double)
    func visit(int value: Int32)
    func visit(int64 value: Int64)
    func visit(uint value: UInt32)
    func visit(uint64 value: UInt64)
}

public extension JSONVisitor {
    func visit(array value: [JSON]) {
        for item in value {
            visit(item)
        }
    }

    func visit(dictionary value: [String: JSON]) {
        for (key, item) in value {
            visit(key: key)
            visit(item)
        }
    }

    func visit(null value: JSON) {
        visit(value)
    }

    func visit(key value: String) {
        // Do nothing
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

class JSONBuffer {
    let ref: JSONRef

    init(ref: JSONRef) {
        self.ref = ref
    }

    deinit {
        json_free(ref)
    }
}

public final class JSON: Codable, TypeNotated, Comparable, CustomStringConvertible {
    public static let null = JSON(type: JSONType.null)
    public typealias Value = JSON

    let buffer: JSONBuffer
    let ref: JSONRef
    var _cachedString: String?
    var _cachedArray: [JSON]?
    var _cachedDictionary: [String: JSON]?

    init(type: JSONType) {
        ref = json_create_type(type)
        buffer = JSONBuffer(ref: ref)
    }

    init(buffer: JSONBuffer, ref: JSONRef) {
        self.buffer = buffer
        self.ref = ref
    }

    private init(ref: JSONRef) {
        self.ref = ref
        buffer = JSONBuffer(ref: ref)
    }

    public convenience init(_ value: Int) {
#if arch(arm64) || arch(x86_64)
        self.init(ref: json_create_int32(Int32(value)))
#else
        self.init(ref: json_create_int64(Int64(value)))
#endif
    }

    public convenience init(_ value: Int32) {
        self.init(ref: json_create_int32(value))
    }

    public convenience init(_ value: Int64) {
        self.init(ref: json_create_int64(value))
    }

    public convenience init(_ value: UInt) {
#if arch(arm64) || arch(x86_64)
        self.init(ref: json_create_uint32(UInt32(value)))
#else
        self.init(ref: json_create_uint64(UInt64(value)))
#endif
    }

    public convenience init(_ value: UInt32) {
        self.init(ref: json_create_uint32(value))
    }

    public convenience init(_ value: UInt64) {
        self.init(ref: json_create_uint64(value))
    }

    public convenience init(_ value: Float) {
        self.init(ref: json_create_float(value))
    }

    public convenience init(_ value: Double) {
        self.init(ref: json_create_double(value))
    }

    public init(string value: String) {
        self.buffer = JSON.null.buffer
        self.ref = JSON.null.ref
        _cachedString = value
    }

    public init(array value: [JSON]) {
        self.buffer = JSON.null.buffer
        self.ref = JSON.null.ref
        _cachedArray = value
    }

    public init(dictionary value: [String: JSON]) {
        self.buffer = JSON.null.buffer
        self.ref = JSON.null.ref
        _cachedDictionary = value
    }

    public required init(from decoder: Decoder) throws {
        fatalError()
    }

    public func encode(to encoder: Encoder) throws {
        fatalError()
    }

    public var raw: Any {
        return ""
    }

    func makeRef(ref: JSONRef?) -> JSON {
        guard let ref = ref, !json_is_null(ref) else {
            return JSON.null
        }
        return JSON(buffer: buffer, ref: ref)
    }

    public var exists: Bool {
        !json_is_null(ref)
    }

    public var arrayValue: [JSON]? {
        if let cached = _cachedArray {
            return cached
        }
        if json_array_size(ref) > 0 {
            var array: [JSON] = []
            for i in 0..<json_array_size(ref) {
                let value = json_array_get_index(ref, i)
                array.append(makeRef(ref: value))
            }
            _cachedArray = array
        }
        return _cachedArray
    }

    public var array: [JSON] {
        arrayValue ?? []
    }

    public var dictionaryValue: [String: JSON]? {
        if let cachedDictionary = _cachedDictionary {
            return cachedDictionary
        }
        _cachedDictionary = JSON.decodeObject(buffer: buffer, ref: ref)
        return _cachedDictionary
    }

    public var dictionary: [String: JSON] {
        dictionaryValue ?? [:]
    }

    public var boolValue: Bool? {
        var result = false
        if json_get_bool(ref, &result) {
            return result
        }
        return nil
    }

    public var bool: Bool {
        var result = false
        if json_get_bool(ref, &result) {
            return result
        }
        return false
    }

    public var stringValue: String? {
        if let cached = _cachedString {
            return cached
        }
        _cachedString = JSON.decodeString(ref: ref)
        return _cachedString
    }

    public var string: String {
        stringValue ?? ""
    }

    public var doubleValue: Double? {
        var result = 0.0
        if json_get_double(ref, &result) {
            return result
        }
        return nil
    }

    public var double: Double {
        var result = 0.0
        if json_get_double(ref, &result) {
            return result
        }
        return 0
    }

    public var floatValue: Float? {
        var result: Float = 0.0
        if json_get_float(ref, &result) {
            return result
        }
        return nil
    }

    public var float: Float {
        var result: Float = 0.0
        if json_get_float(ref, &result) {
            return result
        }
        return 0
    }

    public var intValue: Int? {
#if arch(arm64) || arch(x86_64)
        var result: Int64 = 0
        if json_get_int64(ref, &result) {
            return Int(result)
        }

#else
        var result: Int32 = 0
        if json_get_int32(ref, &result) {
            return Int(result)
        }
#endif
        return nil
    }

    public var int: Int {
#if arch(arm64) || arch(x86_64)
        var result: Int64 = 0
        if json_get_int64(ref, &result) {
            return Int(result)
        }

#else
        var result: Int32 = 0
        if json_get_int32(ref, &result) {
            return Int(result)
        }
#endif
        return 0
    }

    public var int32Value: Int32? {
        var result: Int32 = 0
        if json_get_int32(ref, &result) {
            return result
        }
        return nil
    }

    public var int32: Int32 {
        var result: Int32 = 0
        if json_get_int32(ref, &result) {
            return result
        }
        return 0
    }

    public var int64Value: Int64? {
        var result: Int64 = 0
        if json_get_int64(ref, &result) {
            return result
        }
        return nil
    }

    public var int64: Int64 {
        var result: Int64 = 0
        if json_get_int64(ref, &result) {
            return result
        }
        return 0
    }

    public var uintValue: UInt? {
#if arch(arm64) || arch(x86_64)
        var result: UInt64 = 0
        if json_get_uint64(ref, &result) {
            return UInt(result)
        }

#else
        var result: UInt32 = 0
        if json_get_uint32(ref, &result) {
            return UInt(result)
        }
#endif
        return nil
    }

    public var uint: UInt {
#if arch(arm64) || arch(x86_64)
        var result: UInt64 = 0
        if json_get_uint64(ref, &result) {
            return UInt(result)
        }

#else
        var result: UInt32 = 0
        if json_get_uint32(ref, &result) {
            return UInt(result)
        }
#endif
        return 0
    }

    public var uint32Value: UInt32? {
        var result: UInt32 = 0
        if json_get_uint32(ref, &result) {
            return result
        }
        return nil
    }

    public var uint32: UInt32 {
        var result: UInt32 = 0
        if json_get_uint32(ref, &result) {
            return result
        }
        return 0
    }

    public var uint64Value: UInt64? {
        var result: UInt64 = 0
        if json_get_uint64(ref, &result) {
            return result
        }
        return nil
    }

    public var uint64: UInt64 {
        var result: UInt64 = 0
        if json_get_uint64(ref, &result) {
            return result
        }
        return 0
    }

    public var description: String {
        return ""
    }

    public func accept(visitor: JSONVisitor) {
        switch json_type(ref) {
        case JSONType.array:
            visitor.visit(array: array)
        case JSONType.object:
            visitor.visit(dictionary: dictionary)
        case JSONType.int:
            visitor.visit(int: int32)
        case JSONType.uint:
            visitor.visit(uint: uint32)
        case JSONType.int64:
            visitor.visit(int64: int64)
        case JSONType.uint64:
            visitor.visit(uint64: uint64)
        case JSONType.double:
            visitor.visit(double: double)
        case JSONType.string:
            visitor.visit(string: string)
        case JSONType.null:
            visitor.visit(null: self)
        case JSONType.true:
            visitor.visit(bool: true)
        case JSONType.false:
            visitor.visit(bool: false)
        @unknown default:
            visitor.visit(self)
        }
    }

    public static func ==(lhs: JSON, rhs: JSON) -> Bool {
        json_is_equal(lhs.ref, rhs.ref)
    }

    public static func <(lhs: JSON, rhs: JSON) -> Bool {
        json_is_less_than(lhs.ref, rhs.ref)
    }

    public static func <=(lhs: JSON, rhs: JSON) -> Bool {
        json_is_less_than_or_equal(lhs.ref, rhs.ref)
    }

    public static func >(lhs: JSON, rhs: JSON) -> Bool {
        json_is_greater_than(lhs.ref, rhs.ref)
    }

    public static func >=(lhs: JSON, rhs: JSON) -> Bool {
        json_is_greater_than_or_equal(lhs.ref, rhs.ref)
    }

    public subscript(typed index: Int) -> JSON {
        if json_is_array(ref) {
            let value = json_array_get_index(ref, UInt32(index))
            return makeRef(ref: value)
        }
        return JSON.null
    }

    public subscript(typed key: String) -> JSON {
        dictionaryValue?[key] ?? JSON.null
    }

    public func item(at index: Int) -> Notated {
        self[index]
    }

    public func item(key: String) -> Notated {
        self[key]
    }

    static func decodeString(ref: JSONRef) -> String? {
        var size: UInt32 = 0
        let data = json_get_string(ref, &size)
        return String(bytesNoCopy: data, length: Int(size), encoding: .utf8, freeWhenDone: false)
    }

    static func decodeObject(buffer: JSONBuffer, ref: JSONRef) -> [String: JSON] {
        guard json_object_size(ref) > 0 else {
            return [:]
        }
        var result: [String: JSON] = [:]
        json_object_for_each(ref) { (data, size, value) in
            if let key = String(bytesNoCopy: UnsafeMutableRawPointer(mutating: data), length: Int(size),
                                encoding: .utf8, freeWhenDone: false) {
                result[key] = JSON(buffer: buffer, ref: value)
            }
        }
        return result
    }

    public static func parse(_ value: String) -> JSON {
        value.withCString { pointer in
            if let ref = json_parse_int8_data(pointer) {
                return JSON(buffer: JSONBuffer(ref: ref), ref: ref)
            }
            return JSON.null
        }
    }

    public static func parse(data: Data) -> JSON {
        data.withUnsafeBytes { (raw: UnsafeRawBufferPointer) in
            guard let pointer = raw.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                return JSON.null
            }
            if let ref = json_parse_uint8_data(pointer) {
                return JSON(buffer: JSONBuffer(ref: ref), ref: ref)
            }
            return JSON.null
        }
    }

    public static func tryParse(_ value: String) throws -> JSON {
        try value.withCString { pointer in
            var status = JSONParseStatus.success
            if let ref = json_parse_int8_data_status(pointer, &status) {
                return JSON(buffer: JSONBuffer(ref: ref), ref: ref)
            }
            throw JSONParseError.create(status: status)
        }
    }

    public static func tryParse(data: Data) throws -> JSON {
        try data.withUnsafeBytes { (raw: UnsafeRawBufferPointer) in
            guard let pointer = raw.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                return JSON.null
            }
            var status = JSONParseStatus.success
            if let ref = json_parse_uint8_data_status(pointer, &status) {
                return JSON(buffer: JSONBuffer(ref: ref), ref: ref)
            }
            throw JSONParseError.create(status: status)
        }
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
