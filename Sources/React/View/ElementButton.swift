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

public final class ElementButton: UIControl, ElementContainer, ButtonType {
    public weak var element: BasicElement? = nil

    public let titleLabel: UILabel
    public let imageView: UIImageView
    public let backgroundImageView: UIImageView

    var normalTitle: NSAttributedString?
    var selectedTitle: NSAttributedString?
    var disabledTitle: NSAttributedString?

    var normalImage: UIImage?
    var selectedImage: UIImage?
    var disabledImage: UIImage?

    var normalBackgroundColor: UIColor?
    var selectedBackgroundColor: UIColor?
    var disabledBackgroundColor: UIColor?

    var normalBackgroundImage: UIImage?
    var selectedBackgroundImage: UIImage?
    var disabledBackgroundImage: UIImage?

    public override init(frame: CGRect) {
        titleLabel = UILabel(frame: CGRect.zero)
        imageView = UIImageView(image: nil)
        backgroundImageView = UIImageView(image: nil)
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        titleLabel = UILabel(frame: CGRect.zero)
        imageView = UIImageView(image: nil)
        backgroundImageView = UIImageView(image: nil)
        super.init(coder: aDecoder)
        initialization()
    }

    func initialization() {
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        addSubview(imageView)
    }

    public override var isEnabled: Bool {
        didSet {
            applyChanges()
        }
    }

    public override var isHighlighted: Bool {
        didSet {
            applyChanges()
        }
    }

    public override var isSelected: Bool {
        didSet {
            applyChanges()
        }
    }

    func bindFrame(title: CGRect, image: CGRect) {
        assertMainThread()
        titleLabel.frame = title
        imageView.frame = image
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let object = element else {
            return super.sizeThatFits(size)
        }
        object.layout(width: size.width, height: size.height)
        return object.frame.size
    }

    public override func sizeToFit() {
        guard let object = element else {
            return super.sizeToFit()
        }
        object.layout()
        frame = object.frame
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.frame = bounds
        titleLabel.isHidden = titleLabel.attributedText == nil
        imageView.isHidden = imageView.image == nil
        backgroundImageView.isHidden = backgroundImageView.image == nil
    }

    private func applyTitle() {
        switch state {
        case UIControl.State.normal:
            titleLabel.attributedText = normalTitle
        case UIControl.State.highlighted, UIControl.State.selected:
            titleLabel.attributedText = selectedTitle
        case UIControl.State.disabled:
            titleLabel.attributedText = disabledTitle
        default:
            break
        }
    }

    private func applyImage() {
        switch state {
        case UIControl.State.normal:
            imageView.image = normalImage
        case UIControl.State.highlighted, UIControl.State.selected:
            imageView.image = selectedImage
        case UIControl.State.disabled:
            imageView.image = disabledImage
        default:
            break
        }
    }

    private func applyBackgroundImage() {
        switch state {
        case UIControl.State.normal:
            backgroundImageView.image = normalBackgroundImage
        case UIControl.State.highlighted, UIControl.State.selected:
            backgroundImageView.image = selectedBackgroundImage
        case UIControl.State.disabled:
            backgroundImageView.image = disabledBackgroundImage
        default:
            break
        }
    }

    private func applyChanges() {
        applyTitle()
        applyImage()
        applyBackgroundImage()
    }

    public func setTitle(_ title: String?, for state: UIControl.State) {
        switch state {
        case UIControl.State.normal:
            normalTitle = AttributedString(any: title)?.done()
        case UIControl.State.highlighted, UIControl.State.selected:
            selectedTitle = AttributedString(any: title)?.done()
        case UIControl.State.disabled:
            disabledTitle = AttributedString(any: title)?.done()
        default:
            break
        }
        applyTitle()
    }

    public func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        switch state {
        case UIControl.State.normal:
            normalTitle = title
            selectedTitle = selectedTitle ?? title
            disabledTitle = disabledTitle ?? title
        case UIControl.State.highlighted, UIControl.State.selected:
            selectedTitle = title
        case UIControl.State.disabled:
            disabledTitle = title
        default:
            break
        }
        applyTitle()
    }

    public func setImage(_ image: UIImage?, for state: UIControl.State) {
        switch state {
        case UIControl.State.normal:
            normalImage = image
            selectedImage = selectedImage ?? image
            disabledImage = disabledImage ?? image
        case UIControl.State.highlighted, UIControl.State.selected:
            selectedImage = image
        case UIControl.State.disabled:
            disabledImage = image
        default:
            break
        }
        applyImage()
    }

    public func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        switch state {
        case UIControl.State.normal:
            normalBackgroundImage = image
            selectedBackgroundImage = selectedBackgroundImage ?? image
            disabledBackgroundImage = disabledBackgroundImage ?? image
        case UIControl.State.highlighted, UIControl.State.selected:
            selectedBackgroundImage = image
        case UIControl.State.disabled:
            disabledBackgroundImage = image
        default:
            break
        }
        applyBackgroundImage()
    }
}
