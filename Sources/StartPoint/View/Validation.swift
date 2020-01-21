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

public enum Validation {
    case number(Int?)
    case phone
    case pattern(String)

    public func function(default: Bool = true) -> (String?) -> Bool {
        switch self {
        case let .number(length):
            if let l = length {
                return Validation.create(pattern: "\\d{0,\(l)}", default: `default`)
            } else {
                return Validation.create(pattern: "\\d+", default: `default`)
            }
        case .phone:
            return Validation.create(pattern: "1\\d{0,10}", default: `default`)
        case let .pattern(p):
            return Validation.create(pattern: p, default: `default`)
        }
    }

    static func create(pattern: String, default: Bool) -> (String?) -> Bool {
        guard let expression = try? NSRegularExpression(pattern: pattern, options: []) else {
            return { _ in `default`}
        }
        return { value in
            guard let value = value, !value.isEmpty else {
                return `default`
            }
            let length = value.count
            let range = NSRange(location: 0, length: length)
            guard let result = expression.firstMatch(in: value, options: [], range: range) else {
                return false
            }
            return result.range.length == length
        }
    }
}
