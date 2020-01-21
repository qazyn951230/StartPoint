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

#if os(iOS)
import UIKit

public protocol PagingViewDataSource: class {
    func numberOfView(in pagingView: PagingView) -> Int
    func pagingView(_ pagingView: PagingView, viewAt index: Int) -> UIView
}

public protocol PagingViewDelegate: class {
    func pagingView(_ pagingView: PagingView, manualScrollTo percent: CGFloat)
    func pagingView(_ pagingView: PagingView, willManualScrollAt index: Int)
    func pagingView(_ pagingView: PagingView, didManualScrollAt index: Int)
}

public extension PagingViewDelegate {
    func pagingView(_ pagingView: PagingView, manualScrollTo percent: CGFloat) {
        // Do nothing.
    }

    func pagingView(_ pagingView: PagingView, willManualScrollAt index: Int) {
        // Do nothing.
    }

    func pagingView(_ pagingView: PagingView, didManualScrollAt index: Int) {
        // Do nothing.
    }
}

public class PagingView: UIView, UIScrollViewDelegate {
    public weak var dataSource: PagingViewDataSource? = nil
    public weak var delegate: PagingViewDelegate? = nil

    public var scrollViewInsets: UIEdgeInsets = UIEdgeInsets.zero
    public private(set) var selectedViewIndex: Int = 0
    public private(set) var manualScroll: Bool = false

    private var pagingViews: [Int: UIView] = [:]

    public let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = false
        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }

    private func initialization() {
        scrollView.delegate = self
        addSubview(scrollView)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        var insets = scrollViewInsets
        if #available(iOS 11.0, *) {
            insets += safeAreaInsets
        }
        Layout(view: scrollView).left(float: insets.left).top(float: insets.top)
            .right(float: insets.right).bottom(float: insets.bottom)
            .apply()
        for (index, view) in pagingViews {
            view.frame = CGRect(origin: CGPoint(x: scrollView.bounds.width * CGFloat(index), y: 0),
                                size: scrollView.bounds.size)
        }
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * CGFloat(pagingViews.count),
                                        height: scrollView.bounds.height)
    }

    private func recalculateIndex() {
        selectedViewIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }

    public func reloadData() {
        scrollView.subviews.forEach {
            $0.removeFromSuperview()
        }
        guard let source = dataSource else {
            return
        }
        let count = source.numberOfView(in: self)
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * CGFloat(count), height: scrollView.bounds.height)
        reloadView(index: 0)
    }

    public func reloadView(index: Int? = nil) {
        let index = index ?? 0
        guard let source = dataSource else {
            return
        }
        let count = source.numberOfView(in: self)
        reloadView(index: index - 1, source: source, count: count)
        reloadView(index: index, source: source, count: count)
        reloadView(index: index + 1, source: source, count: count)
    }

    private func reloadView(index: Int, source: PagingViewDataSource, count: Int) {
        guard index > -1 && index < count, pagingViews[index] == nil else {
            return
        }
        let view = source.pagingView(self, viewAt: index)
        // view.frame = CGRect(x: scrollView.bounds.width * CGFloat(index), y: 0, size: scrollView.bounds.size)
        scrollView.addSubview(view)
        pagingViews[index] = view
    }

    public func scroll(toViewAt index: Int, animated: Bool = true) {
        reloadView(index: index)
        let offset = scrollView.bounds.width * CGFloat(index)
        selectedViewIndex = index
        scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: animated)
    }

    // MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard manualScroll else {
            return
        }
        recalculateIndex()
        if let delegate = self.delegate {
            let offset: CGFloat = CGFloat(selectedViewIndex) * scrollView.bounds.width
            var percent: CGFloat = (scrollView.contentOffset.x - offset) / scrollView.bounds.width
            percent = within(percent, min: 0, max: 1)
            delegate.pagingView(self, manualScrollTo: percent)
        }
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        manualScroll = true
        recalculateIndex()
        delegate?.pagingView(self, willManualScrollAt: selectedViewIndex)
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            scrollViewDidEndDecelerating(scrollView)
        }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if manualScroll {
            recalculateIndex()
            delegate?.pagingView(self, didManualScrollAt: selectedViewIndex)
        }
        reloadView(index: selectedViewIndex)
        manualScroll = false
    }
}
#endif // #if os(iOS)
