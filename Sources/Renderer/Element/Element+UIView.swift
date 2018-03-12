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
import QuartzCore

extension Element {
    internal var _backgroundColor: CGColor? {
        if _loaded {
            return rawLayer?.backgroundColor
        }
        // NOTICE: ASDisplayNodeGetPendingState vs _pendingViewState
        return _pendingState?.backgroundColor ?? nil
    }

    public var backgroundColor: UIColor? {
        get {
            return lock.locking {
                assertThreadAffinity(element: self)
                let color = _backgroundColor
                return color.map(UIColor.init(cgColor:))
            }
        }
        set {
            lock.locking {
                if couldApplyState() {
                    if flags.value.contains(.synchronous) {
                        rawView?.backgroundColor = newValue
                    } else {
                        rawLayer?.backgroundColor = newValue?.cgColor
                    }
                } else {
                    pendingState.backgroundColor = newValue?.cgColor
                }
            }
        }
    }

    public func setNeedsLayout() {
        var apply = false
        var loaded = false
        var view: UIView? = nil
        var layer: CALayer? = nil
        lock.lock()
        apply = couldApplyState()
        loaded = self.loaded
        view = rawView
        layer = rawLayer
        if !apply && loaded {
            // The element is loaded but we're not on main.
            pendingState.setNeedsLayout()
        }
        if apply {
            // The node is loaded and we're on main.
            invalidateLayout()
            if view != nil {
                view?.setNeedsLayout()
            } else {
                layer?.setNeedsLayout()
            }
        } else if !loaded {
            // The element is not loaded and we're not on main.
            invalidateLayout()
        }
    }
}
