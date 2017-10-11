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

import UIKit

enum RouteMethod {
    case target(IntentTarget.Type, IntentMethod)
    case intent((Intent) -> Void)
}

public class Router {
    public let scheme: String
    let root: Route<RouteMethod>

    public init(scheme: String) {
        self.scheme = scheme.hasSuffix("://") ? scheme : (scheme + "://")
        root = Route.root(domain: "")
    }

    init(root: Route<RouteMethod>) {
        scheme = ""
        self.root = root
    }

    public func register(path: String, target: IntentTarget.Type, method: IntentMethod = .auto) {
        let info = RouteMethod.target(target, method)
        root.append(path: path, value: info)
    }

    public func register(path: String, handler: @escaping (Intent) -> Void) {
        let info = RouteMethod.intent(handler)
        root.append(path: path, value: info)
    }

    public func use(namespace: String, function: (Router) -> Void) {
        let route: Route<RouteMethod> = Route(path: namespace)
        root.append(route)
        let router = Router(root: route)
        function(router)
    }
}
