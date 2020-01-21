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

extension KeyedDecodingContainer {
//    @inline(__always)
//    func decode<T>(uuid type: T.Type, forKey key: Key) throws -> T where T: PBXObject {
//        let uuid = try decode(String.self, forKey: key)
//        return T.init(uuid: uuid)
//    }
//
//    @inline(__always)
//    func decodeIfPresent<T>(uuid type: T.Type, forKey key: Key) throws -> T? where T: PBXObject {
//        let uuid = try decodeIfPresent(String.self, forKey: key)
//        return uuid.map(T.init(uuid:))
//    }
//
//    @inline(__always)
//    func decode<T>(unkeyed type: T.Type, forKey key: Key) throws -> [T] where T: PBXObject {
//        var result: [T] = []
//        var next = try nestedUnkeyedContainer(forKey: key)
//        while !next.isAtEnd {
//            let uuid = try next.decode(String.self)
//            result.append(T.init(uuid: uuid))
//        }
//        return result
//    }
//
//    @inline(__always)
//    func decodeIfPresent<T>(unkeyed type: T.Type, forKey key: Key) throws -> [T]? where T: PBXObject {
//        if try decodeNil(forKey: key) {
//            return nil
//        }
//        var result: [T] = []
//        let next = try nestedUnkeyedContainer(forKey: key)
//        while !next.isAtEnd {
//            let uuid = try decode(String.self, forKey: key)
//            result.append(T.init(uuid: uuid))
//        }
//        return result
//    }

    @inline(__always)
    public func decode(plist type: Bool.Type, forKey key: Key) throws -> Bool {
        let value = try decode(String.self, forKey: key)
        switch value {
        case "", "1", "true", "TRUE", "YES":
             return true
        case "0", "false", "FALSE", "NO":
            return false
        default:
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "value not bool")
            throw DecodingError.typeMismatch(Bool.self, context)
        }
    }

    @inline(__always)
    public func decodeIfPresent(plist type: Bool.Type, forKey key: Key) throws -> Bool? {
        if try decodeNil(forKey: key) {
            return nil
        }
        let value = try decode(String.self, forKey: key)
        return value == "1" ? true : false
    }

    @inline(__always)
    public func decode<T>(split type: T.Type, forKey key: Key, separator: Character = Character(" ")) throws
            -> [T] where T: RawRepresentable, T.RawValue == String {
        let value = try decode(String.self, forKey: key)
        return try value.split(separator: separator).map {
            if let next = T.init(rawValue: String($0)) {
                return next
            } else {
                let context = DecodingError.Context(codingPath: codingPath, debugDescription: "invalid value")
                throw DecodingError.typeMismatch(T.self, context)
            }
        }
    }
}

extension KeyedEncodingContainer {
//    @inline(__always)
//    mutating func encode<T>(uuid value: [T], forKey key: Key) throws where T: PBXObject {
//        var next = nestedUnkeyedContainer(forKey: key)
//        for item in value {
//            try next.encode(item.uuid)
//        }
//    }
//
//    @inline(__always)
//    mutating func encodeIfPresent<T>(uuid value: [T]?, forKey key: Key) throws where T: PBXObject {
//        guard let array = value else {
//            try encodeNil(forKey: key)
//            return
//        }
//        var next = nestedUnkeyedContainer(forKey: key)
//        for item in array {
//            try next.encode(item.uuid)
//        }
//    }

    @inline(__always)
    mutating func encode(plist value: Bool, forKey key: Key) throws {
        try encode(value ? "1" : "0", forKey: key)
    }

    @inline(__always)
    mutating func encodeIfPresent(plist value: Bool?, forKey key: Key) throws {
        if let temp = value {
            try encode(temp ? "1" : "0", forKey: key)
        } else {
            try encodeNil(forKey: key)
        }
    }
}

