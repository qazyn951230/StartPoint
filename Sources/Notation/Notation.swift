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
    associatedtype NotatedValue: Notated
}

public protocol Notation: BaseNotation {
    init(from notated: NotatedValue)
}

public protocol FailableNotation: BaseNotation {
    init?(from notated: NotatedValue)
}

public protocol ThrowNotation: BaseNotation {
    init(from notated: NotatedValue) throws
}

public protocol StaticNotation: BaseNotation {
    static func create(from notated: NotatedValue) -> Self
}

public protocol RawNotation: StaticNotation, RawRepresentable {
    static var `default`: Self { get }
}

public extension RawNotation where RawValue == String {
    public static func create(from notated: NotatedValue) -> Self {
        let temp: Self? = self.init(rawValue: notated.string)
        return temp ?? Self.default
    }
}

public protocol ListNotation: BaseNotation {
    static func objects(from notated: NotatedValue) -> [Self]
}

public extension ListNotation where Self: Notation, Self.NotatedValue.Value == Self.NotatedValue {
    public static func objects(from notated: Self.NotatedValue) -> [Self] {
        return notated.array.map { (value: Self.NotatedValue.Value) -> Self in
            Self.init(from: value)
        }
    }
}

public extension ListNotation where Self: FailableNotation, Self.NotatedValue.Value == Self.NotatedValue {
    public static func objects(from notated: Self.NotatedValue) -> [Self] {
        return notated.array.compactMap { (value: Self.NotatedValue.Value) -> Self? in
            Self.init(from: value)
        }
    }
}

public extension ListNotation where Self: StaticNotation, Self.NotatedValue.Value == Self.NotatedValue {
    public static func objects(from notated: Self.NotatedValue) -> [Self] {
        return notated.array.map { (value: Self.NotatedValue.Value) -> Self in
            Self.create(from: value)
        }
    }
}

// MARK: - Decodable object
public func <|?<T: FailableNotation>(notated: T.NotatedValue, key: String) -> T?
    where T.NotatedValue.Value == T.NotatedValue {
    return T.init(from: notated[key])
}

public func <|<T: Notation>(notated: T.NotatedValue, key: String) -> T
    where T.NotatedValue.Value == T.NotatedValue {
    return T.init(from: notated[key])
}

public func <|<T: StaticNotation>(notated: T.NotatedValue, key: String) -> T
    where T.NotatedValue.Value == T.NotatedValue {
    return T.create(from: notated[key])
}

public func <|?<T: RawRepresentable, NotatedValue: Notated>(notated: NotatedValue, key: String) -> T?
    where T.RawValue == String {
    return T.init(rawValue: notated[key].string)
}

public func <|?<T: ListNotation>(notated: T.NotatedValue, key: String) -> [T]?
    where T.NotatedValue.Value == T.NotatedValue {
    let objects = T.objects(from: notated[key])
    return objects.count > 0 ? objects : nil
}

public func <|<T: ListNotation>(notated: T.NotatedValue, key: String) -> [T]
    where T.NotatedValue.Value == T.NotatedValue {
    return T.objects(from: notated[key])
}

// MARK: - Decodable array
public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> [NotatedValue.Value.Value]? {
    return notated[key].arrayValue
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> [NotatedValue.Value.Value] {
    return notated[key].array
}

// MARK: - Decodable dictionary
public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> [String: NotatedValue.Value.Value]? {
    return notated[key].dictionaryValue
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> [String: NotatedValue.Value.Value] {
    return notated[key].dictionary
}

public func <|<T: Notation>(notated: T.NotatedValue, key: String) -> [String: T]
    where T.NotatedValue.Value == T.NotatedValue {
    return notated[key].dictionary
        .mapValues(T.init(from:))
}

// MARK: - Decodable bool
public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Bool? {
    return notated[key].boolValue
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Bool {
    return notated[key].bool
}

// MARK: - Decodable string
public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> String? {
    return notated[key].stringValue
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> String {
    return notated[key].string
}

public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> [String]? {
    let array: [NotatedValue.Value.Value]? = notated[key].arrayValue
    return array?.compactMap { $0.stringValue }
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> [String] {
    let array: [NotatedValue.Value.Value] = notated[key].array
    return array.map { $0.string }
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> [String: String] {
    let map: [String: NotatedValue.Value.Value] = notated[key].dictionary
    return map.mapValues { $0.string }
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> [String: Any] {
    let map: [String: NotatedValue.Value.Value] = notated[key].dictionary
    return map.mapValues { $0.raw }
}

// Decodable number
public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Double? {
    return notated[key].doubleValue
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Double {
    return notated[key].double
}

public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Float? {
    return notated[key].floatValue
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Float {
    return notated[key].float
}

public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Int? {
    return notated[key].intValue
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Int {
    return notated[key].int
}

public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> UInt? {
    return notated[key].uintValue
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> UInt {
    return notated[key].uint
}

public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Int32? {
    return notated[key].int32Value
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Int32 {
    return notated[key].int32
}

public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> UInt32? {
    return notated[key].uint32Value
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> UInt32 {
    return notated[key].uint32
}

public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Int64? {
    return notated[key].int64Value
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> Int64 {
    return notated[key].int64
}

public func <|?<NotatedValue: Notated>(notated: NotatedValue, key: String) -> UInt64? {
    return notated[key].uint64Value
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> UInt64 {
    return notated[key].uint64
}

public func <|<NotatedValue: Notated>(notated: NotatedValue, key: String) -> NotatedValue.Value {
    return notated[key]
}

public func <|?(json: JSON, key: String) -> JSON? {
    let result = json[key]
    return result.equals(to: JSON.null) ? nil : result
}
