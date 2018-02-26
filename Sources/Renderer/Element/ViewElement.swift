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

open class ViewElement<View: UIView>: Element {
    private var _view: View? = nil
    private var _layer: CALayer? = nil

    private var creator: (() -> View)? = nil
    override var rawView: UIView? {
        return _view
    }
    override var rawLayer: CALayer? {
        return _layer
    }
    override var loadedView: UIView? {
        return view
    }
    override var loadedLayer: CALayer? {
        return layer
    }
    public var view: View? {
        lock.lock()
        if let v = _view {
            return v
        }
        guard shouldLoad else {
            return nil
        }
        assertMainThread()
        loadView()
        applyPendingState()
        lock.unlocking {
            addAllSubelement()
        }
        if let v = _view {
            return v
        }
        lock.unlock()
        fatalError("load view should create a view")
    }

    public var layer: CALayer? {
        lock.lock()
        defer {
            lock.unlock()
        }
        return _layer
    }

    // MARK: - Loading
    override var _loaded: Bool {
        return _view != nil
    }

    // _locked_loadViewOrLayer
    private func loadView() {
        _view = _loadView()
        _layer = _view?.layer
    }

    // _locked_viewToLoad
    private func _loadView() -> View {
        let view: View
        if let fn = creator {
            view = fn()
        } else {
            view = createView()
        }
        return view
    }

    open func createView() -> View {
        return View(frame: .zero)
    }

    // MARK: - Pending State
    // _locked_applyPendingStateToViewOrLayer
    override func applyPendingState() {
        super.applyPendingState()
        lock.lock()
        defer {
            lock.unlock()
        }
        let direct = !flags.contains(ElementOption.synchronous)
        _pendingState?.apply(to: _view, direct: direct)
        if hierarchyState._rangeManaged {
            _pendingState = nil
        } else {
            _pendingState?.clear()
        }
    }

    // MARK: - View hierarchy
}
