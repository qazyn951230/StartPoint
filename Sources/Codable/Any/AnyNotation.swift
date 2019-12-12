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

public final class AnyNotation: TypeNotated {
    public static let null = AnyNotation()
    public typealias Value = AnyNotation

    private var _rawArray: [Any]?
    private var _mapArray: [AnyNotation]?
    private var _rawObject: [String: Any]?
    private var _mapObject: [String: AnyNotation]?
    private var _rawString: String?
    private var _rawNumber: NSNumber?

    var kind = Kind.unknown

    public init(_ value: Any) {
        setRawObject(object: value)
    }

    internal init() {
        // Do nothing.
    }

    public var raw: Any {
        switch kind {
        case .string:
            return _rawString ?? NSNull()
        case .array:
            if let map = _mapArray {
                return map.map { $0.raw }
            }
            return _rawArray ?? []
        case .object:
            if let map = _mapObject {
                return map.mapValues { $0.raw }
            }
            return _rawObject ?? [:]
        case .number:
            return _rawNumber ?? NSNull()
        case .unknown:
            return NSNull()
        }
    }

    public var arrayValue: [AnyNotation]? {
        if let resolved = _mapArray {
            return resolved
        }
        if let array = _rawArray {
            _mapArray = array.map(AnyNotation.init)
            _rawArray = nil
            return _mapArray
        }
        return nil
    }
    public var array: [AnyNotation] {
        if let resolved = _mapArray {
            return resolved
        }
        if let array = _rawArray {
            let temp = array.map(AnyNotation.init)
            _mapArray = temp
            _rawArray = nil
            return temp
        }
        return []
    }
    public var dictionaryValue: [String: AnyNotation]? {
        if let resolved = _mapObject {
            return resolved
        }
        if let raw = _rawObject {
            _mapObject = raw.mapValues(AnyNotation.init)
            _rawObject = nil
            return _mapObject
        }
        return nil
    }
    public var dictionary: [String: AnyNotation] {
        if let resolved = _mapObject {
            return resolved
        }
        if let raw = _rawObject {
            let temp = raw.mapValues(AnyNotation.init)
            _mapObject = temp
            _rawObject = nil
            return temp
        }
        return [:]
    }
    public var boolValue: Bool? {
        if let number = _rawNumber {
            return number.boolValue
        }
        if let string = _rawString {
            if string.caseInsensitiveCompare("true") == ComparisonResult.orderedSame {
                return true
            }
            if string.caseInsensitiveCompare("false") == ComparisonResult.orderedSame {
                return false
            }
            if let value = intValue {
                return value > 0
            }
        }
        return nil
    }
    public var bool: Bool {
        if let number = _rawNumber {
            return number.boolValue
        }
        if let string = _rawString {
            if string.caseInsensitiveCompare("true") == ComparisonResult.orderedSame {
                return true
            }
            if string.caseInsensitiveCompare("false") == ComparisonResult.orderedSame {
                return false
            }
            return int > 0
        }
        return false
    }
    public var stringValue: String? {
        if let string = _rawString {
            return string
        }
        if let number = _rawNumber {
            return number.stringValue
        }
        return nil
    }
    public var string: String {
        if let string = _rawString {
            return string
        }
        if let number = _rawNumber {
            return number.stringValue
        }
        return String.empty
    }
    public var doubleValue: Double? {
        if let number = _rawNumber {
            return number.doubleValue
        }
        if let string = _rawString {
            return Double(string)
        }
        return nil
    }
    public var double: Double {
        if let number = _rawNumber {
            return number.doubleValue
        }
        if let string = _rawString {
            return Double(string) ?? 0
        }
        return 0
    }
    public var floatValue: Float? {
        if let number = _rawNumber {
            return number.floatValue
        }
        if let string = _rawString {
            return Float(string)
        }
        return nil
    }
    public var float: Float {
        if let number = _rawNumber {
            return number.floatValue
        }
        if let string = _rawString {
            return Float(string) ?? 0
        }
        return 0
    }
    public var intValue: Int? {
        if let number = _rawNumber {
            return number.intValue
        }
        if let string = _rawString {
            return Int(string)
        }
        return nil
    }
    public var int: Int {
        if let number = _rawNumber {
            return number.intValue
        }
        if let string = _rawString {
            return Int(string) ?? 0
        }
        return 0
    }
    public var int32Value: Int32? {
        if let number = _rawNumber {
            return number.int32Value
        }
        if let string = _rawString {
            return Int32(string)
        }
        return nil
    }
    public var int32: Int32 {
        if let number = _rawNumber {
            return number.int32Value
        }
        if let string = _rawString {
            return Int32(string) ?? 0
        }
        return 0
    }
    public var int64Value: Int64? {
        if let number = _rawNumber {
            return number.int64Value
        }
        if let string = _rawString {
            return Int64(string)
        }
        return nil
    }
    public var int64: Int64 {
        if let number = _rawNumber {
            return number.int64Value
        }
        if let string = _rawString {
            return Int64(string) ?? 0
        }
        return 0
    }
    public var uintValue: UInt? {
        if let number = _rawNumber {
            return number.uintValue
        }
        if let string = _rawString {
            return UInt(string)
        }
        return nil
    }
    public var uint: UInt {
        if let number = _rawNumber {
            return number.uintValue
        }
        if let string = _rawString {
            return UInt(string) ?? 0
        }
        return 0
    }
    public var uint32Value: UInt32? {
        if let number = _rawNumber {
            return number.uint32Value
        }
        if let string = _rawString {
            return UInt32(string)
        }
        return nil
    }
    public var uint32: UInt32 {
        if let number = _rawNumber {
            return number.uint32Value
        }
        if let string = _rawString {
            return UInt32(string) ?? 0
        }
        return 0
    }
    public var uint64Value: UInt64? {
        if let number = _rawNumber {
            return number.uint64Value
        }
        if let string = _rawString {
            return UInt64(string)
        }
        return nil
    }
    public var uint64: UInt64 {
        if let number = _rawNumber {
            return number.uint64Value
        }
        if let string = _rawString {
            return UInt64(string) ?? 0
        }
        return 0
    }

    private func setRawObject(object: Any) {
        switch object {
        case let number as NSNumber:
            _rawNumber = number
            kind = Kind.number
        case let string as String:
            _rawString = string
            kind = Kind.string
        case let array as [Any]:
            _rawArray = array
            kind = Kind.array
        case let object as [String: Any]:
            _rawObject = object
            kind = Kind.object
        default:
            kind = Kind.unknown
        }
    }

    public subscript(typed index: Int) -> AnyNotation {
        return arrayValue?[index] ?? AnyNotation.null
    }

    public subscript(typed key: String) -> AnyNotation {
        return dictionaryValue?[key] ?? AnyNotation.null
    }

    enum Kind {
        case number
        case string
        case array
        case object
        case unknown
    }
}
