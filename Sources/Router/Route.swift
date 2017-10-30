// MIT License
//
// Copyright (c) 2017 qazyn951230 qazyn951230@gmail.com
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

class Route<T> {
    let path: String
    let domain: Bool
    let placeholder: Bool
//    let wildcard: Bool
    weak var parent: Route<T>? = nil
    // TODO: nil
    var children: [String: Route<T>] = [:]
    var value: T?

    private init(path: String, domain: Bool = false, placeholder: Bool?, value: T?) {
        self.path = path
        self.domain = domain
        self.placeholder = placeholder ?? path.hasPrefix(":")
        self.value = value
    }

    convenience init(path: String) {
        self.init(path: path, domain: false, placeholder: nil, value: nil)
    }

    func append(_ route: Route<T>) {
        if route.path.isEmpty {
            return
        }
        if let child = children[route.path] {
            for (_, item) in route.children {
                item.parent = child
                child.append(item)
            }
        } else {
            children[route.path] = route
            route.parent = self
        }
    }

    @discardableResult
    func append(path: String, value: T) -> Route<T> {
        let route = Route.create(path, value: value)
        append(route)
        return route
    }

    func use(namespace: String) -> Route<T> {
        let route: Route<T> = Route(path: namespace)
        append(route)
        return route
    }

    func match(path: String) -> Bool {
        return false
//        let paths = path.split(separator: "/")
//        var next: Route<T>? = self
//        for item in paths {
//            if let route = next {
//                if route.placeholder {
//                    if route.children.count == 1 {
//                        (_, next) = route.children.first
//                    } else {
//                        break
//                    }
//                } else {
//                    next = route.children[item]
//                }
//            } else {
//                break
//            }
//        }
//        if let next = next {
//            return next.children.count < 1
//        } else {
//            return false
//        }
    }

    subscript(path: String) -> Route<T>? {
        if path.isEmpty {
            return nil
        }
        if let child = children[path] {
            return child
        }
        let paths = path.split(separator: "/").map(String.init)
        var current: Route<T>? = self
        var result: Route<T>? = nil
        for p in paths {
            result = current?.children[p]
            if result == nil {
                break
            }
            current = result
        }
        return result
    }

    static func root(domain: String?) -> Route<T> {
        let placeholder = domain == nil
        return Route(path: domain ?? "", domain: true, placeholder: placeholder, value: nil)
    }

    static func create(_ path: String, value: T) -> Route<T> {
        let array: [Route<T>] = path.split(separator: "/")
            .map(String.init)
            .map(Route<T>.init)
        if let first = array.first {
            let start = array.index(after: array.startIndex)
            let end = array.endIndex
            let last = array[start..<end].reduce(first) { (result: Route<T>, next: Route<T>) -> Route<T> in
                result.children[next.path] = next
                next.parent = result
                return next
            }
            last.value = value
            return first
        }
        return Route(path: path, placeholder: nil, value: value)
    }
}
