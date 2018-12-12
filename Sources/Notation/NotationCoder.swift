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

public class NotationCoder {
    public static func decodeJSON<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        let json = try JSON.parse(data, option: [])
        let decoder = NotatedDecoder<JSON>(json)
        return try T.init(from: decoder)
    }
}

public class NotatedDecoder<Value>: Decoder where Value: Notated, Value.Value == Value {
    public var codingPath: [CodingKey] = []
    public var userInfo: [CodingUserInfoKey: Any] = [:]

    let value: Value

    public init(_ value: Value) {
        self.value = value
    }

    public func container<Key>(keyedBy type: Key.Type) throws
            -> KeyedDecodingContainer<Key> where Key: CodingKey {
        let temp = NotatedKeyedDecodingContainer<Value, Key>(value)
        return KeyedDecodingContainer<Key>(temp)
    }

    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return NotatedUnkeyedDecodingContainer(value)
    }

    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        return NotatedValueDecodingContainer(value)
    }
}

struct NotatedKey: CodingKey {
    let key: String
    let index: Int

    var stringValue: String {
        return key
    }

    var intValue: Int? {
        return index > -1 ? index : nil
    }

    init(string: String) {
        key = string
        index = -1
    }

    init(int: Int) {
        index = int
        key = ""
    }

    init?(stringValue: String) {
        self.init(string: stringValue)
    }

    init?(intValue: Int) {
        self.init(int: intValue)
    }
}

final class NotatedKeyedDecodingContainer<Value, Key>: KeyedDecodingContainerProtocol
    where Value: Notated, Value.Value == Value, Key: CodingKey {
    let codingPath: [CodingKey] = []

    let value: Value
    let keys: Set<String>

    init(_ value: Value) {
        self.value = value
        keys = Set<String>(value.dictionary.keys)
    }

    var allKeys: [Key] {
        return keys.compactMap(Key.init(stringValue:))
    }

    func contains(_ key: Key) -> Bool {
        return keys.contains(key.stringValue)
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        return !value[key.stringValue].exists
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        return value[key.stringValue].bool
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        return value[key.stringValue].string
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        return value[key.stringValue].double
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        return value[key.stringValue].float
    }

    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        return value[key.stringValue].int
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        let value = self.value[key.stringValue].int
        if value > Int8.max {
            return 0
        }
        return Int8(value)
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        let value = self.value[key.stringValue].int
        if value > Int16.max {
            return 0
        }
        return Int16(value)
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        return value[key.stringValue].int32
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        return value[key.stringValue].int64
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        return value[key.stringValue].uint
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        let value = self.value[key.stringValue].uint
        if value > UInt8.max {
            return 0
        }
        return UInt8(value)
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        let value = self.value[key.stringValue].uint
        if value > UInt16.max {
            return 0
        }
        return UInt16(value)
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        return value[key.stringValue].uint32
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        return value[key.stringValue].uint64
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        let decoder = NotatedDecoder(value[key.stringValue])
        return try T.init(from: decoder)
    }

    func decodeIfPresent(_ type: Bool.Type, forKey key: Key) throws -> Bool? {
        return value[key.stringValue].boolValue
    }

    func decodeIfPresent(_ type: String.Type, forKey key: Key) throws -> String? {
        return value[key.stringValue].stringValue
    }

    func decodeIfPresent(_ type: Double.Type, forKey key: Key) throws -> Double? {
        return value[key.stringValue].doubleValue
    }

    func decodeIfPresent(_ type: Float.Type, forKey key: Key) throws -> Float? {
        return value[key.stringValue].floatValue
    }

    func decodeIfPresent(_ type: Int.Type, forKey key: Key) throws -> Int? {
        return value[key.stringValue].intValue
    }

    func decodeIfPresent(_ type: Int8.Type, forKey key: Key) throws -> Int8? {
        guard let value = self.value[key.stringValue].intValue, value <= Int8.max else {
            return nil
        }
        return Int8(value)
    }

    func decodeIfPresent(_ type: Int16.Type, forKey key: Key) throws -> Int16? {
        guard let value = self.value[key.stringValue].intValue, value <= Int16.max else {
            return nil
        }
        return Int16(value)
    }

    func decodeIfPresent(_ type: Int32.Type, forKey key: Key) throws -> Int32? {
        return value[key.stringValue].int32
    }

    func decodeIfPresent(_ type: Int64.Type, forKey key: Key) throws -> Int64? {
        return value[key.stringValue].int64
    }

    func decodeIfPresent(_ type: UInt.Type, forKey key: Key) throws -> UInt? {
        return value[key.stringValue].uint
    }

    func decodeIfPresent(_ type: UInt8.Type, forKey key: Key) throws -> UInt8? {
        guard let value = self.value[key.stringValue].uintValue, value <= UInt8.max else {
            return nil
        }
        return UInt8(value)
    }

    func decodeIfPresent(_ type: UInt16.Type, forKey key: Key) throws -> UInt16? {
        guard let value = self.value[key.stringValue].uintValue, value <= UInt16.max else {
            return nil
        }
        return UInt16(value)
    }

    func decodeIfPresent(_ type: UInt32.Type, forKey key: Key) throws -> UInt32? {
        return value[key.stringValue].uint32
    }

    func decodeIfPresent(_ type: UInt64.Type, forKey key: Key) throws -> UInt64? {
        return value[key.stringValue].uint64
    }

    func decodeIfPresent<T>(_ type: T.Type, forKey key: Key) throws -> T? where T: Decodable {
        let value = self.value[key.stringValue]
        if !value.exists {
            return nil
        }
        let decoder = NotatedDecoder(value)
        return try T.init(from: decoder)
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        let temp = NotatedKeyedDecodingContainer<Value, NestedKey>(value[key.stringValue])
        return KeyedDecodingContainer<NestedKey>(temp)
    }

    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        return NotatedUnkeyedDecodingContainer(value[key.stringValue])
    }

    func superDecoder() throws -> Decoder {
        return NotatedDecoder(value)
    }

    func superDecoder(forKey key: Key) throws -> Decoder {
        return NotatedDecoder(value[key.stringValue])
    }
}

final class NotatedUnkeyedDecodingContainer<Value>: UnkeyedDecodingContainer
    where Value: Notated, Value.Value == Value {
    let count: Int?
    private(set) var currentIndex: Int = 0

    let value: Value

    init(_ value: Value) {
        self.value = value
        count = value.array.count
    }

    var isAtEnd: Bool {
        let max = count ?? 0
        return currentIndex >= max
    }

    var codingPath: [CodingKey] {
        return value.array.mapIndexed { (_, index) in
            NotatedKey(int: index)
        }
    }

    func decodeNil() throws -> Bool {
        if !value[currentIndex].exists {
            currentIndex += 1
            return true
        }
        return false
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].bool
    }

    func decode(_ type: String.Type) throws -> String {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].string
    }

    func decode(_ type: Double.Type) throws -> Double {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].double
    }

    func decode(_ type: Float.Type) throws -> Float {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].float
    }

    func decode(_ type: Int.Type) throws -> Int {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].int
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        defer {
            currentIndex += 1
        }
        let value = self.value[currentIndex].int
        if value > Int8.max {
            return 0
        }
        return Int8(value)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        defer {
            currentIndex += 1
        }
        let value = self.value[currentIndex].int
        if value > Int16.max {
            return 0
        }
        return Int16(value)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].int32
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].int64
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].uint
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        defer {
            currentIndex += 1
        }
        let value = self.value[currentIndex].uint
        if value > UInt8.max {
            return 0
        }
        return UInt8(value)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        defer {
            currentIndex += 1
        }
        let value = self.value[currentIndex].uint
        if value > UInt16.max {
            return 0
        }
        return UInt16(value)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].uint32
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].uint64
    }

    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        defer {
            currentIndex += 1
        }
        let decoder = NotatedDecoder(value[currentIndex])
        return try T.init(from: decoder)
    }

    func decodeIfPresent(_ type: Bool.Type) throws -> Bool? {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].boolValue
    }

    func decodeIfPresent(_ type: String.Type) throws -> String? {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].stringValue
    }

    func decodeIfPresent(_ type: Double.Type) throws -> Double? {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].doubleValue
    }

    func decodeIfPresent(_ type: Float.Type) throws -> Float? {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].floatValue
    }

    func decodeIfPresent(_ type: Int.Type) throws -> Int? {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].intValue
    }

    func decodeIfPresent(_ type: Int8.Type) throws -> Int8? {
        defer {
            currentIndex += 1
        }
        guard let value = self.value[currentIndex].intValue, value <= Int8.max else {
            return nil
        }
        return Int8(value)
    }

    func decodeIfPresent(_ type: Int16.Type) throws -> Int16? {
        defer {
            currentIndex += 1
        }
        guard let value = self.value[currentIndex].intValue, value <= Int16.max else {
            return nil
        }
        return Int16(value)
    }

    func decodeIfPresent(_ type: Int32.Type) throws -> Int32? {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].int32Value
    }

    func decodeIfPresent(_ type: Int64.Type) throws -> Int64? {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].int64Value
    }

    func decodeIfPresent(_ type: UInt.Type) throws -> UInt? {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].uintValue
    }

    func decodeIfPresent(_ type: UInt8.Type) throws -> UInt8? {
        defer {
            currentIndex += 1
        }
        guard let value = self.value[currentIndex].uintValue, value <= UInt8.max else {
            return nil
        }
        return UInt8(value)
    }

    func decodeIfPresent(_ type: UInt16.Type) throws -> UInt16? {
        defer {
            currentIndex += 1
        }
        guard let value = self.value[currentIndex].uintValue, value <= UInt16.max else {
            return nil
        }
        return UInt16(value)
    }

    func decodeIfPresent(_ type: UInt32.Type) throws -> UInt32? {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].uint32Value
    }

    func decodeIfPresent(_ type: UInt64.Type) throws -> UInt64? {
        defer {
            currentIndex += 1
        }
        return value[currentIndex].uint64Value
    }

    func decodeIfPresent<T>(_ type: T.Type) throws -> T? where T: Decodable {
        defer {
            currentIndex += 1
        }
        let value = self.value[currentIndex]
        if !value.exists {
            return nil
        }
        let decoder = NotatedDecoder(value)
        return try T.init(from: decoder)
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws
            -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        defer {
            currentIndex += 1
        }
        let temp = NotatedKeyedDecodingContainer<Value, NestedKey>(value[currentIndex])
        return KeyedDecodingContainer<NestedKey>(temp)
    }

    func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        defer {
            currentIndex += 1
        }
        return NotatedUnkeyedDecodingContainer(value[currentIndex])
    }

    func superDecoder() throws -> Decoder {
        return NotatedDecoder(value)
    }
}


final class NotatedValueDecodingContainer<Value>: SingleValueDecodingContainer
    where Value: Notated, Value.Value == Value {
    private(set) var codingPath: [CodingKey] = []
    let value: Value

    init(_ value: Value) {
        self.value = value
    }

    func decodeNil() -> Bool {
        return !value.exists
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        return value.bool
    }

    func decode(_ type: String.Type) throws -> String {
        return value.string
    }

    func decode(_ type: Double.Type) throws -> Double {
        return value.double
    }

    func decode(_ type: Float.Type) throws -> Float {
        return value.float
    }

    func decode(_ type: Int.Type) throws -> Int {
        return value.int
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        let value = self.value.int
        if value > Int8.max {
            return 0
        }
        return Int8(value)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        let value = self.value.int
        if value > Int16.max {
            return 0
        }
        return Int16(value)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        return value.int32
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        return value.int64
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        return value.uint
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        let value = self.value.uint
        if value > UInt8.max {
            return 0
        }
        return UInt8(value)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        let value = self.value.uint
        if value > UInt16.max {
            return 0
        }
        return UInt16(value)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        return value.uint32
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        return value.uint64
    }

    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        let decoder = NotatedDecoder(value)
        return try T.init(from: decoder)
    }
}

