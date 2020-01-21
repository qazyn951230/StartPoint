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

public struct Function {
    @inline(__always)
    public static func this<T>(_ value: T) -> T {
        value
    }

    @inline(__always)
    public static func maybe<T>(_ value: T?) -> T? {
        value
    }

    @inline(__always)
    public static func not(_ value: Bool) -> Bool {
        !value
    }

    @inline(__always)
    public static func empty(string: String) -> Bool {
        string.isEmpty
    }

    @inline(__always)
    public static func notEmpty(string: String) -> Bool {
        !string.isEmpty
    }

    @inline(__always)
    public static func empty(string: String?) -> Bool {
        if let s = string {
            return empty(string: s)
        }
        return true
    }

    @inline(__always)
    public static func notEmpty(string: String?) -> Bool {
        if let s = string {
            return notEmpty(string: s)
        }
        return false
    }

    @inline(__always)
    public static func empty<T: Collection>(collection: T) -> Bool {
        collection.isEmpty
    }

    @inline(__always)
    public static func notEmpty<T: Collection>(collection: T) -> Bool {
        !collection.isEmpty
    }

    @inline(__always)
    public static func always<T>(_ value: T) -> (Any) -> T {
        { _ in value }
    }

    @inline(__always)
    public static func alwaysNil<T>() -> T? {
        nil
    }

    @inline(__always)
    public static func alwaysTrue() -> Bool {
        true
    }

    @inline(__always)
    public static func alwaysTrue(_ value: Any) -> Bool {
        true
    }

    @inline(__always)
    public static func alwaysFalse() -> Bool {
        false
    }

    @inline(__always)
    public static func alwaysFalse(_ value: Any) -> Bool {
        false
    }

    @inline(__always)
    public static func and(_ lhs: Bool, _ rhs: Bool) -> Bool {
        lhs && rhs
    }

    @inline(__always)
    public static func or(_ lhs: Bool, _ rhs: Bool) -> Bool {
        lhs || rhs
    }

    @inline(__always)
    public static func lengthGreater(_ value: Int) -> (String) -> Bool {
        { $0.count > value }
    }

    @inline(__always)
    public static func lengthGreaterOrEqual(_ value: Int) -> (String) -> Bool {
        { $0.count >= value }
    }

    @inline(__always)
    public static func lengthLess(_ value: Int) -> (String) -> Bool {
        { $0.count < value }
    }

    @inline(__always)
    public static func lengthLessOrEqual(_ value: Int) -> (String) -> Bool {
        { $0.count <= value }
    }

    @inline(__always)
    public static func lengthEqual(_ value: Int) -> (String) -> Bool {
        { $0.count == value }
    }

    @inline(__always)
    public static func lengthNotEqual(_ value: Int) -> (String) -> Bool {
        { $0.count != value }
    }

    @inline(__always)
    public static func reducedArray(init: Bool = true,
                                    reducer: @escaping (Bool, Bool) -> Bool = Function.and) -> ([Bool]) -> Bool {
        { array in  array.reduce(`init`, reducer) }
    }

    @inline(__always)
    public static func first<A, B>(tuple: (A, B)) -> A {
        tuple.0
    }

    @inline(__always)
    public static func second<A, B>(tuple: (A, B)) -> B {
        tuple.1
    }

    @inline(__always)
    public static func nothing(_ value: Any) {
        // Do nothing.
    }

    @inline(__always)
    public static func nothing() {
        // Do nothing.
    }

    @inline(__always)
    public static func equal<T>(_ value: T) -> (T) -> Bool where T: Comparable {
        { $0 == value }
    }

    @inline(__always)
    public static func notEqual<T>(_ value: T) -> (T) -> Bool where T: Comparable {
        { $0 != value }
    }

    @inline(__always)
    public static func greater<T>(_ value: T) -> (T) -> Bool where T: Comparable {
        { $0 > value }
    }

    @inline(__always)
    public static func greaterOrEqual<T>(_ value: T) -> (T) -> Bool where T: Comparable {
        { $0 >= value }
    }

    @inline(__always)
    public static func less<T>(_ value: T) -> (T) -> Bool where T: Comparable {
        { $0 < value }
    }

    @inline(__always)
    public static func lessOrEqual<T>(_ value: T) -> (T) -> Bool where T: Comparable {
        { $0 <= value }
    }

    @inline(__always)
    public static func print(_ value: Any) {
        Swift.print(value)
    }
}
