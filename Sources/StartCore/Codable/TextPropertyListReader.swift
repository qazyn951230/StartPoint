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

import CoreFoundation

// BNF Syntax:
// WHITESPACE ::= 0x20 | 0x0a | 0x0d
// COMMENT ::= //.+ | /\*[^(\*/)]*\*/
// CHAR :: = [A-Za-z]
// DIGIT :: = [1-9]
// STRING ::= [A-Za-z](CHAR|DIGIT)* | "\"" UNICODE_STRING "\""
// NUMBER ::= DIGIT+
// VALUE ::= STRING | NUMBER | ARRAY | DICTIONARY
// DICTIONARY ::=  "{" DICTIONARY_KEY_VALUE* "}"
// DICTIONARY_KEY_VALUE ::= STRING "=" VALUE ";"
// ARRAY ::= "(" ARRAY_VALUE* ")"
// ARRAY_VALUE ::= VALUE ","
//final class TextPropertyListReader: PropertyListReader {
//    let stream: UnicodeStream
//
//    init(stream: UnicodeStream) {
//        self.stream = stream
//        super.init()
//    }
//
//    override func read() {
//
//    }
//
//
//    private func parse() throws -> PropertyList {
//        guard skip() else {
//            return PropertyList.null
//        }
//        switch stream.peek() {
//        case 0x7b: // "{"
//            return try parseDictionary()
//        default:
//            throw BasicError.invalidData
//        }
//    }
//
//    private func parseDictionary() throws -> PropertyListDictionary {
//        var map: [String: PropertyList] = [:]
//        map[""] = PropertyListString("")
//        return PropertyListDictionary(map)
//    }
//
//    private func parseRawString() throws -> String? {
//        guard skip() else {
//            return nil
//        }
//        let value = stream.peek()
//        if value == 0x22 || value == 0x27 { // "\"", "'"
//            return try parseQuotedString(quote: value)
//        } else if TextPropertyListReader.isUnquotedStringCharacter(value) {
//            return try parseUnquotedString()
//        } else {
//            return nil
//        }
//    }
//
//    private func parseQuotedString(quote: UInt32) throws -> String {
////        var closed = false
////        var scalars: [UInt32] = []
////        var current = stream.peek()
////        while stream.effective {
////            if current == quote {
////                break
////            }
////            if current == 0x22 { // "\""
////                stream.move()
////            }
////        }
//        return ""
//    }
//
//    // "\"" skipped
//    private func peekSlashedChar() -> UInt32? {
//        var current = stream.peek()
//        switch current {
//        case 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37: // [0-7]
//            // three digits maximum to avoid reading \000 followed by 5 as \5 !
//            var number = UInt8(current - 0x30)
//            current = stream.peek(offset: 1)
//            if current >= 0x30 && current <= 0x37 {
//                number = (number << 3) + UInt8(current - 0x30)
//            }
//            current = stream.peek(offset: 2)
//            if current >= 0x30 && current <= 0x37 {
//                number = (number << 3) + UInt8(current - 0x30)
//            }
//            // FIXME: CFStringBuiltInEncodings.nextStepLatin ???
//            let data = Data([number])
//            let _string = data.withUnsafeBytes(TextPropertyListReader.nextStepLatinEncoding)
//            if let string = _string as NSString? as String?, let first = string.unicodeScalars.first?.value {
//                return first
//            } else {
//                return nil
//            }
//        case 0x55: // "U"
//            var i = 0
//            current = stream.next()
//            var number: UInt32 = 0
//            while stream.effective && i < 4,
//                  let hex = TextPropertyListReader.hexadecimalDigit(current)  {
//                number = (number << 4) + hex
//                i += 1
//            }
//            return i == 4 ? number : nil
//        default:
//            return nil
//        }
//    }
//
//    private func parseUnquotedString() throws -> String {
//        return ""
//    }
//
//    private func skip() -> Bool {
//        var current: UInt32 = 0
//        while stream.effective {
//            current = stream.peek()
//            // horizontal tabulation, newline, vertical tabulation, form feed, carriage return
//            // space, line separator, paragraph separator
//            if (current >= 0x09 && current <= 0x0d) ||
//                   current == 0x20 || current == 0x2028 || current == 0x2029 {
//                stream.move()
//                continue
//            }
//            if current == 0x2f { // "/"
//                current = stream.next()
//                if current == 0x2f { // "//"...
//                    current = stream.next()
//                    // move to end of comment line
//                    while stream.effective && !(current == 0x0a || current == 0x0d ||
//                        current == 0x2028 || current == 0x2029) {
//                        current = stream.next()
//                    }
//                } else if current == 0x2a { // "*"
//                    stream.move()
//                    while stream.effective {
//                        current = stream.peek()
//                        if current == 0x2a && stream.peek(offset: 1) == 0x2f {
//                            stream.move(offset: 2)
//                        }
//                    }
//                }
//            }
//        }
//        return stream.effective
//    }
//
//    // (((x) >= 'a' && (x) <= 'z') || ((x) >= 'A' && (x) <= 'Z') || ((x) >= '0' && (x) <= '9') ||
//    // (x) == '_' || (x) == '$' || (x) == '/' || (x) == ':' || (x) == '.' || (x) == '-')
//    private static func isUnquotedStringCharacter(_ value: UInt32) -> Bool {
//        return (value >= 0x61 && value <= 0x7a) || (value >= 0x41 && value <= 0x5a) ||
//            (value >= 0x30 && value <= 0x39) || value == 0x5f || value == 0x24 || value == 0x2f
//            || value == 0x3a || value == 0x2e || value == 0x2d
//    }
//
//    private static func hexadecimalDigit(_ value: UInt32) -> UInt32? {
//        if (value >= 0x61 && value <= 0x66) {
//            return value - 0x61 + 10
//        } else if (value >= 0x41 && value <= 0x46) {
//            return value - 0x41 + 10
//        } else if (value >= 0x30 && value <= 0x39) {
//            return value - 0x30
//        } else {
//            return nil
//        }
//    }
//
//    private static func nextStepLatinEncoding(pointer: UnsafeRawBufferPointer) -> CFString? {
//        guard let pointer = pointer.baseAddress?.assumingMemoryBound(to: Int8.self) else {
//            return nil
//        }
//        return CFStringCreateWithCString(kCFAllocatorDefault, pointer,
//            CFStringBuiltInEncodings.nextStepLatin.rawValue)
//    }
//}
