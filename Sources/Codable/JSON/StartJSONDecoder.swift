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

//public final class StartJSONDecoder {
//    public private(set) var codingPath: [CodingKey]
//    public var userInfo: [CodingUserInfoKey: Any]
//
//    public init() {
//        codingPath = []
//        userInfo = [:]
//    }
//
//    public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
//        let buffer = try data.withUnsafeBytes { (raw: UnsafeRawBufferPointer) -> JSONBufferRef in
//            guard let pointer = raw.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
//                throw JSONParseError.invalidEncoding
//            }
//            let stream = ByteStream.uint8(pointer)
//            let buffer = json_buffer_create(24, 4096)
//            let parser = JSONParser(stream: stream, buffer: buffer, options: [])
//            try parser.parse()
//            return buffer
//        }
//        let decoder = JSONBufferDecoder(buffer: buffer)
//        defer {
//            json_buffer_free(buffer)
//        }
//        return try T.init(from: decoder)
//    }
//}
