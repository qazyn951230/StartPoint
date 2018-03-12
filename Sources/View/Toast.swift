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
import QuartzCore
import RxSwift
import RxCocoa

public class Toast {
    let text: String
    let duration: TimeInterval
    let position: Position
    var view: UIView? = nil
    let viewSize: CGSize?
    var label: UILabel? = nil

    private let bag = DisposeBag()

    static let minimumWidth: CGFloat = 60
    static var maximumWidth: CGFloat {
        let margin: CGFloat
        switch UIDevice.current.userInterfaceIdiom {
        case .unspecified, .phone, .carPlay:
            margin = 20
        case .pad:
            margin = 40
        case .tv:
            margin = 60
        }
        return UIScreen.main.bounds.width - margin * 2
    }
    static let minimumHeight: CGFloat = 30

    public init(text: String, duration: Duration = .short, position: Position = .bottom) {
        self.text = text
        self.duration = duration.duration
        self.position = position
        viewSize = nil
        addObserver()
    }

    public init(view: UIView, size: CGSize? = nil, duration: Duration = .short, position: Position = .bottom) {
        text = String.empty
        self.duration = duration.duration
        self.position = position
        self.view = view
        viewSize = size
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
        layoutView()
    }

    public func show() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let view = self.view ?? createView()
        layoutView()
        var duration = self.duration
        let delay: TimeInterval
        if duration > 4 {
            delay = duration - 4
            duration = 4
        } else {
            delay = 0
        }
        view.alpha = 0
        window.addSubview(view)
        UIView.animate(withDuration: 0.5, delay: 0, options: .beginFromCurrentState, animations: {
            view.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: duration, delay: delay, options: .beginFromCurrentState, animations: {
                view.alpha = 0
            }, completion: { _ in
                view.removeFromSuperview()
            })
        })
    }

    public func cancel() {
        view?.removeFromSuperview()
    }

    static let textWidth: CGFloat = {
        let margin: CGFloat
        switch UIDevice.current.userInterfaceIdiom {
        case .unspecified, .phone, .carPlay:
            margin = 20
        case .pad:
            margin = 40
        case .tv:
            margin = 60
        }
        return UIScreen.main.bounds.width - margin * 2
    }()

    func createView() -> UIView {
        let label: UILabel = UILabel(frame: .zero)
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(white: 0, alpha: 0.7)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.attributedText = AttributedString(self.text).systemFont(14).color(.white).done()
        self.label = label
        return label
    }

    func layoutView() {
        if let label = self.label, let text = label.attributedText {
            let size = text.boundingSize(width: Toast.maximumWidth).ceiled
            layoutView(label, size: CGSize(width: size.width + 10, height: size.height))
        } else if let view = self.view {
            let size: CGSize
            if let viewSize = self.viewSize {
                size = viewSize
            } else {
                view.sizeToFit()
                size = view.frame.size
            }
            layoutView(view, size: size)
        }
    }

    func layoutView(_ view: UIView, size: CGSize) {
        let width: CGFloat = within(size.width, min: Toast.minimumWidth, max: Toast.maximumWidth)
        let height: CGFloat = max(size.height, Toast.minimumHeight)
        let size = CGSize(width: width, height: height)
        let origin = position.origin(frame: UIScreen.main.bounds, size: size, margin: 30)
        view.frame = CGRect(origin: origin, size: size)
    }

    public enum Duration {
        case short
        case long
        case other(TimeInterval)

        var duration: TimeInterval {
            switch self {
            case .short:
                return 2.0
            case .long:
                return 4.0
            case .other(let t):
                return t
            }
        }
    }

    public enum Position {
        case top
        case center
        case bottom

        func origin(frame: CGRect, size: CGSize, margin: CGFloat) -> CGPoint {
            let x: CGFloat = (frame.width - size.width) / 2
            let point: CGPoint
            switch self {
            case .top:
                point = CGPoint(x: x, y: margin)
            case .center:
                let y: CGFloat = (frame.height - size.height) / 2
                point = CGPoint(x: x, y: y)
            case .bottom:
                point = CGPoint(x: x, y: frame.height - margin - size.height)
            }
            return point
        }
    }
}
