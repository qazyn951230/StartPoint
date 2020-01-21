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

import Foundation

public extension String {
    static let empty: String = ""

    @inlinable
    func chunked(size: Int) -> [Substring] {
        if isEmpty || size < 1 {
            return []
        }
        var result: [Substring] = []
        var start = startIndex
        // index(endIndex, offsetBy: 1) will cause a fatal error
        var end = index(start, offsetBy: size, limitedBy: endIndex)
        while let _end = end, _end <= endIndex {
            let seq: Substring = self[start..<_end]
            result.append(seq)
            start = _end
            end = index(start, offsetBy: size, limitedBy: endIndex)
        }
        if start != endIndex {
            let seq: Substring = self[start..<endIndex]
            result.append(seq)
        }
        return result
    }

    func editDistance(other: String, replace: Bool, max: Int = 0) -> Int {
        let from = unicodeScalars.map { $0.value }
        let to = other.unicodeScalars.map { $0.value }
        return from.editDistance(to: to, replace: replace, max: max)
    }

    func split(at index: String.Index) -> (Substring, Substring) {
        if index < startIndex {
            return (Substring(), self[startIndex...])
        }
        if index > endIndex {
            return (self[startIndex...], Substring())
        }
        return (self[..<index], self[index...])
    }

    func split(firstOf element: Character) -> (Substring, Substring) {
        let index = firstIndex(of: element) ?? startIndex
        return split(at: index)
    }

    func split(lastOf element: Character) -> (Substring, Substring) {
        let index = lastIndex(of: element) ?? endIndex
        return split(at: index)
    }

    func string(upTo index: String.Index) -> String {
        String(self[..<index])
    }

    func string(through index: String.Index) -> String {
        String(self[...index])
    }

    func string(from index: String.Index) -> String {
        String(self[index...])
    }

    func remove(prefix: String) -> String {
        if hasPrefix(prefix) {
            return String(self[prefix.endIndex...])
        }
        return self
    }

    func remove(suffix: String) -> String {
        if hasSuffix(suffix) {
            let end = index(endIndex, offsetBy: -suffix.count)
            return String(self[..<end])
        }
        return self
    }

    static func decodeFixedArray<T>(_ value: T, keyPath: PartialKeyPath<T>, count: Int) -> String? {
        guard let offset = MemoryLayout<T>.offset(of: keyPath) else {
            return nil
        }
        return withUnsafePointer(to: value) { (pointer: UnsafePointer<T>) -> String? in
            let raw: UnsafeRawPointer = UnsafeRawPointer(pointer).advanced(by: offset)
            let field: UnsafePointer<UInt8> = raw.assumingMemoryBound(to: UInt8.self)
            if field[count - 1] != 0 {
                let data = Data(bytes: raw, count: count)
                return String(data: data, encoding: .utf8)
            }
            return String(cString: field)
        }
    }
}
