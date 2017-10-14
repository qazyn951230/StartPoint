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

public protocol BannerViewDelegate: class {
    func numberOfBanner(bannerView: BannerView) -> Int
    func bannerView(_ bannerView: BannerView, configImageView imageView: UIImageView, at index: Int)
}

public final class BannerView: UIView {
    public private(set) var scrollView: UIScrollView = UIScrollView(frame: .zero)
    public private(set) var pageControl: UIPageControl = UIPageControl(frame: .zero)

    var imageViews = [UIImageView]()
    var count: Int = 0
    var timer: Timer? = nil

    public weak var delegate: BannerViewDelegate? = nil
    public var autoPlayTimeInterval: TimeInterval = 3.0

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }

    func initialization() {
        pageControl.isUserInteractionEnabled = false

        addSubview(scrollView)
        addSubview(pageControl)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
        let size = pageControl.sizeThatFits(bounds.size)
        Layout(for: pageControl, container: bounds.size)
            .right().bottom().size(size).apply()
    }

    public func reloadData() {
        reloadViews()
    }

    func reloadViews() {
        imageViews.forEach { $0.removeFromSuperview() }
        imageViews.removeAll()
        defer {
            pageControl.isHidden = count < 1
        }
        guard let delegate = self.delegate else {
            return
        }
        count = delegate.numberOfBanner(bannerView: self)
        guard count > 1 else {
            let imageView = UIImageView(frame: scrollView.bounds)
            delegate.bannerView(self, configImageView: imageView, at: 0)
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
            scrollView.contentSize = scrollView.frame.size
            return
        }
        let imageView = UIImageView(frame: scrollView.bounds)
        delegate.bannerView(self, configImageView: imageView, at: count - 1)
        scrollView.addSubview(imageView)
        imageViews.append(imageView)
        for index in 0 ..< count {
            let imageView = UIImageView(frame: scrollView.bounds)
            delegate.bannerView(self, configImageView: imageView, at: index)
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }
        let imageView2 = UIImageView(frame: scrollView.bounds)
        delegate.bannerView(self, configImageView: imageView2, at: 0)
        scrollView.addSubview(imageView2)
        imageViews.append(imageView2)

        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(count + 2),
            height: scrollView.frame.height)
        scrollView.contentOffset = CGPoint(x: scrollView.frame.width, y: 0)
    }

//    func reloadPlayTask() {
//        timer?.invalidate()
//        guard autoPlayTimeInterval > 0, count > 1 else {
//            return
//        }
//    }
}
