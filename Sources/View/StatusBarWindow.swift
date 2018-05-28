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

public final class StatusBarWindow: UIWindow {
    public let statusBarLayer = CALayer()

    public var statusBarColor: UIColor? {
        get {
            return statusBarLayer.backgroundColor
                .map(UIColor.init(cgColor:))
        }
        set {
            statusBarLayer.backgroundColor = newValue?.cgColor
        }
    }

    public override var rootViewController: UIViewController? {
        didSet {
            if let root = rootViewController {
                switch root.preferredStatusBarStyle {
                case .default:
                    statusBarColor = UIColor.hex(0xF8F8F8)
                case .lightContent:
                    statusBarColor = UIColor.hex(0x181818)
                default:
                    break
                }
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }

    func initialization() {
        layer.addSublayer(statusBarLayer)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        let height = UIApplication.shared.statusBarFrame.height
        let frame = CGRect(origin: .zero, width: Device.width, height: height)
        statusBarLayer.frame = frame
        let z = zIndex()
        if z > statusBarLayer.zPosition {
            statusBarLayer.zPosition = z + 1
        }
    }

    func zIndex() -> CGFloat {
        guard let layers = layer.sublayers else {
            return 10
        }
        return layers.reduce(10 as CGFloat) { (result, next) in
            max(result, next.zPosition)
        }
    }
}
