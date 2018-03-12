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

public final class ComponentView: UIView, ComponentContainer {
    public weak var component: BasicComponent? = nil

    public override class var layerClass: AnyClass {
        return ComponentLayer.self
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let object = component else {
            return super.sizeThatFits(size)
        }
        let w = Double(size.width)
        let h = Double(size.height)
        object.layout(width: w, height: h)
        return object.frame.size
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let object = component, object.overrideTouches else {
            super.touchesBegan(touches, with: event)
            return
        }
        object.touchesBegan(touches, with: event)
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let object = component, object.overrideTouches else {
            super.touchesMoved(touches, with: event)
            return
        }
        object.touchesMoved(touches, with: event)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let object = component, object.overrideTouches else {
            super.touchesEnded(touches, with: event)
            return
        }
        object.touchesEnded(touches, with: event)
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let object = component, object.overrideTouches else {
            super.touchesCancelled(touches, with: event)
            return
        }
        object.touchesCancelled(touches, with: event)
    }
}
