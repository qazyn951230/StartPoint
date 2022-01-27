// MIT License
//
// Copyright (c) 2021-present qazyn951230 qazyn951230@gmail.com
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

extension Optional {
    /// Returns `true` if the Optional is a `some` value.
    @inlinable
    public var isSome: Bool {
        switch self {
        case .some:
            return true
        case .none:
            return false
        }
    }

    /// Returns `true` if the Optional is a `none` value.
    @inlinable
    public var isNone: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }

    /// Returns the contained `some` value.
    /// Raise fatalError if the value is a none with a custom fatal error message provided by message.
    ///
    /// - Parameter message: A custom fatal error message provided by message.
    /// - Returns: Returns the contained `some` value.
    @inlinable
    public func expect(_ message: @autoclosure () -> String) -> Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            fatalError(message())
        }
    }

    @inlinable
    @available(*, deprecated, renamed: "ifPresent(_:)")
    public func isPresent(_ then: (Wrapped) throws -> Void) rethrows {
        try ifPresent(then)
    }

    @inlinable
    public func ifPresent(_ then: (Wrapped) throws -> Void) rethrows {
        switch self {
        case .none:
            break
        case let .some(value):
            try then(value)
        }
    }

    @inlinable
    public mutating func withPresenting(_ then: () throws -> Wrapped) rethrows -> Wrapped {
        switch self {
        case .none:
            let value = try then()
            self = .some(value)
            return value
        case let .some(value):
            return value
        }
    }

    @inlinable
    @available(*, deprecated, renamed: "unwrap(by:)")
    public func or(_ creator: @autoclosure () -> Wrapped) -> Wrapped {
        switch self {
        case .none:
            return creator()
        case let .some(value):
            return value
        }
    }

    /// Returns the contained some value or a provided default.
    ///
    /// - Note: Arguments passed to unwrap(or:) are eagerly evaluated;
    /// if you are passing the result of a function call,
    /// it is recommended to use unwrap(by:), which is lazily evaluated.
    ///
    /// - Parameter default: A default value provided if the self value equals `none`.
    /// - Returns: Returns the contained some value or a provided default.
    @inlinable
    public func unwrap(or `default`: Wrapped) -> Wrapped {
        switch self {
        case .none:
            return `default`
        case let .some(value):
            return value
        }
    }

    /// Returns the contained some value or computes it from a closure.
    ///
    /// - Parameter method: A closure provided if the self value equals `none`.
    /// - Returns: Returns the contained some value or a computes one.
    @inlinable
    public func unwrap(by method: () throws -> Wrapped) rethrows -> Wrapped {
        switch self {
        case .none:
            return try method()
        case let .some(value):
            return value
        }
    }
}

extension Optional where Wrapped: Collection {
    @inlinable
    @available(*, deprecated, renamed: "isNilOrEmpty")
    public var isEmptyOrNil: Bool {
        isNilOrEmpty
    }

    @inlinable
    public var isNilOrEmpty: Bool {
        switch self {
        case .none:
            return true
        case let .some(value):
            return value.isEmpty
        }
    }
}
