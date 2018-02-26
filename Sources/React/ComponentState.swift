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

public class ComponentState {
    var dirty: Bool = false

    public var backgroundColor: UIColor? {
        get {
            return _backgroundColor ?? nil
        }
        set {
            _backgroundColor = newValue
            dirty = true
        }
    }
    var _backgroundColor: UIColor??

    public required init() {
        // Do nothing.
    }

    public func apply(view: UIView) {
        assertMainThread()
        guard dirty else {
            return
        }
        if let backgroundColor = _backgroundColor {
            view.backgroundColor = backgroundColor
        }
        invalidate()
    }

    public func apply(layer: CALayer) {
        assertMainThread()
        guard dirty else {
            return
        }
        if let backgroundColor = _backgroundColor {
            layer.backgroundColor = backgroundColor?.cgColor
        }
        invalidate()
    }

    public func invalidate() {
        _backgroundColor = nil
        dirty = false
    }
}

public final class LabelComponentState: ComponentState {
    public var text: NSAttributedString? {
        get {
            return _text ?? nil
        }
        set {
            _text = newValue
            dirty = true
        }
    }
    var _text: NSAttributedString??

    public var numberOfLines: Int {
        get {
            return _numberOfLines ?? 1
        }
        set {
            _numberOfLines = newValue
            dirty = true
        }
    }
    var _numberOfLines: Int?

    public override func apply(view: UIView) {
        if let label = view as? UILabel {
            apply(label: label)
        } else {
            super.apply(view: view)
        }
    }

    public func apply(label: UILabel) {
        if let text = _text {
            label.attributedText = text
        }
        if let numberOfLines = _numberOfLines {
            label.numberOfLines = numberOfLines
        }
        super.apply(view: label)
    }
}

public final class ImageComponentState: ComponentState {
    public var image: UIImage? {
        get {
            return _image ?? nil
        }
        set {
            _image = newValue
            dirty = true
        }
    }
    var _image: UIImage??

    public var highlightedImage: UIImage? {
        get {
            return _highlightedImage ?? nil
        }
        set {
            _highlightedImage = newValue
            dirty = true
        }
    }
    var _highlightedImage: UIImage??

    public override func apply(view: UIView) {
        if let imageView = view as? UIImageView {
            apply(imageView: imageView)
        } else {
            super.apply(view: view)
        }
    }

    public func apply(imageView: UIImageView) {
        if let image = _image {
            imageView.image = image
        }
        if let highlightedImage = _highlightedImage {
            imageView.highlightedImage = highlightedImage
        }
        super.apply(view: imageView)
    }
}