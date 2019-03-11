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

public protocol BannerViewDataSource: class {
    func numberOfBanner(bannerView: BannerView) -> Int
    func bannerView(_ bannerView: BannerView, configImageView imageView: UIImageView, at index: Int)
}

public protocol BannerViewDelegate: class {
    func bannerView(_ bannerView: BannerView, didSelectViewAt index: Int)
}

public final class BannerView: UIView, UIScrollViewDelegate {
    public private(set) var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()
    public private(set) var pageControl: UIPageControl = {
        let page = UIPageControl(frame: .zero)
        page.isUserInteractionEnabled = false
        return page
    }()
    public private(set) var manualScroll: Bool = false
    public weak var dataSource: BannerViewDataSource? = nil
    public weak var delegate: BannerViewDelegate? = nil
    public var autoPlayTimeInterval: TimeInterval = 3.0 {
        didSet {
            startScroll()
        }
    }
    public var selectedViewIndex: Int {
        get {
            return index
        }
        set(newValue) {
            scroll(to: newValue)
        }
    }

    private var imageViews = [UIImageView]()
    private var count: Int = 0
    private var timer: Timer? = nil
    private var infinite: Bool = false
    private var index: Int = 0

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }

    deinit {
        timer?.invalidate()
        timer = nil
    }

    func initialization() {
        scrollView.frame = bounds
        scrollView.delegate = self
        addSubview(scrollView)
        addSubview(pageControl)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapAction(sender:)))
        scrollView.addGestureRecognizer(tapGesture)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
        let size = pageControl.sizeThatFits(bounds.size)
        Layout(view: pageControl).right().bottom()
            .size(size).apply()
        imageViews.forEachIndexed { view, i in
            view.frame = bounds.setOrigin(x: bounds.width * CGFloat(i), y: 0)
        }
        if infinite {
            scrollView.contentSize = CGSize(width: bounds.width * CGFloat(count + 2), height: bounds.height)
            scrollView.contentOffset = CGPoint(x: bounds.width, y: 0)
        } else {
            scrollView.contentSize = bounds.size
            scrollView.contentOffset = CGPoint.zero
        }
    }

    public func startScroll(stopWhenValid: Bool = true) {
        if !stopWhenValid, let x = timer, x.isValid {
            return
        }
        stopScroll()
        guard autoPlayTimeInterval > 0 && infinite else {
            return
        }
        let t = Timer(timeInterval: autoPlayTimeInterval, target: self,
            selector: #selector(autoplay(timer:)), userInfo: nil, repeats: true)
        RunLoop.main.add(t, forMode: RunLoop.Mode.common)
        timer = t
    }

    public func stopScroll() {
        timer?.invalidate()
//        let x = scrollView.bounds.width * CGFloat(index)
//        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
    }

    public func scroll(to index: Int) {
        guard index > 0 && index < count else {
            return
        }
        let next = index + 1
        if next != self.index {
            let x = scrollView.bounds.width * CGFloat(next)
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        self.index = next
    }

    public func reloadData() {
        stopScroll()
        reloadViews()
        startScroll()
    }

    func reloadViews() {
        imageViews.forEach {
            $0.removeFromSuperview()
        }
        imageViews.removeAll()
        defer {
            pageControl.isHidden = count < 1
        }
        guard let delegate = self.dataSource else {
            return
        }
        count = delegate.numberOfBanner(bannerView: self)
        infinite = count > 1
        let size = frame.size
        guard infinite else {
            let imageView0 = UIImageView(frame: CGRect(origin: .zero, size: size))
            delegate.bannerView(self, configImageView: imageView0, at: 0)
            scrollView.addSubview(imageView0)
            imageViews.append(imageView0)
            scrollView.contentSize = bounds.size
            scrollView.contentOffset = CGPoint.zero
            return
        }
        // First image view,  data index = count - 1
        let imageView1 = UIImageView(frame: CGRect(origin: .zero, size: size))
        delegate.bannerView(self, configImageView: imageView1, at: count - 1)
        scrollView.addSubview(imageView1)
        imageViews.append(imageView1)
        for i in 0..<count {
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: size.width * CGFloat(i + 1), y: 0), size: size))
            delegate.bannerView(self, configImageView: imageView, at: i)
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }
        // Last image view, data index = 0
        let imageView2 = UIImageView(frame: CGRect(origin: CGPoint(x: size.width * CGFloat(count + 1), y: 0), size: size))
        delegate.bannerView(self, configImageView: imageView2, at: 0)
        scrollView.addSubview(imageView2)
        imageViews.append(imageView2)

        scrollView.contentSize = CGSize(width: bounds.width * CGFloat(count + 2), height: bounds.height)
        scrollView.contentOffset = CGPoint(x: bounds.width, y: 0)
        index = 1
    }

    @objc func autoplay(timer: Timer) {
        index += 1
        let x = scrollView.bounds.width * CGFloat(index)
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }

    @objc func scrollViewTapAction(sender: AnyObject) {
        delegate?.bannerView(self, didSelectViewAt: index - 1)
    }

    // UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !manualScroll, infinite else {
            return
        }
        let width = scrollView.bounds.width
        guard width > 0 else {
            return
        }
        let x = scrollView.contentOffset.x
        if x >= (width * CGFloat(count) + width) {
            scrollView.contentOffset = CGPoint(x: width, y: 0)
        } else if x <= 0 {
            scrollView.contentOffset = CGPoint(x: width * CGFloat(count), y: 0)
        }
        let next = Int(scrollView.contentOffset.x / width + 0.5)
        index = next
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        manualScroll = false
        startScroll(stopWhenValid: false)
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopScroll()
        manualScroll = true
    }
}
