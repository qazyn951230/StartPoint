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

public extension Sequence {
    func all(predicate: (Element) throws -> Bool) rethrows -> Bool {
        for item in self where (try predicate(item)) == false {
            return false
        }
        return true
    }

    func any(predicate: (Element) throws -> Bool) rethrows -> Bool {
        for item in self where (try predicate(item)) == true {
            return false
        }
        return true
    }

    func associate<K: Hashable, V>(_ transform: (Element) throws -> (K, V)) rethrows -> [K: V] {
        var map: [K: V] = [:]
        for item in self {
            let (k, v) = try transform(item)
            map[k] = v
        }
        return map
    }

    func associate<K: Hashable>(by keySelector: (Element) -> K) -> [K: Element] {
        var map: [K: Element] = [:]
        for item in self {
            let key = keySelector(item)
            map[key] = item
        }
        return map
    }

    func associate<K: Hashable, T>(by keySelector: (Element) -> K,
                                          _ transform: (Element) throws -> T) rethrows -> [K: T] {
        var map: [K: T] = [:]
        for item in self {
            let key = keySelector(item)
            map[key] = try transform(item)
        }
        return map
    }

//    func chunked(size: Int) -> List<List<Element>> {
//
//    }

    func filter<T>(as: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }

    func group<K: Hashable>(by keySelector: (Element) -> K) -> [K: List<Element>] {
        var map: [K: List<Element>] = [:]
        for item in self {
            let key = keySelector(item)
            if let list = map[key] {
                list.append(item)
            } else {
                map[key] = List([item])
            }
        }
        return map
    }

    func group<K: Hashable, T>(by keySelector: (Element) -> K, _ transform: (Element) throws -> T) rethrows
            -> [K: List<T>] {
        var map: [K: List<T>] = [:]
        for item in self {
            let key = keySelector(item)
            let value = try transform(item)
            if let list = map[key] {
                list.append(value)
            } else {
                map[key] = List([value])
            }
        }
        return map
    }

//    func windowed(size: Int, step: Int = 1, partialWindows: Bool = false) {
//
//    }
}
