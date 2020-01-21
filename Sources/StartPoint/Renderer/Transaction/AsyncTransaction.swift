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

//protocol TransactionGroup {
//    func release()
//    func schedule(priority: Int, in queue: DispatchQueue, work: @escaping () -> Void)
//    func notify(queue: DispatchQueue, work: @escaping () -> Void)
//    func enter()
//    func wait()
//}
//
//final class AsyncTransactionQueue: TransactionGroup {
//    // https://lists.swift.org/pipermail/swift-users/Week-of-Mon-20161205/004147.html
//    let pendingOperations: UnsafeMutablePointer<Int32> = {
//        let value = UnsafeMutablePointer<Int32>.allocate(capacity: 1)
//        value.initialize(to: 0)
//        return value
//    }()
//    var releaseCalled = false
//    let lock = MutexLock(recursive: true)
//    var entries: [DispatchQueue: DispatchEntry] = [:]
//
//    func release() {
//        lock.lock()
//        if pendingOperations.pointee != 0 {
//            releaseCalled = true
//        }
//        lock.unlock()
//    }
//
//    func schedule(priority: Int, in queue: DispatchQueue, work: @escaping () -> Void) {
//        lock.lock()
//        defer {
//            lock.unlock()
//        }
//
//    }
//
//    struct Operation {
//        let work: () -> Void
//        // Caution circular reference
//        let group: AsyncTransactionQueue
//        let priority: Int
//    }
//
//    class DispatchEntry {
//        var OperationQueue: [Operation] = []
//    }
//}

public final class AsyncTransaction {
    // this, canceled
    public let completion: ((AsyncTransaction, Bool) -> Void)?
    public var state: State

    var operations: [Operation] = []

    public init(completion: ((AsyncTransaction, Bool) -> Void)?) {
        self.completion = completion
        state = .initialized
    }

    public func addOperation(_ operation: () -> Any?, priority: Int = defaultPriority, queue: DispatchQueue, completion: ((Any?, Bool) -> Void)?) {
        assertMainThread()
        assertEqual(state, State.initialized)
        let operation = Operation(completion: completion)
        operations.append(operation)
    }

    public static let defaultPriority: Int = 0

    public enum State {
        case initialized
        case committed
        case canceled
        case completed
    }

    public final class Operation {
        public var data: Any?
        public let completion: ((Any?, Bool) -> Void)?

        public init(completion: ((Any?, Bool) -> Void)?) {
            self.completion = completion
        }
    }
}
