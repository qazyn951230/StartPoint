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

public final class XMLNotation: TypeNotated {
    public typealias Value = XMLNotation
    static let null = XMLNotation()

    let node: XMLNode?
    let element: XMLElement?
    var _array: [XMLNotation]?
    var _map: [String: XMLNotation]?
    private var resolved = false

    private init() {
        node = nil
        element = nil
        resolved = true
    }

    public init(_ node: XMLNode) {
        if node.kind == XMLNode.Kind.element {
            element = node as? XMLElement
            self.node = nil
        } else {
            element = nil
            self.node = node
        }
    }

    public init(list: List<XMLNode>) {
        node = nil
        element = nil
        _array = list.map(XMLNotation.init)
        resolved = true
    }

    func resolve() {
        guard !resolved, let element = self.element else {
            return
        }
        var children: [XMLNode] = element.children ?? []
        if let attributes = element.attributes {
            children.append(contentsOf: attributes)
        }
        if children.isEmpty {
            return
        }
        let grouped: [String: List<XMLNode>] = children.group { node in
            node.name ?? ""
        }
        _map = grouped.mapValues { list in
            if let first = list.first, list.count < 2 {
                return XMLNotation(first)
            } else {
                return XMLNotation(list: list)
            }
        }
        resolved = true
    }

    public var raw: Any {
        // TODO: XMLNotation.Any
        return ""
    }

    public var exists: Bool {
        return !(element == nil || node == nil || _array == nil)
    }

    public var arrayValue: [XMLNotation]? {
        if _array != nil {
            return _array
        } else {
            resolve()
            if let map = _map {
                return Array<XMLNotation>(map.values)
            }
            return nil
        }
    }

    public var array: [XMLNotation] {
        if let temp = _array {
            return temp
        } else {
            resolve()
            if let map = _map {
                return Array<XMLNotation>(map.values)
            }
            return []
        }
    }

    public var dictionaryValue: [String: XMLNotation]? {
        resolve()
        return _map
    }

    public var dictionary: [String: XMLNotation] {
        resolve()
        return _map ?? [:]
    }

    public var boolValue: Bool? {
        return stringValue.flatMap(Bool.init)
    }

    public var bool: Bool {
        switch string {
        case "YES":
            return true
        case "NO":
            return false
        default:
            // Bool.init => "true" or "false"
            return Bool(string) ?? false
        }
    }

    public var stringValue: String? {
        let node = element ?? self.node
        return node?.stringValue
    }

    public var string: String {
        let node = element ?? self.node
        return node?.stringValue ?? ""
    }

    public var doubleValue: Double? {
        return stringValue.flatMap(Double.init)
    }

    public var double: Double {
        return Double(string) ?? 0.0
    }

    public var floatValue: Float? {
        return stringValue.flatMap(Float.init)
    }

    public var float: Float {
        return Float(string) ?? 0
    }

    public var intValue: Int? {
        return stringValue.flatMap(Int.init)
    }

    public var int: Int {
        return Int(string) ?? 0
    }

    public var int32Value: Int32? {
        return stringValue.flatMap(Int32.init)
    }

    public var int32: Int32 {
        return Int32(string) ?? 0
    }

    public var int64Value: Int64? {
        return stringValue.flatMap(Int64.init)
    }

    public var int64: Int64 {
        return Int64(string) ?? 0
    }

    public var uintValue: UInt? {
        return stringValue.flatMap(UInt.init)
    }

    public var uint: UInt {
        return UInt(string) ?? 0
    }

    public var uint32Value: UInt32? {
        return stringValue.flatMap(UInt32.init)
    }

    public var uint32: UInt32 {
        return UInt32(string) ?? 0
    }

    public var uint64Value: UInt64? {
        return stringValue.flatMap(UInt64.init)
    }

    public var uint64: UInt64 {
        return UInt64(string) ?? 0
    }

    public subscript(typed index: Int) -> XMLNotation {
        return _array?.element(at: index) ?? XMLNotation.null
    }

    public subscript(typed key: String) -> XMLNotation {
        resolve()
        return _map?[key] ?? XMLNotation.null
    }

    public static func parse(path: String, options: XMLNode.Options = []) -> XMLNotation {
        let url = URL(fileURLWithPath: path)
        guard let xml = try? XMLDocument(contentsOf: url, options: options),
              let root = xml.rootElement() else {
            return XMLNotation.null
        }
        return XMLNotation(root)
    }
}
