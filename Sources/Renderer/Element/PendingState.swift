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

// _ASPendingState
final public class PendingState {
    private var _backgroundColor: CGColor?? = nil
    public var backgroundColor: CGColor? {
        get {
            return _backgroundColor ?? nil
        }
        set {
            if let value = _backgroundColor, value == newValue {
                return
            }
            _backgroundColor = newValue
            dirty = true
        }
    }

    public private(set) var dirty = false
    private var needsLayout = false

    public init() {
        // Do nothing
    }

    // applyToView:withSpecialPropertiesHandling:
    // direct: set properties to the layer instead of the view
    public func apply(to view: UIView?, direct: Bool) {
        guard let view = view else {
            return
        }
        let layer: CALayer = view.layer
        if let backgroundColor = _backgroundColor {
            if direct {
                layer.backgroundColor = backgroundColor
            } else {
                view.backgroundColor = backgroundColor.map(UIColor.init(cgColor:))
            }
        }
        if needsLayout {
            view.setNeedsLayout()
        }
    }

    public func clear() {
        _backgroundColor = nil
        dirty = false
        needsLayout = false
    }

    public func setNeedsLayout() {
        needsLayout = true
    }

    // __shouldSetNeedsDisplay
    private func shouldSetNeedsDisplay(layer: CALayer) -> Bool {
        return false
    }
}
