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
import WebKit
import RxSwift
import RxCocoa

open class StartWebController: StartViewController<WKWebView> {
    public static let intentUrlKey = "StartWebControllerIntentUrlKey"

    public let bag = DisposeBag()
    public var initUrl: URL?
    public private(set) var closeBarItem: UIBarButtonItem?
    open var trackWebViewTitle: Bool = true

    open override func createView() -> WKWebView {
        let config = WKWebViewConfiguration()
        return WKWebView(frame: CGRect.zero, configuration: config)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        if let webView = rootView {
            webView.backgroundColor = UIColor.white
            titleDriver(webView: webView)
                .drive(onNext: { [weak self] value in
                    self?.navigationItem.title = value
                }).disposed(by: bag)
            if trackWebViewTitle {
                goBackDriver(webView: webView)
                    .drive(onNext: { [weak self] value in
                        self?.setBackBarButton(canGoBack: value)
                    }).disposed(by: bag)
            }
            if let url = initUrl {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }

    open override func prepare(for intent: Intent, method: ResolvedMethod) -> UIViewController {
        if let text = intent.extra(key: StartWebController.intentUrlKey, of: String.self),
           let url = URL(string: text) {
            initUrl = url
        }
        hidesBottomBarWhenPushed = true
        loadRefreshBarItem()
        closeBarItem = UIBarButtonItem(image: R.image.ic_close(), style: .plain,
                                       target: self, action: #selector(closeBarAction(button:)))
        if method.isPush {
            return self
        }
        return UINavigationController(rootViewController: self)
    }

    // MARK: Action
    open override func backBarItemAction(sender: UIBarButtonItem) {
        if let webView = rootView, webView.canGoBack {
            webView.goBack()
        } else {
            super.backBarItemAction(sender: sender)
        }
    }

    @objc open func closeBarAction(button: UIBarButtonItem) {
        finish()
    }

    @objc open func refreshBarAction(button: UIBarButtonItem) {
        rootView?.reload()
    }

    // MARK: Function
    open func titleDriver(webView: WKWebView) -> Driver<String?> {
        return webView.rx.observeWeakly(String.self, #keyPath(WKWebView.title))
            .asDriver(onErrorJustReturn: nil)
    }

    open func goBackDriver(webView: WKWebView) -> Driver<Bool> {
        return webView.rx.observeWeakly(Bool.self, #keyPath(WKWebView.canGoBack))
            .asDriver(onErrorJustReturn: nil)
            .compactMap(Function.maybe)
            .distinctUntilChanged()
    }

    open func setBackBarButton(canGoBack: Bool) {
        var array: [UIBarButtonItem] = []
        array.append(nil: backBarItem)
        if canGoBack {
            array.append(nil: closeBarItem)
        }
        if array.isNotEmpty {
            navigationItem.setLeftBarButtonItems(array, animated: true)
        } else {
            navigationItem.setLeftBarButtonItems(nil, animated: true)
        }
    }

    open func loadRefreshBarItem() {
        let refreshBarItem = UIBarButtonItem(image: R.image.ic_refresh(), style: .plain,
            target: self, action: #selector(refreshBarAction(button:)))
        navigationItem.rightBarButtonItem = refreshBarItem
    }

    open class func intent(url: String) -> Intent {
        let intent = Intent(target: self)
        intent.add(extra: url, key: intentUrlKey)
        return intent
    }

    open class func createAsRoot(url: String?) -> Self {
        let controller = create()
        controller.initUrl = url.flatMap(URL.init(string:))
        let close = R.image.ic_arrow_back()
        controller.closeBarItem = UIBarButtonItem(image: close, style: .plain, target: controller,
            action: #selector(backBarItemAction(sender:)))
        controller.loadRefreshBarItem()
        return controller
    }
}