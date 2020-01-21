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

extension Element {
    // MARK: - Observing Element-Related Changes
    public func viewLoaded(_ method: @escaping (Element<View>) -> Void) {
        if Runner.isMain(), loaded {
            method(self)
        } else {
            actions.loadAction(self, method)
        }
    }

//    public func bind<T>(target: T, _ method: @escaping (T) -> Void) where T: AnyObject {
//        if Runner.isMain(), loaded {
//            method(target)
//        } else {
//            actions.loadAction(target, method)
//        }
//    }

//    public func bind<T>(target: T, source method: @escaping (T) -> (Element<View>) -> Void) where T: AnyObject {
//        if Runner.isMain(), loaded {
//            method(target)(self)
//        } else {
//            let action: ElementAction.Action = { [weak target, weak self] in
//                if let _target = target, let this = self {
//                    method(_target)(this)
//                }
//            }
//            actions.load.append(action)
//        }
//    }

    // MARK: - Register the Tap Callback
    public func tap<T>(target: T, source method: @escaping (T) -> (Element<View>) -> Void) where T: AnyObject {
        let action: ElementAction.Action = { [weak target, weak self] in
            if let _target = target, let this = self {
                method(_target)(this)
            }
        }
        actions.tap = action
        interactive = true
    }
}
#endif // #if os(iOS)
