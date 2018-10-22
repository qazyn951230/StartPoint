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
    associatedtype Value: Notated = Self

    var arrayValue: [Value]? { get }
    var array: [Value] { get }
    var dictionaryValue: [String: Value]? { get }
    var dictionary: [String: Value] { get }
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

    subscript(index: Int) -> Value { get }
    subscript(key: String) -> Value { get }
}

extension Notated {
    public var arrayValue: [Value]? {
        return nil
    }

    public var array: [Value] {
        return []
    }

    public var dictionaryValue: [String: Value]? {
        return nil
    }

    public var dictionary: [String: Value] {
        return [:]
    }

    public var boolValue: Bool? {
        return nil
    }

    public var bool: Bool {
        return false
    }

    public var stringValue: String? {
        return nil
    }

    public var string: String {
        return String.empty
    }

    public var doubleValue: Double? {
        return nil
    }

    public var double: Double {
        return 0
    }

    public var floatValue: Float? {
        return nil
    }

    public var float: Float {
        return 0
    }

    public var intValue: Int? {
        return nil
    }

    public var int: Int {
        return 0
    }

    public var int32Value: Int32? {
        return nil
    }

    public var int32: Int32 {
        return 0
    }

    public var int64Value: Int64? {
        return nil
    }

    public var int64: Int64 {
        return 0
    }

    public var uintValue: UInt? {
        return nil
    }

    public var uint: UInt {
        return 0
    }

    public var uint32Value: UInt32? {
        return nil
    }

    public var uint32: UInt32 {
        return 0
    }

    public var uint64Value: UInt64? {
        return nil
    }

    public var uint64: UInt64 {
        return 0
    }
}
