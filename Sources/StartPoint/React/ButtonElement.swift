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
        if let button = view as? UIButtonType {
            apply(button: button)
        } else {
            super.apply(view: view)
        }
    }

    public func apply(button view: UIButtonType) {
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

public protocol ButtonType {
    func setTitle(_ title: String?, for state: UIControl.State)
    func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State)
    func setImage(_ image: UIImage?, for state: UIControl.State)
    func setBackgroundImage(_ image: UIImage?, for state: UIControl.State)
}

public typealias UIButtonType = UIControl & ButtonType

extension UIButton: ButtonType {
    // Do nothing.
}

open class BasicButtonElement<Button: UIButtonType>: Element<Button> {
    public let titleElement: LabelElement
    public let imageElement: BasicElement

    public override init(children: [BasicElement] = []) {
        titleElement = LabelElement()
        imageElement = ImageElement()
        var array: [BasicElement] = [imageElement, titleElement]
        array.append(contentsOf: children)
        super.init(children: array)
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
        method(titleElement.layout)
        return self
    }

    @discardableResult
    public func imageStyle(_ method: (FlexLayout) -> Void) -> Self {
        method(imageElement.layout)
        return self
    }

    override func buildChildren(in view: UIView) {
        if children.isEmpty {
            return
        }
        let sorted = children.sorted(by: BasicElement.sortZIndex)
        for child in sorted where child != titleElement && child != imageElement {
            child.build(in: view)
        }
    }

    public override func applyState(to view: Button) {
        super.applyState(to: view)
        if actions.tap != nil {
            view.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
        }
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
        titleElement.text(value)
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
            titleElement.text(value)
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
            titleElement.text(value)
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
        imageElement.layout.size(value?.size ?? CGSize.zero)
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
        imageElement.layout.size(value?.size ?? CGSize.zero)
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
            imageElement.layout.size(value?.size ?? CGSize.zero)
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
            imageElement.layout.size(value?.size ?? CGSize.zero)
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

public class ButtonElement: BasicButtonElement<UIButton> {
    public override init(children: [BasicElement]) {
        super.init(children: children)
        layout.flexDirection(.row)
    }

    public convenience init(type: UIButton.ButtonType = .custom, children: [BasicElement] = []) {
        self.init(children: children)
        creator = {
            UIButton(type: type)
        }
    }

    public override func applyState(to view: UIButton) {
        super.applyState(to: view)
        let (title, image) = edgeInsets()
        view.titleEdgeInsets = title
        view.imageEdgeInsets = image
        view.contentEdgeInsets = paddingEdgeInsets(for: self)
    }

    // MARK: - Observing Element-Related Changes
    public func bind<T>(target: T, source method: @escaping (T) -> (ButtonElement) -> Void) where T: AnyObject {
        if Runner.isMain(), loaded {
            method(target)(self)
        } else {
            let action: ElementAction.Action = { [weak target, weak self] in
                if let _target = target, let this = self {
                    method(_target)(this)
                }
            }
            actions.load.append(action)
        }
    }

    private func edgeInsets() -> (UIEdgeInsets, UIEdgeInsets) {
        let buttonSize: CGSize = frame.size
        let titleSize: CGSize = titleElement.frame.size
        let titleInsets = marginEdgeInsets(for: titleElement)
        let imageSize: CGSize = imageElement.frame.size
        let imageInsets = marginEdgeInsets(for: imageElement)
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

    private func marginEdgeInsets(for element: BasicElement) -> UIEdgeInsets {
        let margin = element.layout.style.margin
        return margin.edgeInsets(style: element.layout.style, size: element._frame.size)
    }

    private func paddingEdgeInsets(for element: BasicElement) -> UIEdgeInsets {
        let padding = element.layout.style.padding
        return padding.edgeInsets(style: element.layout.style, size: element._frame.size)
    }
}

public class FlexButtonElement: BasicButtonElement<ElementButton> {
    public override init(children: [BasicElement] = []) {
        super.init(children: children)
        layout.alignItems(.center).justifyContent(.center)
    }

    public override func applyState(to view: ElementButton) {
        super.applyState(to: view)
        view.bindFrame(title: titleElement.frame, image: imageElement.frame)
    }
}
#endif // #if os(iOS)
