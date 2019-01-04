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

public extension String {
    public static let empty: String = ""

    public func split(at index: String.Index) -> (Substring, Substring) {
        if index < startIndex {
            return (Substring(), self[startIndex...])
        }
        if index > endIndex {
            return (self[startIndex...], Substring())
        }
        return (self[..<index], self[index...])
    }

    public func string(upTo index: String.Index) -> String {
        return String(self[..<index])
    }

    public func string(through index: String.Index) -> String {
        return String(self[...index])
    }

    public func string(from index: String.Index) -> String {
        return String(self[index...])
    }

    public func remove(prefix: String) -> String {
        if hasPrefix(prefix) {
            return String(self[prefix.endIndex...])
        }
        return self
    }

    public func remove(suffix: String) -> String {
        if hasSuffix(suffix) {
            let end = index(endIndex, offsetBy: -suffix.count)
            return String(self[..<end])
        }
        return self
    }
}
