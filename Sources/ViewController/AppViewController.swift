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

open class AppViewController<View:UIView>: UIViewController, UIGestureRecognizerDelegate {
    open var backBarItem: UIBarButtonItem? = nil

    public private(set) var basicView: View? = nil
    public private(set) var interactivePopGestureRecognizer: UIGestureRecognizer? = nil

    open override func loadView() {
        basicView = createView()
        view = basicView
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }

    open func viewDidBack() {
        interactivePopGestureRecognizer?.removeTarget(self, action: #selector(interactivePopGestureRecognizer(sender:)))
    }

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

    @objc open func backBarItemAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        viewDidBack()
    }

    @objc open func interactivePopGestureRecognizer(sender: UIGestureRecognizer) {
        viewDidBack()
    }

    open func createBackBarItem(image: UIImage? = nil) -> UIBarButtonItem {
        let image = image ?? UIImage(named: "ic_arrow_back", in: PackageInfo.bundle, compatibleWith: nil)
        return UIBarButtonItem(image: image, style: .plain, target: self,
            action: #selector(backBarItemAction(sender:)))
    }

    open func createView() -> View {
        return View(frame: .zero)
    }
}
