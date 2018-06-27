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
import CoreGraphics
import QuartzCore
import RxSwift
import RxCocoa

public class ProgressHUD: UIView {
    var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var blockView: UIView? = nil
    private let bag = DisposeBag()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }

    deinit {
        blockView = nil
    }

    func initialization() {
        blockView = UIView(frame: .zero)
        blockView?.addSubview(self)

        layer.cornerRadius = 4
        backgroundColor = UIColor.gray
        addSubview(indicatorView)

        layoutView()
        addObserver()
    }

    func addObserver() {
        let center: Reactive<NotificationCenter> = NotificationCenter.default.rx
        center.notification(.UIDeviceOrientationDidChange)
            .map(deviceOrientationDidChange)
            .subscribe()
            .disposed(by: bag)
    }

    func deviceOrientationDidChange(notification: Notification) {
        // FIXME: Sometimes HUD cannot display correct.
        layoutView()
    }

    func layoutView() {
        let rect = UIScreen.main.bounds
        blockView?.frame = rect
        frame = frame.setSize(width: 60, height: 60)
        center = rect.center
        indicatorView.center = self.bounds.center
    }

    public func show(in view: UIView, animated: Bool = true) {
        guard let blockView = self.blockView else {
            return
        }
        view.addSubview(blockView)
        if animated {
            blockView.alpha = 0
            transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0,
                options: .beginFromCurrentState, animations: { [unowned self] in
                self.transform = CGAffineTransform.identity
                blockView.alpha = 1
                self.indicatorView.startAnimating()
            })
        } else {
            indicatorView.startAnimating()
        }
    }

    public func hide(animated: Bool = true) {
        guard let blockView = self.blockView else {
            return
        }
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0,
                options: .beginFromCurrentState, animations: { [unowned self] in
                self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                blockView.alpha = 0
                self.indicatorView.stopAnimating()
            }, completion: { _ in
                blockView.removeFromSuperview()
            })
        } else {
            indicatorView.stopAnimating()
            blockView.removeFromSuperview()
        }
    }
}
