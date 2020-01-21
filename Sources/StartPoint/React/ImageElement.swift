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

public class ImageElementState: ElementState {
    public var image: UIImage??
    public var highlightedImage: UIImage??

    public override func apply(view: UIView) {
        if let imageView = view as? UIImageView {
            apply(imageView: imageView)
        } else {
            super.apply(view: view)
        }
    }

    public func apply(imageView view: UIImageView) {
        if let image = self.image {
            view.image = image
        }
        if let highlightedImage = self.highlightedImage {
            view.highlightedImage = highlightedImage
        }
        super.apply(view: view)
    }

    public override func invalidate() {
        super.invalidate()
        image = nil
        highlightedImage = nil
    }
}

open class ImageElement: Element<UIImageView> {
    var _imageState: ImageElementState?

    public override var pendingState: ImageElementState {
        let state = _imageState ?? ImageElementState()
        if _imageState == nil {
            _imageState = state
            _pendingState = state
        }
        return state
    }

    // MARK: - Configuring a Element’s Visual Appearance
    @discardableResult
    public func image(_ value: UIImage?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.image = value
        } else {
            pendingState.image = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func sizedImage(_ value: UIImage?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.image = value
        } else {
            pendingState.image = value
            registerPendingState()
        }
        if let size = value?.size {
            layout.size(size)
        }
        return self
    }

    @discardableResult
    public func highlightedImage(_ value: UIImage?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.highlightedImage = value
        } else {
            pendingState.highlightedImage = value
            registerPendingState()
        }
        return self
    }
}
#endif // #if os(iOS)
