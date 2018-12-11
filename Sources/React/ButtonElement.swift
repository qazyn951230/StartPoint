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

extension UIControl.State: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

public class ButtonElementState: ElementState {
    public var titles: [UIControl.State: NSAttributedString?]?
    public var images: [UIControl.State: UIImage?]?
    public var backgroundImages: [UIControl.State: UIImage?]?

    public override func apply(view: UIView) {
        if let button = view as? UIButton {
            apply(button: button)
        } else {
            super.apply(view: view)
        }
    }

    public func apply(button view: UIButton) {
        if let titles = self.titles {
            for (state, title) in titles {
                view.setAttributedTitle(title, for: state)
            }
        }
        if let images = self.images {
            for (state, image) in images {
                view.setImage(image, for: state)
            }
        }
        if let backgroundImages = self.backgroundImages {
            for (state, image) in backgroundImages {
                view.setBackgroundImage(image, for: state)
            }
        }
        super.apply(view: view)
    }

    public override func invalidate() {
        titles = nil
        images = nil
        backgroundImages = nil
        super.invalidate()
    }
}

open class ButtonElement: Element<UIButton> {
    public let title: LabelElement?
    public let image: BasicElement?

    public override init(children: [BasicElement]) {
        let array: [BasicElement]
        if children.isEmpty {
            let _label = LabelElement()
            let _image = ImageElement()
            array = [_label, _image]
            title = _label
            image = _image
        } else {
            title = nil
            image = nil
            array = children
        }
        super.init(children: array)
        layout.flexDirection(.row)
    }

    public convenience init(type: UIButton.ButtonType = .custom, children: [BasicElement] = []) {
        self.init(children: children)
        creator = {
            UIButton(type: type)
        }
    }

    var _buttonState: ButtonElementState?
    public override var pendingState: ButtonElementState {
        let state = _buttonState ?? ButtonElementState()
        if _buttonState == nil {
            _buttonState = state
            _pendingState = state
        }
        return state
    }

    @discardableResult
    public func titleStyle(_ method: (FlexLayout) -> Void) -> Self {
        let layout = title?.layout
        layout.maybe(method)
        return self
    }

    @discardableResult
    public func imageStyle(_ method: (FlexLayout) -> Void) -> Self {
        let layout = image?.layout
        layout.maybe(method)
        return self
    }

    public override func buildChildren(in view: UIView) {
        for child in children {
            if child != title && child != image {
                child.build(in: view)
            }
        }
    }

    public override func applyState(to view: UIButton) {
        super.applyState(to: view)
        if actions.tap != nil {
            view.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
        }
        let (title, image) = edgeInsets()
        if self.title != nil {
            view.titleEdgeInsets = title
        }
        if self.image != nil {
            view.imageEdgeInsets = image
        }
        view.contentEdgeInsets = paddingEdgeInsets(for: self)
    }

    func edgeInsets() -> (UIEdgeInsets, UIEdgeInsets) {
        let buttonSize: CGSize = frame.size
        let titleSize: CGSize = title?.frame.size ?? CGSize.zero
        let titleInsets = marginEdgeInsets(for: title)
        let imageSize: CGSize = image?.frame.size ?? CGSize.zero
        let imageInsets = marginEdgeInsets(for: image)
        let padding = CGFloat(layout.style.totalPadding(for: .column, width: _frame.width))
        let titleEdgeInsets: UIEdgeInsets
        let imageEdgeInsets: UIEdgeInsets
        switch layout.style.flexDirection {
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

    func marginEdgeInsets(for element: BasicElement?) -> UIEdgeInsets {
        guard let element = element else {
            return UIEdgeInsets.zero
        }
        let margin = element.layout.style.margin
        return margin.edgeInsets(style: element.layout.style, size: element._frame.size)
    }

    func paddingEdgeInsets(for element: BasicElement?) -> UIEdgeInsets {
        guard let element = element else {
            return UIEdgeInsets.zero
        }
        let padding = element.layout.style.padding
        return padding.edgeInsets(style: element.layout.style, size: element._frame.size)
    }

    @objc public func tapAction(sender: UIButton) {
        assertMainThread()
        actions.tap?()
    }

    // MARK: - Configuring a Element’s Visual Appearance
    @discardableResult
    public func title(_ value: NSAttributedString?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.setAttributedTitle(value, for: .normal)
        } else {
            let _state = pendingState
            var titles: [UIControl.State: NSAttributedString?] = _state.titles ?? [:]
            titles[UIControl.State.normal] = value
            _state.titles = titles
        }
        title?.text(value)
        return self
    }

    @discardableResult
    public func title(_ value: NSAttributedString?, for state: UIControl.State) -> Self {
        if Runner.isMain(), let view = self.view {
            view.setAttributedTitle(value, for: state)
        } else {
            let _state = pendingState
            var titles: [UIControl.State: NSAttributedString?] = _state.titles ?? [:]
            titles[state] = value
            _state.titles = titles
            registerPendingState()
        }
        if state == UIControl.State.normal {
            title?.text(value)
        }
        return self
    }

    @discardableResult
    public func title(_ value: NSAttributedString?, states: UIControl.State...) -> Self {
        if Runner.isMain(), let view = self.view {
            for state in states {
                view.setAttributedTitle(value, for: state)
            }
        } else {
            let _state = pendingState
            var titles: [UIControl.State: NSAttributedString?] = _state.titles ?? [:]
            for state in states {
                titles[state] = value
            }
            _state.titles = titles
            registerPendingState()
        }
        if states.contains(.normal) {
            title?.text(value)
        }
        return self
    }

    @discardableResult
    public func image(_ value: UIImage?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.setImage(value, for: .normal)
        } else {
            let _state = pendingState
            var images: [UIControl.State: UIImage?] = _state.images ?? [:]
            images[UIControl.State.normal] = value
            _state.images = images
            registerPendingState()
        }
        image?.layout.size(value?.size ?? CGSize.zero)
        return self
    }

    @discardableResult
    public func image(_ value: UIImage?, for state: UIControl.State) -> Self {
        if Runner.isMain(), let view = self.view {
            view.setImage(value, for: state)
        } else {
            let _state = pendingState
            var images: [UIControl.State: UIImage?] = _state.images ?? [:]
            images[state] = value
            _state.images = images
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func image(_ value: UIImage?, states: UIControl.State...) -> Self {
        if Runner.isMain(), let view = self.view {
            for state in states {
                view.setImage(value, for: state)
            }
        } else {
            let _state = pendingState
            var images: [UIControl.State: UIImage?] = _state.images ?? [:]
            for state in states {
                images[state] = value
            }
            _state.images = images
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func sizedImage(_ value: UIImage?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.setImage(value, for: .normal)
        } else {
            let _state = pendingState
            var images: [UIControl.State: UIImage?] = _state.images ?? [:]
            images[UIControl.State.normal] = value
            _state.images = images
            registerPendingState()
        }
        image?.layout.size(value?.size ?? CGSize.zero)
        return self
    }

    @discardableResult
    public func sizedImage(_ value: UIImage?, for state: UIControl.State) -> Self {
        if Runner.isMain(), let view = self.view {
            view.setImage(value, for: state)
        } else {
            let _state = pendingState
            var images: [UIControl.State: UIImage?] = _state.images ?? [:]
            images[state] = value
            _state.images = images
            registerPendingState()
        }
        if state == UIControl.State.normal {
            image?.layout.size(value?.size ?? CGSize.zero)
        }
        return self
    }

    @discardableResult
    public func sizedImage(_ value: UIImage?, states: UIControl.State...) -> Self {
        if Runner.isMain(), let view = self.view {
            for state in states {
                view.setImage(value, for: state)
            }
        } else {
            let _state = pendingState
            var images: [UIControl.State: UIImage?] = _state.images ?? [:]
            for state in states {
                images[state] = value
            }
            _state.images = images
            registerPendingState()
        }
        if states.contains(.normal) {
            image?.layout.size(value?.size ?? CGSize.zero)
        }
        return self
    }

    @discardableResult
    public func backgroundImage(_ value: UIImage?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.setBackgroundImage(value, for: .normal)
        } else {
            let _state = pendingState
            var images: [UIControl.State: UIImage?] = _state.backgroundImages ?? [:]
            images[UIControl.State.normal] = value
            _state.backgroundImages = images
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func backgroundImage(_ value: UIImage?, for state: UIControl.State) -> Self {
        if Runner.isMain(), let view = self.view {
            view.setBackgroundImage(value, for: state)
        } else {
            let _state = pendingState
            var images: [UIControl.State: UIImage?] = _state.backgroundImages ?? [:]
            images[state] = value
            _state.backgroundImages = images
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func backgroundImage(_ value: UIImage?, states: UIControl.State...) -> Self {
        if Runner.isMain(), let view = self.view {
            for state in states {
                view.setBackgroundImage(value, for: state)
            }
        } else {
            let _state = pendingState
            var images: [UIControl.State: UIImage?] = _state.backgroundImages ?? [:]
            for state in states {
                images[state] = value
            }
            _state.backgroundImages = images
            registerPendingState()
        }
        return self
    }
}
