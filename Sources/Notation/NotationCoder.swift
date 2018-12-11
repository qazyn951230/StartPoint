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

public class NotationDecoder {
    static func decodeJSON<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        let json = try JSON.parse(data, option: [])
        let decoder = NotatedDecoder<JSON>(json)
        return try T.init(from: decoder)
    }
}

struct NotatedKey: CodingKey, Equatable {
    let stringValue: String
    let value: Int

    var intValue: Int? {
        return value > -1 ? value : nil
    }

    var key: String{
        return stringValue
    }

    init(string: String) {
        self.stringValue = string
        self.value = -1
    }

    init(int: Int) {
        self.stringValue = String(int)
        self.value = int
    }

    init?(stringValue: String) {
        self.init(string: stringValue)
    }

    init?(intValue: Int) {
        self.init(int: intValue)
    }
}

private func codingMapKey<Value>(item: (key: String, value: Value)) -> NotatedKey
    where Value: Notated, Value.Value == Value {
    return NotatedKey(string: item.key)
}

private func codingListKey<Value>(item: (value: Value, index: Int)) -> NotatedKey
    where Value: Notated, Value.Value == Value {
    return NotatedKey(int: item.index)
}

class NotatedDecoder<Value>: Decoder where Value: Notated, Value.Value == Value {
    let codingPath: [NotatedKey]
    let userInfo: [CodingUserInfoKey: Any]

    let value: Value

    init(_ value: Value) {
        self.value = value
        codingPath = []
        userInfo = [:]
    }

    func container<Key>(keyedBy type: Key.Type) throws
            -> KeyedDecodingContainer<Key> where Key: CodingKey {
        fatalError("container(keyedBy:) has not been implemented")
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        fatalError("unkeyedContainer() has not been implemented")
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        fatalError("singleValueContainer() has not been implemented")
    }
}

class NotatedKeyedDecodingContainer<Value>: KeyedDecodingContainerProtocol
    where Value: Notated, Value.Value == Value{
    typealias Key = NotatedKey
    let codingPath: [CodingKey] = []

    let map: Value
    let keys: Set<String>

    init(map: Value) {
        self.map = map
        keys = Set<String>(map.dictionary.keys)
    }

    var allKeys: [NotatedKey] {
        return keys.map(NotatedKey.init(string:))
    }

    func contains(_ key: NotatedKey) -> Bool {
        return keys.contains(key.key)
    }

    func decodeNil(forKey key: NotatedKey) throws -> Bool {
        return true
    }

    func decode(_ type: Bool.Type, forKey key: NotatedKey) throws -> Bool {
        return map[key.key].bool
    }

    func decode(_ type: String.Type, forKey key: NotatedKey) throws -> String {
        return map[key.key].string
    }

    func decode(_ type: Double.Type, forKey key: NotatedKey) throws -> Double {
        return map[key.key].double
    }

    func decode(_ type: Float.Type, forKey key: NotatedKey) throws -> Float {
        return map[key.key].float
    }

    func decode(_ type: Int.Type, forKey key: NotatedKey) throws -> Int {
        return map[key.key].int
    }

    func decode(_ type: Int8.Type, forKey key: NotatedKey) throws -> Int8 {
        let value = map[key.key].int
        if value > Int8.max {
            return 0
        }
        return Int8(value)
    }

    func decode(_ type: Int16.Type, forKey key: NotatedKey) throws -> Int16 {
        let value = map[key.key].int
        if value > Int16.max {
            return 0
        }
        return Int16(value)
    }

    func decode(_ type: Int32.Type, forKey key: NotatedKey) throws -> Int32 {
        return map[key.key].int32
    }

    func decode(_ type: Int64.Type, forKey key: NotatedKey) throws -> Int64 {
        return map[key.key].int64
    }

    func decode(_ type: UInt.Type, forKey key: NotatedKey) throws -> UInt {
        return map[key.key].uint
    }

    func decode(_ type: UInt8.Type, forKey key: NotatedKey) throws -> UInt8 {
        let value = map[key.key].uint
        if value > UInt8.max {
            return 0
        }
        return UInt8(value)
    }

    func decode(_ type: UInt16.Type, forKey key: NotatedKey) throws -> UInt16 {
        let value = map[key.key].uint
        if value > UInt16.max {
            return 0
        }
        return UInt16(value)
    }

    func decode(_ type: UInt32.Type, forKey key: NotatedKey) throws -> UInt32 {
        return map[key.key].uint32
    }

    func decode(_ type: UInt64.Type, forKey key: NotatedKey) throws -> UInt64 {
        return map[key.key].uint64
    }

    func decode<T>(_ type: T.Type, forKey key: NotatedKey) throws -> T where T: Decodable {
        fatalError("decode(_:forKey:) has not been implemented")
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: NotatedKey) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        fatalError("nestedContainer(keyedBy:forKey:) has not been implemented")
    }

    func nestedUnkeyedContainer(forKey key: NotatedKey) throws -> UnkeyedDecodingContainer {
        fatalError("nestedUnkeyedContainer(forKey:) has not been implemented")
    }

    func superDecoder() throws -> Decoder {
        fatalError("superDecoder() has not been implemented")
    }

    func superDecoder(forKey key: NotatedKey) throws -> Decoder {
        fatalError("superDecoder(forKey:) has not been implemented")
    }
}
