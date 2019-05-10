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

public final class JSONParser {
    public struct Options: OptionSet {
        public let rawValue: Int32

        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let fullPrecision = Options(rawValue: 1 << 0)
        public static let nullTerminated = Options(rawValue: 1 << 1)
    }

    public static let defaultOptions: Options = [Options.nullTerminated]
    let stream: ByteStream
    let options: Options
    let buffer: JSONBufferRef

    public init(stream: ByteStream, buffer: JSONBufferRef, options: Options = JSONParser.defaultOptions) {
        self.stream = stream
        self.options = options
        self.buffer = buffer
    }

    //  n,  t,  f,  ",  [,  {
    // [6e, 74, 66, 22, 5b, 7b]
    public func parse() throws {
        switch stream.peek() {
        case 0x6e:
            try parseNull()
        case 0x74:
            try parseTrue()
        case 0x66:
            try parseFalse()
        case 0x22:
            try parseString()
        case 0x7b:
            try parseObject()
        case 0x5b:
            try parseArray()
        default:
            try parseNumber()
        }
    }

    //  n,  u,  l,  l
    // [6e, 75, 6c, 6c]
    func parseNull() throws {
        if consume(char: 0x6e) && consume(char: 0x75) &&
               consume(char: 0x6c) && consume(char: 0x6c) {
            json_buffer_append_null(buffer)
        } else {
            throw JSONParseError.valueInvalid
        }
    }

    //  t,  r,  u,  e
    // [74, 72, 75, 65]
    func parseTrue() throws {
        if consume(char: 0x74) && consume(char: 0x72) &&
               consume(char: 0x075) && consume(char: 0x65) {
            json_buffer_append_bool(buffer, true)
        } else {
            throw JSONParseError.valueInvalid
        }
    }

    //  f,  a,  l,  s,  e
    // [66, 61, 6c, 73, 65]
    func parseFalse() throws {
        if consume(char: 0x66) && consume(char: 0x61) && consume(char: 0x6C) &&
               consume(char: 0x73) && consume(char: 0x65) {
            json_buffer_append_bool(buffer, false)
        } else {
            throw JSONParseError.valueInvalid
        }
    }

    func parseString() throws {
        if !consume(char: 0x22) {
            throw JSONParseError.valueInvalid
        }
        let start = json_buffer_start_string(buffer)
        try rawString()
        json_buffer_end_string(buffer, start)
        if !consume(char: 0x22) {
            throw JSONParseError.valueInvalid
        }
    }

    //  -,  0,  1,  9,  .
    // [2d, 30, 31, 39, 2e]
    func parseNumber() throws {
        let minus = consume(char: 0x2d)
        var i: UInt32 = 0
        var i64: UInt64 = 0
        var significandDigit = 0
        var use64bit = false
        var next = UInt32(stream.peek())
        switch next {
        case 0x30:
            stream.move()
        case 0x31...0x39:
            i = next - 0x30
            next = UInt32(stream.next())
            if minus {
                while next >= 0x30 && next <= 0x39 {
                    if i >= 214748364 { // 2^31 = 2147483648
                        if i != 214748364 || next > 0x38 {
                            i64 = UInt64(i)
                            use64bit = true
                            break
                        }
                    }
                    i = i * 10 + (next - 0x30)
                    significandDigit += 1
                    next = UInt32(stream.next())
                }
            } else {
                while next >= 0x30 && next <= 0x39 {
                    if i >= 429496729 { // 2^32 - 1 = 4294967295
                        if i != 429496729 || next > 0x35 {
                            i64 = UInt64(i)
                            use64bit = true
                            break
                        }
                    }
                    i = i * 10 + (next - 0x30)
                    significandDigit += 1
                    next = UInt32(stream.next())
                }
            }
        default:
            throw JSONParseError.valueInvalid
        }
        var useDouble = false
        var double: Double = 0
        if use64bit {
            if minus {
                while next >= 0x30 && next <= 0x39 {
                    if i64 >= 922337203685477580 { // 2^63 = 9223372036854775808
                        if i64 != 922337203685477580 || next > 0x38 {
                            double = Double(i64)
                            useDouble = true
                            break
                        }
                    }
                    i64 = i64 * 10 + (UInt64(next) - 0x30)
                    significandDigit += 1
                    next = UInt32(stream.next())
                }
            } else {
                while next >= 0x30 && next <= 0x39 {
                    if i64 >= 1844674407370955161 { // // 2^64 - 1 = 18446744073709551615
                        if i64 != 1844674407370955161 || next > 0x35 {
                            double = Double(i64)
                            useDouble = true
                            break
                        }
                    }
                    i64 = i64 * 10 + (UInt64(next) - 0x30)
                    significandDigit += 1
                    next = UInt32(stream.next())
                }
            }
        }
        if useDouble {
            while next >= 0x30 && next <= 0x39 {
                double = double * 10 + Double(next - 0x30)
                next = UInt32(stream.next())
            }
        }
        var frac: Int32 = 0
//        let decimalPosition: String.Index
        if consume(char: 0x2e) { // .
//            decimalPosition = stream.current
            next = UInt32(stream.peek())
            if next < 0x30 || next > 0x39 {
                throw JSONParseError.numberMissFraction
            }
            if !useDouble {
                if !use64bit {
                    i64 = UInt64(i)
                }
                while next >= 0x30 && next <= 0x39 {
                    if i64 > 0x1F_FFFF_FFFF_FFFF { // 2^53 - 1
                        break
                    }
                    i64 = i64 * 10 + UInt64(next - 0x30)
                    frac -= 1
                    if i64 != 0 {
                        significandDigit += 1
                    }
                    next = UInt32(stream.next())
                }
                double = Double(i64)
                useDouble = true
            }
            while next >= 0x30 && next <= 0x39 { // 0...9
                if significandDigit < 17 {
                    double = double * 10 + Double(next - 0x30)
                    frac -= 1
                    if double > 0 {
                        significandDigit += 1
                    }
                }
                next = UInt32(stream.next())
            }
        }
//        else {
//            decimalPosition = stream.current
//        }
        // Parse exp = e [ minus / plus ] 1*DIGIT
        var exp: Int32 = 0
        if consume(char: 0x65) || consume(char: 0x45) { // e, E
            if !useDouble {
                double = use64bit ? Double(i64) : Double(i)
                useDouble = true
            }
            var expMinus = false
            if consume(char: 0x2b) { // +
                // Do nothing.
            } else if consume(char: 0x2d) { // -
                expMinus = true
            }
            var next = stream.peek()
            if next >= 0x30 && next <= 0x39 { // 0...9
                exp = Int32(next - 0x30)
                next = stream.next()
                if expMinus {
                    assert(frac <= 0)
                    let maxExp: Int32 = (frac + 2147483639) / 10
                    while next >= 0x30 && next <= 0x39 { // 0...9
                        exp = exp * 10 + Int32(next - 0x30)
                        if exp > maxExp {
                            while next >= 0x30 && next <= 0x39 { // 0...9
                                // Consume the rest of exponent
                                next = stream.next()
                            }
                        }
                        next = stream.next()
                    }
                } else {
                    let maxExp: Int32 = 308 - frac
                    while next >= 0x30 && next <= 0x39 { // 0...9
                        exp = exp * 10 + Int32(next - 0x30)
                        if exp > maxExp {
                            throw JSONParseError.numberTooBig
                        }
                        next = stream.next()
                    }
                }
            } else {
                throw JSONParseError.numberMissExponent
            }
            if expMinus {
                exp = -exp
            }
        }
        if useDouble {
            double = parse_double(double, exp + frac)
            if minus {
                json_buffer_append_double(buffer, 0 - double)
            } else {
                json_buffer_append_double(buffer, double)
            }
        } else if use64bit {
            if minus {
                json_buffer_append_int64(buffer, Int64(bitPattern: ~i64 + 1))
            } else {
                json_buffer_append_uint64(buffer, i64)
            }
        } else {
            if minus {
                json_buffer_append_int32(buffer, Int32(bitPattern: ~i + 1))
            } else {
                json_buffer_append_uint32(buffer, i)
            }
        }
    }

    //  {,  },  ",  :,  ,
    // [7b, 7d, 22, 3a, 2c]
    func parseObject() throws {
        let c = consume(char: 0x7b)
        assert(c)
        skip()
        let start = json_buffer_start_object(buffer)
        if consume(char: 0x7d) {
            json_buffer_end_object(buffer, start, 0)
            return
        }
        var count = 0
        while true {
            if stream.peek() != 0x22 {
                throw JSONParseError.objectMissName
            }
            skip()
            try parseString()
            skip()
            if !consume(char: 0x3a) {
                throw JSONParseError.objectMissColon
            }
            skip()
            try parse()
            count += 1
            skip()
            switch stream.peek() {
            case 0x2c:
                stream.move()
                skip()
            case 0x7d:
                stream.move()
                json_buffer_end_object(buffer, start, count)
                return
            default:
                throw JSONParseError.objectMissCommaOrCurlyBracket
            }
        }
    }

    //  [,  ],  ,
    // [5b, 5d, 2c]
    func parseArray() throws {
        let c = consume(char: 0x5b)
        assert(c)
        skip()
        let start = json_buffer_start_array(buffer)
        if consume(char: 0x5d) {
            json_buffer_end_array(buffer, start, 0)
            return
        }
        var count = 0
        while true {
            try parse()
            count += 1
            skip()
            if consume(char: 0x2c) {
                skip()
            } else if consume(char: 0x5d) {
                json_buffer_end_array(buffer, start, count)
                return
            } else {
                throw JSONParseError.arrayMissCommaOrSquareBracket
            }
        }
    }

    //  \,  ",  b,  f,  n,  r,  t,  /,  u
    // [5c, 22, 62, 66, 6e, 72, 74, 2f, 75]
    func rawString() throws {
        var next = stream.peek()
        while true {
            switch next {
            case 0x5c:
                next = stream.next()
                if next == 0x75 {
                    try parseUnicode()
                } else {
                    let char = try parseChar()
                    json_buffer_append_char(buffer, char)
                }
            case 0x22:
                return
            case 0x00:
//                if stream.effective {
//                    buffer.append(next)
//                    stream.move()
//                } else {
//                    throw JSONParseError.missQuotationMark
//                }
                throw JSONParseError.missQuotationMark
            case 0x01..<0x20:
                throw JSONParseError.invalidEncoding
            default:
                json_buffer_append_char(buffer, next)
                stream.move()
            }
            next = stream.peek()
        }
    }

    func parseChar() throws -> UInt8 {
        switch stream.peek() {
        case 0x22:
            stream.move()
            return 0x22
        case 0x5c:
            stream.move()
            return 0x5c
        case 0x2f:
            stream.move()
            return 0x2f
        case 0x62:
            stream.move()
            return 0x08
        case 0x66:
            stream.move()
            return 0x0c
        case 0x6e:
            stream.move()
            return 0x0a
        case 0x72:
            stream.move()
            return 0x0d
        case 0x74:
            stream.move()
            return 0x09
        default:
            throw JSONParseError.stringEscapeInvalid
        }
    }

    func parseUnicode() throws {
        let code = try parseUnicodeValue()
        if code <= 0x7f {
            json_buffer_append_char(buffer, UInt8(truncatingIfNeeded: (code & 0xFF)))
            return
        }
        if code <= 0x7ff {
            json_buffer_append_char(buffer, UInt8(truncatingIfNeeded: (0xc0 | ((code >> 6) & 0xff))))
            json_buffer_append_char(buffer, UInt8(truncatingIfNeeded: (0x80 | (code & 0x3F))))
            return
        }
        if code <= 0xffff {
            json_buffer_append_char(buffer, UInt8(truncatingIfNeeded: (0xE0 | ((code >> 12) & 0xFF))))
            json_buffer_append_char(buffer, UInt8(truncatingIfNeeded: (0x80 | ((code >> 6) & 0x3F))))
            json_buffer_append_char(buffer, UInt8(truncatingIfNeeded: (0x80 | (code & 0x3F))))
            return
        }
        if code <= 0x10ffff {
            json_buffer_append_char(buffer, UInt8(truncatingIfNeeded: (0xF0 | ((code >> 18) & 0xFF))))
            json_buffer_append_char(buffer, UInt8(truncatingIfNeeded: (0x80 | ((code >> 12) & 0x3F))))
            json_buffer_append_char(buffer, UInt8(truncatingIfNeeded: (0x80 | ((code >> 6) & 0x3F))))
            json_buffer_append_char(buffer, UInt8(truncatingIfNeeded: (0x80 | (code & 0x3F))))
            return
        }
        throw JSONParseError.valueInvalid
    }

    func parseUnicodeValue() throws -> UInt32 {
        assert(stream.peek() == 0x75)
        stream.move()
        var point: UInt32 = 0
        for _ in 0..<4 {
            point <<= 4
            let next = UInt32(stream.peek())
            point += next
            switch next { // TODO: Replace range
            case 0x30...0x39: // 0-9
                point -= 0x30
            case 0x41...0x46: // A-F
                point -= 0x41 - 10
            case 0x61...0x66: // a-f
                point -= 0x61 - 10
            default:
                throw JSONParseError.StringUnicodeEscapeInvalidHex
            }
            stream.move()
        }
        return point
    }

    func consume(char: UInt8) -> Bool {
        if stream.peek() == char {
            stream.move()
            return true
        }
        return false
    }

    // ' ', \n, \r, \t
    // [20, 0a, 0d, 09]
    func skip() {
        var next = stream.peek()
        while next == 0x20 || next == 0x0a || next == 0x0d || next == 0x09 {
            next = stream.next()
        }
    }
}
