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

public final class FlexButton: UIControl {
    let root: BasicElement
    let imageElement: ImageElement
    let titleElement: LabelElement

    init(root: BasicElement, image: ImageElement, title: LabelElement) {
        self.root = root
        self.imageElement = image
        self.titleElement = title
        super.init(frame: CGRect.zero)
    }

    public override init(frame: CGRect) {
        imageElement = ImageElement()
        titleElement = LabelElement()
        root = StackElement(children: [imageElement, titleElement])
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        imageElement = ImageElement()
        titleElement = LabelElement()
        root = StackElement(children: [imageElement, titleElement])
        super.init(coder: aDecoder)
    }

    public var imageView: UIImageView? {
        return imageElement.view
    }
    public var titleLabel: UILabel? {
        return titleElement.view
    }

    func initialization() {
        // Do nothing.
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        root.layout(width: bounds.width, height: bounds.height)
        root.build(in: self)
    }
}
#endif // #if os(iOS)
