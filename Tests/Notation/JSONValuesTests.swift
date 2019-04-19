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

@testable import StartPoint
import XCTest

class JSONValuesTests: XCTestCase {
    func testJSONBool() {
        let t = JSONBool(true)
        XCTAssertEqual(t.bool, true)
        XCTAssertEqual(t.boolValue, true as Bool?)

        let f = JSONBool(false)
        XCTAssertEqual(f.bool, false)
        XCTAssertEqual(f.boolValue, false as Bool?)
    }

    func testJSONInt() {
        let intMin = try! JSON.parse("\(Int32.min)")
#if arch(x86_64) || arch(arm64)
        XCTAssertEqual(intMin.int, Int(bitPattern: 0xffff_ffff_8000_0000))
#else
        XCTAssertEqual(intMin.int, Int(bitPattern: 0x8000_0000))
#endif
        XCTAssertEqual(intMin.int32, Int32.min)
        XCTAssertEqual(intMin.int64, Int64(bitPattern: 0xffff_ffff_8000_0000))

        let intMax = try! JSON.parse("\(Int32.max)")
#if arch(x86_64) || arch(arm64)
        XCTAssertEqual(intMax.int, Int(bitPattern: 0x0000_0000_7fff_ffff))
#else
        XCTAssertEqual(intMax.int, Int(bitPattern: 0x7fff_ffff))
#endif
        XCTAssertEqual(intMax.int32, Int32.max)
        XCTAssertEqual(intMax.int64, Int64(bitPattern: 0x0000_0000_7fff_ffff))
    }

    func testJSONInt64() {
        let intMin = try! JSON.parse("\(Int64.min)")
#if arch(x86_64) || arch(arm64)
        XCTAssertEqual(intMin.int, Int(bitPattern: 0x8000_0000_0000_0000))
#else
        XCTAssertEqual(intMin.intValue, nil)
#endif
        XCTAssertEqual(intMin.int32Value, nil)
        XCTAssertEqual(intMin.int64, Int64(bitPattern: 0x8000_0000_0000_0000))

        let intMax = try! JSON.parse("\(Int64.max)")
#if arch(x86_64) || arch(arm64)
        XCTAssertEqual(intMax.int, Int(bitPattern: 0x7fff_ffff_ffff_ffff))
#else
        XCTAssertEqual(intMax.intValue, nil)
#endif
        XCTAssertEqual(intMax.int32Value, nil)
        XCTAssertEqual(intMax.int64, Int64(bitPattern: 0x7fff_ffff_ffff_ffff))
    }

    func testJSONUInt() {
        let intMin = try! JSON.parse("\(UInt32.min)")
        XCTAssertEqual(intMin.uint, 0)
        XCTAssertEqual(intMin.uint32, UInt32.min)
        XCTAssertEqual(intMin.uint64, 0)

        let int = try! JSON.parse("2684354559")
        XCTAssertEqual(int.uint, 0x9fff_ffff as UInt)
        XCTAssertEqual(int.uint32, 0x9fff_ffff as UInt32)
        XCTAssertEqual(int.uint64, 0x9fff_ffff as UInt64)

        let intMax = try! JSON.parse("\(UInt32.max)")
#if arch(x86_64) || arch(arm64)
        XCTAssertEqual(intMax.uint, 0xffff_ffff as UInt)
#else
        XCTAssertEqual(intMax.uint, 0xffff_ffff as UInt)
#endif
        XCTAssertEqual(intMax.uint32, UInt32.max)
        XCTAssertEqual(intMax.uint64, 0xffff_ffff as UInt64)
    }

    func testJSONUInt64() {
        let intMin = try! JSON.parse("\(UInt64.min)")
        XCTAssertEqual(intMin.uint, 0)
        XCTAssertEqual(intMin.uint32, 0)
        XCTAssertEqual(intMin.uint64, UInt64.min)

        let int = try! JSON.parse("11529215046068469759")
#if arch(x86_64) || arch(arm64)
        XCTAssertEqual(int.uint, 0x9fff_ffff_ffff_ffff as UInt)
#else
        XCTAssertEqual(int.uintValue, nil)
#endif
        XCTAssertEqual(int.uint32Value, nil)
        XCTAssertEqual(int.uint64, 0x9fff_ffff_ffff_ffff as UInt64)

        let intMax = try! JSON.parse("\(UInt64.max)")
#if arch(x86_64) || arch(arm64)
        XCTAssertEqual(intMax.uint, 0xffff_ffff_ffff_ffff as UInt)
#else
        XCTAssertEqual(intMax.uint, 0xffff_ffff as UInt)
#endif
        XCTAssertEqual(intMax.uint32Value, nil)
        XCTAssertEqual(intMax.uint64, 0xffff_ffff_ffff_ffff as UInt64)
    }

    func testJSONDouble() {
        let json = try? JSON.parse("-1.50139930144708198E18")
        XCTAssertNotNil(json)
        XCTAssertEqual(String(format: "%.2f", json?.double ?? 0.0), "-1501399301447081984.00")
    }
}
