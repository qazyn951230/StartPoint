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

class Route<T> {
    let component: String
    let placeholder: Bool
    var value: T?
    var children: [String: Route<T>] = [:]

    internal init(component: String, value: T?) {
        placeholder = component.hasPrefix(":")
        self.component = component
        self.value = value
    }

    // path => /foo/bar/:id
    func append(components: [String], value: T?) {
        guard let first = components.first, first == "/", components.count > 1 else {
            return
        }
        var current: Route<T> = self
        for component in components.dropFirst() {
            let route = Route<T>(component: component, value: nil)
            if route.placeholder, let holder = placeholderChild() {
                current = holder
            } else if let t = current.children[component] {
                current = t
            } else {
                current.children[component] = route
                current = route
            }
        }
        current.value = value
    }

    func append(_ path: URL, value: T?) {
        append(components: path.pathComponents, value: value)
    }

    func append(path: String, value: T?) {
        if let url = URL(string: path) {
            append(url, value: value)
        }
    }

    func placeholderChild() -> Route<T>? {
        for (_, child) in children {
            if child.placeholder {
                return child
            }
        }
        return nil
    }

    func match(components: [String]) -> T? {
        guard children.count > 0, components.count > 1,
              let first = components.first, first == "/" else {
            return value
        }
        var last: Route<T> = self
        for component in components.dropFirst() {
            if let holder = last.placeholderChild() {
                last = holder
            } else {
                guard let t = last.children[component] else {
                    return nil
                }
                last = t
            }
        }
        return last.value
    }

    func match(_ path: URL) -> T? {
        return match(components: path.pathComponents)
    }

    func match(path: String) -> T? {
        guard let url = URL(string: path) else {
            return nil
        }
        return match(url)
    }

    func match(component: String) -> Route<T>? {
        return children[component]
    }

    subscript(path: String) -> T? {
        get {
            return match(path: path)
        }
        set {
            append(path: path, value: newValue)
        }
    }

    static func root(domain: String? = nil) -> Route<T> {
        return Route(component: domain ?? String.empty, value: nil)
    }
}
