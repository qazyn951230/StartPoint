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

#if os(iOS)
import UIKit

enum RouteMethod {
    case target(IntentTarget.Type, IntentMethod)
    case intent(() -> Intent)
}

public class Router {
    public let scheme: String
    let root: Route<RouteMethod>

    public init(scheme: String) {
        self.scheme = scheme
        root = Route.root()
    }

    init(root: Route<RouteMethod>) {
        scheme = ""
        self.root = root
    }

    public func register(path: String, target: IntentTarget.Type, method: IntentMethod = .auto) {
        root[path] = RouteMethod.target(target, method)
    }

    public func register(path: String, _ creator: @escaping () -> Intent) {
        root[path] = RouteMethod.intent(creator)
    }

    public func navigation(path: URL, in controller: UIViewController) -> Bool {
        guard let host = path.host.flatMap(root.match(component:)),
              let method = host.match(components: path.pathComponents) else {
            return false
        }
        switch method {
        case .target(let t, let m):
            let i = Intent(target: t, method: m)
            i.start(with: controller)
        case let .intent(f):
            f().start(with: controller)
        }
        return true
    }
}
#endif
