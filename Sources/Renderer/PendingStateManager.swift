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

import Dispatch

final class WeakSet<T: AnyObject & Hashable> {
    var set: Set<WeakHash<T>> = Set()

    func insert(_ value: T) {
        set.insert(WeakHash(value))
    }

    func forEach(_ body: (T) throws -> Void) rethrows {
        try set.forEach { (object: WeakHash<T>) in
            if let value = object.value {
                try body(value)
            }
        }
    }
}

// ASPendingStateController
final class PendingStateManager {
    static var shared: PendingStateManager = PendingStateManager()

    private let lock = MutexLock()
    private var set = WeakSet<Element>()
    private var pendingFlush = false

    private init() {
        // Do nothing
    }

    func register(element: Element) {
        assert(element.loaded, "Expected display node to be loaded before it " +
            "was registered with PendingStateManager.")
        lock.locking {
            set.insert(element)
        }
    }

    func flush() {
        assertMainThread()
        lock.lock()
        let set = self.set
        self.set = WeakSet()
        pendingFlush = false
        lock.unlock()
        set.forEach {
            $0.applyPendingState()
        }
    }

    func scheduleFlush() {
        guard !pendingFlush else {
            return
        }
        pendingFlush = true
        DispatchQueue.main.async {
            PendingStateManager.shared.flush()
        }
    }
}
