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

@inline(__always)
internal func decodeArray(in buffer: JSONBufferRef, at index: Int) -> [JSON] {
    if json_buffer_value_type(buffer, 0) != JSONType.array {
        return []
    }
    let temp = json_buffer_array_create(buffer, 0, false)
    defer {
        json_array_free(temp)
    }
    let index = json_array_index(temp) + 1
    let n = json_array_count(temp)
    if n < 1 {
        return []
    }
    var result: [JSON] = []
    for i in 0..<n {
        result.append(JSON.create(from: buffer, index: index + i))
    }
    return result
}

@inline(__always)
internal func decodeAnyArray(in buffer: JSONBufferRef, at index: Int) -> [JSON]? {
    if json_buffer_value_type(buffer, 0) != JSONType.array {
        return nil
    }
    let temp = json_buffer_array_create(buffer, 0, false)
    defer {
        json_array_free(temp)
    }
    let index = json_array_index(temp) + 1
    let n = json_array_count(temp)
    if n < 1 {
        return nil
    }
    var result: [JSON] = []
    for i in 0..<n {
        result.append(JSON.create(from: buffer, index: index + i))
    }
    return result
}

@inline(__always)
internal func decodeObject(in buffer: JSONBufferRef, at index: Int) -> [String: JSON] {
    if json_buffer_value_type(buffer, 0) != JSONType.object {
        return [:]
    }
    let temp = json_buffer_object_create(buffer, 0, false)
    defer {
        json_object_free(temp)
    }
    let index = json_object_index(temp) + 1
    let n = json_object_count(temp)
    if n < 1 {
        return [:]
    }
    var result: [String: JSON] = [:]
    var i = 0
    while i < n {
        guard let key = decodeAnyString(in: buffer, at: index + i) else {
            return [:]
        }
        let value = JSON.create(from: buffer, index: index + i + 1)
        result[key] = value
        i += 2
    }
    return result
}

@inline(__always)
internal func decodeAnyObject(in buffer: JSONBufferRef, at index: Int) -> [String: JSON]? {
    if json_buffer_value_type(buffer, 0) != JSONType.object {
        return nil
    }
    let temp = json_buffer_object_create(buffer, 0, false)
    defer {
        json_object_free(temp)
    }
    let index = json_object_index(temp) + 1
    let n = json_object_count(temp)
    if n < 1 {
        return nil
    }
    var result: [String: JSON] = [:]
    var i = 0
    while i < n {
        guard let key = decodeAnyString(in: buffer, at: index + i) else {
            return nil
        }
        let value = JSON.create(from: buffer, index: index + i + 1)
        result[key] = value
        i += 2
    }
    return result
}

public final class JSONValue: JSON {
    let buffer: JSONBufferRef

    init(buffer: JSONBufferRef) {
        self.buffer = buffer
        super.init()
    }

    public required convenience init(from decoder: Decoder) throws {
        if let json = decoder as? JSONBufferDecoder {
            let other = json_buffer_copy_all(json.buffer)
            self.init(buffer: other)
        }
        throw JSONParseError.valueInvalid
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }

    deinit {
        json_buffer_free(buffer)
    }

    public override var exists: Bool {
        return json_buffer_is_null(buffer, 0)
    }

    public override var arrayValue: [JSON]? {
        return decodeAnyArray(in: buffer, at: 0)
    }

    public override var array: [JSON] {
        return decodeArray(in: buffer, at: 0)
    }

    public override var dictionaryValue: [String: JSON]? {
        return decodeAnyObject(in: buffer, at: 0)
    }

    public override var dictionary: [String: JSON] {
        return decodeObject(in: buffer, at: 0)
    }

    public override var boolValue: Bool? {
        let i = json_buffer_value_type(buffer, 0)
        switch i {
        case JSONType.true:
            return true
        case JSONType.false:
            return false
        default:
            return nil
        }
    }

    public override var bool: Bool {
        let i = json_buffer_value_type(buffer, 0)
        switch i {
        case JSONType.true:
            return true
        case JSONType.false:
            return false
        default:
            return false
        }
    }

    public override var stringValue: String? {
        if json_buffer_value_type(buffer, 0) != JSONType.string {
            return nil
        }
        return decodeString(in: buffer, at: 0)
    }

    public override var string: String {
        if json_buffer_value_type(buffer, 0) != JSONType.string {
            return ""
        }
        return decodeString(in: buffer, at: 0)
    }

    public override var doubleValue: Double? {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return Double(json_buffer_int32(buffer, 0))
        case JSONType.int64:
            return Double(json_buffer_int64(buffer, 0))
        case JSONType.uint:
            return Double(json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            return Double(json_buffer_uint64(buffer, 0))
        case JSONType.double:
            return json_buffer_double(buffer, 0)
        default:
            return nil
        }
    }

    public override var double: Double {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return Double(json_buffer_int32(buffer, 0))
        case JSONType.int64:
            return Double(json_buffer_int64(buffer, 0))
        case JSONType.uint:
            return Double(json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            return Double(json_buffer_uint64(buffer, 0))
        case JSONType.double:
            return json_buffer_double(buffer, 0)
        default:
            return 0
        }
    }

    public override var floatValue: Float? {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return Float(json_buffer_int32(buffer, 0))
        case JSONType.int64:
            return Float(json_buffer_int64(buffer, 0))
        case JSONType.uint:
            return Float(json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            return Float(json_buffer_uint64(buffer, 0))
        case JSONType.double:
            return Float(json_buffer_double(buffer, 0))
        default:
            return nil
        }
    }

    public override var float: Float {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return Float(json_buffer_int32(buffer, 0))
        case JSONType.int64:
            return Float(json_buffer_int64(buffer, 0))
        case JSONType.uint:
            return Float(json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            return Float(json_buffer_uint64(buffer, 0))
        case JSONType.double:
            return Float(json_buffer_double(buffer, 0))
        default:
            return 0
        }
    }

    public override var intValue: Int? {
#if arch(arm64) || arch(x86_64)
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return Int(json_buffer_int32(buffer, 0))
        case JSONType.int64:
            return Int(json_buffer_int64(buffer, 0))
        case JSONType.uint:
            return Int(exactly: json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            return Int(exactly: json_buffer_uint64(buffer, 0))
        case JSONType.double:
            return Int(exactly: json_buffer_double(buffer, 0))
        default:
            return nil
        }
#else
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return Int(json_buffer_int32(buffer, 0))
        case JSONType.uint:
            return Int(exactly: json_buffer_uint32(buffer, 0))
        case JSONType.double:
            return Int(exactly: json_buffer_double(buffer, 0))
        default:
            return nil
        }
#endif
    }

    public override var int: Int {
#if arch(arm64) || arch(x86_64)
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return Int(json_buffer_int32(buffer, 0))
        case JSONType.int64:
            return Int(json_buffer_int64(buffer, 0))
        case JSONType.uint:
            return Int(exactly: json_buffer_uint32(buffer, 0)) ?? 0
        case JSONType.uint64:
            return Int(exactly: json_buffer_uint64(buffer, 0)) ?? 0
        case JSONType.double:
            return Int(exactly: json_buffer_double(buffer, 0)) ?? 0
        default:
            return 0
        }
#else
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return Int(json_buffer_int32(buffer, 0))
        case JSONType.uint:
            return Int(exactly: json_buffer_uint32(buffer, 0)) ?? 0
        case JSONType.double:
            return Int(exactly: json_buffer_double(buffer, 0)) ?? 0
        default:
            return 0
        }
#endif
    }

    public override var int32Value: Int32? {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return json_buffer_int32(buffer, 0)
        case JSONType.uint:
            return Int32(exactly: json_buffer_uint32(buffer, 0))
        case JSONType.double:
            return Int32(exactly: json_buffer_double(buffer, 0))
        default:
            return nil
        }
    }

    public override var int32: Int32 {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return json_buffer_int32(buffer, 0)
        case JSONType.uint:
            return Int32(exactly: json_buffer_uint32(buffer, 0)) ?? 0
        case JSONType.double:
            return Int32(exactly: json_buffer_double(buffer, 0)) ?? 0
        default:
            return 0
        }
    }

    public override var int64Value: Int64? {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return Int64(json_buffer_int32(buffer, 0))
        case JSONType.int64:
            return json_buffer_int64(buffer, 0)
        case JSONType.uint:
            return Int64(json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            return Int64(exactly: json_buffer_uint64(buffer, 0))
        case JSONType.double:
            return Int64(exactly: json_buffer_double(buffer, 0))
        default:
            return nil
        }
    }

    public override var int64: Int64 {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return Int64(json_buffer_int32(buffer, 0))
        case JSONType.int64:
            return json_buffer_int64(buffer, 0)
        case JSONType.uint:
            return Int64(json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            return Int64(exactly: json_buffer_uint64(buffer, 0)) ?? 0
        case JSONType.double:
            return Int64(exactly: json_buffer_double(buffer, 0)) ?? 0
        default:
            return 0
        }
    }

    public override var uintValue: UInt? {
#if arch(arm64) || arch(x86_64)
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return UInt(exactly: json_buffer_int32(buffer, 0))
        case JSONType.int64:
            return UInt(exactly: json_buffer_int64(buffer, 0))
        case JSONType.uint:
            return UInt(json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            return UInt(json_buffer_uint64(buffer, 0))
        case JSONType.double:
            return UInt(exactly: json_buffer_double(buffer, 0))
        default:
            return nil
        }
#else
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return UInt(exactly: json_buffer_int32(buffer, 0))
        case JSONType.uint:
            return UInt(json_buffer_uint32(buffer, 0))
        case JSONType.double:
            return UInt(exactly: json_buffer_double(buffer, 0))
        default:
            return nil
        }
#endif
    }

    public override var uint: UInt {
#if arch(arm64) || arch(x86_64)
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return UInt(exactly: json_buffer_int32(buffer, 0)) ?? 0
        case JSONType.int64:
            return UInt(exactly: json_buffer_int64(buffer, 0)) ?? 0
        case JSONType.uint:
            return UInt(json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            return UInt(json_buffer_uint64(buffer, 0))
        case JSONType.double:
            return UInt(exactly: json_buffer_double(buffer, 0)) ?? 0
        default:
            return 0
        }
#else
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return UInt(exactly: json_buffer_int32(buffer, 0)) ?? 0
        case JSONType.uint:
            return UInt(json_buffer_uint32(buffer, 0))
        case JSONType.double:
            return UInt(exactly: json_buffer_double(buffer, 0)) ?? 0
        default:
            return 0
        }
#endif
    }

    public override var uint32Value: UInt32? {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return UInt32(exactly: json_buffer_int32(buffer, 0))
        case JSONType.uint:
            return json_buffer_uint32(buffer, 0)
        case JSONType.double:
            return UInt32(exactly: json_buffer_double(buffer, 0))
        default:
            return nil
        }
    }

    public override var uint32: UInt32 {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return UInt32(exactly: json_buffer_int32(buffer, 0)) ?? 0
        case JSONType.uint:
            return json_buffer_uint32(buffer, 0)
        case JSONType.double:
            return UInt32(exactly: json_buffer_double(buffer, 0)) ?? 0
        default:
            return 0
        }
    }

    public override var uint64Value: UInt64? {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return UInt64(exactly: json_buffer_int32(buffer, 0))
        case JSONType.int64:
            return UInt64(exactly: json_buffer_int64(buffer, 0))
        case JSONType.uint:
            return UInt64(json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            return json_buffer_uint64(buffer, 0)
        case JSONType.double:
            return UInt64(exactly: json_buffer_double(buffer, 0))
        default:
            return nil
        }
    }

    public override var uint64: UInt64 {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.int:
            return UInt64(exactly: json_buffer_int32(buffer, 0)) ?? 0
        case JSONType.int64:
            return UInt64(exactly: json_buffer_int64(buffer, 0)) ?? 0
        case JSONType.uint:
            return UInt64(json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            return json_buffer_uint64(buffer, 0)
        case JSONType.double:
            return UInt64(exactly: json_buffer_double(buffer, 0)) ?? 0
        default:
            return 0
        }
    }

    public override func accept(visitor: JSONVisitor) {
        switch json_buffer_value_type(buffer, 0) {
        case JSONType.true:
            visitor.visit(bool: true)
        case JSONType.false:
            visitor.visit(bool: false)
        case JSONType.int:
            visitor.visit(int: json_buffer_int32(buffer, 0))
        case JSONType.int64:
            visitor.visit(int64: json_buffer_int64(buffer, 0))
        case JSONType.uint:
            visitor.visit(uint: json_buffer_uint32(buffer, 0))
        case JSONType.uint64:
            visitor.visit(uint64: json_buffer_uint64(buffer, 0))
        case JSONType.double:
            visitor.visit(double: json_buffer_double(buffer, 0))
        case JSONType.string:
            visitor.visit(string: decodeString(in: buffer, at: 0))
        default:
            break
        }
    }
}

public final class JSONNull: JSON {
    override init() {
        super.init()
    }

    public required convenience init(from decoder: Decoder) throws {
        throw JSONParseError.valueInvalid
    }

    public override var raw: Any {
        return NSNull()
    }

    public override var exists: Bool {
        return false
    }

    public override var description: String {
        return "<JSON: null>"
    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(null: self)
    }

    override func equals(other: JSON) -> Bool {
        return self === JSON.null
    }

    override func less(other: JSON) -> Bool {
        return true
    }

    override func greater(other: JSON) -> Bool {
        return false
    }
}

public final class JSONObject: JSON {
    let buffer: JSONBufferRef

    init(buffer: JSONBufferRef) {
        self.buffer = buffer
        super.init()
    }

    public override init() {
        buffer = json_buffer_create(12, 256)
        super.init()
    }

    public required convenience init(from decoder: Decoder) throws {
        if let json = decoder as? JSONBufferDecoder {
            let other = json_buffer_copy_all(json.buffer)
            self.init(buffer: other)
        }
        throw JSONParseError.valueInvalid
    }

    deinit {
        json_buffer_free(buffer)
    }

    public var isEmpty: Bool {
        return json_buffer_is_empty(buffer)
    }

//    public override var raw: Any {
//        return value
//    }

    public override var exists: Bool {
        return json_buffer_is_null(buffer, 0)
    }

    public override var dictionaryValue: [String: JSON]? {
        return decodeAnyObject(in: buffer, at: 0)
    }

    public override var dictionary: [String: JSON] {
        return decodeObject(in: buffer, at: 0)
    }

//    public override var description: String {
//        return "<JSON: \(value)>"
//    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(dictionary: self)
    }

//    @discardableResult
//    public func append(key: String, _ element: JSON) -> JSONObject {
//        value[key] = element
//        return self
//    }
//
//    @discardableResult
//    public func append(key: String, array element: [JSON]) -> JSONObject {
//        return append(key: key, JSONArray(element))
//    }
//
//    @discardableResult
//    public func append(key: String, array element: JSONArray) -> JSONObject {
//        return append(key: key, element)
//    }
//
//    @discardableResult
//    public func append(key: String, dictionary element: [String: JSON]) -> JSONObject {
//        return append(key: key, JSONObject(element))
//    }
//
//    @discardableResult
//    public func append(key: String, dictionary element: [String: Any], nullable: Bool) -> JSONObject {
//        if nullable {
//            let json = JSON.create(from: element, nullable: nullable) ?? JSON.null
//            return append(key: key, json)
//        } else {
//            if let json = JSON.create(from: element, nullable: nullable) {
//                return append(key: key, json)
//            }
//            return self
//        }
//    }
//
//    @discardableResult
//    public func append(key: String, dictionary element: JSONObject) -> JSONObject {
//        return append(key: key, element)
//    }
//
//    @discardableResult
//    public func append(key: String, bool element: Bool) -> JSONObject {
//        return append(key: key, JSONBool(element))
//    }
//
//    @discardableResult
//    public func append(key: String, string element: String) -> JSONObject {
//        return append(key: key, JSONString(element))
//    }
//
//    @discardableResult
//    public func append(key: String, double element: Double) -> JSONObject {
//        return append(key: key, JSONDouble(element))
//    }
//
//    @discardableResult
//    public func append(key: String, float element: Float) -> JSONObject {
//        return append(key: key, JSONDouble(Double(element)))
//    }
//
//    @discardableResult
//    public func append(key: String, int element: Int) -> JSONObject {
//        return append(key: key, JSONInt64(Int64(element)))
//    }
//
//    @discardableResult
//    public func append(key: String, int32 element: Int32) -> JSONObject {
//        return append(key: key, JSONInt(element))
//    }
//
//    @discardableResult
//    public func append(key: String, int64 element: Int64) -> JSONObject {
//        return append(key: key, JSONInt64(element))
//    }
//
//    @discardableResult
//    public func append(key: String, uint element: UInt) -> JSONObject {
//        return append(key: key, JSONUInt64(UInt64(element)))
//    }
//
//    @discardableResult
//    public func append(key: String, uint32 element: UInt32) -> JSONObject {
//        return append(key: key, JSONUInt(element))
//    }
//
//    @discardableResult
//    public func append(key: String, uint64 element: UInt64) -> JSONObject {
//        return append(key: key, JSONUInt64(element))
//    }

//    override func equals(other: JSON) -> Bool {
//        if let element = other as? JSONObject {
//            return value == element.value
//        }
//        return super.equals(other: other)
//    }
//
//    override func less(other: JSON) -> Bool {
//        if let element = other as? JSONObject {
//            return value.count < element.value.count
//        }
//        return super.less(other: other)
//    }
//
//    override func greater(other: JSON) -> Bool {
//        if let element = other as? JSONObject {
//            return value.count > element.value.count
//        }
//        return super.greater(other: other)
//    }

//    public override subscript(typed key: String) -> JSON {
//        var index = 0
//        if json_buffer_key_index_check(buffer, 0, key, &index) {
//            return JSON.null
//        }
//        return JSON.create(from: buffer, index: index + 1)
//    }
}

public final class JSONArray: JSON {
    let buffer: JSONBufferRef

    init(buffer: JSONBufferRef) {
        self.buffer = buffer
        super.init()
    }

    public override init() {
        buffer = json_buffer_create(12, 256)
        super.init()
    }

    public required convenience init(from decoder: Decoder) throws {
        if let json = decoder as? JSONBufferDecoder {
            let other = json_buffer_copy_all(json.buffer)
            self.init(buffer: other)
        }
        throw JSONParseError.valueInvalid
    }

    deinit {
        json_buffer_free(buffer)
    }

    public var isEmpty: Bool {
        return json_buffer_is_empty(buffer)
    }

//    public override var raw: Any {
//        return value
//    }

    public override var exists: Bool {
        return json_buffer_is_null(buffer, 0)
    }

    public override var arrayValue: [JSON]? {
        return decodeAnyArray(in: buffer, at: 0)
    }

    public override var array: [JSON] {
        return decodeArray(in: buffer, at: 0)
    }

//    public override var description: String {
//        return "<JSON: \(value)>"
//    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(array: self)
    }

//    @discardableResult
//    public func append(_ element: JSON) -> JSONArray {
//        value.append(element)
//        return self
//    }
//
//    @discardableResult
//    public func append(array element: [JSON]) -> JSONArray {
//        return append(JSONArray(element))
//    }
//
//    @discardableResult
//    public func append(array element: JSONArray) -> JSONArray {
//        return append(element)
//    }
//
//    @discardableResult
//    public func append(dictionary element: [String: JSON]) -> JSONArray {
//        return append(JSONObject(element))
//    }
//
//    @discardableResult
//    public func append(dictionary element: JSONObject) -> JSONArray {
//        return append(element)
//    }
//
//    @discardableResult
//    public func append(bool element: Bool) -> JSONArray {
//        return append(JSONBool(element))
//    }
//
//    @discardableResult
//    public func append(string element: String) -> JSONArray {
//        return append(JSONString(element))
//    }
//
//    @discardableResult
//    public func append(double element: Double) -> JSONArray {
//        return append(JSONDouble(element))
//    }
//
//    @discardableResult
//    public func append(float element: Float) -> JSONArray {
//        return append(JSONDouble(Double(element)))
//    }
//
//    @discardableResult
//    public func append(int element: Int) -> JSONArray {
//        return append(JSONInt64(Int64(element)))
//    }
//
//    @discardableResult
//    public func append(int32 element: Int32) -> JSONArray {
//        return append(JSONInt(element))
//    }
//
//    @discardableResult
//    public func append(int64 element: Int64) -> JSONArray {
//        return append(JSONInt64(element))
//    }
//
//    @discardableResult
//    public func append(uint element: UInt) -> JSONArray {
//        return append(JSONUInt64(UInt64(element)))
//    }
//
//    @discardableResult
//    public func append(uint32 element: UInt32) -> JSONArray {
//        return append(JSONUInt(element))
//    }
//
//    @discardableResult
//    public func append(uint64 element: UInt64) -> JSONArray {
//        return append(JSONUInt64(element))
//    }

//    override func equals(other: JSON) -> Bool {
//        if let element = other as? JSONArray {
//            return value == element.value
//        }
//        return super.equals(other: other)
//    }
//
//    override func less(other: JSON) -> Bool {
//        if let element = other as? JSONArray {
//            return value.count < element.value.count
//        }
//        return super.less(other: other)
//    }
//
//    override func greater(other: JSON) -> Bool {
//        if let element = other as? JSONArray {
//            return value.count > element.value.count
//        }
//        return super.greater(other: other)
//    }

//    public override subscript(typed index: Int) -> JSON {
//        return JSON.create(from: buffer, index: index)
//    }
}
