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

//public protocol UnicodeProvider {
//    var available: Bool { get }
//    func decode() throws -> UInt32
//}
//
//// http://bjoern.hoehrmann.de/utf-8/decoder/dfa/
//// https://github.com/Tencent/rapidjson/blob/master/include/rapidjson/encodings.h#L204
//public final class UTF8Provider: UnicodeProvider {
//    public let stream: ByteStream
//
//    public var available: Bool {
//        return stream.effective
//    }
//
//    public init(stream: ByteStream) {
//        self.stream = stream
//    }
//
//    public func decode() throws -> UInt32 {
//        var byte = stream.peek()
//        var value: UInt32 = 0
//        var state: UInt32 = 0
//        while stream.effective {
//            stream.move()
//            if UTF8Provider.decode(byte: byte, value: &value, state: &state) {
//                return value
//            }
//            byte = stream.peek()
//        }
//        return 0
//    }
//
//    private static func decode(byte: UInt8, value: inout UInt32, state: inout UInt32) -> Bool {
//        let _byte = UInt32(byte)
//        let type = UInt32(utf8d[Int(_byte)])
//        value = (state != 0) ? (_byte & 0x3f) | (value << 6) : (0xff >> type) & _byte
//        state = UInt32(utf8d[Int(256 + state * 16 + type)])
//        return state == 0
//    }
//
//    private static let utf8d: [UInt8] = [
//        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 00..1f
//        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 20..3f
//        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 40..5f
//        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 60..7f
//        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, // 80..9f
//        7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, // a0..bf
//        8, 8, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, // c0..df
//        0xa, 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x4, 0x3, 0x3, // e0..ef
//        0xb, 0x6, 0x6, 0x6, 0x5, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, // f0..ff
//        0x0, 0x1, 0x2, 0x3, 0x5, 0x8, 0x7, 0x1, 0x1, 0x1, 0x4, 0x6, 0x1, 0x1, 0x1, 0x1, // s0..s0
//        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, // s1..s2
//        1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, // s3..s4
//        1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 3, 1, 1, 1, 1, 1, 1, // s5..s6
//        1, 3, 1, 1, 1, 1, 1, 3, 1, 3, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, // s7..s8
//    ]
//}
//
//public final class StringProvider: UnicodeProvider {
//    let scalars: String.UnicodeScalarView
//    var current: String.UnicodeScalarView.Index
//
//    public init(text: String) {
//        scalars = text.unicodeScalars
//        current = scalars.startIndex
//    }
//
//    public var available: Bool {
//        return current < scalars.endIndex
//    }
//
//    public func decode() throws -> UInt32 {
//        guard available else {
//            return 0
//        }
//        defer {
//            current = scalars.index(after: current)
//        }
//        return scalars.at(current)?.value ?? 0
//    }
//}
//
//public final class UnicodeStream: InStream {
//    // Codepoint
//    public typealias Value = UInt32
//
//    public let provider: UnicodeProvider
//    var data: UnsafeMutablePointer<UInt32>
//    let capacity = 2048
//    var current: UnsafeMutablePointer<UInt32>
//    var index = 0
//    var count = 0
//
//    public init(provider: UnicodeProvider) {
//        self.provider = provider
//        data = UnsafeMutablePointer<UInt32>.allocate(capacity: capacity)
//        current = data
//        decode(offset: 0)
//    }
//
//    deinit {
//        data.deallocate()
//    }
//
//    public var effective: Bool {
//        index < count
//    }
//
//    // index < count <= capacity
//    // offset > 0: guarantee (index + offset) < count <= capacity
//    private func decode(offset: Int) {
//        precondition(offset > -1 && offset < 1024)
//        guard provider.available else {
//            return
//        }
//        let copy = (offset > 0 && (index + offset) > count) || (count > (capacity / 2))
//        if copy {
//            // uint_32* temp = (uint_8 *)malloc(sizeof(uint_32) * capacity);
//            // memcpy(temp, data, sizeof(uint_32) * (count - index));
//            // free(data);
//            // data = temp;
//            if count > index {
//                let temp = UnsafeMutablePointer<UInt32>.allocate(capacity: capacity)
//                // FIXME: moveAssign == memcpy ?
//                temp.moveAssign(from: data, count: count - index)
//                data.deallocate()
//                data = temp
//                current = data
//                count = count - index
//                index = 0
//            } else {
//                current = data
//                count = 0
//                index = 0
//            }
//        }
//        let size = capacity / 2
//        var pointer = current
//        for _ in count ..< size {
//            if !provider.available {
//                break
//            }
//            // FIXME: try? => try
//            if let codepoint = try? provider.decode() {
//                pointer.initialize(to: codepoint)
//                pointer = pointer.successor()
//                count += 1
//            }
//        }
//    }
//
//    public func peek() -> UInt32 {
//        decode(offset: 0)
//        return effective ? current.pointee : 0
//    }
//
//    public func peek(offset: Int) -> UInt32 {
//        precondition(offset > -1 && offset < 1024)
//        decode(offset: offset)
//        if index + offset < count {
//            return current.advanced(by: offset).pointee
//        } else {
//            return 0
//        }
//    }
//
//    @discardableResult
//    public func move() -> Bool {
//        decode(offset: 0)
//        if effective {
//            current = current.successor()
//            index += 1
//        }
//        return true
//    }
//
//    @discardableResult
//    public func move(offset: Int) -> Bool {
//        precondition(offset > -1 && offset < 1024)
//        decode(offset: offset)
//        if index + offset < count {
//            current = current.advanced(by: offset)
//            index += offset
//        }
//        return true
//    }
//}
