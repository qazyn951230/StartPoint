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
import CoreGraphics

open class BasicComponent<State: ComponentState> {
    public internal(set) var subComponents: [BasicComponent]?
    public let layout = FlexLayout()

    let framed: Bool
    var frame: CGRect = CGRect.zero

    var _pendingState: State?
    public var pendingState: State {
        let state = _pendingState ?? State()
        if _pendingState == nil {
            _pendingState = state
        }
        return state
    }

    init(framed: Bool) {
        self.framed = framed
    }

    public func addSubComponent(_ component: BasicComponent) {
        subComponents = subComponents ?? []
        subComponents?.append(component)
        layout.append(component.layout)
    }

    @discardableResult
    public func then(_ method: (BasicComponent) -> Void) -> Self {
        method(self)
        return self
    }

    @discardableResult
    public func layout(_ method: (FlexLayout) -> Void) -> Self {
        method(layout)
        return self
    }

    public func layout(width: Double = .nan, height: Double = .nan) {
        layout.calculate(width: width, height: height, direction: .ltr)
    }

    public func apply() {
        apply(left: 0, top: 0)
    }

    func apply(left: Double, top: Double) {
        var left = left
        var top = top
        if framed {
            apply(x: CGFloat(left + layout.box.position.left), y: CGFloat(top + layout.box.position.top),
                width: CGFloat(layout.box.width), height: CGFloat(layout.box.height))
            left = 0
            top = 0
        } else {
            left += layout.box.position.left
            top += layout.box.position.top
        }
        subComponents?.forEach {
            $0.apply(left: left, top: top)
        }
    }

    public func apply(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        // Do nothing.
    }

    func build(in view: UIView) {
        assertMainThread()
        subComponents?.forEach {
            $0.build(in: view)
        }
    }
}
