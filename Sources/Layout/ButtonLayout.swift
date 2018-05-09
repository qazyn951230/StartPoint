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

// √ button padding
// √ title image padding
final public class ButtonLayout: FlexLayout {
    // Property
    public private(set) var title: NSAttributedString? = nil
    public private(set) var image: UIImage? = nil
    // Layout
    public private(set) var titleLayout: TextLayout? = nil
    public private(set) var imageLayout: FlexLayout? = nil

    public required init(view: LayoutView? = nil) {
        super.init(view: view)
        flexDirection(.row)
            .justifyContent(.center)
            .alignContent(.center)
            .alignItems(.center)
    }

    public func title(_ value: NSAttributedString?) -> TextLayout? {
        self.title = value
        guard value != nil else {
            _ = titleLayout.map(self.remove)
            titleLayout = nil
            return nil
        }
        titleLayout = TextLayout().text(value).append(to: self)
        return titleLayout
    }

    public func image(_ value: UIImage?) -> FlexLayout? {
        self.image = value
        return image(size: value?.size)
    }

    public func image(size value: CGSize?) -> FlexLayout? {
        guard let size = value else {
            _ = imageLayout.map(self.remove)
            imageLayout = nil
            return nil
        }
        imageLayout = FlexLayout().size(size).append(to: self)
        return imageLayout
    }

    @discardableResult
    public func titleLayout(_ value: TextLayout) -> ButtonLayout {
        if let t = self.titleLayout {
            remove(t)
        }
        self.titleLayout = value
        append(value)
        return self
    }

    @discardableResult
    public func imageLayout(_ value: FlexLayout) -> ButtonLayout {
        if let t = self.imageLayout {
            remove(t)
        }
        self.imageLayout = value
        append(value)
        return self
    }

    public override func apply(to view: LayoutView?, left: Double, top: Double) {
        super.apply(to: view, left: left, top: top)
        guard let button = view as? UIButton else {
            return
        }
        let (title, image) = edgeInsets()
        if titleLayout != nil {
            button.titleEdgeInsets = title
        }
        if imageLayout != nil {
            button.imageEdgeInsets = image
        }
        button.contentEdgeInsets = paddingEdgeInsets(for: self)
    }

    func edgeInsets() -> (UIEdgeInsets, UIEdgeInsets) {
        let buttonSize: CGSize = frame.size
        let titleSize: CGSize = titleLayout?.frame.size ?? CGSize.zero
        let titleInsets = marginEdgeInsets(for: titleLayout)
        let imageSize: CGSize = imageLayout?.frame.size ?? CGSize.zero
        let imageInsets = marginEdgeInsets(for: imageLayout)
        let padding = CGFloat(style.totalPadding(for: .column, width: box.width))
        let titleEdgeInsets: UIEdgeInsets
        let imageEdgeInsets: UIEdgeInsets
        switch style.flexDirection {
        case .row:
            titleEdgeInsets = UIEdgeInsets(top: titleInsets.top, left: titleInsets.left + imageInsets.left,
                bottom: titleInsets.bottom, right: titleInsets.right - imageInsets.right)
            imageEdgeInsets = UIEdgeInsets(top: imageInsets.top, left: imageInsets.left - titleInsets.left,
                bottom: imageInsets.bottom, right: imageInsets.right + titleInsets.right)
        case .rowReverse:
            titleEdgeInsets = UIEdgeInsets(top: titleInsets.top,
                left: titleInsets.left - imageSize.width - imageInsets.horizontal,
                bottom: titleInsets.bottom, right: imageSize.width + titleInsets.right)
            imageEdgeInsets = UIEdgeInsets(top: imageInsets.top,
                left: titleSize.width + imageSize.width + titleInsets.horizontal + imageInsets.left,
                bottom: imageInsets.bottom, right: imageSize.width + imageInsets.right)
        case .column:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: titleInsets.left - imageSize.width,
                bottom: titleSize.height - buttonSize.height + padding + titleInsets.bottom * 2,
                right: titleInsets.right)
            imageEdgeInsets = UIEdgeInsets(top: imageSize.height - buttonSize.height + padding + imageInsets.top * 2,
                left: imageInsets.left, bottom: 0, right: imageInsets.right - titleSize.width)
        case .columnReverse:
            titleEdgeInsets = UIEdgeInsets(top: titleSize.height - buttonSize.height + padding + titleInsets.top * 2,
                left: titleInsets.left - imageSize.width, bottom: 0, right: titleInsets.right)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: imageInsets.left,
                bottom: imageSize.height - buttonSize.height + padding + imageInsets.bottom * 2,
                right: imageInsets.right - titleSize.width)
        }
        return (titleEdgeInsets, imageEdgeInsets)
    }

    func marginEdgeInsets(for layout: FlexLayout?) -> UIEdgeInsets {
        guard let layout = layout else {
            return UIEdgeInsets.zero
        }
        let margin = layout.style.margin
        return margin.edgeInsets(style: layout.style, size: Size(width: box.width, height: box.height))
    }

    func paddingEdgeInsets(for layout: FlexLayout?) -> UIEdgeInsets {
        guard let layout = layout else {
            return UIEdgeInsets.zero
        }
        let padding = layout.style.padding
        return padding.edgeInsets(style: layout.style, size: Size(width: box.width, height: box.height))
    }
}
