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

public class RunLoopQueue<T: AnyObject & Equatable> {
    let runLoop: CFRunLoop
    let handler: ((T?, Bool) -> Void)?
    var items: [Weak<T>] = []
    var observer: CFRunLoopObserver? = nil
    let source: CFRunLoopSource

    public var empty: Bool {
        return items.isEmpty
    }

    public var batchSize: UInt = 1
    public var ensureExclusiveMembership: Bool = true

    // handler => (item, drained)
    public init(runLoop: CFRunLoop, retain: Bool, handler: ((T?, Bool) -> Void)?) {
        self.runLoop = runLoop
        self.handler = handler
        var context = CFRunLoopSourceContext()
        // context.perform = { _ in }
        source = CFRunLoopSourceCreate(nil, 0, &context)
        CFRunLoopAddSource(self.runLoop, source, CFRunLoopMode.commonModes)
        observer = CFRunLoopObserverCreateWithHandler(nil, CFRunLoopActivity.beforeWaiting.rawValue, true, 0, process)
        CFRunLoopAddObserver(self.runLoop, observer, CFRunLoopMode.commonModes)
    }

    deinit {
        if CFRunLoopContainsSource(runLoop, source, CFRunLoopMode.commonModes) {
            CFRunLoopRemoveSource(runLoop, source, CFRunLoopMode.commonModes)
        }
        if CFRunLoopObserverIsValid(observer) {
            CFRunLoopObserverInvalidate(observer)
        }
    }

    public func enqueue(_ object: T) {
        if items.contains(Weak(object)) {
            return
        }
        CFRunLoopSourceSignal(source)
        CFRunLoopWakeUp(runLoop)
    }

    func process(observer: CFRunLoopObserver?, activity: CFRunLoopActivity) {
        guard let fn = handler, !items.isEmpty else {
            return
        }
        let maxProcessCount = min(items.count, Int(batchSize))
        let item: [Weak<T>] = Array(items.prefix(maxProcessCount))
        items.removeFirst(maxProcessCount)
        if item.isEmpty {
            return
        }
        let drained = items.isEmpty
        var index = 0
        for t in item {
            fn(t.value, drained && index == item.count - 1)
            index += 1
        }
        if !drained {
            CFRunLoopSourceSignal(source)
            CFRunLoopWakeUp(runLoop)
        }
    }
}
