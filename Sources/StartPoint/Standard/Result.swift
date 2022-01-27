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

extension Result {
    /// Returns `true` if the result is `.success`.
    /// - Since: 0.1.1
    @inlinable
    @inline(__always)
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    /// Returns `true` if the result is `.failure`.
    /// - Since: 0.1.1
    @inlinable
    @inline(__always)
    public var isFailure: Bool {
        switch self {
        case .success:
            return false
        case .failure:
            return true
        }
    }

    /// Converts from `Result<Success, Failure>` to `Option<Success>`.
    ///
    /// Converts `self` into an `Option<Success>`, consuming self, and discarding the error, if any.
    /// - Since: 0.1.1
    @inlinable
    @inline(__always)
    public var succeed: Success? {
        switch self {
        case let .success(value):
            return value
        case .failure:
            return nil
        }
    }

    /// Converts from `Result<Success, Failure>` to `Option<Failure>`.
    ///
    /// Converts self into an `Option<Failure>`, consuming self, and discarding the success value, if any.
    /// - Since: 0.1.1
    @inlinable
    @inline(__always)
    public var failed: Failure? {
        switch self {
        case .success:
            return nil
        case let .failure(error):
            return error
        }
    }

    /// Returns `resource` if the result is `success`, otherwise returns the failure value of `self`.
    ///
    /// - Since: 0.1.1
    /// - Parameter resource: A function returns a new `Result`.
    /// - Returns: A resolved result.
    @inlinable
    public func and<NewSuccess>(
        _ resource: @autoclosure () -> Result<NewSuccess, Failure>
    ) -> Result<NewSuccess, Failure> {
        switch self {
        case .success:
            return resource()
        case let .failure(failure):
            return .failure(failure)
        }
    }

    /// Returns resource if the result is `failure`, otherwise returns the success value of `self`.
    ///
    /// - Since: 0.1.1
    /// - Parameter resource: A function returns a new `Result`.
    /// - Returns: A resolved result.
    @inlinable
    public func or<NewFailure>(
        _ resource: @autoclosure () -> Result<Success, NewFailure>
    ) -> Result<Success, NewFailure> {
        switch self {
        case let .success(success):
            return .success(success)
        case .failure:
            return resource()
        }
    }

    /// Returns the contained `success` value.
    ///
    /// - Note: Because this function may crash, its use is generally discouraged.
    ///     Instead, prefer to use pattern matching and handle the `failure` case explicitly,
    ///     or call ``unwrap(:or)``.
    ///
    /// - Since: 0.1.1
    /// - Returns: The `success` value.
    @inlinable
    public func unwrap() -> Success {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            preconditionFailure("Result is error: \(error)")
        }
    }

    /// Returns the contained `success` value or a provided default.
    ///
    /// - Since: 0.1.1
    /// - Parameter default: A function provides a "default" success value
    /// - Returns: The `success` value or newly created value.
    @inlinable
    public func unwrap(or `default`: @autoclosure () -> Success) -> Success {
        switch self {
        case let .success(value):
            return value
        case .failure:
            return `default`()
        }
    }

    /// Returns the contained `success` value or a provided default.
    ///
    /// - Since: 0.1.1
    /// - Parameter method: A function provides a "default" success value
    /// - Returns: The `success` value or newly created value.
    /// - Throws: A error may thrown by the method function.
    @inlinable
    public func unwrap(by method: () throws -> Success) rethrows -> Success {
        switch self {
        case let .success(value):
            return value
        case .failure:
            return try method()
        }
    }

    /// Returns the contained `success` value or a provided default.
    ///
    /// - Since: 0.1.1
    /// - Parameter default: A function provides a "default" success value
    /// - Returns: The `success` value or newly created value.
    @inlinable
    @available(*, deprecated, renamed: "unwrap(or:)")
    public func value(or `default`: @autoclosure () -> Success) -> Success {
        unwrap(or: `default`())
    }

    /// Returns a new result, mapping any success value using the given transformation.
    /// Like `map`, but allow throw errors.
    ///
    /// - Since: 0.1.1
    /// - Parameter transform: A function that takes the success value of this instance.
    /// - Returns: A `Result` instance with the result of evaluating `transform` as
    ///            the new success value if this instance represents a success.
    @inlinable
    public func tryMap<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> Result<NewSuccess, Error> {
        switch self {
        case let .success(value):
            do {
                let t = try transform(value)
                return .success(t)
            } catch {
                return .failure(error)
            }
        case let .failure(error):
            return .failure(error)
        }
    }

    /// A action performs when the result contains `success` value
    ///
    /// - Since: 0.1.1
    /// - Parameter then: A function that takes the success value.
    @inlinable
    public func whenSuccess(_ then: (Success) -> Void) {
        switch self {
        case let .success(value):
            then(value)
        case .failure:
            break
        }
    }

    /// A action performs when the result contains `failure` value
    ///
    /// - Since: 0.1.1
    /// - Parameter then: A function that takes the failure value (error).
    @inlinable
    public func whenFailure(_ then: (Failure) -> Void) {
        switch self {
        case .success:
            break
        case let .failure(error):
            then(error)
        }
    }
}

extension Result where Success: Equatable {
    /// Returns a Bool value indicating whether the result contains the given success value.
    ///
    /// - Since: 0.1.1
    /// - Parameter value: The value to find in the result.
    /// - Returns: `true` if the value was found in the result; otherwise, `false`.
    @inlinable
    public func contains(_ value: Success) -> Bool {
        switch self {
        case let .success(temp):
            return temp == value
        case .failure:
            return false
        }
    }
}

extension Result where Failure: Equatable {
    /// Returns a Bool value indicating whether the result contains the given error.
    ///
    /// - Since: 0.1.1
    /// - Parameter value: The error to find in the result.
    /// - Returns: `true` if the error was found in the result; otherwise, `false`.
    @inlinable
    public func contains(error value: Failure) -> Bool {
        switch self {
        case .success:
            return false
        case let .failure(error):
            return error == value
        }
    }
}
