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
    @inline(__always)
    func any() -> Bool {
        anySatisfy { _ in true }
    }

    @inlinable
    func anySatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        for item in self where (try predicate(item)) == true {
            return false
        }
        return true
    }

    @inlinable
    func associate<K, V>(_ transform: (Element) throws -> (K, V)) rethrows -> [K: V] where K: Hashable {
        var map: [K: V] = [:]
        for item in self {
            let (k, v) = try transform(item)
            map[k] = v
        }
        return map
    }

    @inlinable
    func associate<K>(by keySelector: (Element) throws -> K) rethrows -> [K: Element] where K: Hashable {
        var map: [K: Element] = [:]
        for item in self {
            let key = try keySelector(item)
            map[key] = item
        }
        return map
    }

    @inlinable
    func associate<K, T>(by keySelector: (Element) throws -> K, _ transform: (Element) throws -> T) rethrows
            -> [K: T] where K: Hashable {
        var map: [K: T] = [:]
        for item in self {
            let key = try keySelector(item)
            map[key] = try transform(item)
        }
        return map
    }

    @inlinable
    func associate<K, V>(to map: inout [K: V], _ transform: (Element) throws -> (K, V)) rethrows
            -> [K: V] where K: Hashable {
        for item in self {
            let (k, v) = try transform(item)
            map[k] = v
        }
        return map
    }

    @inlinable
    func associate<K>(to map: inout [K: Element], by keySelector: (Element) throws -> K) rethrows
            -> [K: Element] where K: Hashable {
        for item in self {
            let key = try keySelector(item)
            map[key] = item
        }
        return map
    }

    @inlinable
    func associate<K, T>(to map: inout [K: T], by keySelector: (Element) throws -> K,
                         _ transform: (Element) throws -> T) rethrows -> [K: T] where K: Hashable {
        for item in self {
            let key = try keySelector(item)
            map[key] = try transform(item)
        }
        return map
    }

    @inline(__always)
    func filterAs<T>() -> [T] {
        compactMap { $0 as? T }
    }

    @inline(__always)
    func filter<T>(as: T.Type) -> [T] {
        compactMap { $0 as? T }
    }

    @inlinable
    func filterNot(_ isNotIncluded: (Element) throws -> Bool) rethrows -> [Element] {
        try filter { e in
            !(try isNotIncluded(e))
        }
    }

    @inlinable
    func group<K>(by keySelector: (Element) throws -> K) rethrows -> [K: List<Element>] where K: Hashable {
        var map: [K: List<Element>] = [:]
        for item in self {
            let key = try keySelector(item)
            if let list = map[key] {
                list.append(item)
            } else {
                map[key] = List([item])
            }
        }
        return map
    }

    func group<K, T>(by keySelector: (Element) throws -> K, _ transform: (Element) throws -> T) rethrows
            -> [K: List<T>] where K: Hashable {
        var map: [K: List<T>] = [:]
        for item in self {
            let key = try keySelector(item)
            let value = try transform(item)
            if let list = map[key] {
                list.append(value)
            } else {
                map[key] = List([value])
            }
        }
        return map
    }
}
