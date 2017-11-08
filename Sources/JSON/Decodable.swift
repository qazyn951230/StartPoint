// MIT License
//
// Copyright (c) 2017 qazyn951230 qazyn951230@gmail.com
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

import SwiftyJSON

precedencegroup DecodePrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
    lowerThan: NilCoalescingPrecedence
}

infix operator <|: DecodePrecedence
infix operator <|?: DecodePrecedence

public protocol BaseNotation {
    static func objects(from json: JSON) -> [Self]
}

public protocol Notation: BaseNotation {
    init(from json: JSON)
}

public extension Notation {
    public static func objects(from json: JSON) -> [Self] {
        guard let array = json.array else {
            return []
        }
        return array.map(Self.init)
    }
}

public protocol FailableNotation: BaseNotation {
    init?(from json: JSON)
}

public extension FailableNotation {
    public static func objects(from json: JSON) -> [Self] {
        guard let array = json.array else {
            return []
        }
        return array.flatMap(Self.init)
    }
}

public protocol StaticNotation {
    static func create(from json: JSON) -> Self
}

public extension StaticNotation {
    public static func objects(from json: JSON) -> [Self] {
        guard let array = json.array else {
            return []
        }
        return array.map(Self.create)
    }
}

public protocol RawNotation: StaticNotation, RawRepresentable {
    static var `default`: Self { get }
}

public extension RawNotation where RawValue == String {
    public static func create(from json: JSON) -> Self {
        let foo: Self? = self.init(rawValue: json.stringValue)
        return foo ?? Self.default
    }
}

// MARK: - Decodable object
public func <|?<T:FailableNotation>(json: JSON, key: String) -> T? {
    return T.init(from: json[key])
}

public func <|<T:Notation>(json: JSON, key: String) -> T {
    return T.init(from: json[key])
}

public func <|<T:StaticNotation>(json: JSON, key: String) -> T {
    return T.create(from: json[key])
}

public func <|<T:RawRepresentable>(json: JSON, key: String) -> T? where T.RawValue == String {
    return T.init(rawValue: json[key].stringValue)
}

public func <|?<T:BaseNotation>(json: JSON, key: String) -> [T]? {
    let objects = T.objects(from: json[key])
    return objects.count > 0 ? objects : nil
}

public func <|<T:BaseNotation>(json: JSON, key: String) -> [T] {
    return T.objects(from: json[key])
}

// MARK: - Decodable array
public func <|?(json: JSON, key: String) -> [JSON]? {
    return json[key].array
}

public func <|(json: JSON, key: String) -> [JSON] {
    return json[key].arrayValue
}

public func <|(json: JSON, key: String) -> [Any]? {
    return json[key].arrayObject
}

// MARK: - Decodable dictionary
public func <|?(json: JSON, key: String) -> [String: JSON]? {
    return json[key].dictionary
}

public func <|(json: JSON, key: String) -> [String: JSON] {
    return json[key].dictionaryValue
}

public func <|(json: JSON, key: String) -> [String: Any]? {
    return json[key].dictionaryObject
}

// MARK: - Decodable bool
public func <|?(json: JSON, key: String) -> Bool? {
    return json[key].bool
}

public func <|(json: JSON, key: String) -> Bool {
    return json[key].boolValue
}

// MARK: - Decodable string
public func <|?(json: JSON, key: String) -> String? {
    return json[key].string
}

public func <|(json: JSON, key: String) -> String {
    return json[key].stringValue
}

// Decodable number
public func <|?(json: JSON, key: String) -> Double? {
    return json[key].double
}

public func <|(json: JSON, key: String) -> Double {
    return json[key].doubleValue
}

public func <|?(json: JSON, key: String) -> Float? {
    return json[key].float
}

public func <|(json: JSON, key: String) -> Float {
    return json[key].floatValue
}

public func <|?(json: JSON, key: String) -> Int? {
    return json[key].int
}

public func <|(json: JSON, key: String) -> Int {
    return json[key].intValue
}

public func <|?(json: JSON, key: String) -> UInt? {
    return json[key].uInt
}

public func <|(json: JSON, key: String) -> UInt {
    return json[key].uIntValue
}

public func <|?(json: JSON, key: String) -> Int8? {
    return json[key].int8
}

public func <|(json: JSON, key: String) -> Int8 {
    return json[key].int8Value
}

public func <|?(json: JSON, key: String) -> UInt8? {
    return json[key].uInt8
}

public func <|(json: JSON, key: String) -> UInt8 {
    return json[key].uInt8Value
}

public func <|?(json: JSON, key: String) -> Int16? {
    return json[key].int16
}

public func <|(json: JSON, key: String) -> Int16 {
    return json[key].int16Value
}

public func <|?(json: JSON, key: String) -> UInt16? {
    return json[key].uInt16
}

public func <|(json: JSON, key: String) -> UInt16 {
    return json[key].uInt16Value
}

public func <|?(json: JSON, key: String) -> Int32? {
    return json[key].int32
}

public func <|(json: JSON, key: String) -> Int32 {
    return json[key].int32Value
}

public func <|?(json: JSON, key: String) -> UInt32? {
    return json[key].uInt32
}

public func <|(json: JSON, key: String) -> UInt32 {
    return json[key].uInt32Value
}

public func <|?(json: JSON, key: String) -> Int64? {
    return json[key].int64
}

public func <|(json: JSON, key: String) -> Int64 {
    return json[key].int64Value
}

public func <|?(json: JSON, key: String) -> UInt64? {
    return json[key].uInt64
}

public func <|(json: JSON, key: String) -> UInt64 {
    return json[key].uInt64Value
}

public func <|(json: JSON, key: String) -> JSON {
    return json[key]
}

public func <|?(json: JSON, key: String) -> JSON? {
    let result = json[key]
    guard result.exists() else {
        return nil
    }
    return result
}
