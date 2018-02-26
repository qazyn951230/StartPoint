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

public typealias ViewComponent = Component<UIView, ComponentState>

open class Component<View: UIView, State: ComponentState>: BasicComponent<State> {
    public internal(set) var view: View?
    public internal(set) var creator: (() -> View)?

    public convenience init() {
        self.init {
            View.init(frame: .zero)
        }
    }

    public init(creator: @escaping () -> View) {
        self.creator = creator
        super.init(framed: true)
    }

    public override func apply(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        view?.frame = CGRect(x: x, y: y, width: width, height: height)
    }

    @discardableResult
    open func buildView(in view: UIView?) -> View {
        assertMainThread()
        let this = _buildView()
        view?.addSubview(this)
        subComponents?.forEach {
            $0.build(in: this)
        }
        return this
    }

    override func build(in view: UIView) {
        assertMainThread()
        let this = _buildView()
        view.addSubview(this)
        subComponents?.forEach {
            $0.build(in: this)
        }
    }

    func _buildView() -> View {
        let this = creator?() ?? View.init(frame: .zero)
        self.view = this
        _pendingState?.apply(view: this)
        return this
    }
}

public extension Component {
    @discardableResult
    public func backgroundColor(_ value: UIColor?) -> Self {
        if mainThread() {
            view?.backgroundColor = value
        } else {
            pendingState.backgroundColor = value
        }
        return self
    }

    @discardableResult
    public func backgroundColor(hex: UInt32) -> Self {
        let value = UIColor.hex(hex)
        if mainThread() {
            view?.backgroundColor = value
        } else {
            pendingState.backgroundColor = value
        }
        return self
    }
}
