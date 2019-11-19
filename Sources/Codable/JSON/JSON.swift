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

    public var kind: JSONType {
        get {
            json_type(ref)
        }
        set {
            if json_type(ref) != newValue {
                json_reset_type(ref, newValue)
            }
        }
    }

    @usableFromInline
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

    public convenience init(_ value: Bool) {
        self.init(ref: json_create_bool(value))
    }

    public convenience init(_ value: Double) {
        self.init(ref: json_create_double(value))
    }

    public convenience init(_ value: Float) {
        self.init(ref: json_create_float(value))
    }

    public convenience init(_ value: Int) {
#if arch(arm64) || arch(x86_64)
        self.init(ref: json_create_int32(Int32(value)))
#else
        self.init(ref: json_create_int64(Int64(value)))
#endif
    }

    public convenience init(_ value: Int8) {
        self.init(Int(value))
    }

    public convenience init(_ value: Int16) {
        self.init(Int(value))
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

    public convenience init(_ value: UInt8) {
        self.init(UInt(value))
    }

    public convenience init(_ value: UInt16) {
        self.init(UInt(value))
    }

    public convenience init(_ value: UInt32) {
        self.init(ref: json_create_uint32(value))
    }

    public convenience init(_ value: UInt64) {
        self.init(ref: json_create_uint64(value))
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
}

extension JSON {
    @inlinable
    public static func object() -> JSON {
        JSON(type: JSONType.object)
    }

    @inlinable
    public static func array() -> JSON {
        JSON(type: JSONType.array)
    }
}

// MARK: - Single JSON Container
extension JSON {
    public func fillNull() {
        json_reset_type(ref, JSONType.null)
    }

    public func fill(any value: String?) {
        precondition(kind != JSONType.array && kind != JSONType.object)
        if let value = value {
            json_reset_type(ref, JSONType.string)
            _cachedString = value
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: Bool?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
            json_set_bool(ref, value)
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: Float?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
            json_set_float(ref, value)
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: Double?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
            json_set_double(ref, value)
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: Int?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
#if arch(arm64) || arch(x86_64)
            json_set_int64(ref, Int64(value))
#else
            json_set_int32(ref, Int32(value))
#endif
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: Int8?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
            json_set_int32(ref, Int32(value))
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: Int16?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
            json_set_int32(ref, Int32(value))
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: Int32?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
            json_set_int32(ref, value)
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: Int64?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
            json_set_int64(ref, value)
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: UInt?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
#if arch(arm64) || arch(x86_64)
            json_set_uint64(ref, UInt64(value))
#else
            json_set_uint32(ref, UInt32(value))
#endif
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: UInt8?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
            json_set_uint32(ref, UInt32(value))
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: UInt16?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
            json_set_uint32(ref, UInt32(value))
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: UInt32?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
            json_set_uint32(ref, value)
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: UInt64?) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        if let value = value {
            json_set_uint64(ref, value)
        } else {
            json_reset_type(ref, JSONType.null)
        }
    }

    public func fill(any value: JSON?) {
        if let value = value {
            json_replace(ref, value.ref)
            _cachedArray = value._cachedArray
            _cachedDictionary = value._cachedDictionary
            _cachedString = value._cachedString
            value._cachedArray = nil
            value._cachedDictionary = nil
            value._cachedString = nil
        } else {
            json_reset_type(ref, JSONType.null)
            _cachedArray = nil
            _cachedDictionary = nil
            _cachedString = nil
        }
    }

    public func fill(_ value: String) {
        precondition(kind != JSONType.array && kind != JSONType.object)
        json_reset_type(ref, JSONType.string)
        _cachedString = value
    }

    public func fill(_ value: Bool) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        json_set_bool(ref, value)
    }

    public func fill(_ value: Float) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        json_set_float(ref, value)
    }

    public func fill(_ value: Double) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        json_set_double(ref, value)
    }

    public func fill(_ value: Int) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
#if arch(arm64) || arch(x86_64)
        json_set_int64(ref, Int64(value))
#else
        json_set_int32(ref, Int32(value))
#endif
    }

    public func fill(_ value: Int8) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        json_set_int32(ref, Int32(value))
    }

    public func fill(_ value: Int16) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        json_set_int32(ref, Int32(value))
    }

    public func fill(_ value: Int32) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        json_set_int32(ref, value)
    }

    public func fill(_ value: Int64) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        json_set_int64(ref, value)
    }

    public func fill(_ value: UInt) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
#if arch(arm64) || arch(x86_64)
        json_set_uint64(ref, UInt64(value))
#else
        json_set_uint32(ref, UInt32(value))
#endif
    }

    public func fill(_ value: UInt8) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        json_set_uint32(ref, UInt32(value))
    }

    public func fill(_ value: UInt16) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        json_set_uint32(ref, UInt32(value))
    }

    public func fill(_ value: UInt32) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        json_set_uint32(ref, value)
    }

    public func fill(_ value: UInt64) {
        precondition(kind != JSONType.array && kind != JSONType.object && kind != JSONType.string)
        json_set_uint64(ref, value)
    }

    public func fill(_ value: JSON) {
        json_replace(ref, value.ref)
        _cachedArray = value._cachedArray
        _cachedDictionary = value._cachedDictionary
        _cachedString = value._cachedString
        value._cachedArray = nil
        value._cachedDictionary = nil
        value._cachedString = nil
    }
}

// MARK: - Unkeyed JSON Container
extension JSON {
    public func appendNull() {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON.null)
    }

    public func append(any value: String?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(string: value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: Bool?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: Float?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: Double?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: Int?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: Int8?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: Int16?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: Int32?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: Int64?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: UInt?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: UInt8?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: UInt16?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: UInt32?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: UInt64?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(JSON(value))
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(any value: JSON?) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        if let value = value {
            _cachedArray?.append(value)
        } else {
            _cachedArray?.append(JSON.null)
        }
    }

    public func append(_ value: String) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(string: value))
    }

    public func append(_ value: Bool) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: Float) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: Double) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: Int) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: Int8) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: Int16) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: Int32) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: Int64) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: UInt) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: UInt8) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: UInt16) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: UInt32) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: UInt64) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(JSON(value))
    }

    public func append(_ value: JSON) {
        precondition(kind == JSONType.array)
        if _cachedArray == nil {
            _cachedArray = []
        }
        _cachedArray?.append(value)
    }
}

// MARK: - Keyed JSON Container
extension JSON {
    public func setNull(key: String) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON.null
    }

    public func set(key: String, any value: String?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(string: value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: Bool?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: Float?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: Double?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: Int?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: Int8?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: Int16?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: Int32?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: Int64?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: UInt?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: UInt8?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: UInt16?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: UInt32?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: UInt64?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = JSON(value)
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, any value: JSON?) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        if let value = value {
            _cachedDictionary?[key] = value
        } else {
            _cachedDictionary?[key] = JSON.null
        }
    }

    public func set(key: String, _ value: String) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(string: value)
    }

    public func set(key: String, _ value: Bool) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: Float) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: Double) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: Int) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: Int8) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: Int16) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: Int32) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: Int64) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: UInt) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: UInt8) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: UInt16) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: UInt32) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: UInt64) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = JSON(value)
    }

    public func set(key: String, _ value: JSON) {
        precondition(kind == JSONType.object)
        if _cachedDictionary == nil {
            _cachedDictionary = [:]
        }
        _cachedDictionary?[key] = value
    }
}

// MARK: - JSON parse
extension JSON {
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
}
