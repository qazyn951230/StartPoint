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

public protocol JSONGenerator {
    func generate() -> JSON
}

public extension JSON {
    func fill(any value: JSONGenerator?) {
        fill(any: value?.generate())
    }

    func fill(_ value: JSONGenerator) {
        fill(value.generate())
    }

    func append(any value: JSONGenerator?) {
        append(any: value?.generate())
    }

    func append(_ value: JSONGenerator) {
        append(value.generate())
    }

    func set(key: String, any value: JSONGenerator?) {
        set(key: key, any: value?.generate())
    }

    func set(key: String, _ value: JSONGenerator) {
        set(key: key, value.generate())
    }
}

extension Array: JSONGenerator where Element: JSONGenerator {
    public func generate() -> JSON {
        let json = JSON(type: JSONType.array)
        for item in self {
            json.append(item.generate())
        }
        return json
    }
}
