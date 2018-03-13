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

open class OverlayComponent: BasicComponent {
    public let primary: BasicComponent
    public let background: BasicComponent?
    public let overlay: BasicComponent?

    public init(primary: BasicComponent, background: BasicComponent?, overlay: BasicComponent? = nil) {
        self.primary = primary
        self.background = background
        self.overlay = overlay
        super.init(framed: false, children: [primary])
    }

    public override func build(in view: UIView) {
        assertMainThread()
        background?.build(in: view)
        primary.build(in: view)
        overlay?.build(in: view)
    }

    override func apply(left: Double, top: Double) {
        primary.apply(left: left, top: top)
        let frame = primary._frame
        if let background = self.background {
            if background.children.isEmpty {
                background._frame = frame
            } else {
                background.layout(width: frame.width, height: frame.height)
            }
        }
        if let overlay = self.overlay {
            if overlay.children.isEmpty {
                overlay._frame = frame
            } else {
                overlay.layout(width: frame.width, height: frame.height)
            }
        }
    }
}
