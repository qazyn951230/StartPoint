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

import Foundation

// Same API with JSONEncoder
public final class StartJSONEncoder {
    public var userInfo: [CodingUserInfoKey: Any] = [:]
    public var outputFormatting: JSONEncoder.OutputFormatting = []
    public var keyEncodingStrategy = JSONEncoder.KeyEncodingStrategy.useDefaultKeys
    public var dateEncodingStrategy = JSONEncoder.DateEncodingStrategy.deferredToDate
    public var dataEncodingStrategy = JSONEncoder.DataEncodingStrategy.base64
    public var nonConformingFloatEncodingStrategy = JSONEncoder.NonConformingFloatEncodingStrategy.throw

    public init() {
        // Do nothing.
    }

    public func encode<T>(_ value: T) throws -> Data where T: Encodable {
        let context = SJEncoderContext(userInfo: userInfo,
            outputFormatting: outputFormatting,
            keyEncodingStrategy: keyEncodingStrategy,
            dateEncodingStrategy: dateEncodingStrategy,
            dataEncodingStrategy: dataEncodingStrategy,
            nonConformingFloatEncodingStrategy: nonConformingFloatEncodingStrategy)
        let encoder = SJEncoder(options: context, codingPath: [])
        try encoder.encode(value)
        return context.data
    }
}

enum JSONEncoderState {
    case empty
    case value
    case root
}

struct StartCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        intValue = nil
    }

    init?(intValue: Int) {
        self.intValue = intValue
        stringValue = "\(intValue)"
    }

    init(_ value: String) {
        stringValue = value
        intValue = nil
    }

    init(_ value: Int) {
        self.intValue = value
        stringValue = "\(value)"
    }
}

class SJEncoderContext {
    let userInfo: [CodingUserInfoKey: Any]
    let outputFormatting: JSONEncoder.OutputFormatting
    let keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy
    let dateEncodingStrategy: JSONEncoder.DateEncodingStrategy
    let dataEncodingStrategy: JSONEncoder.DataEncodingStrategy
    let nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy

    fileprivate(set) var data: Data = Data()
    fileprivate(set) var state = JSONEncoderState.empty

    fileprivate lazy var iso8601Formatter: ISO8601DateFormatter = {
        ISO8601DateFormatter()
    }()

    init(userInfo: [CodingUserInfoKey: Any],
         outputFormatting: JSONEncoder.OutputFormatting,
         keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy,
         dateEncodingStrategy: JSONEncoder.DateEncodingStrategy,
         dataEncodingStrategy: JSONEncoder.DataEncodingStrategy,
         nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy) {
        self.userInfo = userInfo
        self.outputFormatting = outputFormatting
        self.keyEncodingStrategy = keyEncodingStrategy
        self.dateEncodingStrategy = dateEncodingStrategy
        self.dataEncodingStrategy = dataEncodingStrategy
        self.nonConformingFloatEncodingStrategy = nonConformingFloatEncodingStrategy
    }
}

enum JSONModel {
    case data(Data)
}

class SJEncoder: Encoder {
    var codingPath: [CodingKey]
    let context: SJEncoderContext
    private(set) var key: CodingKey?

    var userInfo: [CodingUserInfoKey: Any] {
        context.userInfo
    }

    init(options: SJEncoderContext, key: CodingKey? = nil, codingPath: [CodingKey]) {
        self.context = options
        self.key = key
        self.codingPath = codingPath
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        let next = SJEKeyedContainer<Key>(encoder: self)
        return KeyedEncodingContainer(next)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        SJEUnkeyedContainer(encoder: self)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        SJESingleContainer(encoder: self)
    }

    func nextValue(_ value: Any) throws {
        if context.state == JSONEncoderState.value {
            let context = EncodingError.Context.init(codingPath: codingPath,
                debugDescription: SJEncoder.mutilRootJSON())
            throw EncodingError.invalidValue(value, context)
        }
        if context.state == JSONEncoderState.empty {
            context.state = JSONEncoderState.value
        }
    }

    func startArray() {
        context.data.append(0x5b)
    }

    func endArray() {
        context.data.append(0x5d)
    }

    func startObject() {
        context.data.append(0x7b)
    }

    func endObject() {
        context.data.append(0x7d)
    }

    @inline(__always)
    func encodeNil() { // null
        SJEncoder.write4(0x6e, 0x75, 0x6c, 0x6c, to: &context.data)
    }

    @inline(__always)
    func encode(_ value: Bool) {
        if value { // true
            SJEncoder.write4(0x74, 0x72, 0x75, 0x64, to: &context.data)
        } else { // false
            SJEncoder.write5(0x66, 0x61, 0x6c, 0x73, 0x65, to: &context.data)
        }
    }

    @inline(__always)
    func encode(key value: String) throws {
        guard let input = value.data(using: .utf8) else {
            let context = EncodingError.Context.init(codingPath: codingPath,
                debugDescription: SJEncoder.stringCannotEncoding())
            throw EncodingError.invalidValue(value, context)
        }
        context.data.append(0x22) // "
        context.data.append(input)
        context.data.append(0x22) // "
    }

    @inline(__always)
    func encode(_ value: String) throws {
        guard let input = value.data(using: .utf8) else {
            let context = EncodingError.Context.init(codingPath: codingPath,
                debugDescription: SJEncoder.stringCannotEncoding())
            throw EncodingError.invalidValue(value, context)
        }
        context.data.append(0x22) // "
        context.data.append(input)
        context.data.append(0x22) // "
    }

    @inline(__always)
    func encode(_ value: Double) throws {
        json_double_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: Float) throws {
        json_float_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: Int) {
        json_int_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: Int8) {
        json_int8_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: Int16) {
        json_int16_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: Int32) {
        json_int32_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: Int64) {
        json_int64_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: UInt) {
        json_uint_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: UInt8) {
        json_uint8_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: UInt16) {
        json_uint16_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: UInt32) {
        json_uint32_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: UInt64) {
        json_uint64_to_string(value) { pointer, size in
            context.data.append(pointer, count: size)
        }
    }

    @inline(__always)
    func encode(_ value: Date) throws {
        switch context.dateEncodingStrategy {
        case .deferredToDate:
            try value.encode(to: self)
        case .secondsSince1970:
            encode(UInt64(value.timeIntervalSince1970))
        case .millisecondsSince1970:
            encode(UInt64(value.timeIntervalSince1970 * 1000))
        case .iso8601:
            try encode(context.iso8601Formatter.string(from: value))
        case let .formatted(formatter):
            try encode(formatter.string(from: value))
        case let .custom(method):
            try method(value, self)
        @unknown default:
            try value.encode(to: self)
        }
    }

    @inline(__always)
    func encode(_ value: Data) throws {
        switch context.dataEncodingStrategy {
        case .deferredToData:
            try value.encode(to: self)
        case .base64:
            context.data.append(0x22) // "
            context.data.append(value.base64EncodedData())
            context.data.append(0x22) // "
        case let .custom(method):
            try method(value, self)
        @unknown default:
            try value.encode(to: self)
        }
    }

    @inline(__always)
    func encode<T>(_ value: T) throws where T: Encodable {
        switch value {
        case let date as Date:
            try encode(date)
        case let data as Data:
            try encode(data)
        default:
            try value.encode(to: self)
        }
    }

    @inline(__always)
    static func write4(_ value1: UInt8, _ value2: UInt8, _ value3: UInt8, _ value4: UInt8,
                       to data: inout Data) {
        data.append(value1)
        data.append(value2)
        data.append(value3)
        data.append(value4)
    }

    @inline(__always)
    static func write5(_ value1: UInt8, _ value2: UInt8, _ value3: UInt8, _ value4: UInt8, _ value5: UInt8,
                       to data: inout Data) {
        data.append(value1)
        data.append(value2)
        data.append(value3)
        data.append(value4)
        data.append(value5)
    }

    @inline(__always)
    static func stringCannotEncoding() -> String {
        "stringCannotEncoding"
    }

    @inline(__always)
    static func mutilRootJSON() -> String {
        "mutilRootJSON"
    }
}

struct SJESingleContainer: SingleValueEncodingContainer {
    let encoder: SJEncoder
    private(set) var key: CodingKey?

    var codingPath: [CodingKey] {
        encoder.codingPath
    }

    init(encoder: SJEncoder, key: CodingKey? = nil) {
        self.encoder = encoder
        self.key = key
    }

    mutating func encodeNil() throws {
        encoder.encodeNil()
    }

    mutating func encode(_ value: Bool) throws {
        encoder.encode(value)
    }

    mutating func encode(_ value: String) throws {
        try encoder.encode(value)
    }

    mutating func encode(_ value: Double) throws {
        try encoder.encode(value)
    }

    mutating func encode(_ value: Float) throws {
        try encoder.encode(value)
    }

    mutating func encode(_ value: Int) throws {
        encoder.encode(value)
    }

    mutating func encode(_ value: Int8) throws {
        encoder.encode(value)
    }

    mutating func encode(_ value: Int16) throws {
        encoder.encode(value)
    }

    mutating func encode(_ value: Int32) throws {
        encoder.encode(value)
    }

    mutating func encode(_ value: Int64) throws {
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt) throws {
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt8) throws {
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt16) throws {
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt32) throws {
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt64) throws {
        encoder.encode(value)
    }

    mutating func encode<T>(_ value: T) throws where T: Encodable {
        try value.encode(to: encoder)
    }
}

struct SJEUnkeyedContainer: UnkeyedEncodingContainer {
    let encoder: SJEncoder
    private(set) var key: CodingKey?
    private(set) var count: Int = 0

    var codingPath: [CodingKey] {
        encoder.codingPath
    }

    init(encoder: SJEncoder, key: CodingKey? = nil) {
        self.encoder = encoder
        self.key = key
    }

    mutating func encodeNil() throws {
        count += 1
        encoder.encodeNil()
    }

    mutating func encode(_ value: Bool) throws {
        count += 1
        encoder.encode(value)
    }

    mutating func encode(_ value: String) throws {
        encoder.codingPath.append(StartCodingKey(count))
        defer {
            encoder.codingPath.removeLast()
        }
        count += 1
        try encoder.encode(value)
    }

    mutating func encode(_ value: Double) throws {
        encoder.codingPath.append(StartCodingKey(count))
        defer {
            encoder.codingPath.removeLast()
        }
        count += 1
        try encoder.encode(value)
    }

    mutating func encode(_ value: Float) throws {
        encoder.codingPath.append(StartCodingKey(count))
        defer {
            encoder.codingPath.removeLast()
        }
        count += 1
        try encoder.encode(value)
    }

    mutating func encode(_ value: Int) throws {
        count += 1
        encoder.encode(value)
    }

    mutating func encode(_ value: Int8) throws {
        count += 1
        encoder.encode(value)
    }

    mutating func encode(_ value: Int16) throws {
        count += 1
        encoder.encode(value)
    }

    mutating func encode(_ value: Int32) throws {
        count += 1
        encoder.encode(value)
    }

    mutating func encode(_ value: Int64) throws {
        count += 1
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt) throws {
        count += 1
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt8) throws {
        count += 1
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt16) throws {
        count += 1
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt32) throws {
        count += 1
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt64) throws {
        count += 1
        encoder.encode(value)
    }

    mutating func encode<T>(_ value: T) throws where T: Encodable {
        encoder.codingPath.append(StartCodingKey(count))
        defer {
            encoder.codingPath.removeLast()
        }
        count += 1
        try encoder.encode(value)
    }

    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type)
            -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        fatalError("nestedContainer() has not been implemented")
    }

    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        encoder.codingPath.append(StartCodingKey(count))
        defer {
            encoder.codingPath.removeLast()
        }
        count += 1
        return SJEUnkeyedContainer(encoder: encoder)
    }

    mutating func superEncoder() -> Encoder {
        encoder
    }
}

struct SJEKeyedContainer<Key>: KeyedEncodingContainerProtocol where Key: CodingKey {
    let encoder: SJEncoder
    private(set) var data = Data()
    private(set) var key: CodingKey?
    private(set) var keys: Set<String> = []

    var codingPath: [CodingKey] {
        encoder.codingPath
    }

    init(encoder: SJEncoder, key: CodingKey? = nil) {
        self.encoder = encoder
        self.key = key
    }

    private func encodeKey(_ key: Key) throws {
        let value = key.stringValue
        try encoder.encode(key: value)
    }

    mutating func encodeNil(forKey key: Key) throws {
        try encodeKey(key)
        encoder.encodeNil()
    }

    mutating func encode(_ value: Bool, forKey key: Key) throws {
        try encodeKey(key)
        encoder.encode(value)
    }

    mutating func encode(_ value: String, forKey key: Key) throws {
        try encodeKey(key)
        try encoder.encode(value)
    }

    mutating func encode(_ value: Double, forKey key: Key) throws {
        try encodeKey(key)
        try encoder.encode(value)
    }

    mutating func encode(_ value: Float, forKey key: Key) throws {
        try encodeKey(key)
        try encoder.encode(value)
    }

    mutating func encode(_ value: Int, forKey key: Key) throws {
        try encodeKey(key)
    }

    mutating func encode(_ value: Int8, forKey key: Key) throws {
        try encodeKey(key)
        encoder.encode(value)
    }

    mutating func encode(_ value: Int16, forKey key: Key) throws {
        try encodeKey(key)
        encoder.encode(value)
    }

    mutating func encode(_ value: Int32, forKey key: Key) throws {
        try encodeKey(key)
        encoder.encode(value)
    }

    mutating func encode(_ value: Int64, forKey key: Key) throws {
        try encodeKey(key)
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt, forKey key: Key) throws {
        try encodeKey(key)
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        try encodeKey(key)
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        try encodeKey(key)
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        try encodeKey(key)
        encoder.encode(value)
    }

    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        try encodeKey(key)
        encoder.encode(value)
    }

    mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        try encodeKey(key)
        try encoder.encode(value)
    }

    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) ->
        KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let next = SJEKeyedContainer<NestedKey>(encoder: encoder, key: key)
        return KeyedEncodingContainer<NestedKey>(next)
    }

    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        SJEUnkeyedContainer(encoder: encoder, key: key)
    }

    mutating func superEncoder() -> Encoder {
        encoder
    }

    mutating func superEncoder(forKey key: Key) -> Encoder {
        SJEncoder(options: encoder.context, key: key, codingPath: encoder.codingPath)
    }
}
