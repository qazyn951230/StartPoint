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

import XCTest
@testable import StartCore

// http://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html
// https://github.com/mattgallagher/CwlUtils/blob/master/Tests/CwlUtilsPerformanceTests/CwlMutexPerformanceTests.swift
final class LockTests: XCTestCase {
    static let max = 1_000_000

    var count = 0

    override func setUp() {
        count = 0
    }

    func testUnfairLockPerformance() {
        let lock = UnfairLock()
        measure {
            for _ in 0..<Self.max {
                lock.locking {
                    self.count += 1
                }
            }
        }
    }

    func testUnfairLockPerformance1() {
        let lock = UnfairLock()
        measure {
            var count = 0
            for _ in 0..<Self.max {
                lock.locking {
                    count += 1
                }
            }
        }
    }

    func testUnfairLockPerformance2() {
        let lock = UnfairLock()
        measure {
            var count = 0
            for _ in 0..<Self.max {
                count = lock.locking(count) {
                    $0 + 1
                }
            }
        }
    }

    func testUnfairLockPerformance3() {
        let lock = UnfairLock()
        measure {
            var count = 0
            for _ in 0..<Self.max {
                lock.locking(into: &count) {
                    $0 += 1
                }
            }
        }
    }

    func testUnfairLockPerformance4() {
        var lock = os_unfair_lock()
        measure {
            var count = 0
            for _ in 0..<Self.max {
                os_unfair_lock_lock(&lock)
                count += 1
                os_unfair_lock_unlock(&lock)
            }
        }
    }
}
