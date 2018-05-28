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

public enum JsonType {
    case string
    case number
    case bool
    case object
    case array
    case null
}

public final class JSON2 {
    static let null: JSON2 = {
        let value = JSON2(raw: NSNull())
        value.resolved = true
        return value
    }()

    let raw: Any
    var element: JsonElement = JsonElement.null
    var resolved = false

    public init(raw: Any) {
        self.raw = raw
    }

    func resolve() {
        guard !resolved else {
            return
        }
        element = JsonElement.create(raw)
        resolved = true
    }
}

extension JSON2 {
    public var string: String? {
        resolve()
        return element.string()
    }

    public var bool: Bool? {
        resolve()
        return element.bool()
    }

    public var float: Float? {
        resolve()
        return element.float()
    }

    public var double: Double? {
        resolve()
        return element.double()
    }

    public var int: Int? {
        resolve()
        return element.int()
    }

    public var int8: Int8? {
        resolve()
        return element.int8()
    }

    public var int16: Int16? {
        resolve()
        return element.int16()
    }

    public var int32: Int32? {
        resolve()
        return element.int32()
    }

    public var int64: Int64? {
        resolve()
        return element.int64()
    }

    public var uint: UInt? {
        resolve()
        return element.uint()
    }

    public var uint8: UInt8? {
        resolve()
        return element.uint8()
    }

    public var uint16: UInt16? {
        resolve()
        return element.uint16()
    }

    public var uint32: UInt32? {
        resolve()
        return element.uint32()
    }

    public var uint64: UInt64? {
        resolve()
        return element.uint64()
    }

    public func string(default: String = "") -> String {
        return self.string ?? `default`
    }

    public func bool(default: Bool = false) -> Bool {
        return self.bool ?? `default`
    }

    public func float(default: Float = 0) -> Float {
        return self.float ?? `default`
    }

    public func double(default: Double = 0) -> Double {
        return self.double ?? `default`
    }

    public func int(default: Int = 0) -> Int {
        return self.int ?? `default`
    }

    public func int8(default: Int8 = 0) -> Int8 {
        return self.int8 ?? `default`
    }

    public func int16(default: Int16 = 0) -> Int16 {
        return self.int16 ?? `default`
    }

    public func int32(default: Int32 = 0) -> Int32 {
        return self.int32 ?? `default`
    }

    public func int64(default: Int64 = 0) -> Int64 {
        return self.int64 ?? `default`
    }

    public func uint(default: UInt = 0) -> UInt {
        return self.uint ?? `default`
    }

    public func uint8(default: UInt8 = 0) -> UInt8 {
        return self.uint8 ?? `default`
    }

    public func uint16(default: UInt16 = 0) -> UInt16 {
        return self.uint16 ?? `default`
    }

    public func uint32(default: UInt32 = 0) -> UInt32 {
        return self.uint32 ?? `default`
    }

    public func uint64(default: UInt64 = 0) -> UInt64 {
        return self.uint64 ?? `default`
    }
}

extension JSON2 {
    public var array: [JSON2]? {
        resolve()
        return element.array()?.map(JSON2.init(raw:))
    }

    public var object: [String: JSON2]? {
        resolve()
        return element.object()?.mapValues(JSON2.init(raw:))
    }

    public func array(default: [JSON2] = []) -> [JSON2] {
        return self.array ?? `default`
    }

    public func object(default: [String: JSON2] = [:]) -> [String: JSON2] {
        return self.object ?? `default`
    }
}

extension JSON2 {
    public subscript(key: String) -> JSON2 {
        return self.object?[key] ?? JSON2.null
    }

    public subscript(key: Int) -> JSON2 {
        guard key > -1, let array = self.array, key < array.count else {
            return JSON2.null
        }
        return array[key]
    }
}

extension JSON2: Equatable {
    public static func ==(lhs: JSON2, rhs: JSON2) -> Bool {
        lhs.resolve()
        rhs.resolve()
        return lhs.element == rhs.element
    }
}

extension JSON2 {
    public func map<T>(_ transform: (JSON2) throws -> T) rethrows -> [T] {
        return try array().map(transform)
    }

    public func map<T>(_ transform: (String, JSON2) throws -> T) rethrows -> [T] {
        return try object().map(transform)
    }

    public func mapValues<T>(_ transform: (JSON2) throws -> T) rethrows -> [String: T] {
        return try object().mapValues(transform)
    }

    public func compactMap<T>(_ transform: (JSON2) throws -> T?) rethrows -> [T] {
        return try array().compactMap(transform)
    }

    public func compactMap<T>(_ transform: (String, JSON2) throws -> T?) rethrows -> [T] {
        return try object().compactMap(transform)
    }
}
