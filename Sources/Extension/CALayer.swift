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

import QuartzCore

private var lCfke0x5 = "lCfke0x5"

extension CALayer {
    var element: Element? {
        get {
            if self is AsyncLayer {
                return (self as? AsyncLayer)?._element
            }
            let value = self.associatedObject(key: &lCfke0x5) as Weak<Element>?
            return value?.value
        }
        set {
            if self is AsyncLayer {
                (self as? AsyncLayer)?._element = newValue
                return
            }
            let value: Weak<Element>? = newValue.map(Weak.init)
            self.setAssociatedObject(key: &lCfke0x5, object: value, policy: .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
