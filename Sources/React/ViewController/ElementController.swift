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

open class ElementController<View: UIView, E: Element<View>>: UIViewController, UIGestureRecognizerDelegate {
    open var backBarItem: UIBarButtonItem?

    public private(set) var rootElement: E?
    public private(set) var rootView: View?
    public private(set) var interactivePopGestureRecognizer: UIGestureRecognizer?

    var size = Size.zero

    open func initialization() {
        if let count = navigationController?.viewControllers.count, count > 1 {
            backBarItem = createBackBarItem()
            navigationItem.leftBarButtonItem = backBarItem
            if let recognizer = navigationController?.interactivePopGestureRecognizer {
                recognizer.delegate = self
                recognizer.addTarget(self, action: #selector(interactivePopGestureRecognizer(sender:)))
                interactivePopGestureRecognizer = recognizer
            }
        }
    }

    open override func loadView() {
        super.loadView()
        size = Size(cgSize: view.frame.size)
        rootElement = createElement()
        rootElement?.layout(width: size.width, height: size.height)
        rootView = rootElement?.buildView()
        view = rootView
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }

    open func viewDidBack() {
        interactivePopGestureRecognizer?.removeTarget(self,
            action: #selector(interactivePopGestureRecognizer(sender:)))
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        rootElement?.layout(width: size.width, height: size.height)
    }

    @objc open func backBarItemAction(sender: UIBarButtonItem) {
        if presentingViewController != nil {
            dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
        viewDidBack()
    }

    @objc open func interactivePopGestureRecognizer(sender: UIGestureRecognizer) {
        viewDidBack()
    }

    open func createBackBarItem(image: UIImage? = nil) -> UIBarButtonItem {
        let image = image ?? R.image.ic_arrow_back()
        return UIBarButtonItem(image: image, style: .plain, target: self,
            action: #selector(backBarItemAction(sender:)))
    }

    open func createElement() -> E {
        fatalError("Subclass mast override this function.")
    }
}

// FIXME: AdjustsScrollViewInsets in Element
//public extension ElementController where View: UIScrollView {
//    public func adjustsViewInsets(_ adjusts: Bool) {
//        if #available(iOS 11.0, *) {
//            rootView?.contentInsetAdjustmentBehavior = adjusts ? .automatic : .never
//        } else {
//            automaticallyAdjustsScrollViewInsets = adjusts
//        }
//    }
//}
