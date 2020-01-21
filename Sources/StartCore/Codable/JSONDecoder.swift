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
// Same API with JSONDecoder
public final class StartJSONDecoder {
    public var userInfo: [CodingUserInfoKey: Any] = [:]
    public var keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.useDefaultKeys
    public var dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.deferredToDate
    public var dataDecodingStrategy = JSONDecoder.DataDecodingStrategy.base64
    public var nonConformingFloatDecodingStrategy = JSONDecoder.NonConformingFloatDecodingStrategy.throw

    public init() {
        // Do nothing.
    }

    public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        var json = JSON.null
        do {
            json = try JSON.parse(data: data)
        } catch let error {
            let context = DecodingError.Context(codingPath: [],
                debugDescription: SJDecoder.jsonParseError(error), underlyingError: error)
            throw DecodingError.dataCorrupted(context)
        }
        let options = SJDecoderOptions(buffer: json.buffer, userInfo: userInfo,
            keyDecodingStrategy: keyDecodingStrategy,
            dateDecodingStrategy: dateDecodingStrategy,
            dataDecodingStrategy: dataDecodingStrategy,
            nonConformingFloatDecodingStrategy: nonConformingFloatDecodingStrategy)
        let decoder = SJDecoder(value: json.ref, options: options, codingPath: [])
        return try decoder.decode(type, value: json.ref, key: nil)
    }
}

final class SJDecoderOptions {
    let buffer: JSONBuffer
    let userInfo: [CodingUserInfoKey: Any]
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
}

final class SJDecoder: Decoder {
    private(set) var codingPath: [CodingKey]
    private(set) var knownKeys: [String: String] = [:]
    let value: JSONRef
    let options: SJDecoderOptions

    var userInfo: [CodingUserInfoKey: Any] {
        options.userInfo
    }

    fileprivate lazy var iso8601Formatter: ISO8601DateFormatter = {
        ISO8601DateFormatter()
    }()

    init(value: JSONRef, options: SJDecoderOptions, codingPath: [CodingKey]) {
        self.value = value
        self.options = options
        self.codingPath = codingPath
    }

    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
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
    func findKey<Key>(_ key: Key) -> String where Key: CodingKey {
        let raw = key.stringValue
        if let key = knownKeys[raw] {
            return key
        }
        let next = decodeKey(key)
        knownKeys[raw] = next
        return next
    }

    @inline(__always)
    private func decodeKey<Key>(_ key: Key) -> String where Key: CodingKey {
        switch options.keyDecodingStrategy {
        case .useDefaultKeys:
            return key.stringValue
        case .convertFromSnakeCase:
            return SJDecoder.convertFromSnakeCase(key.stringValue)
        case let .custom(method):
            var path = codingPath
            path.append(key)
            return method(path).stringValue
        @unknown default:
            return key.stringValue
        }
    }

    @inline(__always)
    fileprivate func appendKey(_ value: UInt32) {
        codingPath.append(AnyCodingKey(Int(value)))
    }

    @inline(__always)
    fileprivate func appendKey(_ value: String) {
        codingPath.append(AnyCodingKey(value))
    }

    @inline(__always)
    fileprivate func removeLastKey() {
        codingPath.removeLast()
    }

    @inline(__always)
    func decodeNil(_ value: JSONRef) -> Bool {
        json_is_null(value)
    }

    @inline(__always)
    func decodeBool(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> Bool {
        var result = false
        if json_get_bool(value, &result) {
            return result
        } else {
            throw typeMismatchError(value, type: Bool.self, key: key())
        }
    }

    @inline(__always)
    func decodeString(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> String {
        if let result = JSON.decodeString(ref: value) {
            return result
        } else {
            throw typeMismatchError(value, type: String.self, key: key())
        }
    }

    @inline(__always)
    func decodeDouble(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> Double {
        var result: Double = 0
        if json_get_double(value, &result) {
            return result
        } else {
            switch options.nonConformingFloatDecodingStrategy {
            case let .convertFromString(positiveInfinity, negativeInfinity, nan):
                if let text = JSON.decodeString(ref: value) {
                    switch text {
                    case positiveInfinity:
                        return Double.infinity
                    case negativeInfinity:
                        return -Double.infinity
                    case nan:
                        return Double.nan
                    default:
                        break
                    }
                }
            case .throw:
                break
            @unknown default:
                break
            }
            throw typeMismatchError(value, type: Double.self, key: key())
        }
    }

    @inline(__always)
    func decodeFloat(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> Float {
        var result: Float = 0
        if json_get_float(value, &result) {
            return result
        } else {
            switch options.nonConformingFloatDecodingStrategy {
            case let .convertFromString(positiveInfinity, negativeInfinity, nan):
                if let text = JSON.decodeString(ref: value) {
                    switch text {
                    case positiveInfinity:
                        return Float.infinity
                    case negativeInfinity:
                        return -Float.infinity
                    case nan:
                        return Float.nan
                    default:
                        break
                    }
                }
            case .throw:
                break
            @unknown default:
                break
            }
            throw typeMismatchError(value, type: Float.self, key: key())
        }
    }

    @inline(__always)
    func decodeInt(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> Int {
#if arch(arm64) || arch(x86_64)
        var result: Int64 = 0
        if json_get_int64(value, &result) {
            return Int(result)
        } else {
            throw typeMismatchError(value, type: Int.self, key: key())
        }
#else
        var result: Int32 = 0
        if json_get_int32(value, &result) {
            return Int(result)
        } else {
            throw typeMismatchError(value, type: Int.self, key: key())
        }
#endif
    }

    @inline(__always)
    func decodeInt8(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> Int8 {
        var result: Int32 = 0
        if json_get_int32(value, &result), let next = Int8(exactly: result) {
            return next
        } else {
            throw typeMismatchError(value, type: Int8.self, key: key())
        }
    }

    @inline(__always)
    func decodeInt16(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> Int16 {
        var result: Int32 = 0
        if json_get_int32(value, &result), let next = Int16(exactly: result) {
            return next
        } else {
            throw typeMismatchError(value, type: Int16.self, key: key())
        }
    }

    @inline(__always)
    func decodeInt32(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> Int32 {
        var result: Int32 = 0
        if json_get_int32(value, &result) {
            return result
        } else {
            throw typeMismatchError(value, type: Int32.self, key: key())
        }
    }

    @inline(__always)
    func decodeInt64(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> Int64 {
        var result: Int64 = 0
        if json_get_int64(value, &result) {
            return result
        } else {
            throw typeMismatchError(value, type: Int64.self, key: key())
        }
    }

    @inline(__always)
    func decodeUInt(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> UInt {
#if arch(arm64) || arch(x86_64)
        var result: UInt64 = 0
        if json_get_uint64(value, &result) {
            return UInt(result)
        } else {
            throw typeMismatchError(value, type: UInt.self, key: key())
        }
#else
        var result: UInt32 = 0
        if json_get_uint32(value, &result) {
            return UInt(result)
        } else {
            throw typeMismatchError(value, type: UInt.self, key: key())
        }
#endif
    }

    @inline(__always)
    func decodeUInt8(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> UInt8 {
        var result: UInt32 = 0
        if json_get_uint32(value, &result), let next = UInt8(exactly: result) {
            return next
        } else {
            throw typeMismatchError(value, type: UInt8.self, key: key())
        }
    }

    @inline(__always)
    func decodeUInt16(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> UInt16 {
        var result: UInt32 = 0
        if json_get_uint32(value, &result), let next = UInt16(exactly: result) {
            return next
        } else {
            throw typeMismatchError(value, type: UInt16.self, key: key())
        }
    }

    @inline(__always)
    func decodeUInt32(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> UInt32 {
        var result: UInt32 = 0
        if json_get_uint32(value, &result) {
            return result
        } else {
            throw typeMismatchError(value, type: UInt32.self, key: key())
        }
    }

    @inline(__always)
    func decodeUInt64(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> UInt64 {
        var result: UInt64 = 0
        if json_get_uint64(value, &result) {
            return result
        } else {
            throw typeMismatchError(value, type: UInt64.self, key: key())
        }
    }

    @inline(__always)
    func decode<T>(_ type: T.Type, value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws
            -> T where T: Decodable {
        if type == Date.self {
            return try decodeDate(value, key: key()) as! T
        } else if type == Data.self {
            return try decodeData(value, key: key()) as! T
        } else {
            var path = codingPath
            if let next = key() {
                path.append(next)
            }
            let next = SJDecoder(value: value, options: options, codingPath: path)
            return try T.init(from: next)
        }
    }

    @inline(__always)
    private func decodeDate(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> Date {
        switch options.dateDecodingStrategy {
        case .secondsSince1970:
            let time = try decodeDouble(value, key: key())
            return Date(timeIntervalSince1970: time)
        case .millisecondsSince1970:
            let time = try decodeDouble(value, key: key())
            return Date(timeIntervalSince1970: time / 1000)
        case .iso8601:
            let time = try decodeString(value, key: key())
            if let date = iso8601Formatter.date(from: time) {
                return date
            } else {
                throw typeMismatchError(value, type: Date.self, key: key())
            }
        case let .formatted(formatter):
            let time = try decodeString(value, key: key())
            if let date = formatter.date(from: time) {
                return date
            } else {
                throw typeMismatchError(value, type: Date.self, key: key())
            }
        case let .custom(method):
            return try method(self)
        case .deferredToDate:
            fallthrough
        @unknown default:
            return try Date.init(from: self)
        }
    }

    @inline(__always)
    private func decodeData(_ value: JSONRef, key: @autoclosure () -> AnyCodingKey?) throws -> Data {
        switch options.dataDecodingStrategy {
        case .deferredToData:
            return try Data.init(from: self)
        case let .custom(method):
            return try method(self)
        case .base64:
            fallthrough
        @unknown default:
            let text = try decodeString(value, key: key())
            if let data = Data(base64Encoded: text) {
                return data
            } else {
                throw typeMismatchError(value, type: Data.self, key: key())
            }
        }
    }

    // Copy from .../swift/stdlib/public/Darwin/Foundation/JSONEncoder.swift _convertFromSnakeCase
    @inline(__always)
    private static func convertFromSnakeCase(_ stringKey: String) -> String {
        if stringKey.isEmpty {
            return stringKey
        }

        // Find the first non-underscore character
        guard let firstNonUnderscore = stringKey.firstIndex(where: { $0 != "_" }) else {
            // Reached the end without finding an _
            return stringKey
        }

        // Find the last non-underscore character
        var lastNonUnderscore = stringKey.index(before: stringKey.endIndex)
        while lastNonUnderscore > firstNonUnderscore && stringKey[lastNonUnderscore] == "_" {
            stringKey.formIndex(before: &lastNonUnderscore)
        }

        let keyRange = firstNonUnderscore...lastNonUnderscore
        let leadingUnderscoreRange = stringKey.startIndex..<firstNonUnderscore
        let trailingUnderscoreRange = stringKey.index(after: lastNonUnderscore)..<stringKey.endIndex

        let components = stringKey[keyRange].split(separator: "_")
        let joinedString: String
        if components.count == 1 {
            // No underscores in key, leave the word as is - maybe already camel cased
            joinedString = String(stringKey[keyRange])
        } else {
            joinedString = ([components[0].lowercased()] + components[1...].map {
                $0.capitalized
            }).joined()
        }

        // Do a cheap isEmpty check before creating and appending potentially empty strings
        let result: String
        if (leadingUnderscoreRange.isEmpty && trailingUnderscoreRange.isEmpty) {
            result = joinedString
        } else if (!leadingUnderscoreRange.isEmpty && !trailingUnderscoreRange.isEmpty) {
            // Both leading and trailing underscores
            result = String(stringKey[leadingUnderscoreRange]) + joinedString +
                String(stringKey[trailingUnderscoreRange])
        } else if (!leadingUnderscoreRange.isEmpty) {
            // Just leading
            result = String(stringKey[leadingUnderscoreRange]) + joinedString
        } else {
            // Just trailing
            result = joinedString + String(stringKey[trailingUnderscoreRange])
        }
        return result
    }

    @inline(__always)
    func typeMismatchError(_ value: JSONRef, type: Any.Type, key: CodingKey?) -> DecodingError {
        var path = codingPath
        if let next = key {
            path.append(next)
        }
        let context = DecodingError.Context(codingPath: path,
            debugDescription: SJDecoder.typeMismatchDescription(value))
        return DecodingError.typeMismatch(type, context)
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
}

struct SJDSingleContainer: SingleValueDecodingContainer {
    let value: JSONRef
    let decoder: SJDecoder

    var codingPath: [CodingKey] {
        decoder.codingPath
    }

    init(decoder: SJDecoder) throws {
        self.value = decoder.value
        self.decoder = decoder
    }

    func decodeNil() -> Bool {
        decoder.decodeNil(value)
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        try decoder.decodeBool(value, key: nil)
    }

    func decode(_ type: String.Type) throws -> String {
        try decoder.decodeString(value, key: nil)
    }

    func decode(_ type: Double.Type) throws -> Double {
        try decoder.decodeDouble(value, key: nil)
    }

    func decode(_ type: Float.Type) throws -> Float {
        try decoder.decodeFloat(value, key: nil)
    }

    func decode(_ type: Int.Type) throws -> Int {
        try decoder.decodeInt(value, key: nil)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        try decoder.decodeInt8(value, key: nil)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        try decoder.decodeInt16(value, key: nil)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        try decoder.decodeInt32(value, key: nil)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        try decoder.decodeInt64(value, key: nil)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        try decoder.decodeUInt(value, key: nil)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try decoder.decodeUInt8(value, key: nil)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try decoder.decodeUInt16(value, key: nil)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try decoder.decodeUInt32(value, key: nil)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try decoder.decodeUInt64(value, key: nil)
    }

    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        try decoder.decode(type, value: value, key: nil)
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
        guard json_is_array(value) || json_is_null(value) else {
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
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return decoder.decodeNil(item)
    }

    mutating func decode(_ type: Bool.Type) throws -> Bool {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeBool(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: String.Type) throws -> String {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeString(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: Double.Type) throws -> Double {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeDouble(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: Float.Type) throws -> Float {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeFloat(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: Int.Type) throws -> Int {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeInt(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeInt8(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeInt16(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeInt32(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeInt64(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: UInt.Type) throws -> UInt {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeUInt(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeUInt8(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeUInt16(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeUInt32(item, key: AnyCodingKey(_current))
    }

    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decodeUInt64(item, key: AnyCodingKey(_current))
    }

    mutating func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        return try decoder.decode(type, value: item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: Bool.Type) throws -> Bool? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeBool(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: String.Type) throws -> String? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeString(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: Double.Type) throws -> Double? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeDouble(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: Float.Type) throws -> Float? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeFloat(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: Int.Type) throws -> Int? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeInt(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: Int8.Type) throws -> Int8? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeInt8(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: Int16.Type) throws -> Int16? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeInt16(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: Int32.Type) throws -> Int32? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeInt32(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: Int64.Type) throws -> Int64? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeInt64(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: UInt.Type) throws -> UInt? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeUInt(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: UInt8.Type) throws -> UInt8? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeUInt8(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: UInt16.Type) throws -> UInt16? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeUInt16(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: UInt32.Type) throws -> UInt32? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeUInt32(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent(_ type: UInt64.Type) throws -> UInt64? {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decodeUInt64(item, key: AnyCodingKey(_current))
    }

    mutating func decodeIfPresent<T>(_ type: T.Type) throws -> T? where T: Decodable {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        defer {
            _current += 1
        }
        if decoder.decodeNil(item) {
            return nil
        }
        return try decoder.decode(T.self, value: item, key: AnyCodingKey(_current))
    }

    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws ->
        KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        decoder.appendKey(_current)
        defer {
            _current += 1
            decoder.removeLastKey()
        }
        let nested = try SJDKeyedContainer<NestedKey>(decoder: decoder, value: item)
        return KeyedDecodingContainer(nested)
    }

    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        guard let item = json_array_get_index(value, _current) else {
            throw outOfIndexError()
        }
        decoder.appendKey(_current)
        defer {
            _current += 1
            decoder.removeLastKey()
        }
        return try SJDUnkeyedContainer(decoder: decoder, value: item)
    }

    mutating func superDecoder() throws -> Decoder {
        decoder
    }

    @inline(__always)
    private func outOfIndexError() -> DecodingError {
        var path = decoder.codingPath
        path.append(AnyCodingKey(Int(_current + 1)))
        let context = DecodingError.Context(codingPath: path, debugDescription: SJDecoder.valueOutOfIndex())
        return DecodingError.dataCorrupted(context)
    }
}

struct SJDKeyedContainer<Key>: KeyedDecodingContainerProtocol where Key: CodingKey {
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

    @inline(__always)
    private func contains(key: Key) -> JSONRef? {
        contains(key: decoder.findKey(key))
    }

    @inline(__always)
    private func contains(key: String) -> JSONRef? {
        return key.withCString { pointer in
            json_object_find_key(value, pointer)
        }
    }

    @inline(__always)
    private func find(key: Key) throws -> JSONRef {
        if let item = contains(key: key) {
            return item
        } else {
            throw keyNotFoundError(key: key)
        }
    }

    func contains(_ key: Key) -> Bool {
        contains(key: key) != nil
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        guard let item = contains(key: key) else {
            return true
        }
        return decoder.decodeNil(item)
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        let item = try find(key: key)
        return try decoder.decodeBool(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        let item = try find(key: key)
        return try decoder.decodeString(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        let item = try find(key: key)
        return try decoder.decodeDouble(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        let item = try find(key: key)
        return try decoder.decodeFloat(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        let item = try find(key: key)
        return try decoder.decodeInt(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        let item = try find(key: key)
        return try decoder.decodeInt8(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        let item = try find(key: key)
        return try decoder.decodeInt16(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        let item = try find(key: key)
        return try decoder.decodeInt32(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        let item = try find(key: key)
        return try decoder.decodeInt64(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        let item = try find(key: key)
        return try decoder.decodeUInt(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        let item = try find(key: key)
        return try decoder.decodeUInt8(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        let item = try find(key: key)
        return try decoder.decodeUInt16(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        let item = try find(key: key)
        return try decoder.decodeUInt32(item, key: AnyCodingKey(key.stringValue))
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        let item = try find(key: key)
        return try decoder.decodeUInt64(item, key: AnyCodingKey(key.stringValue))
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        let item = try find(key: key)
        var path = decoder.codingPath
        path.append(key)
        return try decoder.decode(type, value: item, key: AnyCodingKey(key.stringValue))
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws ->
        KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        let item = try find(key: key)
        decoder.appendKey(key.stringValue)
        defer {
            decoder.removeLastKey()
        }
        let next = try SJDKeyedContainer<NestedKey>(decoder: decoder, value: item)
        return KeyedDecodingContainer(next)
    }

    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        let item = try find(key: key)
        decoder.appendKey(key.stringValue)
        defer {
            decoder.removeLastKey()
        }
        return try SJDUnkeyedContainer(decoder: decoder, value: item)
    }

    func superDecoder() throws -> Decoder {
        let key = AnyCodingKey("super")
        guard let item = contains(key: key.stringValue) else {
            var path = decoder.codingPath
            path.append(key)
            let context = DecodingError.Context(codingPath: path, debugDescription: SJDecoder.keyNotFound())
            throw DecodingError.keyNotFound(key, context)
        }
        var path = decoder.codingPath
        path.append(key)
        let next = SJDecoder(value: item, options: decoder.options, codingPath: path)
        return next
    }

    func superDecoder(forKey key: Key) throws -> Decoder {
        let item = try find(key: key)
        var path = decoder.codingPath
        path.append(key)
        let next = SJDecoder(value: item, options: decoder.options, codingPath: path)
        return next
    }

    @inline(__always)
    private func keyNotFoundError(key: Key) -> DecodingError {
        var path = decoder.codingPath
        path.append(AnyCodingKey(key.stringValue))
        let context = DecodingError.Context(codingPath: path, debugDescription: SJDecoder.keyNotFound())
        return DecodingError.keyNotFound(key, context)
    }
}
