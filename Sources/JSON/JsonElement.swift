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

class JsonElement: Equatable {
    static let null = JsonNull()
    let type: JsonType

    init(type: JsonType) {
        self.type = type
    }

    static func ==(lhs: JsonElement, rhs: JsonElement) -> Bool {
        guard lhs.type == rhs.type else {
            return false
        }
        switch (lhs.type) {
        case .string:
            return lhs.string() == rhs.string()
        case .bool:
            return lhs.bool() == rhs.bool()
        case .number:
            return lhs.number() == rhs.number()
        case .array, .object:
            // [Any] and [String: Any] cannot compare equality
            return false
        case .null:
            return true
        }
    }

    func string() -> String? {
        return nil
    }

    func number() -> NSNumber? {
        return nil
    }

    func bool() -> Bool? {
        return nil
    }

    func double() -> Double? {
        return nil
    }

    func float() -> Float? {
        return nil
    }

    func int() -> Int? {
        return nil
    }

    func int8() -> Int8? {
        return nil
    }

    func int16() -> Int16? {
        return nil
    }

    func int32() -> Int32? {
        return nil
    }

    func int64() -> Int64? {
        return nil
    }

    func uint() -> UInt? {
        return nil
    }

    func uint8() -> UInt8? {
        return nil
    }

    func uint16() -> UInt16? {
        return nil
    }

    func uint32() -> UInt32? {
        return nil
    }

    func uint64() -> UInt64? {
        return nil
    }

    func array() -> [Any]? {
        return nil
    }

    func object() -> [String: Any]? {
        return nil
    }

    static func create(_ value: Any) -> JsonElement {
        if let string = value as? String {
            return JsonString(string)
        }
        if let object = value as? [String: Any] {
            return JsonObject(object)
        }
        if let number = value as? NSNumber {
            return JsonRawNumber(number)
        }
        if let array = value as? [Any] {
            return JsonArray(array)
        }
        return JsonElement.null
    }
}

class JsonNumber: JsonElement {
    init() {
        super.init(type: .number)
    }

    override func number() -> NSNumber? {
        return NSNumber()
    }
}

final class JsonRawNumber: JsonNumber {
    let value: NSNumber

    init(_ value: NSNumber) {
        self.value = value
        super.init()
    }

    override func number() -> NSNumber {
        return value
    }

    override func string() -> String? {
        return value.stringValue
    }

    override func bool() -> Bool? {
        return value.boolValue
    }

    override func float() -> Float? {
        return value.floatValue
    }

    override func double() -> Double? {
        return value.doubleValue
    }

    override func int() -> Int? {
        return value.intValue
    }

    override func int8() -> Int8? {
        return value.int8Value
    }

    override func int16() -> Int16? {
        return value.int16Value
    }

    override func int32() -> Int32? {
        return value.int32Value
    }

    override func int64() -> Int64? {
        return value.int64Value
    }

    override func uint() -> UInt? {
        return value.uintValue
    }

    override func uint8() -> UInt8? {
        return value.uint8Value
    }

    override func uint16() -> UInt16? {
        return value.uint16Value
    }

    override func uint32() -> UInt32? {
        return value.uint32Value
    }

    override func uint64() -> UInt64? {
        return value.uint64Value
    }
}

final class JsonString: JsonElement {
    let value: String

    init(_ value: String) {
        self.value = value
        super.init(type: .string)
    }

    override func string() -> String? {
        return value
    }

    override func bool() -> Bool? {
        return Bool(value)
    }

    override func float() -> Float? {
        return Float(value)
    }

    override func double() -> Double? {
        return Double(value)
    }

    override func int() -> Int? {
        return Int(value)
    }

    override func int8() -> Int8? {
        return Int8(value)
    }

    override func int16() -> Int16? {
        return Int16(value)
    }

    override func int32() -> Int32? {
        return Int32(value)
    }

    override func int64() -> Int64? {
        return Int64(value)
    }

    override func uint() -> UInt? {
        return UInt(value)
    }

    override func uint8() -> UInt8? {
        return UInt8(value)
    }

    override func uint16() -> UInt16? {
        return UInt16(value)
    }

    override func uint32() -> UInt32? {
        return UInt32(value)
    }

    override func uint64() -> UInt64? {
        return UInt64(value)
    }
}

final class JsonArray: JsonElement {
    let value: [Any]

    init(_ value: [Any]) {
        self.value = value
        super.init(type: .array)
    }

    override func array() -> [Any]? {
        return value
    }
}

final class JsonObject: JsonElement {
    let value: [String: Any]

    init(_ value: [String: Any]) {
        self.value = value
        super.init(type: .object)
    }

    override func object() -> [String: Any]? {
        return value
    }
}

final class JsonNull: JsonElement {
    init() {
        super.init(type: .null)
    }
}
