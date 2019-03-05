// MIT License
//
// Copyright (c) 2017-present qazyn951230 qazyn951230@gmail.com
//
// Permission is hereby granted,free of charge,to any person obtaining a copy
// of this software and associated documentation files (the "Software"),to deal
// in the Software without restriction,including without limitation the rights
// to use,copy,modify,merge,publish,distribute,sublicense,and/or sell
// copies of the Software,and to permit persons to whom the Software is
// furnished to do so,subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS",WITHOUT WARRANTY OF ANY KIND,EXPRESS OR
// IMPLIED,INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,DAMAGES OR OTHER
// LIABILITY,WHETHER IN AN ACTION OF CONTRACT,TORT OR OTHERWISE,ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

//@testable import StartPoint
//import XCTest
//
//fileprivate struct Simple: Decodable, Equatable {
//    let a: Int
//    let b: UInt
//    let c: String
//}
//
//fileprivate struct SimpleKey: Decodable, Equatable {
//    let a: Int
//    let b: UInt
//    let c: String
//
//    enum CodingKeys: String, CodingKey {
//        case a = "b"
//        case b = "c"
//        case c = "a"
//    }
//}
//
//fileprivate class CodeFoo: Decodable {
//    let simple: Simple
//    let data: Data
//
//    init(simple: Simple, data: Data) {
//        self.simple = simple
//        self.data = data
//    }
//}
//
//fileprivate class CodeBar: CodeFoo, Equatable {
//    let simpleKey: SimpleKey
//    let date: Date
//
//    init(simple: Simple, data: Data, simpleKey: SimpleKey, date: Date) {
//        self.simpleKey = simpleKey
//        self.date = date
//        super.init(simple: simple, data: data)
//    }
//
//    required init(from decoder: Decoder) throws {
//        simpleKey = try SimpleKey(from: decoder)
//        date = try Date(from: decoder)
//        try super.init(from: decoder)
//    }
//
//    static func ==(lhs: CodeBar, rhs: CodeBar) -> Bool {
//        if lhs === rhs {
//            return true
//        }
//        if type(of: lhs) != type(of: rhs) {
//            return false
//        }
//        return lhs.simple == rhs.simple &&
//            lhs.data == rhs.data &&
//            lhs.simpleKey == rhs.simpleKey &&
//            lhs.date == rhs.date
//    }
//}
//
//class NotationCoderTests: XCTestCase {
//    func decode<T>(_ json: String, decoded: T, file: StaticString = #file,
//                   line: UInt = #line) where T: Decodable & Equatable {
//        do {
//            let data = json.data(using: .utf8) ?? Data()
//            let value = try NotationCoder.decodeJSON(T.self, from: data)
//            XCTAssertEqual(value, decoded, file: file, line: line)
//        } catch {
//            XCTFail("decode failed", file: file, line: line)
//        }
//    }
//
//    func testDecodeSimple() {
//        decode("1", decoded: 1 as Int8)
//        decode("1", decoded: 1 as Int16)
//        decode("1", decoded: 1 as Int)
//        decode("1", decoded: 1 as Int32)
//        decode("1", decoded: 1 as Int64)
//        decode("1", decoded: 1 as UInt8)
//        decode("1", decoded: 1 as UInt16)
//        decode("1", decoded: 1 as UInt)
//        decode("1", decoded: 1 as UInt32)
//        decode("1", decoded: 1 as UInt64)
//        decode("1", decoded: 1 as Double)
//        decode("1", decoded: 1 as Float)
//
//        decode("-1", decoded: -1 as Int8)
//        decode("-1", decoded: -1 as Int16)
//        decode("-1", decoded: -1 as Int)
//        decode("-1", decoded: -1 as Int32)
//        decode("-1", decoded: -1 as Int64)
//        decode("-1", decoded: 0 as UInt8)
//        decode("-1", decoded: 0 as UInt16)
//        decode("-1", decoded: 0 as UInt)
//        decode("-1", decoded: 0 as UInt32)
//        decode("-1", decoded: 0 as UInt64)
//        decode("-1", decoded: -1 as Double)
//        decode("-1", decoded: -1 as Float)
//
//        decode("\"1\"", decoded: "1")
//        decode("true", decoded: true)
//        decode("false", decoded: false)
//
//        decode("1", decoded: 1 as Int8?)
//        decode("1", decoded: 1 as Int16?)
//        decode("1", decoded: 1 as Int?)
//        decode("1", decoded: 1 as Int32?)
//        decode("1", decoded: 1 as Int64?)
//        decode("1", decoded: 1 as UInt8?)
//        decode("1", decoded: 1 as UInt16?)
//        decode("1", decoded: 1 as UInt?)
//        decode("1", decoded: 1 as UInt32?)
//        decode("1", decoded: 1 as UInt64?)
//        decode("1", decoded: 1 as Double?)
//        decode("1", decoded: 1 as Float?)
//
//        decode("null", decoded: nil as Int8?)
//        decode("null", decoded: nil as Int16?)
//        decode("null", decoded: nil as Int?)
//        decode("null", decoded: nil as Int32?)
//        decode("null", decoded: nil as Int64?)
//        decode("null", decoded: nil as UInt8?)
//        decode("null", decoded: nil as UInt16?)
//        decode("null", decoded: nil as UInt?)
//        decode("null", decoded: nil as UInt32?)
//        decode("null", decoded: nil as UInt64?)
//        decode("null", decoded: nil as Double?)
//        decode("null", decoded: nil as Float?)
//
//        decode("\"1\"", decoded: "1" as String?)
//        decode("true", decoded: true as Bool?)
//        decode("false", decoded: false as Bool?)
//
//        decode("null", decoded: nil as String?)
//        decode("null", decoded: nil as Bool?)
//        decode("null", decoded: nil as Bool?)
//    }
//
//    func testDecodeArray() {
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Int8])
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Int16])
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Int])
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Int32])
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Int64])
//        decode("[1,11,111]", decoded: [1, 11, 111] as [UInt8])
//        decode("[1,11,111]", decoded: [1, 11, 111] as [UInt16])
//        decode("[1,11,111]", decoded: [1, 11, 111] as [UInt])
//        decode("[1,11,111]", decoded: [1, 11, 111] as [UInt32])
//        decode("[1,11,111]", decoded: [1, 11, 111] as [UInt64])
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Double])
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Float])
//
//        decode("[-1,22,0]", decoded: [-1, 22, 0] as [Int8])
//        decode("[-1,22,0]", decoded: [-1, 22, 0] as [Int16])
//        decode("[-1,22,0]", decoded: [-1, 22, 0] as [Int])
//        decode("[-1,22,0]", decoded: [-1, 22, 0] as [Int32])
//        decode("[-1,22,0]", decoded: [-1, 22, 0] as [Int64])
//        decode("[-1,22,0]", decoded: [0, 22, 0] as [UInt8])
//        decode("[-1,22,0]", decoded: [0, 22, 0] as [UInt16])
//        decode("[-1,22,0]", decoded: [0, 22, 0] as [UInt])
//        decode("[-1,22,0]", decoded: [0, 22, 0] as [UInt32])
//        decode("[-1,22,0]", decoded: [0, 22, 0] as [UInt64])
//        decode("[-1,22,0]", decoded: [-1, 22, 0] as [Double])
//        decode("[-1,22,0]", decoded: [-1, 22, 0] as [Float])
//
//        decode("[1,null,11]", decoded: [1, nil, 11] as [Int8?])
//        decode("[777,null,999]", decoded: [777, nil, 999] as [Int16?])
//        decode("[777,null,999]", decoded: [777, nil, 999] as [Int?])
//        decode("[777,null,999]", decoded: [777, nil, 999] as [Int32?])
//        decode("[777,null,999]", decoded: [777, nil, 999] as [Int64?])
//        decode("[1,null,11]", decoded: [1, nil, 11] as [UInt8?])
//        decode("[777,null,999]", decoded: [777, nil, 999] as [UInt16?])
//        decode("[777,null,999]", decoded: [777, nil, 999] as [UInt?])
//        decode("[777,null,999]", decoded: [777, nil, 999] as [UInt32?])
//        decode("[777,null,999]", decoded: [777, nil, 999] as [UInt64?])
//        decode("[777,null,999]", decoded: [777, nil, 999] as [Double?])
//        decode("[777,null,999]", decoded: [777, nil, 999] as [Float?])
//
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Int8]?)
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Int16]?)
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Int]?)
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Int32]?)
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Int64]?)
//        decode("[1,11,111]", decoded: [1, 11, 111] as [UInt8]?)
//        decode("[1,11,111]", decoded: [1, 11, 111] as [UInt16]?)
//        decode("[1,11,111]", decoded: [1, 11, 111] as [UInt]?)
//        decode("[1,11,111]", decoded: [1, 11, 111] as [UInt32]?)
//        decode("[1,11,111]", decoded: [1, 11, 111] as [UInt64]?)
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Double]?)
//        decode("[1,11,111]", decoded: [1, 11, 111] as [Float]?)
//
//        decode("[\"1\",\"989\",\"*&(1\"]", decoded: ["1", "989", "*&(1"])
//        decode("[\"1\",null,\"*&(1\"]", decoded: ["1", nil, "*&(1"] as [String?])
//        decode("[\"1\",\"989\",\"*&(1\"]", decoded: ["1", "989", "*&(1"] as [String]?)
//        decode("[true,false]", decoded: [true, false])
//        decode("[true,null]", decoded: [true, nil] as [Bool?])
//        decode("[false,true]", decoded: [false, true] as [Bool]?)
//    }
//
//    func testDecodeObject() {
////        decode("{\"a\":-999,\"b\":999,\"c\":\"foobar\"}",
////            decoded: Simple(a: -999, b: 999, c: "foobar"))
////        decode("{\"a\":\"foobar\",\"b\":-999,\"c\":999}",
////            decoded: SimpleKey(a: -999, b: 999, c: "foobar"))
////        decode("{\"simple\":{\"a\":-999,\"b\":999,\"c\":\"foobar\"},\"simpleKey\":{\"a\":\"foobar\",\"b\":-999,\"c\":999},\"data\":\"01010101\",\"date\":\"1545101000\"}",
////            decoded: CodeBar(simple: Simple(a: -999, b: 999, c: "foobar"), data: Data(),
////                simpleKey: SimpleKey(a: -999, b: 999, c: "foobar"), date: Date(timeIntervalSince1970: 1545101000)))
////        decode("1545101000", decoded: Date(timeIntervalSince1970: 1545101000))
//        decode("01010101", decoded: Data())
//    }
//
//    func testDecodeObjectArray() {
//        decode("[{\"a\":-999,\"b\":999,\"c\":\"foobar\"},{\"a\":938,\"b\":123,\"c\":\"***\"}]",
//            decoded: [Simple(a: -999, b: 999, c: "foobar"), Simple(a: 938, b: 123, c: "***")])
//        decode("[{\"a\":\"foobar\",\"b\":-999,\"c\":999},{\"a\":\"***\",\"b\":938,\"c\":123}]",
//            decoded: [SimpleKey(a: -999, b: 999, c: "foobar"), SimpleKey(a: 938, b: 123, c: "***")])
//    }
//}
