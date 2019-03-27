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

precedencegroup DecodePrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
    lowerThan: NilCoalescingPrecedence
}

infix operator <|: DecodePrecedence
infix operator <|?: DecodePrecedence

public protocol BaseNotation {
    static func objects(from notated: Notated) -> [Self]
}

public protocol Notation: BaseNotation {
    init(from notated: Notated)
}

public protocol FailableNotation: BaseNotation {
    init?(from notated: Notated)
}

public protocol ThrowNotation: BaseNotation {
    init(from notated: Notated) throws
}

public protocol StaticNotation: BaseNotation {
    static func create(from notated: Notated) -> Self
}

public protocol RawNotation: StaticNotation, RawRepresentable {
    static var `default`: Self { get }
}

public extension RawNotation where RawValue == String {
    static func create(from notated: Notated) -> Self {
        let temp: Self? = self.init(rawValue: notated.string)
        return temp ?? Self.default
    }
}

public extension RawNotation where RawValue == UInt {
    static func create(from notated: Notated) -> Self {
        let temp: Self? = self.init(rawValue: notated.uint)
        return temp ?? Self.default
    }
}

public extension Notation {
    static func objects(from notated: Notated) -> [Self] {
        return notated.list.map { (value: Notated) -> Self in
            Self.init(from: value)
        }
    }
}

public extension FailableNotation {
    static func objects(from notated: Notated) -> [Self] {
        return notated.list.compactMap { (value: Notated) -> Self? in
            Self.init(from: value)
        }
    }
}

public extension StaticNotation {
    static func objects(from notated: Notated) -> [Self] {
        return notated.list.map { (value: Notated) -> Self in
            Self.create(from: value)
        }
    }
}

// MARK: - Decodable object
public func <|?<T: FailableNotation>(notated: Notated, key: String) -> T? {
    return T.init(from: notated.item(key: key))
}

public func <|<T: Notation>(notated: Notated, key: String) -> T {
    return T.init(from: notated.item(key: key))
}

public func <|?<T: Notation>(notated: Notated, key: String) -> T? {
    let temp: Notated = notated.item(key: key)
    guard temp.exists else {
        return nil
    }
    return T.init(from: temp)
}

public func <|<T: StaticNotation>(notated: Notated, key: String) -> T {
    return T.create(from: notated.item(key: key))
}

public func <|?<T: RawRepresentable>(notated: Notated, key: String) -> T?
    where T.RawValue == String {
    return T.init(rawValue: notated.item(key: key).string)
}

public func <|?<T: BaseNotation>(notated: Notated, key: String) -> [T]? {
    let objects = T.objects(from: notated.item(key: key))
    return objects.count > 0 ? objects : nil
}

public func <|<T: BaseNotation>(notated: Notated, key: String) -> [T] {
    return T.objects(from: notated.item(key: key))
}

// MARK: - Decodable array
public func <|?(notated: Notated, key: String) -> [Notated]? {
    return notated.item(key: key).listValue
}

public func <|(notated: Notated, key: String) -> [Notated] {
    return notated.item(key: key).list
}

// MARK: - Decodable.map
public func <|?(notated: Notated, key: String) -> [String: Notated]? {
    return notated.item(key: key).mapValue
}

public func <|(notated: Notated, key: String) -> [String: Notated] {
    return notated.item(key: key).map
}

public func <|<T: Notation>(notated: Notated, key: String) -> [String: T] {
    return notated.item(key: key).map
        .mapValues(T.init(from:))
}

// MARK: - Decodable bool
public func <|?(notated: Notated, key: String) -> Bool? {
    return notated.item(key: key).boolValue
}

public func <|(notated: Notated, key: String) -> Bool {
    return notated.item(key: key).bool
}

// MARK: - Decodable string
public func <|?(notated: Notated, key: String) -> String? {
    return notated.item(key: key).stringValue
}

public func <|(notated: Notated, key: String) -> String {
    return notated.item(key: key).string
}

public func <|?(notated: Notated, key: String) -> [String]? {
    let array: [Notated]? = notated.item(key: key).listValue
    return array?.compactMap { $0.stringValue }
}

public func <|(notated: Notated, key: String) -> [String] {
    let array: [Notated] = notated.item(key: key).list
    return array.map { $0.string }
}

public func <|(notated: Notated, key: String) -> [String: String] {
    let map: [String: Notated] = notated.item(key: key).map
    return map.mapValues { $0.string }
}

public func <|(notated: Notated, key: String) -> [String: Any] {
    let map: [String: Notated] = notated.item(key: key).map
    return map.mapValues { $0.raw }
}

// Decodable number
public func <|?(notated: Notated, key: String) -> Double? {
    return notated.item(key: key).doubleValue
}

public func <|(notated: Notated, key: String) -> Double {
    return notated.item(key: key).double
}

public func <|?(notated: Notated, key: String) -> Float? {
    return notated.item(key: key).floatValue
}

public func <|(notated: Notated, key: String) -> Float {
    return notated.item(key: key).float
}

public func <|?(notated: Notated, key: String) -> Int? {
    return notated.item(key: key).intValue
}

public func <|(notated: Notated, key: String) -> Int {
    return notated.item(key: key).int
}

public func <|?(notated: Notated, key: String) -> UInt? {
    return notated.item(key: key).uintValue
}

public func <|(notated: Notated, key: String) -> UInt {
    return notated.item(key: key).uint
}

public func <|?(notated: Notated, key: String) -> Int32? {
    return notated.item(key: key).int32Value
}

public func <|(notated: Notated, key: String) -> Int32 {
    return notated.item(key: key).int32
}

public func <|?(notated: Notated, key: String) -> UInt32? {
    return notated.item(key: key).uint32Value
}

public func <|(notated: Notated, key: String) -> UInt32 {
    return notated.item(key: key).uint32
}

public func <|?(notated: Notated, key: String) -> Int64? {
    return notated.item(key: key).int64Value
}

public func <|(notated: Notated, key: String) -> Int64 {
    return notated.item(key: key).int64
}

public func <|?(notated: Notated, key: String) -> UInt64? {
    return notated.item(key: key).uint64Value
}

public func <|(notated: Notated, key: String) -> UInt64 {
    return notated.item(key: key).uint64
}

public func <|(notated: Notated, key: String) -> Notated {
    return notated.item(key: key)
}

public func <|?(notated: Notated, key: String) -> Notated? {
    let result = notated.item(key: key)
    return result.exists ? nil : result
}
