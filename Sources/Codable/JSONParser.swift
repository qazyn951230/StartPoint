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
    }

    let stream: ByteStream
    let options: Options

    public init(stream: ByteStream, options: Options = []) {
        self.stream = stream
        self.options = options
    }

    //  n,  t,  f,  ",  [,  {
    // [6e, 74, 66, 22, 5b, 7b]
    public func parse() throws -> JSON {
        switch stream.peek() {
        case 0x6e:
            return try parseNull()
        case 0x74:
            return try parseTrue()
        case 0x66:
            return try parseFalse()
        case 0x22:
            return try parseString()
        case 0x7b:
            return try parseObject()
        case 0x5b:
            return try parseArray()
        default:
            return try parseNumber()
        }
    }

    //  n,  u,  l,  l
    // [6e, 75, 6c, 6c]
    func parseNull() throws -> JSON {
        if consume(char: 0x6e) && consume(char: 0x75) &&
               consume(char: 0x6c) && consume(char: 0x6c) {
            return JSON.null
        } else {
            throw JSONParseError.valueInvalid
        }
    }

    //  t,  r,  u,  e
    // [74, 72, 75, 65]
    func parseTrue() throws -> JSON {
        if consume(char: 0x74) && consume(char: 0x72) &&
               consume(char: 0x075) && consume(char: 0x65) {
            return JSONBool(true)
        } else {
            throw JSONParseError.valueInvalid
        }
    }

    //  f,  a,  l,  s,  e
    // [66, 61, 6c, 73, 65]
    func parseFalse() throws -> JSON {
        if consume(char: 0x66) && consume(char: 0x61) && consume(char: 0x6C) &&
               consume(char: 0x73) && consume(char: 0x65) {
            return JSONBool(false)
        } else {
            throw JSONParseError.valueInvalid
        }
    }

    func parseString() throws -> JSON {
        let value = try quotedString()
        return JSONString(value)
    }

    //  -,  0,  1,  9,  .
    // [2d, 30, 31, 39, 2e]
    func parseNumber() throws -> JSON {
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
        if consume(char: 0x2e) {
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
                    i64 = i64 * 10 + (UInt64(next) - 0x30)
                    frac -= 1
                    if i64 != 0 {
                        significandDigit += 1
                    }
                    next = UInt32(stream.next())
                }
                double = Double(i64)
                useDouble = true
            }
            while next >= 0x30 && next <= 0x39 {
                if significandDigit < 17 {
                    double = double * 10 + Double(next - 0x30)
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
        if useDouble {
            double = parse_double(double, frac)
            if minus {
                return JSONDouble(0 - double)
            } else {
                return JSONDouble(double)
            }
        } else if use64bit {
            if minus {
                return JSONInt64(Int64(bitPattern: ~i64 + 1))
            } else {
                return JSONUInt64(i64)
            }
        } else {
            if minus {
                return JSONInt(Int32(bitPattern: ~i + 1))
            } else {
                return JSONUInt(i)
            }
        }
    }

    //  {,  },  ",  :,  ,
    // [7b, 7d, 22, 3a, 2c]
    func parseObject() throws -> JSON {
        let c = consume(char: 0x7b)
        assert(c)
        skip()
        let object = JSONObject([:])
        if consume(char: 0x7d) {
            return object
        }
        while true {
            if stream.peek() != 0x22 {
                throw JSONParseError.objectMissName
            }
            skip()
            let key = try quotedString()
            skip()
            if !consume(char: 0x3a) {
                throw JSONParseError.objectMissColon
            }
            skip()
            let value = try parse()
            skip()
            object.append(key: key, value)
            switch stream.peek() {
            case 0x2c:
                stream.move()
                skip()
            case 0x7d:
                stream.move()
                return object
            default:
                throw JSONParseError.objectMissCommaOrCurlyBracket
            }
        }
    }

    //  [,  ],  ,
    // [5b, 5d, 2c]
    func parseArray() throws -> JSON {
        let c = consume(char: 0x5b)
        assert(c)
        skip()
        let array = JSONArray([])
        if consume(char: 0x5d) {
            return array
        }
        while true {
            let value = try parse()
            array.append(value)
            skip()
            if consume(char: 0x2c) {
                skip()
            } else if consume(char: 0x5d) {
                return array
            } else {
                throw JSONParseError.arrayMissCommaOrSquareBracket
            }
        }
    }

    func quotedString() throws -> String {
        if !consume(char: 0x22) {
            throw JSONParseError.valueInvalid
        }
        let value = try rawString()
        if !consume(char: 0x22) {
            throw JSONParseError.valueInvalid
        }
        return value
    }

    //  \,  ",  b,  f,  n,  r,  t,  /,  u
    // [5c, 22, 62, 66, 6e, 72, 74, 2f, 75]
    func rawString() throws -> String {
        var result: [UInt8] = []
        var next = stream.peek()
        while true {
            switch next {
            case 0x5c:
                next = stream.next()
                if next == 0x75 {
                    let codes = try parseUnicode()
                    result.append(contentsOf: codes)
                } else {
                    let char = try parseChar()
                    result.append(char)
                }
            case 0x22:
                return String(bytes: result, encoding: .utf8) ?? ""
            case 0x00:
                throw JSONParseError.missQuotationMark
            case 0x01..<0x20:
                throw JSONParseError.invalidEncoding
            default:
                result.append(next)
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

    func parseUnicode() throws -> [UInt8] {
        let code = try parseUnicodeValue()
        if code <= 0x7f {
            return [UInt8(truncatingIfNeeded: (code & 0xFF))]
        }
        if code <= 0x7ff {
            return [UInt8(truncatingIfNeeded: (0xc0 | ((code >> 6) & 0xff))),
                    UInt8(truncatingIfNeeded: (0x80 | (code & 0x3F)))]
        }
        if code <= 0xffff {
            return [UInt8(truncatingIfNeeded: (0xE0 | ((code >> 12) & 0xFF))),
                    UInt8(truncatingIfNeeded: (0x80 | ((code >> 6) & 0x3F))),
                    UInt8(truncatingIfNeeded: (0x80 | (code & 0x3F)))]
        }
        if code <= 0x10ffff {
            return [UInt8(truncatingIfNeeded: (0xF0 | ((code >> 18) & 0xFF))),
                    UInt8(truncatingIfNeeded: (0x80 | ((code >> 12) & 0x3F))),
                    UInt8(truncatingIfNeeded: (0x80 | ((code >> 6) & 0x3F))),
                    UInt8(truncatingIfNeeded: (0x80 | (code & 0x3F)))]
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
            switch next { // TODO: Replace range
            case 0x30...0x39: // 0-9
                point -= next - 0x30
            case 0x41...0x46: // A-F
                point -= next - 0x41
            case 0x61...0x66: // a-f
                point -= next - 0x61
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
