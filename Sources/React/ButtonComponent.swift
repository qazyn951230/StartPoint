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

open class ButtonComponentState: ComponentState {
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

    open override func apply(view: UIView) {
        if let button = view as? UIButton {
            apply(button: button)
        } else {
            super.apply(view: view)
        }
    }

    open func apply(button: UIButton) {
        _titles?.forEach { (state, title) in
            button.setAttributedTitle(title, for: state)
        }
        _images?.forEach { (state, image) in
            button.setImage(image, for: state)
        }
        _backgroundImages?.forEach { (state, image) in
            button.setBackgroundImage(image, for: state)
        }
        super.apply(view: button)
    }

    open override func invalidate() {
        _titles = nil
        _images = nil
        _backgroundImages = nil
        tap = false
        super.invalidate()
    }
}

public typealias ButtonComponent = BasicButtonComponent<UIButton>

open class BasicButtonComponent<Button: UIButton>: Component<Button> {
    let label: LabelComponent?
    let image: BasicComponent?
    private var _tap: ((UIButton) -> Void)?

    public convenience init(type: UIButtonType = .custom, children: [BasicComponent] = []) {
        self.init(children: children) {
            Button(type: type)
        }
    }

    public override init(children: [BasicComponent] = [], creator: @escaping () -> Button) {
        let array: [BasicComponent]
        if children.isEmpty {
            let _label = LabelComponent()
            let _image = ImageComponent()
            array = [_label, _image]
            label = _label
            image = _image
        } else {
            label = nil
            image = nil
            array = children
        }
        super.init(children: array, creator: creator)
    }

    deinit {
        Log.debug(stringAddress(self))
        // FIXME: Remove button target in main thread!
        view?.removeTarget(self, action: nil, for: .touchUpInside)
    }

    var _buttonState: ButtonComponentState?
    public override var pendingState: ButtonComponentState {
        let state = _buttonState ?? ButtonComponentState()
        if _buttonState == nil {
            _buttonState = state
            _pendingState = state
        }
        return state
    }

    public override func build(in view: UIView) {
        assertMainThread()
        let this = _buildView()
        view.addSubview(this)
        for child in children {
            if child != label && child != image {
                child.build(in: this)
            }
        }
    }

    override func _buildView() -> Button {
        assertMainThread()
        let this = _createView()
        if _buttonState?.tap == true {
            this.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
        }
        _buttonState?.apply(button: this)
        return this
    }

    @objc open func tapAction(sender: UIButton) {
        _tap?(sender)
    }

    @discardableResult
    public func titles(_ value: NSAttributedString?) -> Self {
        // TODO: Verify button state
        if mainThread(), let view = view {
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
        if mainThread(), let view = view {
            view.setAttributedTitle(value, for: state)
        } else {
            let _state = pendingState
            var titles: [UIControlState: NSAttributedString?] = _state.titles
            titles[state] = value
            _state.titles = titles
        }
        if state == UIControlState.normal {
            label?.text(value)
        }
        return self
    }

    @discardableResult
    public func title(_ value: NSAttributedString?, states: UIControlState...) -> Self {
        if mainThread(), let view = view {
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
        }
        if states.contains(.normal) {
            label?.text(value)
        }
        return self
    }

    @discardableResult
    public func images(_ value: UIImage?) -> Self {
        if mainThread(), let view = view {
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
        }
        image?.layout.size(value?.size ?? CGSize.zero)
        return self
    }

    @discardableResult
    public func image(_ value: UIImage?, for state: UIControlState = .normal) -> Self {
        if mainThread(), let view = view {
            view.setImage(value, for: state)
        } else {
            let _state = pendingState
            var images: [UIControlState: UIImage?] = _state.images
            images[state] = value
            _state.images = images
        }
        if state == UIControlState.normal {
            image?.layout.size(value?.size ?? CGSize.zero)
        }
        return self
    }

    @discardableResult
    public func image(_ value: UIImage?, states: UIControlState...) -> Self {
        if mainThread(), let view = view {
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
        }
        if states.contains(.normal) {
            image?.layout.size(value?.size ?? CGSize.zero)
        }
        return self
    }

    @discardableResult
    public func tap(_ method: @escaping (UIButton) -> Void) -> Self {
        _tap = method
        if mainThread(), let view = view {
            view.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
        } else {
            pendingState.tap = true
        }
        return self
    }
}
