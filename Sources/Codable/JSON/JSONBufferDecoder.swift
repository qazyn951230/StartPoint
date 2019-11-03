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

//internal func decodeString(in buffer: JSONBufferRef, at index: Int) -> String {
//    if json_buffer_value_type(buffer, index) != JSONType.string {
//        return ""
//    }
//    var count = 0
//    let bytes = json_buffer_string(buffer, index, &count)
//    if count > 0 {
//        let data = Data(bytesNoCopy: bytes, count: count, deallocator: .none)
//        return String(data: data, encoding: .utf8) ?? ""
//    }
//    return ""
//}
//
//internal func decodeAnyString(in buffer: JSONBufferRef, at index: Int) -> String? {
//    if json_buffer_value_type(buffer, index) != JSONType.string {
//        return nil
//    }
//    var count = 0
//    let bytes = json_buffer_string(buffer, index, &count)
//    if count > 0 {
//        let data = Data(bytesNoCopy: bytes, count: count, deallocator: .none)
//        return String(data: data, encoding: .utf8)
//    }
//    return nil
//}
//
//@inline(__always)
//private func typeMismatch(_ expectation: Any.Type, not reality: Any.Type,
//                          in decoder: JSONBufferDecoder) -> DecodingError {
//    return DecodingError.typeMismatch(expectation,
//        DecodingError.Context(codingPath: decoder.codingPath,
//            debugDescription: "Expected to decode \(expectation) but found \(reality) instead."))
//}
//
//@inline(__always)
//private func findKey(_ key: String, in buffer: JSONBufferRef, index: Int) -> Int? {
//    return key.withCString { (pointer: UnsafePointer<Int8>) -> Int? in
//        var result = 0
//        if json_buffer_key_index_check(buffer, index, pointer, &result) {
//            return result
//        }
//        return nil
//    }
//}
//
//@inline(__always)
//private func findIndex(keyPath: [CodingKey], in buffer: JSONBufferRef, index base: Int) throws -> Int {
//    var index = base
//    var i = 0
//    let n = keyPath.count - 1
//    for key in keyPath {
//        switch json_buffer_value_type(buffer, index) {
//        case JSONType.array:
//            if let t = key.intValue {
//                index += t + 1
//            } else {
//                throw JSONParseError.valueInvalid
//            }
//        case JSONType.object:
//            if let t = findKey(key.stringValue, in: buffer, index: index) {
//                index = t + 1
//            } else {
//                throw JSONParseError.valueInvalid
//            }
//        default:
//            if i != n {
//                throw JSONParseError.valueInvalid
//            }
//        }
//        i += 1
//    }
//    return index
//}
//
//final class JSONBufferDecoder: KeyPathDecoder {
//    var codingPath: [CodingKey]
//    var userInfo: [CodingUserInfoKey: Any]
//    let buffer: JSONBufferRef
//    let index: Int
//
//    init(buffer: JSONBufferRef, index: Int = 0) {
//        self.buffer = buffer
//        self.index = index
//        codingPath = []
//        userInfo = [:]
//    }
//
//    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
//        return try container(keyedBy: type, index: index)
//    }
//
//    func container<Key>(keyedBy type: Key.Type, keyPath: [CodingKey]) throws
//        -> KeyedDecodingContainer<Key> where Key : CodingKey {
//        let temp = try findIndex(keyPath: keyPath, in: buffer, index: index)
//        if json_buffer_value_type(buffer, temp) != JSONType.object {
//            throw JSONParseError.valueInvalid
//        }
//        return try container(keyedBy: type, index: temp)
//    }
//
//    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
//        return try unkeyedContainer(index: index)
//    }
//
//    func unkeyedContainer(keyPath: [CodingKey]) throws -> UnkeyedDecodingContainer {
//        let temp = try findIndex(keyPath: keyPath, in: buffer, index: index)
//        if json_buffer_value_type(buffer, temp) != JSONType.array {
//            throw JSONParseError.valueInvalid
//        }
//        return try unkeyedContainer(index: temp)
//    }
//
//    func singleValueContainer() throws -> SingleValueDecodingContainer {
//        return try singleValueContainer(index: index)
//    }
//
//    func singleValueContainer(keyPath: [CodingKey]) throws -> SingleValueDecodingContainer {
//        let temp = try findIndex(keyPath: keyPath, in: buffer, index: index)
//        let type = json_buffer_value_type(buffer, temp)
//        if type == JSONType.object || type == JSONType.array {
//            throw JSONParseError.valueInvalid
//        }
//        return try singleValueContainer(index: temp)
//    }
//
//    func decodeNil(index: Int) -> Bool {
//        return json_buffer_is_null(buffer, index)
//    }
//
//    func decode(_ type: Bool.Type, index: Int) throws -> Bool {
//        return json_buffer_bool(buffer, index)
//    }
//
//    func decode(_ type: String.Type, index: Int) throws -> String {
//        return decodeString(in: buffer, at: index)
//    }
//
//    func decode(_ type: Double.Type, index: Int) throws -> Double {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return Double(value)
//        case JSONType.int64:
//            let value: Int64 = number.int64
//            return Double(value)
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return Double(value)
//        case JSONType.uint64:
//            let value: UInt64 = number.uint64
//            return Double(value)
//        case JSONType.double:
//            let value: Double = number.floating
//            return value
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode(_ type: Float.Type, index: Int) throws -> Float {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return Float(value)
//        case JSONType.int64:
//            let value: Int64 = number.int64
//            return Float(value)
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return Float(value)
//        case JSONType.uint64:
//            let value: UInt64 = number.uint64
//            return Float(value)
//        case JSONType.double:
//            let value: Double = number.floating
//            return Float(value)
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode(_ type: Int.Type, index: Int) throws -> Int {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return Int(value)
//        case JSONType.int64:
//            let value: Int64 = number.int64
//            return Int(value)
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return Int(value)
//        case JSONType.uint64:
//            let value: UInt64 = number.uint64
//            return Int(value)
//        case JSONType.double:
//            let value: Double = number.floating
//            return Int(value)
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode(_ type: Int8.Type, index: Int) throws -> Int8 {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return Int8(value)
//        case JSONType.int64:
//            throw typeMismatch(Int64.self, not: Int8.self, in: self)
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return Int8(value)
//        case JSONType.uint64:
//            throw JSONParseError.valueInvalid
//        case JSONType.double:
//            let value: Double = number.floating
//            return Int8(value)
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode(_ type: Int16.Type, index: Int) throws -> Int16 {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return Int16(value)
//        case JSONType.int64:
//            let value: Int64 = number.int64
//            return Int16(value)
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return Int16(value)
//        case JSONType.uint64:
//            let value: UInt64 = number.uint64
//            return Int16(value)
//        case JSONType.double:
//            let value: Double = number.floating
//            return Int16(value)
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode(_ type: Int32.Type, index: Int) throws -> Int32 {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return value
//        case JSONType.int64:
//            throw JSONParseError.valueInvalid
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return Int32(value)
//        case JSONType.uint64:
//            throw JSONParseError.valueInvalid
//        case JSONType.double:
//            let value: Double = number.floating
//            return Int32(value)
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode(_ type: Int64.Type, index: Int) throws -> Int64 {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return Int64(value)
//        case JSONType.int64:
//            let value: Int64 = number.int64
//            return value
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return Int64(value)
//        case JSONType.uint64:
//            let value: UInt64 = number.uint64
//            return Int64(value)
//        case JSONType.double:
//            let value: Double = number.floating
//            return Int64(value)
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode(_ type: UInt.Type, index: Int) throws -> UInt {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return UInt(value)
//        case JSONType.int64:
//            let value: Int64 = number.int64
//            return UInt(value)
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return UInt(value)
//        case JSONType.uint64:
//            let value: UInt64 = number.uint64
//            return UInt(value)
//        case JSONType.double:
//            let value: Double = number.floating
//            return UInt(value)
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode(_ type: UInt8.Type, index: Int) throws -> UInt8 {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return UInt8(value)
//        case JSONType.int64:
//            let value: Int64 = number.int64
//            return UInt8(value)
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return UInt8(value)
//        case JSONType.uint64:
//            let value: UInt64 = number.uint64
//            return UInt8(value)
//        case JSONType.double:
//            let value: Double = number.floating
//            return UInt8(value)
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode(_ type: UInt16.Type, index: Int) throws -> UInt16 {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return UInt16(value)
//        case JSONType.int64:
//            let value: Int64 = number.int64
//            return UInt16(value)
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return UInt16(value)
//        case JSONType.uint64:
//            let value: UInt64 = number.uint64
//            return UInt16(value)
//        case JSONType.double:
//            let value: Double = number.floating
//            return UInt16(value)
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode(_ type: UInt32.Type, index: Int) throws -> UInt32 {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return UInt32(value)
//        case JSONType.int64:
//            let value: Int64 = number.int64
//            return UInt32(value)
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return value
//        case JSONType.uint64:
//            let value: UInt64 = number.uint64
//            return UInt32(value)
//        case JSONType.double:
//            let value: Double = number.floating
//            return UInt32(value)
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode(_ type: UInt64.Type, index: Int) throws -> UInt64 {
//        let raw = json_buffer_index(buffer, index)
//        let number = raw.value
//        switch raw.type {
//        case JSONType.int:
//            let value: Int32 = number.i.int32
//            return UInt64(value)
//        case JSONType.int64:
//            let value: Int64 = number.int64
//            return UInt64(value)
//        case JSONType.uint:
//            let value: UInt32 = number.u.uint32
//            return UInt64(value)
//        case JSONType.uint64:
//            let value: UInt64 = number.uint64
//            return value
//        case JSONType.double:
//            let value: Double = number.floating
//            return UInt64(value)
//        default:
//            throw JSONParseError.valueInvalid
//        }
//    }
//
//    func decode<T>(_ type: T.Type, index: Int) throws -> T where T: Decodable {
//        let decoder = JSONBufferDecoder(buffer: buffer, index: index)
//        return try T.init(from: decoder)
//    }
//
//    func container<Key>(keyedBy type: Key.Type, index: Int) throws
//            -> KeyedDecodingContainer<Key> where Key: CodingKey {
//        let raw = json_buffer_object(buffer, index)
//        let object = JSONObjectContainer<Key>(decoder: self, object: raw)
//        json_object_free(raw)
//        return KeyedDecodingContainer<Key>(object)
//    }
//
//    func unkeyedContainer(index: Int) throws -> UnkeyedDecodingContainer {
//        let raw = json_buffer_array(buffer, index)
//        let array = JSONArrayContainer(decoder: self, array: raw)
//        json_array_free(raw)
//        return array
//    }
//
//    func singleValueContainer(index: Int) throws -> SingleValueDecodingContainer {
//        return JSONContainer(decoder: self, index: index)
//    }
//}
//
//final class JSONContainer: SingleValueDecodingContainer {
//    let decoder: JSONBufferDecoder
//    let index: Int
//
//    var codingPath: [CodingKey] {
//        return decoder.codingPath
//    }
//
//    init(decoder: JSONBufferDecoder, index: Int) {
//        self.decoder = decoder
//        self.index = index
//    }
//
//    func decodeNil() -> Bool {
//        return decoder.decodeNil(index: index)
//    }
//
//    func decode(_ type: Bool.Type) throws -> Bool {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: String.Type) throws -> String {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Double.Type) throws -> Double {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Float.Type) throws -> Float {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int.Type) throws -> Int {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int8.Type) throws -> Int8 {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int16.Type) throws -> Int16 {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int32.Type) throws -> Int32 {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int64.Type) throws -> Int64 {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt.Type) throws -> UInt {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt8.Type) throws -> UInt8 {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt16.Type) throws -> UInt16 {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt32.Type) throws -> UInt32 {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt64.Type) throws -> UInt64 {
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
//        return try decoder.decode(type, index: index)
//    }
//}
//
//final class JSONArrayContainer: UnkeyedDecodingContainer {
//    let decoder: JSONBufferDecoder
//    private var firstIndex: Int
//    private let _count: Int
//    private var _index: Int
//
//    init(decoder: JSONBufferDecoder, array: JSONArrayRef) {
//        self.decoder = decoder
//        firstIndex = json_array_index(array) + 1
//        _index = firstIndex
//        _count = json_array_count(array)
//    }
//
//    var codingPath: [CodingKey] {
//        return decoder.codingPath
//    }
//
//    var count: Int? {
//        return _count
//    }
//
//    var isAtEnd: Bool {
//        return (_index - firstIndex) == _count
//    }
//
//    var currentIndex: Int {
//        return _index - firstIndex
//    }
//
//    private func move() throws -> Int {
//        let current = _index
//        if (_index - firstIndex) >= _count {
//            throw JSONParseError.valueInvalid
//        }
//        _index += 1
//        return current
//    }
//
//    func decodeNil() throws -> Bool {
//        let index = try move()
//        return decoder.decodeNil(index: index)
//    }
//
//    func decode(_ type: Bool.Type) throws -> Bool {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: String.Type) throws -> String {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Double.Type) throws -> Double {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Float.Type) throws -> Float {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int.Type) throws -> Int {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int8.Type) throws -> Int8 {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int16.Type) throws -> Int16 {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int32.Type) throws -> Int32 {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int64.Type) throws -> Int64 {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt.Type) throws -> UInt {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt8.Type) throws -> UInt8 {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt16.Type) throws -> UInt16 {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt32.Type) throws -> UInt32 {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt64.Type) throws -> UInt64 {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
//        let index = try move()
//        return try decoder.decode(type, index: index)
//    }
//
//    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws
//            -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
//        let index = try move()
//        return try decoder.container(keyedBy: type, index: index)
//    }
//
//    func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
//        let index = try move()
//        return try decoder.unkeyedContainer(index: index)
//    }
//
//    func superDecoder() throws -> Decoder {
//        return decoder
//    }
//}
//
//final class JSONObjectContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
//    private(set) var codingPath: [CodingKey] = []
//    private(set) var allKeys: [Key] = []
//
//    let decoder: JSONBufferDecoder
//    private var index: Int
//
//    init(decoder: JSONBufferDecoder, object: JSONObjectRef) {
//        self.decoder = decoder
//        index = json_object_index(object)
//    }
//
//    private func findIndex(key: Key) throws -> Int {
//        if let int = key.intValue {
//            let result = index + int
//            let raw = json_buffer_value_type(decoder.buffer, result)
//            if raw != JSONType.object {
//                throw JSONParseError.valueInvalid
//            }
//            return result
//        } else {
//            let result = key.stringValue.withCString { (pointer: UnsafePointer<Int8>) -> Int? in
//                var result = 0
//                if json_buffer_key_index_check(decoder.buffer, index, pointer, &result) {
//                    return result
//                }
//                return nil
//            }
//            if let number = result {
//                return number
//            } else {
//                throw JSONParseError.valueInvalid
//            }
//        }
//    }
//
//    func contains(_ key: Key) -> Bool {
//        let index = try? findIndex(key: key)
//        return index != nil
//    }
//
//    func decodeNil(forKey key: Key) throws -> Bool {
//        let index = try findIndex(key: key)
//        return decoder.decodeNil(index: index)
//    }
//
//    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: String.Type, forKey key: Key) throws -> String {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
//        let index = try findIndex(key: key)
//        return try decoder.decode(type, index: index)
//    }
//
//    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws
//            -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
//        let index = try findIndex(key: key)
//        return try decoder.container(keyedBy: type, index: index)
//    }
//
//    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
//        let index = try findIndex(key: key)
//        return try decoder.unkeyedContainer(index: index)
//    }
//
//    func superDecoder() throws -> Decoder {
//        return decoder
//    }
//
//    func superDecoder(forKey key: Key) throws -> Decoder {
//        let index = try findIndex(key: key)
//        return JSONBufferDecoder(buffer: decoder.buffer, index: index)
//    }
//}
