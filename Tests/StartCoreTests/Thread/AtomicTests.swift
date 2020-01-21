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
import Dispatch
@testable import StartCore

class AtomicTests: XCTestCase {
    func testCAtomicIntAdd() {
        let value: SPAIntRef = spa_int_create(0)
        XCTAssertEqual(spa_int_load(value), 0)

        let group = DispatchGroup()
        let queue = DispatchQueue(label: "test", qos: .utility, attributes: .concurrent)
        queue.apply(iterations: 10) { _ in
            group.enter()
            for _ in 0..<1000 {
                spa_int_add(value, 1)
            }
            group.leave()
        }
        _ = group.wait(timeout: .distantFuture)
        XCTAssertEqual(spa_int_load(value), 10000)
        spa_int_free(value)
    }

    // https://github.com/ReactiveX/RxSwift/issues/1853
    func testCAtomicIntDataRace() {
        let value  = spa_int_create(0)
        let group = DispatchGroup()
        for i in 0...100 {
            DispatchQueue.global(qos: .background).async {
                if i % 2 == 0 {
                    spa_int_add(value, 1)
                } else {
                    spa_int_sub(value, 1)
                }
                if i == 100 {
                    group.leave()
                }
            }
        }
        group.enter()
        _ = group.wait(timeout: .distantFuture)
        XCTAssertEqual(spa_int_load(value), 1)
        spa_int_free(value)
    }

    func testCAtomicIntPerformance() {
        measure {
            let value = spa_int_create(0)
            for _ in 0..<LockTests.max {
                spa_int_add(value, 1)
            }
            spa_int_free(value)
        }
    }
}
