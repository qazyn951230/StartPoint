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

public extension Dictionary {
    func compactMapValues<T>(_ transform: (Value) throws -> T?) rethrows -> [Key: T] {
        var map: [Key: T] = [:]
        for (key, value) in self {
            if let item = try transform(value) {
                map[key] = item
            }
        }
        return map
    }

    func firstValue(where predicate: (Key, Value) throws -> Bool) rethrows -> Value? {
        for (key, value) in self {
            if try predicate(key, value) {
                return value
            }
        }
        return nil
    }

    static func generate(count: Int, _ generator: (Int) throws -> (Key, Value)) rethrows
            -> Dictionary<Key, Value> {
        var result: [Key: Value] = [:]
        for index in 0..<count {
            let (key, value) = try generator(index)
            result[key] = value
        }
        return result
    }

    static func generate(from: Key, _ generator: (Key) throws -> (Key, Value)?) rethrows
            -> Dictionary<Key, Value> {
        var result: [Key: Value] = [:]
        var last = from
        while let (_key, _value) = try generator(last) {
            result[_key] = _value
            last = _key
        }
        return result
    }
}
