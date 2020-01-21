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

public protocol Notated {
    var raw: Any { get }
    var exists: Bool { get }

    var listValue: [Notated]? { get }
    var list: [Notated] { get }
    var mapValue: [String: Notated]? { get }
    var map: [String: Notated] { get }
    var boolValue: Bool? { get }
    var bool: Bool { get }
    var stringValue: String? { get }
    var string: String { get }
    var doubleValue: Double? { get }
    var double: Double { get }
    var floatValue: Float? { get }
    var float: Float { get }
    var intValue: Int? { get }
    var int: Int { get }
    var int32Value: Int32? { get }
    var int32: Int32 { get }
    var int64Value: Int64? { get }
    var int64: Int64 { get }
    var uintValue: UInt? { get }
    var uint: UInt { get }
    var uint32Value: UInt32? { get }
    var uint32: UInt32 { get }
    var uint64Value: UInt64? { get }
    var uint64: UInt64 { get }

    func item(at index: Int) -> Notated
    func item(key: String) -> Notated

    subscript(index: Int) -> Notated { get }
    subscript(key: String) -> Notated { get }
}

public extension Notated {
    var exists: Bool {
        true
    }

    var boolValue: Bool? {
        nil
    }

    var bool: Bool {
        false
    }

    var stringValue: String? {
        nil
    }

    var string: String {
        ""
    }

    var doubleValue: Double? {
        nil
    }

    var double: Double {
        0
    }

    var floatValue: Float? {
        nil
    }

    var float: Float {
        0
    }

    var intValue: Int? {
        nil
    }

    var int: Int {
        0
    }

    var int32Value: Int32? {
        nil
    }

    var int32: Int32 {
        0
    }

    var int64Value: Int64? {
        nil
    }

    var int64: Int64 {
        0
    }

    var uintValue: UInt? {
        nil
    }

    var uint: UInt {
        0
    }

    var uint32Value: UInt32? {
        nil
    }

    var uint32: UInt32 {
        0
    }

    var uint64Value: UInt64? {
        nil
    }

    var uint64: UInt64 {
        0
    }

    subscript(index: Int) -> Notated {
        item(at: index)
    }

    subscript(key: String) -> Notated {
        item(key: key)
    }
}

public protocol TypeNotated: Notated {
    associatedtype Typed: Notated = Self

    var arrayValue: [Typed]? { get }
    var array: [Typed] { get }
    var dictionaryValue: [String: Typed]? { get }
    var dictionary: [String: Typed] { get }

    subscript(typed index: Int) -> Typed { get }
    subscript(typed key: String) -> Typed { get }
}

public extension TypeNotated {
    var listValue: [Notated]? {
        arrayValue
    }
    var list: [Notated] {
        array
    }
    var mapValue: [String: Notated]? {
        dictionaryValue
    }
    var map: [String: Notated] {
        dictionary
    }

    func item(at index: Int) -> Notated {
        self[typed: index]
    }

    func item(key: String) -> Notated {
        self[typed: key]
    }

    subscript(index: Int) -> Notated {
        self[typed: index]
    }

    subscript(key: String) -> Notated {
        self[typed: key]
    }
}
