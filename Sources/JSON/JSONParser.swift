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
    var error = false

    public func parser(json: String) {
        var iterator = json.makeIterator()
        var next: Character? = iterator.next()
        while next != nil {
            guard let char = next else {
                return
            }
            switch char {
            case "n":
                parserNull(in: &iterator)
            case "t":
                parserTrue(in: &iterator)
            case "f":
                parserFalse(in: &iterator)
            case "\"":
                break
            case "{":
                break
            case "[":
                break
            default:
                break
            }
            next = iterator.next()
        }
    }

    func parserNull(in iterator: inout String.Iterator) {
        consume(in: &iterator, as: "u")
        consume(in: &iterator, as: "l")
        consume(in: &iterator, as: "l")
    }

    func parserTrue(in iterator: inout String.Iterator) {
        consume(in: &iterator, as: "r")
        consume(in: &iterator, as: "u")
        consume(in: &iterator, as: "e")
    }

    func parserFalse(in iterator: inout String.Iterator) {
        consume(in: &iterator, as: "a")
        consume(in: &iterator, as: "l")
        consume(in: &iterator, as: "s")
        consume(in: &iterator, as: "e")
    }

    func parserString(in iterator: inout String.Iterator) {
        var result: [Character] = []
        var flag = true
        let q: Character = "\""
        repeat {
            if let char = iterator.next(), char != q {
                result.append(char)
            } else {
                flag = false
            }
        } while flag
    }

    func consume(in iterator: inout String.Iterator, as char: Character) {
        error = iterator.next() == char
    }
}
