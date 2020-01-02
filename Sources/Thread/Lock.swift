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

public protocol Locking {
    func lock()
    func unlock()
    func `try`() -> Bool
}

public extension Locking {
    @discardableResult
    @inline(__always)
    func locking<T>(_ method: () throws -> T) rethrows -> T {
        self.lock()
        defer {
            self.unlock()
        }
        return try method()
    }

    @discardableResult
    @inline(__always)
    func locking<T, R>(_ value: T, _ method: (T) throws -> R) rethrows -> R {
        self.lock()
        defer {
            self.unlock()
        }
        return try method(value)
    }

    @inline(__always)
    func locking<T>(into value: inout T, _ method: (inout T) throws -> Void) rethrows {
        self.lock()
        defer {
            self.unlock()
        }
        try method(&value)
    }

    @discardableResult
    @inline(__always)
    func unlocking<T>(_ method: () throws -> T) rethrows -> T {
        self.unlock()
        defer {
            self.lock()
        }
        return try method()
    }
}

@available(OSX 10.12, iOS 10.0, *)
public final class UnfairLock: Locking {
    @usableFromInline
    var _lock: os_unfair_lock

    @inline(__always)
    public init() {
        _lock = os_unfair_lock()
    }

    @inline(__always)
    public func lock() {
        os_unfair_lock_lock(&_lock)
    }

    @inline(__always)
    public func unlock() {
        os_unfair_lock_unlock(&_lock)
    }

    @inline(__always)
    public func `try`() -> Bool {
        return os_unfair_lock_trylock(&_lock)
    }
}

public final class MutexLock: Locking {
    private let mutex: UnsafeMutablePointer<pthread_mutex_t>

    public init(recursive: Bool = false) {
        mutex = UnsafeMutablePointer.allocate(capacity: 1)

        var attribute = pthread_mutexattr_t()
        pthread_mutexattr_init(&attribute)
        defer {
            pthread_mutexattr_destroy(&attribute)
        }

        let type: Int32 = recursive ? PTHREAD_MUTEX_RECURSIVE : PTHREAD_MUTEX_NORMAL
        pthread_mutexattr_settype(&attribute, type)
        let status = pthread_mutex_init(mutex, &attribute)
        assert(status == 0, "Unexpected pthread_muter_init error code: \(status)")
    }

    deinit {
        let status = pthread_mutex_destroy(mutex)
        assert(status == 0, "Unexpected pthread_mutex_destroy error code: \(status)")
        mutex.deallocate()
    }

    public func lock() {
        let status = pthread_mutex_lock(mutex)
        assert(status == 0, "Unexpected pthread_mutex_lock error code: \(status)")
    }

    public func unlock() {
        let status = pthread_mutex_unlock(mutex)
        assert(status == 0, "Unexpected pthread_mutex_unlock error code: \(status)")
    }

    public func `try`() -> Bool {
        let status = pthread_mutex_trylock(mutex)
        switch status {
        case 0:
            return true
        case EBUSY:
            return false
        default:
            assert(false, "Unexpected pthread_mutex_trylock error code: \(status)")
            return false
        }
    }
}

public final class ReadWriteLock {
    private let lock: UnsafeMutablePointer<pthread_rwlock_t>

    public init(recursive: Bool = false) {
        lock = UnsafeMutablePointer.allocate(capacity: 1)
        let status = pthread_rwlock_init(lock, nil)
        assert(status == 0, "Unexpected pthread_rwlock_init error code: \(status)")
    }

    deinit {
        let status = pthread_rwlock_destroy(lock)
        assert(status == 0, "Unexpected pthread_rwlock_destroy error code: \(status)")
        lock.deallocate()
    }

    public func lockRead() {
        let status = pthread_rwlock_rdlock(lock)
        assert(status == 0, "Unexpected pthread_rwlock_rdlock error code: \(status)")
    }
    
    public func lockWrite() {
        let status = pthread_rwlock_wrlock(lock)
        assert(status == 0, "Unexpected pthread_rwlock_rdlock error code: \(status)")
    }

    public func unlock() {
        let status = pthread_rwlock_unlock(lock)
        assert(status == 0, "Unexpected pthread_mutex_unlock error code: \(status)")
    }

    public func tryRead() -> Bool {
        let status = pthread_rwlock_tryrdlock(lock)
        switch status {
        case 0:
            return true
        case EBUSY:
            return false
        default:
            assert(false, "Unexpected pthread_rwlock_tryrdlock error code: \(status)")
            return false
        }
    }
    
    public func tryWrite() -> Bool {
        let status = pthread_rwlock_trywrlock(lock)
        switch status {
        case 0:
            return true
        case EBUSY:
            return false
        default:
            assert(false, "Unexpected pthread_rwlock_tryrdlock error code: \(status)")
            return false
        }
    }
    
    @discardableResult
    @inline(__always)
    public func lockingRead<T>(_ method: () throws -> T) rethrows -> T {
        self.lockRead()
        defer {
            self.unlock()
        }
        return try method()
    }
    
    @discardableResult
    @inline(__always)
    public func lockingWrite<T>(_ method: () throws -> T) rethrows -> T {
        self.lockWrite()
        defer {
            self.unlock()
        }
        return try method()
    }
}

public struct Lock {
    private init() {
        // Do nothing.
    }

    public static func make() -> Locking {
        if #available(iOS 10.0, *) {
            return UnfairLock()
        } else {
            return MutexLock()
        }
    }
}
