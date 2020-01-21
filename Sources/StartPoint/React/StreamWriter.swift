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

class StreamWriter {
    var level: Int = 0
    private var stream: AnyByteStream

    init(stream: AnyByteStream) {
        self.stream = stream
    }

    func intent() {
        if level < 1 {
            return
        }
        let array = Array<UInt8>(repeating: 0x20, count: level * 2)
        stream.write(array)
    }

    @inline(__always)
    func write(_ data: Data) {
        stream.write(data)
    }

    @inline(__always)
    func write(_ string: String) {
        guard let data = string.data(using: .utf8) else {
            return
        }
        stream.write(data)
    }

    @inline(__always)
    func write(byte: UInt8) {
        stream.write(byte)
    }

    @inline(__always)
    func write(bytes: [UInt8]) {
        stream.write(bytes)
    }

    @inline(__always)
    func write(double value: Double) {
        write(String(value))
    }

    @inline(__always)
    func newline() {
        write(byte: 0x0a) // "\n"
    }

    @inline(__always)
    func space() {
        write(byte: 0x20) // " "
    }

    @inline(__always)
    func comma() {
        write(byte: 0x2c) // ,
    }

    @inline(__always)
    func colon() {
        write(byte: 0x3a) // :
    }

    @inline(__always)
    func semicolon() {
        write(byte: 0x3b) // ;
    }

}
