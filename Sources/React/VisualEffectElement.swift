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

import UIKit

open class VisualEffectElement: Element<UIVisualEffectView> {
    public init(effect: UIVisualEffect, children: [BasicElement] = []) {
        super.init(children: children)
        creator = {
            UIVisualEffectView(effect: effect)
        }
    }

    open override func buildChildren() {
        if let view = self.view {
            super.buildChildren(in: view.contentView)
        }
    }

    @discardableResult
    public override func cornerRadius(_ value: CGFloat) -> VisualEffectElement {
        if Runner.isMain(), let view = view {
            view.layer.cornerRadius = value
            view.layer.masksToBounds = true
        } else {
            let state = pendingState
            state.cornerRadius = value
            state.clips = true
            registerPendingState()
        }
        return self
    }
}
