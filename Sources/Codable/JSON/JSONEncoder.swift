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

enum SJNodeType {
    case single
    case array
    case object
}

class SJNode: CustomDebugStringConvertible {
    let kind: SJNodeType
    let data: ByteArrayRef

    init(kind: SJNodeType) {
        self.kind = kind
        data = byte_array_create_size(0)
    }

    var debugDescription: String {
        String(bytesNoCopy: UnsafeMutableRawPointer(mutating: byte_array_data(data)),
            length: byte_array_size(data), encoding: .utf8, freeWhenDone: false) ?? "[SJNode NULL]"
    }

    deinit {
        byte_array_free(data)
    }

    @inline(__always)
    func writeNull() {
        byte_array_write_null(data)
    }

    @inline(__always)
    func write(_ value: Bool) {
        byte_array_write_bool(data, value)
    }

    @inline(__always)
    func write(_ value: String) {
        byte_array_add(data, 0x22) // "
        value.withCString { pointer in
            byte_array_write_int8_data(data, pointer, 0)
        }
        byte_array_add(data, 0x22) // "
    }

    @inline(__always)
    func write(_ value: Data) {
        value.withUnsafeBytes { (raw: UnsafeRawBufferPointer) in
            guard let pointer = raw.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                return
            }
            byte_array_write_uint8_data(data, pointer, raw.count)
        }
    }

    @inline(__always)
    func write(_ value: Float) {
        byte_array_write_float(data, value)
    }

    @inline(__always)
    func write(_ value: Double) {
        byte_array_write_double(data, value)
    }

    @inline(__always)
    func write(_ value: Int) {
        byte_array_write_int(data, value)
    }

    @inline(__always)
    func write(_ value: Int8) {
        byte_array_write_int8(data, value)
    }

    @inline(__always)
    func write(_ value: Int16) {
        byte_array_write_int16(data, value)
    }

    @inline(__always)
    func write(_ value: Int32) {
        byte_array_write_int32(data, value)
    }

    @inline(__always)
    func write(_ value: Int64) {
        byte_array_write_int64(data, value)
    }

    @inline(__always)
    func write(_ value: UInt) {
        byte_array_write_uint(data, value)
    }

    @inline(__always)
    func write(_ value: UInt8) {
        byte_array_write_uint8(data, value)
    }

    @inline(__always)
    func write(_ value: UInt16) {
        byte_array_write_uint16(data, value)
    }

    @inline(__always)
    func write(_ value: UInt32) {
        byte_array_write_uint32(data, value)
    }

    @inline(__always)
    func write(_ value: UInt64) {
        byte_array_write_uint64(data, value)
    }

    @inline(__always)
    func write(_ value: SJNode) {
        byte_array_copy(data, value.data)
    }
}

class SJEncoderContext {
    let userInfo: [CodingUserInfoKey: Any]
    let outputFormatting: JSONEncoder.OutputFormatting
    let keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy
    let dateEncodingStrategy: JSONEncoder.DateEncodingStrategy
    let dataEncodingStrategy: JSONEncoder.DataEncodingStrategy
    let nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy

    var stack: [SJNode] = []

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
    private(set) var key: CodingKey?

    var current: SJNode {
        context.stack.last ?? SJNode(kind: .single)
    }

    var userInfo: [CodingUserInfoKey: Any] {
        context.userInfo
    }

    init(options: SJEncoderContext, key: CodingKey? = nil, codingPath: [CodingKey]) {
        self.context = options
        self.key = key
        self.codingPath = codingPath
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        pushNode(kind: .object)
        let next = SJEKeyedContainer<Key>(encoder: self)
        return KeyedEncodingContainer(next)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        pushNode(kind: .array)
        return SJEUnkeyedContainer(encoder: self)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        pushNode(kind: .single)
        return SJESingleContainer(encoder: self)
    }

    func pushNode(kind: SJNodeType) {
        context.stack.append(SJNode(kind: kind))
    }

    func popNode() -> SJNode? {
        context.stack.popLast()
    }

    func removeLastNode() {
        if context.stack.isNotEmpty {
            _ = context.stack.removeLast()
        }
    }

    func resolve() -> Data {
        guard let root = context.stack.first else {
            return Data()
        }
        var data = Data()
        switch root.kind {
        case .single:
            break;
        case .object:
            data.append(0x7b) // {
            byte_array_add(root.data, 0x7d) // }
        case .array:
            data.append(0x5b) // [
            byte_array_add(root.data, 0x5d) // ]
        }
        data.append(byte_array_uint8_data(root.data), count: byte_array_size(root.data))
        return data
//        var data = Data()
//        resolve(node: root, to: &data)
//        return data
    }

//    private func resolve(node: SJNode, to data: inout Data) {
//        debugPrint(node)
//        data.append(byte_array_uint8_data(node.data), count: byte_array_size(node.data))
//        for child in node.children {
//            resolve(node: child, to: &data)
//        }
//    }

    @inline(__always)
    func encode(_ value: Date) throws {
        switch context.dateEncodingStrategy {
        case .deferredToDate:
            try value.encode(to: self)
        case .secondsSince1970:
            current.write(UInt64(value.timeIntervalSince1970))
        case .millisecondsSince1970:
            current.write(UInt64(value.timeIntervalSince1970 * 1000))
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
            current.write(value.base64EncodedData())
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
}

struct SJESingleContainer: SingleValueEncodingContainer {
    let encoder: SJEncoder
    private(set) var key: CodingKey?
    private(set) var written = false

    var codingPath: [CodingKey] {
        encoder.codingPath
    }

    init(encoder: SJEncoder, key: CodingKey? = nil) {
        self.encoder = encoder
        self.key = key
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
        try check()
        encoder.current.writeNull()
    }

    mutating func encode(_ value: Bool) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: String) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: Double) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: Float) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: Int) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: Int8) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: Int16) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: Int32) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: Int64) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: UInt) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: UInt8) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: UInt16) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: UInt32) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode(_ value: UInt64) throws {
        try check()
        encoder.current.write(value)
    }

    mutating func encode<T>(_ value: T) throws where T: Encodable {
        try check()
        try encoder.encode(value)
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

    func prefix() {
        if count > 1 {
            byte_array_add(encoder.current.data, 0x2c)
        }
    }

    func postfix() {
    }

    mutating func encodeNil() throws {
        count += 1
        prefix()
        encoder.current.writeNull()
        postfix()
    }

    mutating func encode(_ value: Bool) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: String) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Double) throws {
//        encoder.codingPath.append(StartCodingKey(count))
//        defer {
//            encoder.codingPath.removeLast()
//        }
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Float) throws {
//        encoder.codingPath.append(StartCodingKey(count))
//        defer {
//            encoder.codingPath.removeLast()
//        }
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Int) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Int8) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Int16) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Int32) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Int64) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: UInt) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: UInt8) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: UInt16) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: UInt32) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: UInt64) throws {
        count += 1
        prefix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode<T>(_ value: T) throws where T: Encodable {
        encoder.codingPath.append(StartCodingKey(count))
        defer {
            encoder.codingPath.removeLast()
        }
        count += 1
        do {
            try encoder.encode(value)
        } catch let error {
            encoder.removeLastNode()
            throw error
        }
        guard let data = encoder.popNode() else {
            return
        }
        prefix()
        switch data.kind {
        case .single:
            encoder.current.write(data)
        case .array:
            byte_array_add(encoder.current.data, 0x5b)
            encoder.current.write(data)
            byte_array_add(encoder.current.data, 0x5d)
        case .object:
            byte_array_add(encoder.current.data, 0x7b)
            encoder.current.write(data)
            byte_array_add(encoder.current.data, 0x7d)
        }
        postfix()
    }

    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type)
            -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        count += 1
        prefix()
        return encoder.container(keyedBy: keyType)
    }

    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        count += 1
        prefix()
        return encoder.unkeyedContainer()
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

    private func prefix() {

    }

    private func infix() {

    }

    private func postfix() {

    }

    private func writeKey(_ key: Key) throws {
        let value = key.stringValue
        encoder.current.write(value)
    }

    mutating func encodeNil(forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.writeNull()
        postfix()
    }

    mutating func encode(_ value: Bool, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: String, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Double, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Float, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Int, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Int8, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Int16, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Int32, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: Int64, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: UInt, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        prefix()
        try writeKey(key)
        infix()
        encoder.current.write(value)
        postfix()
    }

    mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {
        prefix()
        try writeKey(key)
        infix()
        try encoder.encode(value)
        postfix()
    }

    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) ->
        KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
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
