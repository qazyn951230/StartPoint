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

import Darwin

struct Assert {
    private static let checkKey: pthread_key_t = {
        var key = pthread_key_t()
        pthread_key_create(&key, nil)
        return key
    }()

    static var checkMainThread: Bool {
        get {
            if let value: UnsafeMutableRawPointer = pthread_getspecific(Assert.checkKey) {
                let b = value.assumingMemoryBound(to: Bool.self)
                return b.pointee
            } else {
                var check = true
                pthread_setspecific(Assert.checkKey, &check)
                return check
            }
        }
        set {
            var check = newValue
            pthread_setspecific(Assert.checkKey, &check)
        }
    }
}

public func assertMainThread(file: StaticString = #file, line: UInt = #line) {
    assert(Assert.checkMainThread || Runner.isMain(),
        "This method must be called on the main thread", file: file, line: line)
}

func assertThreadAffinity(for element: BasicElement, file: StaticString = #file, line: UInt = #line) {
    assert(!element.loaded || Assert.checkMainThread || Runner.isMain(),
        "This method must be called on the main thread after element's view or layer has been created",
        file: file, line: line)
}

public func assertFail(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
    assert(false, message, file: file, line: line)
}

public func assertNil(_ expression: @autoclosure () -> Any?, _ message: @autoclosure () -> String = "",
                      file: StaticString = #file, line: UInt = #line) {
    assert(expression() == nil, message, file: file, line: line)
}

public func assertNotNil(_ expression: @autoclosure () -> Any?, _ message: @autoclosure () -> String = "",
                         file: StaticString = #file, line: UInt = #line) {
    assert(expression() != nil, message, file: file, line: line)
}

public func assertTrue(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "",
                       file: StaticString = #file, line: UInt = #line) {
    assert(expression() == true, message, file: file, line: line)
}

public func assertFalse(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "",
                        file: StaticString = #file, line: UInt = #line) {
    assert(expression() == false, message, file: file, line: line)
}

public func assertEqual<T: Equatable>(_ expression1: @autoclosure () -> T,
                                      _ expression2: @autoclosure () -> T,
                                      _ message: @autoclosure () -> String = "",
                                      file: StaticString = #file, line: UInt = #line) {
    assert(expression1() == expression2(), message, file: file, line: line)
}

public func assertNotEqual<T: Equatable>(_ expression1: @autoclosure () -> T,
                                         _ expression2: @autoclosure () -> T,
                                         _ message: @autoclosure () -> String = "",
                                         file: StaticString = #file, line: UInt = #line) {
    assert(expression1() != expression2(), message, file: file, line: line)
}

public func assertLessThan<T: Comparable>(_ expression1: @autoclosure () -> T,
                                          _ expression2: @autoclosure () -> T,
                                          _ message: @autoclosure () -> String = "",
                                          file: StaticString = #file, line: UInt = #line) {
    assert(expression1() < expression2(), message, file: file, line: line)
}

public func assertGreaterThan<T: Comparable>(_ expression1: @autoclosure () -> T,
                                             _ expression2: @autoclosure () -> T,
                                             _ message: @autoclosure () -> String = "",
                                             file: StaticString = #file, line: UInt = #line) {
    assert(expression1() > expression2(), message, file: file, line: line)
}

public func assertLessThanOrEqual<T: Comparable>(_ expression1: @autoclosure () -> T,
                                                 _ expression2: @autoclosure () -> T,
                                                 _ message: @autoclosure () -> String = "",
                                                 file: StaticString = #file, line: UInt = #line) {
    assert(expression1() <= expression2(), message, file: file, line: line)
}

public func assertGreaterThanOrEqual<T: Comparable>(_ expression1: @autoclosure () -> T,
                                                    _ expression2: @autoclosure () -> T,
                                                    _ message: @autoclosure () -> String = "",
                                                    file: StaticString = #file, line: UInt = #line) {
    assert(expression1() >= expression2(), message, file: file, line: line)
}
