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

open class FlexView: UIView {
    public let root: BasicElement = BasicElement()

    open override var bounds: CGRect {
        didSet {
            // TODO: Is it needed?
            if bounds.size != oldValue.size {
                root.layout.size(bounds.size)
                // TODO: assertMainThread()
                setNeedsLayout()
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }

    open func initialization() {
        // Do nothing.
    }

    open func layout() {
        // TODO: If bounds == CGSize.zero?
        root.layout(width: bounds.width, height: bounds.height)
        root.build(in: self)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        root.layout(width: size.width, height: size.height)
        return root._frame.cgSize
    }
}
#endif // #if os(iOS)
