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

public final class JSONNull: JSON {
    override init() {
        super.init()
    }

    public override var raw: Any {
        return NSNull()
    }

    public override var exists: Bool {
        return false
    }
    public override var description: String {
        return "<JSON: null>"
    }

    public override var debugDescription: String {
        return "<JSON: null>"
    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(null: self)
    }

    override func equals(to object: JSON) -> Bool {
        return self === JSON.null
    }
}

public final class JSONString: JSON {
    let value: String

    public init(_ value: String) {
        self.value = value
        super.init()
    }

    public override var raw: Any {
        return value
    }

    public override var stringValue: String? {
        return value.isEmpty ? nil : value
    }

    public override var string: String {
        return value
    }

    public override var description: String {
        return "<JSON: \(value)>"
    }

    public override var debugDescription: String {
        return "<JSON: \(value)>"
    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(string: self)
    }

    override func equals(to object: JSON) -> Bool {
        if let element = object as? JSONString {
            return value == element.value
        }
        return super.equals(to: object)
    }
}

public final class JSONInt: JSON {
    let value: Int32

    public init(_ value: Int32) {
        self.value = value
        super.init()
    }

    public override var raw: Any {
        return value
    }

    public override var doubleValue: Double? {
        return Double(value)
    }

    public override var double: Double {
        return Double(value)
    }

    public override var floatValue: Float? {
        return Float(value)
    }

    public override var float: Float {
        return Float(value)
    }

    public override var intValue: Int? {
        return Int(value)
    }

    public override var int: Int {
        return Int(value)
    }

    public override var int32Value: Int32? {
        return value
    }

    public override var int32: Int32 {
        return value
    }

    public override var int64Value: Int64? {
        return Int64(value)
    }

    public override var int64: Int64 {
        return Int64(value)
    }

//    public var uintValue: UInt? {
//        if value < 0 {
//            return nil
//        }
//        return UInt(bitPattern: Int(value))
//    }
//
//    public var uint: UInt {
//        if value < 0 {
//            return 0
//        }
//        return UInt(bitPattern: Int(value))
//    }
//
//    public var uint32Value: UInt32? {
//        if value < 0 {
//            return nil
//        }
//        return UInt32(bitPattern: value)
//    }
//
//    public var uint32: UInt32 {
//        if value < 0 {
//            return nil
//        }
//        return UInt32(bitPattern: value)
//    }

    public override var description: String {
        return "<JSON: \(value)>"
    }

    public override var debugDescription: String {
        return "<JSON: \(value) \(address(of: self))>"
    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(int: self)
    }

    override func equals(to object: JSON) -> Bool {
        if let element = object as? JSONInt {
            return value == element.value
        }
        return super.equals(to: object)
    }
}

public final class JSONInt64: JSON {
    let value: Int64

    public init(_ value: Int64) {
        self.value = value
        super.init()
    }

    public override var raw: Any {
        return value
    }

    public override var doubleValue: Double? {
        return Double(value)
    }

    public override var double: Double {
        return Double(value)
    }

    public override var floatValue: Float? {
        return Float(value)
    }

    public override var float: Float {
        return Float(value)
    }

    public override var intValue: Int? {
#if arch(arm64) || arch(x86_64)
        return Int(value)
#else
        return nil
#endif
    }

    public override var int: Int {
#if arch(arm64) || arch(x86_64)
        return Int(value)
#else
        return 0
#endif
    }

//    public var int32Value: Int32? {
//        let mask: Int64 = 0x7FFFFFFF80000000
//        if value & mask > 0 {
//            return nil
//        }
//        return Int32(truncatingIfNeeded: value)
//    }
//
//    public var int32: Int32 {
//        let mask: Int64 = 0x7FFFFFFF80000000
//        if value & mask > 0 {
//            return 0
//        }
//        return Int32(truncatingIfNeeded: value)
//    }

    public override var int64Value: Int64? {
        return value
    }

    public override var int64: Int64 {
        return value
    }

    public override var description: String {
        return "<JSON: \(value)>"
    }

    public override var debugDescription: String {
        return "<JSON: \(value) \(address(of: self))>"
    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(int64: self)
    }

    override func equals(to object: JSON) -> Bool {
        if let element = object as? JSONInt64 {
            return value == element.value
        }
        return super.equals(to: object)
    }
}

public final class JSONUInt: JSON {
    let value: UInt32

    public init(_ value: UInt32) {
        self.value = value
        super.init()
    }

    public override var raw: Any {
        return value
    }

    public override var doubleValue: Double? {
        return Double(value)
    }

    public override var double: Double {
        return Double(value)
    }

    public override var floatValue: Float? {
        return Float(value)
    }

    public override var float: Float {
        return Float(value)
    }

    public override var uintValue: UInt? {
        return UInt(value)
    }

    public override var uint: UInt {
        return UInt(value)
    }

    public override var uint32Value: UInt32? {
        return value
    }

    public override var uint32: UInt32 {
        return value
    }

    public override var uint64Value: UInt64? {
        return UInt64(value)
    }

    public override var uint64: UInt64 {
        return UInt64(value)
    }

    public override var intValue: Int? {
        if value > 0x7fff_ffff {
            return nil
        }
        return Int(value)
    }

    public override var int: Int {
        if value > 0x7fff_ffff {
            return 0
        }
        return Int(value)
    }

    public override var int32Value: Int32? {
        if value > 0x7fff_ffff {
            return nil
        }
        return Int32(bitPattern: value)
    }

    public override var int32: Int32 {
        if value > 0x7fff_ffff {
            return 0
        }
        return Int32(bitPattern: value)
    }

    public override var int64Value: Int64? {
        if value > 0x7fff_ffff {
            return nil
        }
        return Int64(value)
    }

    public override var int64: Int64 {
        if value > 0x7fff_ffff {
            return 0
        }
        return Int64(value)
    }

    public override var description: String {
        return "<JSON: \(value)>"
    }

    public override var debugDescription: String {
        return "<JSON: \(value) \(address(of: self))>"
    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(uint: self)
    }

    override func equals(to object: JSON) -> Bool {
        if let element = object as? JSONUInt {
            return value == element.value
        }
        return super.equals(to: object)
    }
}

public final class JSONUInt64: JSON {
    let value: UInt64

    public init(_ value: UInt64) {
        self.value = value
        super.init()
    }

    public override var raw: Any {
        return value
    }

    public override var doubleValue: Double? {
        return Double(value)
    }

    public override var double: Double {
        return Double(value)
    }

    public override var floatValue: Float? {
        return Float(value)
    }

    public override var float: Float {
        return Float(value)
    }

    public override var uintValue: UInt? {
#if arch(arm64) || arch(x86_64)
        return UInt(value)
#else
        return nil
#endif
    }

    public override var uint: UInt {
#if arch(arm64) || arch(x86_64)
        return UInt(value)
#else
        return 0
#endif
    }

    public override var uint64Value: UInt64? {
        return value
    }

    public override var uint64: UInt64 {
        return value
    }

    public override var intValue: Int? {
#if arch(arm64) || arch(x86_64)
        if value > 0x7fff_ffff_ffff_ffff {
            return nil
        }
        return Int(value)
#else
        return nil
#endif
    }

    public override var int: Int {
#if arch(arm64) || arch(x86_64)
        if value > 0x7fff_ffff_ffff_ffff {
            return 0
        }
        return Int(value)
#else
        return 0
#endif
    }

    public override var int64Value: Int64? {
        if value > 0x7fff_ffff_ffff_ffff {
            return 0
        }
        return Int64(bitPattern: value)
    }

    public override var int64: Int64 {
        if value > 0x7fff_ffff_ffff_ffff {
            return 0
        }
        return Int64(bitPattern: value)
    }

    public override var description: String {
        return "<JSON: \(value)>"
    }

    public override var debugDescription: String {
        return "<JSON: \(value) \(address(of: self))>"
    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(uint64: self)
    }

    override func equals(to object: JSON) -> Bool {
        if let element = object as? JSONUInt64 {
            return value == element.value
        }
        return super.equals(to: object)
    }
}

public final class JSONDouble: JSON {
    let value: Double

    public init(_ value: Double) {
        self.value = value
        super.init()
    }

    public override var raw: Any {
        return value
    }

    public override var doubleValue: Double? {
        return value
    }

    public override var double: Double {
        return value
    }

    public override var floatValue: Float? {
        return Float(value)
    }

    public override var float: Float {
        return Float(value)
    }

    public override var description: String {
        return "<JSON: \(value)>"
    }

    public override var debugDescription: String {
        return "<JSON: \(value) \(address(of: self))>"
    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(double: self)
    }

    override func equals(to object: JSON) -> Bool {
        if let element = object as? JSONDouble {
            return value == element.value
        }
        return super.equals(to: object)
    }
}

public final class JSONBool: JSON {
    let value: Bool

    public init(_ value: Bool) {
        self.value = value
        super.init()
    }

    public override var raw: Any {
        return value
    }

    public override var boolValue: Bool? {
        return value
    }

    public override var bool: Bool {
        return value
    }

    public override var description: String {
        return "<JSON: \(value)>"
    }

    public override var debugDescription: String {
        return "<JSON: \(value) \(address(of: self))>"
    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(bool: self)
    }

    override func equals(to object: JSON) -> Bool {
        if let element = object as? JSONBool {
            return value == element.value
        }
        return super.equals(to: object)
    }
}

public final class JSONObject: JSON {
    var value: [String: JSON]

    public init(_ value: [String: JSON]) {
        self.value = value
        super.init()
    }

    public override var raw: Any {
        return value
    }

    public override var dictionaryValue: [String: Notated]? {
        return value.isEmpty ? nil : value
    }

    public override var dictionary: [String: Notated] {
        return value
    }

    public override var description: String {
        return "<JSON: \(value)>"
    }

    public override var debugDescription: String {
        return "<JSON: \(value) \(address(of: self))>"
    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(dictionary: self)
    }

    @discardableResult
    public func append(key: String, _ element: JSON) -> JSONObject {
        value[key] = element
        return self
    }

    @discardableResult
    public func append(key: String, array element: [JSON]) -> JSONObject {
        return append(key: key, JSONArray(element))
    }

    @discardableResult
    public func append(key: String, array element: JSONArray) -> JSONObject {
        return append(key: key, element)
    }

    @discardableResult
    public func append(key: String, dictionary element: [String: JSON]) -> JSONObject {
        return append(key: key, JSONObject(element))
    }

    @discardableResult
    public func append(key: String, dictionary element: JSONObject) -> JSONObject {
        return append(key: key, element)
    }

    @discardableResult
    public func append(key: String, bool element: Bool) -> JSONObject {
        return append(key: key, JSONBool(element))
    }

    @discardableResult
    public func append(key: String, string element: String) -> JSONObject {
        return append(key: key, JSONString(element))
    }

    @discardableResult
    public func append(key: String, double element: Double) -> JSONObject {
        return append(key: key, JSONDouble(element))
    }

    @discardableResult
    public func append(key: String, float element: Float) -> JSONObject {
        return append(key: key, JSONDouble(Double(element)))
    }

    @discardableResult
    public func append(key: String, int element: Int) -> JSONObject {
        return append(key: key, JSONInt64(Int64(element)))
    }

    @discardableResult
    public func append(key: String, int32 element: Int32) -> JSONObject {
        return append(key: key, JSONInt(element))
    }

    @discardableResult
    public func append(key: String, int64 element: Int64) -> JSONObject {
        return append(key: key, JSONInt64(element))
    }

    @discardableResult
    public func append(key: String, uint element: UInt) -> JSONObject {
        return append(key: key, JSONUInt64(UInt64(element)))
    }

    @discardableResult
    public func append(key: String, uint32 element: UInt32) -> JSONObject {
        return append(key: key, JSONUInt(element))
    }

    @discardableResult
    public func append(key: String, uint64 element: UInt64) -> JSONObject {
        return append(key: key, JSONUInt64(element))
    }

    override func equals(to object: JSON) -> Bool {
        if let element = object as? JSONObject {
            return value == element.value
        }
        return super.equals(to: object)
    }

    public override subscript(key: String) -> JSON {
        return value[key] ?? JSON.null
    }
}

public final class JSONArray: JSON {
    var value: [JSON]

    public init(_ value: [JSON]) {
        self.value = value
        super.init()
    }

    public override var raw: Any {
        return value
    }

    public override var arrayValue: [Notated]? {
        return value.isEmpty ? nil : value
    }

    public override var array: [Notated] {
        return value
    }

    public override var description: String {
        return "<JSON: \(value)>"
    }

    public override var debugDescription: String {
        return "<JSON: \(value) \(address(of: self))>"
    }

    public override func accept(visitor: JSONVisitor) {
        visitor.visit(array: self)
    }

    @discardableResult
    public func append(_ element: JSON) -> JSONArray {
        value.append(element)
        return self
    }

    @discardableResult
    public func append(array element: [JSON]) -> JSONArray {
        return append(JSONArray(element))
    }

    @discardableResult
    public func append(array element: JSONArray) -> JSONArray {
        return append(element)
    }

    @discardableResult
    public func append(dictionary element: [String: JSON]) -> JSONArray {
        return append(JSONObject(element))
    }

    @discardableResult
    public func append(dictionary element: JSONObject) -> JSONArray {
        return append(element)
    }

    @discardableResult
    public func append(bool element: Bool) -> JSONArray {
        return append(JSONBool(element))
    }

    @discardableResult
    public func append(string element: String) -> JSONArray {
        return append(JSONString(element))
    }

    @discardableResult
    public func append(double element: Double) -> JSONArray {
        return append(JSONDouble(element))
    }

    @discardableResult
    public func append(float element: Float) -> JSONArray {
        return append(JSONDouble(Double(element)))
    }

    @discardableResult
    public func append(int element: Int) -> JSONArray {
        return append(JSONInt64(Int64(element)))
    }

    @discardableResult
    public func append(int32 element: Int32) -> JSONArray {
        return append(JSONInt(element))
    }

    @discardableResult
    public func append(int64 element: Int64) -> JSONArray {
        return append(JSONInt64(element))
    }

    @discardableResult
    public func append(uint element: UInt) -> JSONArray {
        return append(JSONUInt64(UInt64(element)))
    }

    @discardableResult
    public func append(uint32 element: UInt32) -> JSONArray {
        return append(JSONUInt(element))
    }

    @discardableResult
    public func append(uint64 element: UInt64) -> JSONArray {
        return append(JSONUInt64(element))
    }

    override func equals(to object: JSON) -> Bool {
        if let element = object as? JSONArray {
            return value == element.value
        }
        return super.equals(to: object)
    }

    public override subscript(index: Int) -> JSON {
        guard index > -1 && index < value.count else {
            return JSON.null
        }
        return value[index]
    }
}
