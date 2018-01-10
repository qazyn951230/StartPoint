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
import CoreGraphics

open class ElementState {
    public private(set) var dirty = false

    public required init() {
        // Do nothing
    }

    public var background: UIColor? = nil {
        willSet {
            dirty = dirty || newValue != background
        }
    }
}

open class Element<View: UIView, State: ElementState>: Equatable {
    private var _view: View? = nil
    public var view: View {
        if _view == nil {
            loadView()
        }
        return _view ?? View(frame: .zero)
    }

    public let layout = FlexLayout()
    public private(set) var pendingState: State? = nil
    public private(set) var children: [Element<UIView, ElementState>] = []

    public var loaded: Bool {
        return _view != nil
    }

    public var background: UIColor? {
        get {
            return _view?.backgroundColor
        }
        set {
            let state: State = pendingState ?? State()
            state.background = newValue
        }
    }

    @inline(__always)
    public func couldApplyState() -> Bool {
        let loaded = self.loaded
        if mainThread() {
            return loaded
        } else {
//            if loaded && !(pendingState?.dirty ?? false) {
//
//            }
            return false
        }
    }

    public func loadView() {
        let t = createView()
        for child in children {
            t.addSubview(child.view)
        }
        layout.bind(view: t)
        _view = t
    }

    open func layout(width: CGFloat, height: CGFloat) {
        layout.layout(width: width, height: height)
    }

    public func addSubelement(_ element: Element<UIView, ElementState>) {
        children.append(element)
        layout.append(element.layout)
    }

    public func removeSubelement(_ element: Element<UIView, ElementState>) {
        if let index = children.index(of: element) {
            children.remove(at: index)
            layout.remove(element.layout)
        }
    }

    open func createView() -> View {
        return View(frame: .zero)
    }

    // _recursivelyTriggerDisplayAndBlock
    fileprivate func triggerDisplay(synchronous: Bool) {
        Assert.mainThread()
    }

    // Equatable
    public static func ==(lhs: Element<View, State>, rhs: Element<View, State>) -> Bool {
        return lhs === rhs
    }
}

struct Renderer {
    static let rendererQueue: RunLoopQueue<Element<UIView, ElementState>> = {
        return RunLoopQueue(runLoop: CFRunLoopGetMain(), retain: false) { (item, drained) in
            item?.triggerDisplay(synchronous: false)
        }
    }()
}
