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

public enum JSONParseError: Error {
    case valueInvalid
    case invalidEncoding
    case missQuotationMark
    case stringEscapeInvalid
    case stringUnicodeSurrogateInvalid
    case stringUnicodeEscapeInvalidHex
    case objectMissName
    case objectMissColon
    case objectMissCommaOrCurlyBracket
    case arrayMissCommaOrSquareBracket
    case numberMissFraction
    case numberTooBig
    case numberMissExponent

    static func create(status: JSONParseStatus) -> JSONParseError {
        switch status {
        case JSONParseStatus.valueInvalid:
            return JSONParseError.valueInvalid
        case JSONParseStatus.invalidEncoding:
            return JSONParseError.invalidEncoding
        case JSONParseStatus.missQuotationMark:
            return JSONParseError.missQuotationMark
        case JSONParseStatus.stringEscapeInvalid:
            return JSONParseError.stringEscapeInvalid
        case JSONParseStatus.stringUnicodeSurrogateInvalid:
            return JSONParseError.stringUnicodeSurrogateInvalid
        case JSONParseStatus.stringUnicodeEscapeInvalidHex:
            return JSONParseError.stringUnicodeEscapeInvalidHex
        case JSONParseStatus.objectMissName:
            return JSONParseError.objectMissName
        case JSONParseStatus.objectMissColon:
            return JSONParseError.objectMissColon
        case JSONParseStatus.objectMissCommaOrCurlyBracket:
            return JSONParseError.objectMissCommaOrCurlyBracket
        case JSONParseStatus.arrayMissCommaOrSquareBracket:
            return JSONParseError.arrayMissCommaOrSquareBracket
        case JSONParseStatus.numberMissFraction:
            return JSONParseError.numberMissFraction
        case JSONParseStatus.numberTooBig:
            return JSONParseError.numberTooBig
        case JSONParseStatus.numberMissExponent:
            return JSONParseError.numberMissExponent
        case JSONParseStatus.success:
            return JSONParseError.valueInvalid
        @unknown default:
            return JSONParseError.valueInvalid
        }
    }
}
