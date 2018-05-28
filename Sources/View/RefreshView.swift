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
import RxSwift
import RxCocoa

public enum RefreshViewState: Equatable {
    case idle
    case progress(Double) // 0 ... 1
    case triggered
    case disabled

    var fulfill: Bool {
        if case let .progress(value) = self {
            return value ~~ 1
        }
        return false
    }

    public static func ==(lhs: RefreshViewState, rhs: RefreshViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.triggered, .triggered), (.disabled, .disabled):
            return true
        case let (.progress(l), .progress(r)):
            return l ~~ r
        default:
            return false
        }
    }
}

public protocol Refresher: class {
    var state: RefreshViewState { get }
    var content: Element<UIView>? { get }
    var action: ((Refresher) -> Void)? { get }

    func startRefreshing()
    func endRefreshing()
}

public class RefreshView: UIView, Refresher {
    let bag = DisposeBag()
    weak var scrollView: UIScrollView?
    var contentOffset: Driver<CGPoint>?
//    var contentInset: Driver<UIEdgeInsets>?
    var contentSize: Driver<CGSize>?

    var initOffset: CGPoint = CGPoint.zero
    var initInset: UIEdgeInsets = UIEdgeInsets.zero

    public var content: Element<UIView>?
    public var action: ((Refresher) -> Void)?
    public private(set) var state: RefreshViewState = .idle

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }

    func initialization() {
        if frame.width < 1 {
            frame = frame.setWidth(Device.width)
        }
    }

    public func startRefreshing() {
        // Do nothing.
    }

    public func endRefreshing() {
        // Do nothing.
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        guard let content = self.content else {
            return
        }
        content.layout(width: Double(frame.width))
        content.build(in: self)
        let height: CGFloat = content.frame.height
        frame = CGRect(x: frame.minX, y: 0 - height - initInset.top, width: frame.width, height: height)
    }

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard let scroll = newSuperview as? UIScrollView else {
            return
        }
        scroll.alwaysBounceVertical = true
        scrollView = scroll
        addObserver(to: scroll)
        initInset = scroll.contentInset
    }

    func addObserver(to scrollView: UIScrollView) {
        let offset: Driver<CGPoint> = scrollView.rx
            .observe(CGPoint.self, #keyPath(UIScrollView.contentOffset))
            .asDriver(onErrorJustReturn: CGPoint.zero)
            .compactMap(Function.maybe)
        contentOffset = offset
        offset.drive(onNext: nextContentOffset)
            .disposed(by: bag)

//        let inset: Driver<UIEdgeInsets> = scrollView.rx
//            .observe(UIEdgeInsets.self, #keyPath(UIScrollView.contentInset))
//            .asDriver(onErrorJustReturn: UIEdgeInsets.zero)
//            .compactMap(Function.maybe)
//        contentInset = inset
//        inset.drive(onNext: nextContentInset)
//            .disposed(by: bag)

        let size: Driver<CGSize> = scrollView.rx
            .observe(CGSize.self, #keyPath(UIScrollView.contentSize))
            .asDriver(onErrorJustReturn: CGSize.zero)
            .compactMap(Function.maybe)
        contentSize = size
        size.drive(onNext: nextContentSize)
            .disposed(by: bag)
    }

    func nextContentOffset(_ offset: CGPoint) {
        assertMainThread()
        guard !isHidden && state != .disabled, let scroll = scrollView else {
            return
        }
        if state == .triggered {
            var inset = scroll.contentInset
            inset.top = max(-scroll.contentOffset.y, initInset.top)
            inset.top = min(inset.top, frame.height + initInset.top)
            scroll.contentInset = inset
            return
        }
        let currentY = offset.y
        let initY = 0 - initInset.top
        if currentY > initY { // Scroll down, header will never show.
            return
        }
        let height: CGFloat = frame.height > 0 ? frame.height : 1
        let fullY: CGFloat = initY - height
        if currentY <= fullY { // Full show
            state = .progress(1)
        } else {
            if state.fulfill {
                state = .triggered
                let this = self
                if let fn = action {
                    DispatchQueue.main.async {
                        fn(this)
                    }
                }
            } else {
                let percent: CGFloat = (initY - currentY) / height
                state = .progress(Double(percent))
            }
        }
        Log.debug(state)
    }

//    func nextContentInset(_ insets: UIEdgeInsets) {
//        Log.debug(insets)
//        initInset = insets
//        frame = frame.setY(0 - frame.height - initInset.top)
//    }

    func nextContentSize(_ size: CGSize) {
        Log.debug(size)
    }

    // Utilities
    func contentInset(for scrollView: UIScrollView) -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return scrollView.adjustedContentInset
        } else {
            return scrollView.contentInset
        }
    }
}

public class RefreshHeaderView: RefreshView {
    public override func startRefreshing() {

    }

    public override func endRefreshing() {

    }
}

var refreshHeaderKey = "fQRq881K9mZtz92T"
var refreshFooterKey = "IYy9PUFrFJXdwrhI"

extension UIScrollView {
    public var refreshHeader: RefreshView? {
        get {
            return associatedObject(key: &refreshHeaderKey)
        }
        set {
            let old: RefreshView? = associatedObject(key: &refreshHeaderKey)
            old?.removeFromSuperview()
            if let value = newValue {
                self.insertSubview(value, at: 0)
            }
            setAssociatedObject(key: &refreshHeaderKey, object: newValue)
        }
    }

    public var refreshFooter: RefreshView? {
        get {
            return associatedObject(key: &refreshFooterKey)
        }
        set {
            let old: RefreshView? = associatedObject(key: &refreshHeaderKey)
            old?.removeFromSuperview()
            if let value = newValue {
                self.insertSubview(value, at: 0)
            }
            setAssociatedObject(key: &refreshFooterKey, object: newValue)
        }
    }
}
