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
import QuartzCore

open class LayerComponent<T: CALayer, State: ComponentState>: BasicComponent<State> {
    public internal(set) var layer: T

    public init(layer: T) {
        self.layer = layer
        super.init(framed: true)
    }

    public convenience init() {
        self.init(layer: T.init())
    }

    public override func apply(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        layer.frame = CGRect(x: x, y: y, width: width, height: height)
    }

    override func build(in view: UIView) {
        let this = T.init()
        view.layer.addSublayer(this)
        super.build(in: view)
    }
}

public extension LayerComponent {
    @discardableResult
    public func backgroundColor(_ value: CGColor?) -> Self {
        layer.backgroundColor = value
        return self
    }

    @discardableResult
    public func backgroundColor(_ value: UIColor?) -> Self {
        layer.backgroundColor = value?.cgColor
        return self
    }

    public func backgroundColor(hex: UInt32) -> Self {
#if os(iOS)
        layer.backgroundColor = UIColor.hex(hex).cgColor
#else
        layer.backgroundColor = CGColor.hex(hex)
#endif
        return self
    }
}
