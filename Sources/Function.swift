// MIT License
//
// Copyright (c) 2017 qazyn951230 qazyn951230@gmail.com
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
    public static func this<T>(_ value: T) -> T {
        return value
    }

    public static func maybe<T>(_ value: T?) -> T? {
        return value
    }

    public static func not(_ value: Bool) -> Bool {
        return !value
    }

    public static func empty(string: String) -> Bool {
        return string.isEmpty
    }

    public static func notEmpty(string: String) -> Bool {
        return !string.isEmpty
    }

    public static func empty(string: String?) -> Bool {
        if let s = string {
            return empty(string: s)
        }
        return true
    }

    public static func notEmpty(string: String?) -> Bool {
        if let s = string {
            return notEmpty(string: s)
        }
        return false
    }

    public static func empty<T:Collection>(collection: T) -> Bool {
        return collection.isEmpty
    }

    public static func notEmpty<T:Collection>(collection: T) -> Bool {
        return !collection.isEmpty
    }

    public static func always<T>(_ value: T) -> (Any) -> T {
        return { _ in value }
    }

    public static func alwaysTrue() -> Bool {
        return true
    }

    public static func alwaysTrue(_ value: Any) -> Bool {
        return true
    }

    public static func alwaysFalse() -> Bool {
        return false
    }

    public static func alwaysFalse(_ value: Any) -> Bool {
        return false
    }

    public static func and(_ lhs: Bool, _ rhs: Bool) -> Bool {
        return lhs && rhs
    }

    public static func or(_ lhs: Bool, _ rhs: Bool) -> Bool {
        return lhs || rhs
    }

    public static func lengthGreater(_ value: Int) -> (String) -> Bool {
        return {
            $0.length > value
        }
    }

    public static func lengthGreaterOrEqual(_ value: Int) -> (String) -> Bool {
        return {
            $0.length >= value
        }
    }

    public static func lengthLess(_ value: Int) -> (String) -> Bool {
        return {
            $0.length < value
        }
    }

    public static func lengthLessOrEqual(_ value: Int) -> (String) -> Bool {
        return {
            $0.length <= value
        }
    }

    public static func lengthEqual(_ value: Int) -> (String) -> Bool {
        return {
            $0.length == value
        }
    }

    public static func lengthNotEqual(_ value: Int) -> (String) -> Bool {
        return {
            $0.length != value
        }
    }

    public static func reducedArray(init: Bool = true,
                                    reducer: @escaping (Bool, Bool) -> Bool = Function.and) -> ([Bool]) -> Bool {
        return { array in
            return array.reduce(`init`, reducer)
        }
    }

    public static func first<A, B>(tuple: (A, B)) -> A {
        return tuple.0
    }

    public static func second<A, B>(tuple: (A, B)) -> B {
        return tuple.1
    }

    public static func nothing(_ value: Any) {
        // Do nothing.
    }

    public static func equal<T:Comparable>(_ value: T) -> (T) -> Bool {
        return {
            $0 == value
        }
    }

    public static func notEqual<T:Comparable>(_ value: T) -> (T) -> Bool {
        return {
            $0 != value
        }
    }
}
