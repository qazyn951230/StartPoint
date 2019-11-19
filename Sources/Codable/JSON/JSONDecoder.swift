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

// Same API with JSONDecoder
public final class StartJSONDecoder {
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    public var keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.useDefaultKeys
    public var dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.deferredToDate
    public var dataDecodingStrategy = JSONDecoder.DataDecodingStrategy.base64
    public var nonConformingFloatDecodingStrategy = JSONDecoder.NonConformingFloatDecodingStrategy.throw

    public init() {
        // Do nothing.
    }

    public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        do {
            let json = try JSON.tryParse(data: data)
            let options = SJDecoderOptions(buffer: json.buffer, userInfo: userInfo,
                keyDecodingStrategy: keyDecodingStrategy,
                dateDecodingStrategy: dateDecodingStrategy,
                dataDecodingStrategy: dataDecodingStrategy,
                nonConformingFloatDecodingStrategy: nonConformingFloatDecodingStrategy)
            let decoder = SJDecoder(value: json.ref, options: options, codingPath: [])
            return try T.init(from: decoder)
        } catch let error {
            let context = DecodingError.Context(codingPath: [],
                debugDescription: SJDecoder.jsonParseError(error), underlyingError: error)
            throw DecodingError.dataCorrupted(context)
        }
    }
}

class SJDecoderOptions {
    let buffer: JSONBuffer
    let userInfo: [CodingUserInfoKey : Any]
    let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    let dataDecodingStrategy: JSONDecoder.DataDecodingStrategy
    let nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy

    init(buffer: JSONBuffer, userInfo: [CodingUserInfoKey: Any],
         keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
         dateDecodingStrategy: JSONDecoder.DateDecodingStrategy,
         dataDecodingStrategy: JSONDecoder.DataDecodingStrategy,
         nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy) {
        self.buffer = buffer
        self.userInfo = userInfo
        self.keyDecodingStrategy = keyDecodingStrategy
        self.dateDecodingStrategy = dateDecodingStrategy
        self.dataDecodingStrategy = dataDecodingStrategy
        self.nonConformingFloatDecodingStrategy = nonConformingFloatDecodingStrategy
    }

    func decodeKey<Key>(_ key: Key, codingPath: [CodingKey] = []) -> String where Key: CodingKey {
        switch keyDecodingStrategy {
        case .useDefaultKeys:
            return key.stringValue
        case .convertFromSnakeCase:
            return key.stringValue
        case let .custom(method):
            var path = codingPath
            path.append(key)
            return method(path).stringValue
        @unknown default:
            return key.stringValue
        }
    }
}

struct SJDecoder: Decoder {
    let codingPath: [CodingKey]
    let value: JSONRef
    let options: SJDecoderOptions

    var userInfo: [CodingUserInfoKey : Any] {
        options.userInfo
    }

    init(value: JSONRef, options: SJDecoderOptions, codingPath: [CodingKey]) {
        self.value = value
        self.options = options
        self.codingPath = codingPath
    }

    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        let next = try SJDKeyedContainer<Key>(decoder: self)
        return KeyedDecodingContainer(next)
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        try SJDUnkeyedContainer(decoder: self)
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        try SJDSingleContainer(decoder: self)
    }

    @inline(__always)
    static func jsonParseError(_ error: Error) -> String {
        "jsonParseError"
    }

    @inline(__always)
    static func typeMismatchDescription(_ value: JSONRef) -> String {
        "typeMismatchDescription"
    }

    @inline(__always)
    static func valueIsNotSingleContainer(_ value: JSONRef) -> String {
        "valueIsNotSingleContainer"
    }

    @inline(__always)
    static func valueOutOfIndex() -> String {
        "valueOutOfIndex"
    }

    @inline(__always)
    static func valueIsNotUnkeyedContainer(_ value: JSONRef) -> String {
        "valueIsNotUnkeyedContainer"
    }

    @inline(__always)
    static func keyNotFound() -> String {
        "keyNotFound"
    }

    @inline(__always)
    static func valueIsNotKeyedContainer(_ value: JSONRef) -> String {
        "valueIsNotKeyedContainer"
    }

    @inline(__always)
    static func decodeNil(_ value: JSONRef) -> Bool {
        json_is_null(value)
    }

    @inline(__always)
    static func decodeBool(_ value: JSONRef, codingPath: [CodingKey]) throws -> Bool {
        var result = false
        if json_get_bool(value, &result) {
            return result
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(Bool.self, context)
        }
    }

    @inline(__always)
    static func decodeString(_ value: JSONRef, codingPath: [CodingKey]) throws -> String {
        if let result = JSON.decodeString(ref: value) {
            return result
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(String.self, context)
        }
    }

    @inline(__always)
    static func decodeDouble(_ value: JSONRef, codingPath: [CodingKey]) throws -> Double {
        var result: Double = 0
        if json_get_double(value, &result) {
            return result
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(Double.self, context)
        }
    }

    @inline(__always)
    static func decodeFloat(_ value: JSONRef, codingPath: [CodingKey]) throws -> Float {
        var result: Float = 0
        if json_get_float(value, &result) {
            return result
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(Float.self, context)
        }
    }

    @inline(__always)
    static func decodeInt(_ value: JSONRef, codingPath: [CodingKey]) throws -> Int {
#if arch(arm64) || arch(x86_64)
        var result: Int64 = 0
        if json_get_int64(value, &result) {
            return Int(result)
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(Int.self, context)
        }
#else
        var result: Int32 = 0
        if json_get_int32(value, &result) {
            return Int(result)
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(Int.self, context)
        }
#endif
    }

    @inline(__always)
    static func decodeInt8(_ value: JSONRef, codingPath: [CodingKey]) throws -> Int8 {
        var result: Int32 = 0
        if json_get_int32(value, &result), let next = Int8(exactly: result) {
            return next
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(Int8.self, context)
        }
    }

    @inline(__always)
    static func decodeInt16(_ value: JSONRef, codingPath: [CodingKey]) throws -> Int16 {
        var result: Int32 = 0
        if json_get_int32(value, &result), let next = Int16(exactly: result) {
            return next
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(Int16.self, context)
        }
    }

    @inline(__always)
    static func decodeInt32(_ value: JSONRef, codingPath: [CodingKey]) throws -> Int32 {
        var result: Int32 = 0
        if json_get_int32(value, &result) {
            return result
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(Int32.self, context)
        }
    }

    @inline(__always)
    static func decodeInt64(_ value: JSONRef, codingPath: [CodingKey]) throws -> Int64 {
        var result: Int64 = 0
        if json_get_int64(value, &result) {
            return result
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(Int64.self, context)
        }
    }

    @inline(__always)
    static func decodeUInt(_ value: JSONRef, codingPath: [CodingKey]) throws -> UInt {
#if arch(arm64) || arch(x86_64)
        var result: UInt64 = 0
        if json_get_uint64(value, &result) {
            return UInt(result)
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(UInt.self, context)
        }
#else
        var result: UInt32 = 0
        if json_get_uint32(value, &result) {
            return UInt(result)
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(UInt.self, context)
        }
#endif
    }

    @inline(__always)
    static func decodeUInt8(_ value: JSONRef, codingPath: [CodingKey]) throws -> UInt8 {
        var result: UInt32 = 0
        if json_get_uint32(value, &result), let next = UInt8(exactly: result) {
            return next
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(UInt8.self, context)
        }
    }

    @inline(__always)
    static func decodeUInt16(_ value: JSONRef, codingPath: [CodingKey]) throws -> UInt16 {
        var result: UInt32 = 0
        if json_get_uint32(value, &result), let next = UInt16(exactly: result) {
            return next
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(UInt16.self, context)
        }
    }

    @inline(__always)
    static func decodeUInt32(_ value: JSONRef, codingPath: [CodingKey]) throws -> UInt32 {
        var result: UInt32 = 0
        if json_get_uint32(value, &result) {
            return result
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(UInt32.self, context)
        }
    }

    @inline(__always)
    static func decodeUInt64(_ value: JSONRef, codingPath: [CodingKey]) throws -> UInt64 {
        var result: UInt64 = 0
        if json_get_uint64(value, &result) {
            return result
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.typeMismatchDescription(value))
            throw DecodingError.typeMismatch(UInt64.self, context)
        }
    }
}

struct SJDSingleContainer: SingleValueDecodingContainer {
    let value: JSONRef
    let decoder: SJDecoder

    var codingPath: [CodingKey] {
        decoder.codingPath
    }

    init(decoder: SJDecoder) throws {
        if json_is_array(decoder.value) || json_is_object(decoder.value) {
            let context = DecodingError.Context(codingPath: decoder.codingPath,
                debugDescription: SJDecoder.valueIsNotSingleContainer(decoder.value))
            throw DecodingError.dataCorrupted(context)
        }
        self.value = decoder.value
        self.decoder = decoder
    }

    func decodeNil() -> Bool {
        SJDecoder.decodeNil(value)
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        try SJDecoder.decodeBool(value, codingPath: codingPath)
    }

    func decode(_ type: String.Type) throws -> String {
        try SJDecoder.decodeString(value, codingPath: codingPath)
    }

    func decode(_ type: Double.Type) throws -> Double {
        try SJDecoder.decodeDouble(value, codingPath: codingPath)
    }

    func decode(_ type: Float.Type) throws -> Float {
        try SJDecoder.decodeFloat(value, codingPath: codingPath)
    }

    func decode(_ type: Int.Type) throws -> Int {
        try SJDecoder.decodeInt(value, codingPath: codingPath)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        try SJDecoder.decodeInt8(value, codingPath: codingPath)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        try SJDecoder.decodeInt16(value, codingPath: codingPath)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        try SJDecoder.decodeInt32(value, codingPath: codingPath)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        try SJDecoder.decodeInt64(value, codingPath: codingPath)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        try SJDecoder.decodeUInt(value, codingPath: codingPath)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try SJDecoder.decodeUInt8(value, codingPath: codingPath)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try SJDecoder.decodeUInt16(value, codingPath: codingPath)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try SJDecoder.decodeUInt32(value, codingPath: codingPath)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try SJDecoder.decodeUInt64(value, codingPath: codingPath)
    }

    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        try T.init(from: decoder)
    }
}

struct SJDUnkeyedContainer: UnkeyedDecodingContainer {
    let value: JSONRef
    let decoder: SJDecoder
    private let _count: UInt32
    private var _current: UInt32 = 0

    var codingPath: [CodingKey] {
        decoder.codingPath
    }
    var count: Int? {
        Int(_count)
    }
    var isAtEnd: Bool {
        _current >= _count
    }
    var currentIndex: Int {
        Int(_current)
    }

    init(decoder: SJDecoder) throws {
        try self.init(decoder: decoder, value: decoder.value)
    }

    init(decoder: SJDecoder, value: JSONRef) throws {
        guard json_is_array(decoder.value) || json_is_null(decoder.value) else {
            let context = DecodingError.Context(codingPath: decoder.codingPath,
                debugDescription: SJDecoder.valueIsNotUnkeyedContainer(value))
            throw DecodingError.dataCorrupted(context)
        }
        self.value = value
        self.decoder = decoder
        _count = json_array_size(value)
    }

    mutating func decodeNil() throws -> Bool {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return SJDecoder.decodeNil(item)
    }

    mutating func decode(_ type: Bool.Type) throws -> Bool {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeBool(item, codingPath: codingPath)
    }

    mutating func decode(_ type: String.Type) throws -> String {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeString(item, codingPath: codingPath)
    }

    mutating func decode(_ type: Double.Type) throws -> Double {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeDouble(item, codingPath: codingPath)
    }

    mutating func decode(_ type: Float.Type) throws -> Float {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeFloat(item, codingPath: codingPath)
    }

    mutating func decode(_ type: Int.Type) throws -> Int {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeInt(item, codingPath: codingPath)
    }

    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeInt8(item, codingPath: codingPath)
    }

    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeInt16(item, codingPath: codingPath)
    }

    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeInt32(item, codingPath: codingPath)
    }

    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeInt64(item, codingPath: codingPath)
    }

    mutating func decode(_ type: UInt.Type) throws -> UInt {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeUInt(item, codingPath: codingPath)
    }

    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeUInt8(item, codingPath: codingPath)
    }

    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeUInt16(item, codingPath: codingPath)
    }

    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeUInt32(item, codingPath: codingPath)
    }

    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDecoder.decodeUInt64(item, codingPath: codingPath)
    }

    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        let nested = SJDecoder(value: item, options: decoder.options, codingPath: decoder.codingPath)
        return try T.init(from: nested)
    }

    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws ->
        KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        let nested = try SJDKeyedContainer<NestedKey>(decoder: decoder, value: item)
        return KeyedDecodingContainer(nested)
    }

    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        guard let item = json_array_get_index(value, _current) else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: SJDecoder.valueOutOfIndex())
        }
        _current += 1
        return try SJDUnkeyedContainer(decoder: decoder, value: item)
    }

    mutating func superDecoder() throws -> Decoder {
        decoder
    }
}

struct SJDKeyedContainer<Key>: KeyedDecodingContainerProtocol where Key : CodingKey {
    let value: JSONRef
    let decoder: SJDecoder
    let allKeys: [Key]

    var codingPath: [CodingKey] {
        decoder.codingPath
    }

    init(decoder: SJDecoder) throws {
        try self.init(decoder: decoder, value: decoder.value)
    }

    init(decoder: SJDecoder, value: JSONRef) throws {
        guard json_is_object(value) || json_is_null(value) else {
            let context = DecodingError.Context(codingPath: decoder.codingPath,
                debugDescription: SJDecoder.valueIsNotKeyedContainer(value))
            throw DecodingError.dataCorrupted(context)
        }
        self.value = value
        self.decoder = decoder
        let keys = json_object_all_key(value)
        allKeys = keys.compactMap(Key.init(stringValue:))
    }

    func contains(_ key: Key) -> Bool {
        key.stringValue.withCString { pointer in
            json_object_contains_key(value, pointer)
        }
    }

    private func find(key: Key) throws -> JSONRef {
        let item: JSONRef? = key.stringValue.withCString { pointer in
            json_object_find_key(value, pointer)
        }
        if let item = item {
            return item
        } else {
            let context = DecodingError.Context(codingPath: codingPath,
                debugDescription: SJDecoder.keyNotFound())
            throw DecodingError.keyNotFound(key, context)
        }
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        let item = try find(key: key)
        return SJDecoder.decodeNil(item)
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        let item = try find(key: key)
        return try SJDecoder.decodeBool(item, codingPath: codingPath)
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        let item = try find(key: key)
        return try SJDecoder.decodeString(item, codingPath: codingPath)
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        let item = try find(key: key)
        return try SJDecoder.decodeDouble(item, codingPath: codingPath)
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        let item = try find(key: key)
        return try SJDecoder.decodeFloat(item, codingPath: codingPath)
    }

    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        let item = try find(key: key)
        return try SJDecoder.decodeInt(item, codingPath: codingPath)
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        let item = try find(key: key)
        return try SJDecoder.decodeInt8(item, codingPath: codingPath)
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        let item = try find(key: key)
        return try SJDecoder.decodeInt16(item, codingPath: codingPath)
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        let item = try find(key: key)
        return try SJDecoder.decodeInt32(item, codingPath: codingPath)
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        let item = try find(key: key)
        return try SJDecoder.decodeInt64(item, codingPath: codingPath)
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        let item = try find(key: key)
        return try SJDecoder.decodeUInt(item, codingPath: codingPath)
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        let item = try find(key: key)
        return try SJDecoder.decodeUInt8(item, codingPath: codingPath)
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        let item = try find(key: key)
        return try SJDecoder.decodeUInt16(item, codingPath: codingPath)
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        let item = try find(key: key)
        return try SJDecoder.decodeUInt32(item, codingPath: codingPath)
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        let item = try find(key: key)
        return try SJDecoder.decodeUInt64(item, codingPath: codingPath)
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        let item = try find(key: key)
        var path = decoder.codingPath
        path.append(key)
        let next = SJDecoder(value: item, options: decoder.options, codingPath: path)
        return try T.init(from: next)
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws ->
        KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        let item = try find(key: key)
        let next = try SJDKeyedContainer<NestedKey>(decoder: decoder, value: item)
        return KeyedDecodingContainer(next)
    }

    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        let item = try find(key: key)
        return try SJDUnkeyedContainer(decoder: decoder, value: item)
    }

    func superDecoder() throws -> Decoder {
        decoder
    }

    func superDecoder(forKey key: Key) throws -> Decoder {
        let item = try find(key: key)
        var path = decoder.codingPath
        path.append(key)
        let next = SJDecoder(value: item, options: decoder.options, codingPath: path)
        return next
    }
}
