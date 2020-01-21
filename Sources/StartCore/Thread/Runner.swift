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

import Dispatch
import Darwin
import Foundation

public final class Runner {
    public let queue: DispatchQueue

    public init(_ raw: DispatchQueue) {
        queue = raw
    }

    public convenience init(name: String) {
        let queue = DispatchQueue(label: name)
        self.init(queue)
    }

    public var isMain: Bool {
        return Runner.isMain()
    }

    @discardableResult
    public func sync(_ method: @escaping () -> Void) -> Runner {
        queue.sync(execute: method)
        return self
    }

    @discardableResult
    public func async(_ method: @escaping () -> Void) -> Runner {
        queue.async(execute: method)
        return self
    }

    @discardableResult
    public func async(after: TimeInterval, _ method: @escaping () -> Void) -> Runner {
        queue.asyncAfter(deadline: DispatchTime.now() + after, execute: method)
        return self
    }

    // The pthread_main_np() function returns
    // 1    if the calling thread is the initial thread,
    // 0    if the calling thread is not the initial thread, and
    // -1   if the thread's initialization has not yet completed.
    @inline(__always)
    public static func isMain() -> Bool {
        return pthread_main_np() != 0
    }

    @inline(__always)
    public static func notMain() -> Bool {
        return pthread_main_np() == 0
    }

    @inline(__always)
    public static func main() -> Runner {
        return Runner(DispatchQueue.main)
    }

    @inline(__always)
    public static func onMain(_ method: @escaping () -> Void) {
        if Runner.isMain() {
            method()
        } else {
            DispatchQueue.main.async(execute: method)
        }
    }

    @inline(__always)
    public static func main(async method: @escaping () -> Void) {
        DispatchQueue.main.async(execute: method)
    }

    @inline(__always)
    public static func main(after: TimeInterval, async method: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after, execute: method)
    }
}
