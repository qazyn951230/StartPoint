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

open class AppViewController<View: UIView>: UIViewController, UIGestureRecognizerDelegate, IntentTarget {
    open var backBarItem: UIBarButtonItem? = nil

    public private(set) var rootView: View? = nil
    public private(set) var interactivePopGestureRecognizer: UIGestureRecognizer? = nil

#if DEBUG
    var viewLoaded = false
#endif

    open var shouldLoadBackBarItem: Bool {
        guard let count = navigationController?.viewControllers.count else {
            return false
        }
        return count > 1
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialization()
#if DEBUG
        assertFalse(viewLoaded, "view should not load when initialization")
#endif
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
#if DEBUG
        assertFalse(viewLoaded, "view should not load when initialization")
#endif
    }

    open func initialization() {
        // Do nothing.
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        loadBackBarItem()
    }

    open override func loadView() {
#if DEBUG
        viewLoaded = true
#endif
        rootView = createView()
        view = rootView
    }

    open func viewDidBack() {
        interactivePopGestureRecognizer?.removeTarget(self, action: #selector(interactivePopGestureRecognizer(sender:)))
    }

    @objc open func backBarItemAction(sender: UIBarButtonItem) {
        finish()
        viewDidBack()
    }

    @objc open func interactivePopGestureRecognizer(sender: UIGestureRecognizer) {
        viewDidBack()
    }

    open func loadBackBarItem() {
        guard shouldLoadBackBarItem else {
            return
        }
        backBarItem = createBackBarItem()
        navigationItem.leftBarButtonItem = backBarItem
        if let recognizer = navigationController?.interactivePopGestureRecognizer {
            recognizer.delegate = self
            recognizer.addTarget(self, action: #selector(interactivePopGestureRecognizer(sender:)))
            interactivePopGestureRecognizer = recognizer
        }
    }

    open func createBackBarItem(image: UIImage? = nil) -> UIBarButtonItem {
        let image = image ?? R.image.ic_arrow_back()
        return UIBarButtonItem(image: image, style: .plain, target: self,
            action: #selector(backBarItemAction(sender:)))
    }

    open func createView() -> View {
        return View(frame: .zero)
    }

    open func prepare(for intent: Intent, method: ResolvedMethod) -> UIViewController {
        return self
    }
}

public extension AppViewController where View: UIScrollView {
    public func adjustsViewInsets(_ adjusts: Bool) {
        if #available(iOS 11.0, *) {
            rootView?.contentInsetAdjustmentBehavior = adjusts ? .automatic : .never
        } else {
            automaticallyAdjustsScrollViewInsets = adjusts
        }
    }
}
