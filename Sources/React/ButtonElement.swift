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

public class ButtonElementState: ElementState {
    public var titles: [UIControlState: NSAttributedString?] {
        get {
            return _titles ?? [:]
        }
        set {
            _titles = newValue
        }
    }
    var _titles: [UIControlState: NSAttributedString?]?

    public var images: [UIControlState: UIImage?] {
        get {
            return _images ?? [:]
        }
        set {
            _images = newValue
        }
    }
    var _images: [UIControlState: UIImage?]?

    public var backgroundImages: [UIControlState: UIImage?] {
        get {
            return _backgroundImages ?? [:]
        }
        set {
            _backgroundImages = newValue
        }
    }
    var _backgroundImages: [UIControlState: UIImage?]?

    var tap = false

    public override func apply(view: UIView) {
        if let button = view as? UIButton {
            apply(button: button)
        } else {
            super.apply(view: view)
        }
    }

    public func apply(button view: UIButton) {
        _titles?.forEach { (state, title) in
            view.setAttributedTitle(title, for: state)
        }
        _images?.forEach { (state, image) in
            view.setImage(image, for: state)
        }
        _backgroundImages?.forEach { (state, image) in
            view.setBackgroundImage(image, for: state)
        }
        super.apply(view: view)
    }

    public override func invalidate() {
        _titles = nil
        _images = nil
        _backgroundImages = nil
        tap = false
        super.invalidate()
    }
}

public class ButtonElement: Element<UIButton> {
    let label: LabelElement?
    let image: BasicElement?

    public override init(children: [BasicElement]) {
        let array: [BasicElement]
        if children.isEmpty {
            let _label = LabelElement()
            let _image = ImageElement()
            array = [_label, _image]
            label = _label
            image = _image
        } else {
            label = nil
            image = nil
            array = children
        }
        super.init(children: array)
        layout.flexDirection(.row)
    }

    public convenience init(type: UIButtonType = .custom, children: [BasicElement] = []) {
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

    public override func buildChildren(in view: UIView) {
        for child in children {
            if child != label && child != image {
                child.build(in: view)
            }
        }
    }

    public override func applyState(to view: UIButton) {
        if _buttonState?.tap == true {
            view.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
        }
        super.applyState(to: view)
        let (title, image) = edgeInsets()
        if label != nil {
            view.titleEdgeInsets = title
        }
        if self.image != nil {
            view.imageEdgeInsets = image
        }
        view.contentEdgeInsets = paddingEdgeInsets(for: self)
    }

    func edgeInsets() -> (UIEdgeInsets, UIEdgeInsets) {
        let buttonSize: CGSize = frame.size
        let titleSize: CGSize = label?.frame.size ?? CGSize.zero
        let titleInsets = marginEdgeInsets(for: label)
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
        _tap?(self)
    }

    public override func tap(_ method: @escaping (BasicElement) -> Void) {
        super.tap(method)
        if Runner.isMain(), let view = view {
            view.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
        } else {
            pendingState.tap = true
        }
    }

    // MARK: - Configuring a Element’s Visual Appearance
    @discardableResult
    public func titles(_ value: NSAttributedString?) -> Self {
        // TODO: Verify button state
        if Runner.isMain(), let view = view {
            view.setAttributedTitle(value, for: .normal)
            view.setAttributedTitle(value, for: .selected)
            view.setAttributedTitle(value, for: .disabled)
        } else {
            let state = pendingState
            var titles: [UIControlState: NSAttributedString?] = state.titles
            titles[.normal] = value
            titles[.selected] = value
            titles[.disabled] = value
            state.titles = titles
        }
        label?.text(value)
        return self
    }

    @discardableResult
    public func title(_ value: NSAttributedString?, for state: UIControlState = .normal) -> Self {
        if Runner.isMain(), let view = view {
            view.setAttributedTitle(value, for: state)
        } else {
            let _state = pendingState
            var titles: [UIControlState: NSAttributedString?] = _state.titles
            titles[state] = value
            _state.titles = titles
            registerPendingState()
        }
        if state == UIControlState.normal {
            label?.text(value)
        }
        return self
    }

    @discardableResult
    public func title(_ value: NSAttributedString?, states: UIControlState...) -> Self {
        if Runner.isMain(), let view = view {
            for state in states {
                view.setAttributedTitle(value, for: state)
            }
        } else {
            let _state = pendingState
            var titles: [UIControlState: NSAttributedString?] = _state.titles
            for state in states {
                titles[state] = value
            }
            _state.titles = titles
            registerPendingState()
        }
        if states.contains(.normal) {
            label?.text(value)
        }
        return self
    }

    @discardableResult
    public func images(_ value: UIImage?) -> Self {
        if Runner.isMain(), let view = view {
            view.setImage(value, for: .normal)
            view.setImage(value, for: .selected)
            view.setImage(value, for: .disabled)
        } else {
            let state = pendingState
            var images: [UIControlState: UIImage?] = state.images
            images[.normal] = value
            images[.selected] = value
            images[.disabled] = value
            state.images = images
            registerPendingState()
        }
        image?.layout.size(value?.size ?? CGSize.zero)
        return self
    }

    @discardableResult
    public func image(_ value: UIImage?, for state: UIControlState = .normal) -> Self {
        if Runner.isMain(), let view = view {
            view.setImage(value, for: state)
        } else {
            let _state = pendingState
            var images: [UIControlState: UIImage?] = _state.images
            images[state] = value
            _state.images = images
            registerPendingState()
        }
        if state == UIControlState.normal {
            image?.layout.size(value?.size ?? CGSize.zero)
        }
        return self
    }

    @discardableResult
    public func image(_ value: UIImage?, states: UIControlState...) -> Self {
        if Runner.isMain(), let view = view {
            for state in states {
                view.setImage(value, for: state)
            }
        } else {
            let _state = pendingState
            var images: [UIControlState: UIImage?] = _state.images
            for state in states {
                images[state] = value
            }
            _state.images = images
            registerPendingState()
        }
        if states.contains(.normal) {
            let size: CGSize = value?.size ?? CGSize.zero
            image?.layout.size(size)
            layout.size(size)
        }
        return self
    }

    @discardableResult
    public func sizedImages(_ value: UIImage?) -> Self {
        if Runner.isMain(), let view = view {
            view.setImage(value, for: .normal)
            view.setImage(value, for: .selected)
            view.setImage(value, for: .disabled)
        } else {
            let state = pendingState
            var images: [UIControlState: UIImage?] = state.images
            images[.normal] = value
            images[.selected] = value
            images[.disabled] = value
            state.images = images
            registerPendingState()
        }
        let size: CGSize = value?.size ?? CGSize.zero
        image?.layout.size(size)
        layout.size(size)
        return self
    }

    @discardableResult
    public func sizedImage(_ value: UIImage?, for state: UIControlState = .normal) -> Self {
        if Runner.isMain(), let view = view {
            view.setImage(value, for: state)
        } else {
            let _state = pendingState
            var images: [UIControlState: UIImage?] = _state.images
            images[state] = value
            _state.images = images
            registerPendingState()
        }
        if state == UIControlState.normal {
            let size: CGSize = value?.size ?? CGSize.zero
            image?.layout.size(size)
            layout.size(size)
        }
        return self
    }

    @discardableResult
    public func sizedImage(_ value: UIImage?, states: UIControlState...) -> Self {
        if Runner.isMain(), let view = view {
            for state in states {
                view.setImage(value, for: state)
            }
        } else {
            let _state = pendingState
            var images: [UIControlState: UIImage?] = _state.images
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
    public func backgroundImages(_ value: UIImage?) -> Self {
        if Runner.isMain(), let view = view {
            view.setBackgroundImage(value, for: .normal)
            view.setBackgroundImage(value, for: .selected)
            view.setBackgroundImage(value, for: .disabled)
        } else {
            let state = pendingState
            var images: [UIControlState: UIImage?] = state.backgroundImages
            images[.normal] = value
            images[.selected] = value
            images[.disabled] = value
            state.backgroundImages = images
            registerPendingState()
        }
//        image?.layout.size(value?.size ?? CGSize.zero)
        return self
    }

    @discardableResult
    public func backgroundImage(_ value: UIImage?, for state: UIControlState = .normal) -> Self {
        if Runner.isMain(), let view = view {
            view.setBackgroundImage(value, for: state)
        } else {
            let _state = pendingState
            var images: [UIControlState: UIImage?] = _state.backgroundImages
            images[state] = value
            _state.backgroundImages = images
            registerPendingState()
        }
//        if state == UIControlState.normal {
//            image?.layout.size(value?.size ?? CGSize.zero)
//        }
        return self
    }

    @discardableResult
    public func backgroundImage(_ value: UIImage?, states: UIControlState...) -> Self {
        if Runner.isMain(), let view = view {
            for state in states {
                view.setBackgroundImage(value, for: state)
            }
        } else {
            let _state = pendingState
            var images: [UIControlState: UIImage?] = _state.backgroundImages
            for state in states {
                images[state] = value
            }
            _state.backgroundImages = images
            registerPendingState()
        }
//        if states.contains(.normal) {
//            image?.layout.size(value?.size ?? CGSize.zero)
//        }
        return self
    }
}
