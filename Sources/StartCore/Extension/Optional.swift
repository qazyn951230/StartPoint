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

public extension Optional {
    func maybe(_ method: (Wrapped) throws -> Void) rethrows {
        if let value = self {
            try method(value)
        }
    }

    func or(_ method: () throws -> Wrapped) rethrows -> Wrapped {
        if let value = self {
            return value
        } else {
            return try method()
        }
    }
}

extension Optional where Wrapped: Comparable {
    public static func <(lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        if let left = lhs, let right = rhs {
            return left < right
        }
        return false
    }

    public static func <=(lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        if let left = lhs, let right = rhs {
            return left <= right
        }
        return false
    }

    public static func >=(lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        if let left = lhs, let right = rhs {
            return left >= right
        }
        return false
    }

    public static func >(lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        if let left = lhs, let right = rhs {
            return left > right
        }
        return false
    }
}

public extension Optional where Wrapped: BinaryInteger {
    func add(_ other: Wrapped?, origin: Wrapped? = nil) -> Wrapped? {
        if let left = self ?? origin, let right = other {
            return left + right
        }
        return nil
    }

    mutating func adding(_ other: Wrapped?, origin: Wrapped? = nil) {
        self = (self ?? origin).add(other)
    }

    func subtract(_ other: Wrapped?, origin: Wrapped? = nil) -> Wrapped? {
        if let left = self ?? origin, let right = other {
            return left - right
        }
        return nil
    }

    mutating func subtracting(_ other: Wrapped?, origin: Wrapped? = nil) {
        self = (self ?? origin).subtract(other)
    }
}

public extension Optional where Wrapped == String {
    var orEmpty: String {
        if let value = self {
            return value
        }
        return String.empty
    }

    var notEmpty: String? {
        if let value = self {
            return value.isEmpty ? nil : value
        }
        return nil
    }
}

