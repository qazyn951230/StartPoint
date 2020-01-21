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
        return encoder.resolve()
    }

    public func encodeToJSON<T>(_ value: T) throws -> JSON where T: Encodable {
        let context = SJEncoderContext(userInfo: userInfo,
            outputFormatting: outputFormatting,
            keyEncodingStrategy: keyEncodingStrategy,
            dateEncodingStrategy: dateEncodingStrategy,
            dataEncodingStrategy: dataEncodingStrategy,
            nonConformingFloatEncodingStrategy: nonConformingFloatEncodingStrategy)
        let encoder = SJEncoder(options: context, codingPath: [])
        try encoder.encode(value)
        return encoder.root
    }
}

class SJEncoderContext {
    let userInfo: [CodingUserInfoKey: Any]
    let outputFormatting: JSONEncoder.OutputFormatting
    let keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy
    let dateEncodingStrategy: JSONEncoder.DateEncodingStrategy
    let dataEncodingStrategy: JSONEncoder.DataEncodingStrategy
    let nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy

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

class SJEncoder: Encoder {
    var codingPath: [CodingKey]
    let context: SJEncoderContext
    let root: JSON = JSON(type: JSONType.null)
    private(set) var stack: [JSON] = []
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
#if JSON_ENCODER_TRACE
        Log.debug("container")
#endif
        let next = SJEKeyedContainer<Key>(encoder: self)
        return KeyedEncodingContainer(next)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
#if JSON_ENCODER_TRACE
        Log.debug("unkeyedContainer")
#endif
        return SJEUnkeyedContainer(encoder: self)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
#if JSON_ENCODER_TRACE
        Log.debug("singleValueContainer")
#endif
        return SJESingleContainer(encoder: self)
    }

    func resolve() -> Data {
        let writer = JSONDataWriter()
        if #available(iOS 11.0, *) {
            writer.sortKeys = context.outputFormatting.contains(.sortedKeys)
        }
        root.accept(visitor: writer)
        return Data(bytes: byte_array_data(writer.data), count: byte_array_size(writer.data))
    }

    @inline(__always)
    func pushNode(type: JSONType = JSONType.null) -> JSON {
        let json = JSON(type: type)
        stack.append(json)
        return json
    }

    @inline(__always)
    func popNode() -> JSON {
        stack.popLast() ?? root
    }

//    @inline(__always)
//    func encode(_ value: Date) throws {
//        switch context.dateEncodingStrategy {
//        case .deferredToDate:
//            try value.encode(to: self)
//        case .secondsSince1970:
//            current.write(UInt64(value.timeIntervalSince1970))
//        case .millisecondsSince1970:
//            current.write(UInt64(value.timeIntervalSince1970 * 1000))
//        case .iso8601:
//            try encode(context.iso8601Formatter.string(from: value))
//        case let .formatted(formatter):
//            try encode(formatter.string(from: value))
//        case let .custom(method):
//            try method(value, self)
//        @unknown default:
//            try value.encode(to: self)
//        }
//    }
//
//    @inline(__always)
//    func encode(_ value: Data) throws {
//        switch context.dataEncodingStrategy {
//        case .deferredToData:
//            try value.encode(to: self)
//        case .base64:
//            current.write(value.base64EncodedData())
//        case let .custom(method):
//            try method(value, self)
//        @unknown default:
//            try value.encode(to: self)
//        }
//    }
//
//    @inline(__always)
//    func encode<T>(_ value: T) throws where T: Encodable {
//        switch value {
//        case let date as Date:
//            try encode(date)
//        case let data as Data:
//            try encode(data)
//        default:
//            try value.encode(to: self)
//        }
//    }

    @inline(__always)
    func encode<T>(_ value: T) throws where T: Encodable {
#if JSON_ENCODER_TRACE
        Log.debug("T", value)
#endif
//        switch value {
//        case let date as Date:
//            try encode(date)
//        case let data as Data:
//            try encode(data)
//        default:
//            try value.encode(to: self)
//        }
        try value.encode(to: self)
    }

//    @inline(__always)
//    func encode<T>(_ value: T, to node: JSON) throws where T: Encodable {
//        switch value {
//        case let date as Date:
//            try encode(date)
//        case let data as Data:
//            try encode(data)
//        default:
//            try value.encode(to: self)
//        }
//    }
}

struct SJESingleContainer: SingleValueEncodingContainer {
    let encoder: SJEncoder
    let node: JSON
    private(set) var key: CodingKey?
    private(set) var written = false

    var codingPath: [CodingKey] {
        encoder.codingPath
    }

    init(encoder: SJEncoder, key: CodingKey? = nil) {
        self.encoder = encoder
        self.key = key
        self.node = encoder.popNode()
        self.node.kind = JSONType.null
    }

    private mutating func check(_ value: Any = "null") throws {
        if written {
            let context = EncodingError.Context(codingPath: encoder.codingPath,
                debugDescription: "")
            throw EncodingError.invalidValue(value, context)
        }
        written = true
    }

    mutating func encodeNil() throws {
#if JSON_ENCODER_TRACE
        Log.debug("nil")
#endif
        try check()
        node.fillNull()
    }

    mutating func encode(_ value: Bool) throws {
#if JSON_ENCODER_TRACE
        Log.debug("Bool", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: String) throws {
#if JSON_ENCODER_TRACE
        Log.debug("String", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: Double) throws {
#if JSON_ENCODER_TRACE
        Log.debug("Double", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: Float) throws {
#if JSON_ENCODER_TRACE
        Log.debug("Float", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: Int) throws {
#if JSON_ENCODER_TRACE
        Log.debug("Int", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: Int8) throws {
#if JSON_ENCODER_TRACE
        Log.debug("Int8", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: Int16) throws {
#if JSON_ENCODER_TRACE
        Log.debug("Int16", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: Int32) throws {
#if JSON_ENCODER_TRACE
        Log.debug("Int32", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: Int64) throws {
#if JSON_ENCODER_TRACE
        Log.debug("Int64", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: UInt) throws {
#if JSON_ENCODER_TRACE
        Log.debug("UInt", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: UInt8) throws {
#if JSON_ENCODER_TRACE
        Log.debug("UInt8", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: UInt16) throws {
#if JSON_ENCODER_TRACE
        Log.debug("UInt16", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: UInt32) throws {
#if JSON_ENCODER_TRACE
        Log.debug("UInt32", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode(_ value: UInt64) throws {
#if JSON_ENCODER_TRACE
        Log.debug("UInt64", value)
#endif
        try check()
        node.fill(value)
    }

    mutating func encode<T>(_ value: T) throws where T: Encodable {
#if JSON_ENCODER_TRACE
        Log.debug("T", value)
#endif
        try check()
        try encoder.encode(value)
    }
}

struct SJEUnkeyedContainer: UnkeyedEncodingContainer {
    let encoder: SJEncoder
    let node: JSON
    private(set) var key: CodingKey?
    private(set) var count: Int = 0

    var codingPath: [CodingKey] {
        encoder.codingPath
    }

    init(encoder: SJEncoder, key: CodingKey? = nil) {
        self.encoder = encoder
        self.key = key
        self.node = encoder.popNode()
        self.node.kind = JSONType.array
    }

    mutating func encodeNil() throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("nil")
#endif
        node.appendNull()
    }

    mutating func encode(_ value: Bool) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("Bool", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: String) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("String", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: Double) throws {
//        encoder.codingPath.append(StartCodingKey(count))
//        defer {
//            encoder.codingPath.removeLast()
//        }
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("Double", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: Float) throws {
//        encoder.codingPath.append(StartCodingKey(count))
//        defer {
//            encoder.codingPath.removeLast()
//        }
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("Float", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: Int) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("Int", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: Int8) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("Int8", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: Int16) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("Int16", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: Int32) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("Int32", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: Int64) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("Int64", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: UInt) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("UInt", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: UInt8) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("UInt8", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: UInt16) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("UInt16", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: UInt32) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("UInt32", value)
#endif
        node.append(value)
    }

    mutating func encode(_ value: UInt64) throws {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("UInt64", value)
#endif
        node.append(value)
    }

    mutating func encode<T>(_ value: T) throws where T: Encodable {
//        encoder.codingPath.append(StartCodingKey(count))
//        defer {
//            encoder.codingPath.removeLast()
//        }
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("T", value)
#endif
        let next = encoder.pushNode()
        node.append(next)
        try encoder.encode(value)
    }

    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type)
            -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("nestedContainer")
#endif
        let next = encoder.pushNode()
        node.append(next)
        return encoder.container(keyedBy: keyType)
    }

    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        count += 1
#if JSON_ENCODER_TRACE
        Log.debug("nestedUnkeyedContainer")
#endif
        let next = encoder.pushNode()
        node.append(next)
        return encoder.unkeyedContainer()
    }

    mutating func superEncoder() -> Encoder {
#if JSON_ENCODER_TRACE
        Log.debug("superEncoder")
#endif
        return encoder
    }
}

struct SJEKeyedContainer<Key>: KeyedEncodingContainerProtocol where Key: CodingKey {
    let encoder: SJEncoder
    let node: JSON
    private(set) var key: CodingKey?
    private(set) var keys: Set<String> = []

    var codingPath: [CodingKey] {
        encoder.codingPath
    }

    init(encoder: SJEncoder, key: CodingKey? = nil) {
        self.encoder = encoder
        self.key = key
        self.node = encoder.popNode()
        self.node.kind = JSONType.object
    }

    private mutating func check(_ key: Key) throws -> String {
        return key.stringValue
    }

    mutating func encodeNil(forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "nil")
#endif
        let next = try check(key)
        node.setNull(key: next)
    }

    mutating func encode(_ value: Bool, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "Bool", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: String, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "String", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: Double, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "Double", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: Float, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "Float", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: Int, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "Int", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: Int8, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "Int8", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: Int16, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "Int16", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: Int32, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "Int32", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: Int64, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "Int64", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: UInt, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "UInt", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: UInt8, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "UInt8", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: UInt16, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "UInt16", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: UInt32, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "UInt32", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode(_ value: UInt64, forKey key: Key) throws {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "UInt64", value)
#endif
        let next = try check(key)
        node.set(key: next, value)
    }

    mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {
#if JSON_ENCODER_TRACE
        Log.debug("key", key, "T", value)
#endif
        let next = try check(key)
        let temp = encoder.pushNode()
        node.set(key: next, temp)
        try encoder.encode(value)
    }

    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) ->
        KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
#if JSON_ENCODER_TRACE
        Log.debug("nestedContainer")
#endif
//        let next = try check(key)
//        let temp = encoder.pushNode()
//        node.set(key: next, temp)
        let next = SJEKeyedContainer<NestedKey>(encoder: encoder, key: key)
        return KeyedEncodingContainer<NestedKey>(next)
    }

    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
#if JSON_ENCODER_TRACE
        Log.debug("nestedUnkeyedContainer")
#endif
//        let next = try check(key)
//        let temp = encoder.pushNode()
//        node.set(key: next, temp)
        return SJEUnkeyedContainer(encoder: encoder, key: key)
    }

    mutating func superEncoder() -> Encoder {
#if JSON_ENCODER_TRACE
        Log.debug("superEncoder")
#endif
        return encoder
    }

    mutating func superEncoder(forKey key: Key) -> Encoder {
#if JSON_ENCODER_TRACE
        Log.debug("superEncoder")
#endif
        return SJEncoder(options: encoder.context, key: key, codingPath: encoder.codingPath)
    }
}
