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

//import Foundation
//
//// Same API with JSONEncoder
//public final class StartJSONEncoder {
//    public var userInfo: [CodingUserInfoKey: Any] = [:]
//    public var outputFormatting: JSONEncoder.OutputFormatting = []
//    public var keyEncodingStrategy = JSONEncoder.KeyEncodingStrategy.useDefaultKeys
//    public var dateEncodingStrategy = JSONEncoder.DateEncodingStrategy.deferredToDate
//    public var dataEncodingStrategy = JSONEncoder.DataEncodingStrategy.base64
//    public var nonConformingFloatEncodingStrategy = JSONEncoder.NonConformingFloatEncodingStrategy.throw
//
//    public init() {
//        // Do nothing.
//    }
//
//    public func encode<T>(_ value: T) throws -> Data where T: Encodable {
//        let context = SJEncoderContext(userInfo: userInfo,
//            outputFormatting: outputFormatting,
//            keyEncodingStrategy: keyEncodingStrategy,
//            dateEncodingStrategy: dateEncodingStrategy,
//            dataEncodingStrategy: dataEncodingStrategy,
//            nonConformingFloatEncodingStrategy: nonConformingFloatEncodingStrategy)
//        let encoder = SJEncoder(options: context, codingPath: [])
//        try encoder.encode(value)
//        return encoder.resolve()
//    }
//}
//
//struct StartCodingKey: CodingKey {
//    var stringValue: String
//    var intValue: Int?
//
//    init?(stringValue: String) {
//        self.stringValue = stringValue
//        intValue = nil
//    }
//
//    init?(intValue: Int) {
//        self.intValue = intValue
//        stringValue = "\(intValue)"
//    }
//
//    init(_ value: String) {
//        stringValue = value
//        intValue = nil
//    }
//
//    init(_ value: Int) {
//        self.intValue = value
//        stringValue = "\(value)"
//    }
//}
//
//class SJEncoderContext {
//    let userInfo: [CodingUserInfoKey: Any]
//    let outputFormatting: JSONEncoder.OutputFormatting
//    let keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy
//    let dateEncodingStrategy: JSONEncoder.DateEncodingStrategy
//    let dataEncodingStrategy: JSONEncoder.DataEncodingStrategy
//    let nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy
//
//    var root: JSON?
//
//    fileprivate lazy var iso8601Formatter: ISO8601DateFormatter = {
//        ISO8601DateFormatter()
//    }()
//
//    init(userInfo: [CodingUserInfoKey: Any],
//         outputFormatting: JSONEncoder.OutputFormatting,
//         keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy,
//         dateEncodingStrategy: JSONEncoder.DateEncodingStrategy,
//         dataEncodingStrategy: JSONEncoder.DataEncodingStrategy,
//         nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy) {
//        self.userInfo = userInfo
//        self.outputFormatting = outputFormatting
//        self.keyEncodingStrategy = keyEncodingStrategy
//        self.dateEncodingStrategy = dateEncodingStrategy
//        self.dataEncodingStrategy = dataEncodingStrategy
//        self.nonConformingFloatEncodingStrategy = nonConformingFloatEncodingStrategy
//    }
//}
//
//struct SJEncoder: Encoder {
//    var codingPath: [CodingKey]
//    let context: SJEncoderContext
//    private(set) var stack: [JSON] = []
//    private(set) var key: CodingKey?
//
//    var userInfo: [CodingUserInfoKey: Any] {
//        context.userInfo
//    }
//
//    init(options: SJEncoderContext, key: CodingKey? = nil, codingPath: [CodingKey]) {
//        self.context = options
//        self.key = key
//        self.codingPath = codingPath
//    }
//
//    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
//        let next = SJEKeyedContainer<Key>(encoder: self)
//        return KeyedEncodingContainer(next)
//    }
//
//    func unkeyedContainer() -> UnkeyedEncodingContainer {
//        SJEUnkeyedContainer(encoder: self)
//    }
//
//    func singleValueContainer() -> SingleValueEncodingContainer {
//        SJESingleContainer(encoder: self, node: singleNode())
//    }
//
//    func resolve() -> Data {
//        Data()
//    }
//
//    func arrayNode() -> JSON {
//        let next = JSON(type: JSONType.array)
//        if let temp = parent ?? context.root {
//            temp.append(next)
//        } else {
//            context.root = next
//        }
//        return next
//    }
//
//    func objectNode() -> JSON {
//        let next = JSON(type: JSONType.object)
//        if let temp = parent ?? context.root {
//            temp.append(next)
//        } else {
//            context.root = next
//        }
//        return next
//    }
//
//    @inline(__always)
//    func singleNode() -> JSON {
//        let next = JSON(type: JSONType.null)
//        if let temp = parent ?? context.root {
//            temp.append(next)
//        } else {
//            context.root = next
//        }
//        return next
//    }
//
////    @inline(__always)
////    func encode(_ value: Date) throws {
////        switch context.dateEncodingStrategy {
////        case .deferredToDate:
////            try value.encode(to: self)
////        case .secondsSince1970:
////            current.write(UInt64(value.timeIntervalSince1970))
////        case .millisecondsSince1970:
////            current.write(UInt64(value.timeIntervalSince1970 * 1000))
////        case .iso8601:
////            try encode(context.iso8601Formatter.string(from: value))
////        case let .formatted(formatter):
////            try encode(formatter.string(from: value))
////        case let .custom(method):
////            try method(value, self)
////        @unknown default:
////            try value.encode(to: self)
////        }
////    }
////
////    @inline(__always)
////    func encode(_ value: Data) throws {
////        switch context.dataEncodingStrategy {
////        case .deferredToData:
////            try value.encode(to: self)
////        case .base64:
////            current.write(value.base64EncodedData())
////        case let .custom(method):
////            try method(value, self)
////        @unknown default:
////            try value.encode(to: self)
////        }
////    }
////
////    @inline(__always)
////    func encode<T>(_ value: T) throws where T: Encodable {
////        switch value {
////        case let date as Date:
////            try encode(date)
////        case let data as Data:
////            try encode(data)
////        default:
////            try value.encode(to: self)
////        }
////    }
//
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
//}
//
//struct SJESingleContainer: SingleValueEncodingContainer {
//    let encoder: SJEncoder
//    let node: JSON
//    private(set) var key: CodingKey?
//    private(set) var written = false
//
//    var codingPath: [CodingKey] {
//        encoder.codingPath
//    }
//
//    init(encoder: SJEncoder, node: JSON, key: CodingKey? = nil) {
//        self.encoder = encoder
//        self.key = key
//        self.node = node
//    }
//
//    private mutating func check(_ value: Any = "null") throws {
//        if written {
//            let context = EncodingError.Context(codingPath: encoder.codingPath,
//                debugDescription: "")
//            throw EncodingError.invalidValue(value, context)
//        }
//        written = true
//    }
//
//    mutating func encodeNil() throws {
//        try check()
//        node.kind = JSONType.null
//    }
//
//    mutating func encode(_ value: Bool) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: String) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: Double) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: Float) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: Int) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: Int8) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: Int16) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: Int32) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: Int64) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: UInt) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: UInt8) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: UInt16) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: UInt32) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode(_ value: UInt64) throws {
//        try check()
//        node.fill(value)
//    }
//
//    mutating func encode<T>(_ value: T) throws where T: Encodable {
//        try check()
//        try encoder.encode(value)
//    }
//}
//
//struct SJEUnkeyedContainer: UnkeyedEncodingContainer {
//    let encoder: SJEncoder
//    private(set) var key: CodingKey?
//    private(set) var count: Int = 0
//
//    var codingPath: [CodingKey] {
//        encoder.codingPath
//    }
//
//    init(encoder: SJEncoder, key: CodingKey? = nil) {
//        self.encoder = encoder
//        self.key = key
//    }
//
//    func prefix() {
//        if count > 1 {
//            encoder.current.append(0x2c)
//        }
//    }
//
//    func postfix() {
//    }
//
//    mutating func encodeNil() throws {
//        count += 1
//        prefix()
//        encoder.current.writeNull()
//        postfix()
//    }
//
//    mutating func encode(_ value: Bool) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: String) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Double) throws {
////        encoder.codingPath.append(StartCodingKey(count))
////        defer {
////            encoder.codingPath.removeLast()
////        }
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Float) throws {
////        encoder.codingPath.append(StartCodingKey(count))
////        defer {
////            encoder.codingPath.removeLast()
////        }
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Int) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Int8) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Int16) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Int32) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Int64) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: UInt) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: UInt8) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: UInt16) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: UInt32) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: UInt64) throws {
//        count += 1
//        prefix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode<T>(_ value: T) throws where T: Encodable {
//        encoder.codingPath.append(StartCodingKey(count))
//        defer {
//            encoder.codingPath.removeLast()
//        }
//        count += 1
//        do {
//            try encoder.encode(value)
//        } catch let error {
//            encoder.removeLastNode()
//            throw error
//        }
//        guard let data = encoder.popNode() else {
//            return
//        }
//        prefix()
//        switch data.kind {
//        case .single:
//            encoder.current.write(data)
//        case .array:
//            encoder.current.append(0x5b)
//            encoder.current.write(data)
//            encoder.current.append(0x5d)
//        case .object:
//            encoder.current.append(0x7b)
//            encoder.current.write(data)
//            encoder.current.append(0x7d)
//        }
//        postfix()
//    }
//
//    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type)
//            -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
//        count += 1
//        return encoder.container(keyedBy: keyType)
//    }
//
//    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
//        count += 1
//        return encoder.unkeyedContainer()
//    }
//
//    mutating func superEncoder() -> Encoder {
//        encoder
//    }
//}
//
//struct SJEKeyedContainer<Key>: KeyedEncodingContainerProtocol where Key: CodingKey {
//    let encoder: SJEncoder
//    private(set) var data = Data()
//    private(set) var key: CodingKey?
//    private(set) var keys: Set<String> = []
//
//    var codingPath: [CodingKey] {
//        encoder.codingPath
//    }
//
//    init(encoder: SJEncoder, key: CodingKey? = nil) {
//        self.encoder = encoder
//        self.key = key
//    }
//
//    private func prefix() {
//        if keys.isNotEmpty {
//            encoder.current.append(0x2c)
//        }
//    }
//
//    private func infix() {
//        encoder.current.append(0x3a)
//    }
//
//    private func postfix() {
//    }
//
//    private mutating func writeKey(_ key: Key) throws {
//        let value = key.stringValue
//        _ = keys.insert(value)
//        encoder.current.write(value)
//    }
//
//    mutating func encodeNil(forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.writeNull()
//        postfix()
//    }
//
//    mutating func encode(_ value: Bool, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: String, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Double, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Float, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Int, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Int8, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Int16, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Int32, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: Int64, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: UInt, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: UInt8, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: UInt16, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: UInt32, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode(_ value: UInt64, forKey key: Key) throws {
//        prefix()
//        try writeKey(key)
//        infix()
//        encoder.current.write(value)
//        postfix()
//    }
//
//    mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {
//        prefix()
//        try writeKey(key)
//        infix()
//        try encoder.encode(value)
//        postfix()
//    }
//
//    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) ->
//        KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
//        let next = SJEKeyedContainer<NestedKey>(encoder: encoder, key: key)
//        return KeyedEncodingContainer<NestedKey>(next)
//    }
//
//    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
//        SJEUnkeyedContainer(encoder: encoder, key: key)
//    }
//
//    mutating func superEncoder() -> Encoder {
//        encoder
//    }
//
//    mutating func superEncoder(forKey key: Key) -> Encoder {
//        SJEncoder(options: encoder.context, key: key, codingPath: encoder.codingPath)
//    }
//}
