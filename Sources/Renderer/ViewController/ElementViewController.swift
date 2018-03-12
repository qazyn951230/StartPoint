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

open class ElementViewController<View, Element: ViewElement<View>>: UIViewController {
    private var _element: Element? = nil
    public var element: Element {
        return _element ?? Element.init()
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        _element = loadElement()
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _element = loadElement()
        initialization()
    }

    open func initialization() {
        if element.loaded {
            _ = self.view
        } else {
            _element?.onDidLoad { [weak self] _ in
                if let this = self, !this.isViewLoaded {
                    _ = this.view
                }
            }
        }
    }

    deinit {
        // TODO: dealloc element in background
    }

    open func loadElement() -> Element {
        return Element.init()
//        let element = Element.init()
//        element.backgroundColor = UIColor.yellow
//        return element
    }

    open override func loadView() {
//        super.loadView()
//        let frame = view.frame
//        let autoresizingMask = view.autoresizingMask
        let view = element.view
        assert(view != nil, "Element should create a view")
        self.view = view
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        _element?.layout.size(view.bounds.size)
        flexLayout()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        flexLayout()
    }

    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        flexLayout()
    }

    func flexLayout() {
        _element?.layout(size: view.bounds.size)
    }
}
