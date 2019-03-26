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
import RxSwift
import RxCocoa

public class TextFieldElementState: ElementState {
    public var text: NSAttributedString??
    public var placeholder: String??
    public var attributedPlaceholder: NSAttributedString??
    public var clearButtonMode: UITextField.ViewMode?
    public var keyboard: UIKeyboardType?
    public var returnKey: UIReturnKeyType?
    public var secure: Bool?
    public var textAlignment: NSTextAlignment?
    public var font: UIFont??
    public var color: UIColor??
    public var textAttributes: [NSAttributedString.Key: Any]?

    public override func apply(view: UIView) {
        if let textField = view as? UITextField {
            apply(textField: textField)
        } else {
            super.apply(view: view)
        }
    }

    public func apply(textField view: UITextField) {
        if let text = self.text {
            view.attributedText = text
        }
        if let placeholder = self.attributedPlaceholder {
            view.attributedPlaceholder = placeholder
        } else if let placeholder2 = self.placeholder {
            view.placeholder = placeholder2
        }
        if let clearButtonMode = self.clearButtonMode {
            view.clearButtonMode = clearButtonMode
        }
        if let keyboard = self.keyboard {
            view.keyboardType = keyboard
        }
        if let returnKey = self.returnKey {
            view.returnKeyType = returnKey
        }
        if let secure = self.secure {
            view.isSecureTextEntry = secure
        }
        if let textAlignment = self.textAlignment {
            view.textAlignment = textAlignment
        }
        if let font = self.font {
            view.font = font
        }
        if let color = self.color {
            view.textColor = color
        }
        if let textAttributes = self.textAttributes {
            view.defaultTextAttributes = textAttributes
        }
        super.apply(view: view)
    }

    public override func invalidate() {
        super.invalidate()
        text = nil
        attributedPlaceholder = nil
        placeholder = nil
        clearButtonMode = nil
        keyboard = nil
        clearButtonMode = nil
        secure = nil
        textAlignment = nil
        font = nil
        color = nil
        textAttributes = nil
    }
}

public enum TextFieldElementEndEditingReason {
    case committed
    case unknown

    @available(iOS 10.0, *)
    public init(reason: UITextField.DidEndEditingReason) {
        switch reason {
        case .committed:
            self = .committed
        default:
            self = .unknown
        }
    }
}

public protocol TextFieldElementDelegate: class {
    func textFieldShouldBeginEditing(_ textField: TextFieldElement) -> Bool
    func textFieldDidBeginEditing(_ textField: TextFieldElement)
    func textFieldShouldEndEditing(_ textField: TextFieldElement) -> Bool
    func textField(_ textField: TextFieldElement, didEndEditing reason: TextFieldElementEndEditingReason)
    func textField(_ textField: TextFieldElement, shouldReplaceTo string: String, in range: Range<String.Index>) -> Bool
    func textFieldShouldClear(_ textField: TextFieldElement) -> Bool
    func textFieldShouldReturn(_ textField: TextFieldElement) -> Bool
}

public extension TextFieldElementDelegate {
    public func textFieldShouldBeginEditing(_ textField: TextFieldElement) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: TextFieldElement) {
        // Do nothing.
    }

    func textFieldShouldEndEditing(_ textField: TextFieldElement) -> Bool {
        return true
    }

    func textField(_ textField: TextFieldElement, didEndEditing reason: TextFieldElementEndEditingReason) {
        // Do nothing.
    }

    func textField(_ textField: TextFieldElement, shouldReplaceTo string: String, in range: Range<String.Index>) -> Bool {
        return true
    }

    func textFieldShouldClear(_ textField: TextFieldElement) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: TextFieldElement) -> Bool {
        return true
    }
}

public final class TextFieldDelegate: NSObject, UITextFieldDelegate {
    public weak var delegate: TextFieldElement?

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        assertMainThread()
        return delegate?.textFieldShouldBeginEditing(textField) ?? true
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        assertMainThread()
        delegate?.textFieldDidBeginEditing(textField)
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        assertMainThread()
        return delegate?.textFieldShouldEndEditing(textField) ?? true
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        assertMainThread()
        delegate?.textFieldDidEndEditing(textField)
    }

    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        assertMainThread()
        delegate?.textFieldDidEndEditing(textField, reason: reason)
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        assertMainThread()
        return delegate?.textField(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        assertMainThread()
        return delegate?.textFieldShouldClear(textField) ?? true
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        assertMainThread()
        return delegate?.textFieldShouldReturn(textField) ?? true
    }
}

open class TextFieldElement: Element<UITextField>, PropertyText {
    var _text: NSAttributedString?
    var placeholder: NSAttributedString?

    var _textFieldState: TextFieldElementState?
    public override var pendingState: TextFieldElementState {
        let state = _textFieldState ?? TextFieldElementState()
        if _textFieldState == nil {
            _textFieldState = state
            _pendingState = state
        }
        return state
    }

    private let _delegate: TextFieldDelegate = TextFieldDelegate()
    public weak var delegate: TextFieldElementDelegate?
    public var validation: ((String) -> Bool)?
    public var returnAction: (() -> Bool)?

    public final var text: ControlProperty<String?>? {
        assertMainThread()
        return view?.rx.text
    }

    public final var attributedText: ControlProperty<NSAttributedString?>? {
        assertMainThread()
        return view?.rx.attributedText
    }

    public override init(children: [BasicElement] = []) {
        super.init(children: children)
        layout.measureSelf = { [weak self] (w, wm, h, hm) in
            TextFieldElement.measureText(self, width: w, widthMode: wm, height: h, heightMode: hm)
        }
        _delegate.delegate = self
    }

    public override func buildView() -> UITextField {
        assertMainThread()
        let view = super.buildView()
        view.delegate = _delegate
        return view
    }

    // MARK: - Observing Element-Related Changes
    public func bind<T>(target: T, source method: @escaping (T) -> (TextFieldElement) -> Void) where T: AnyObject {
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

    // MARK: - UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        assertMainThread()
        return delegate?.textFieldShouldBeginEditing(self) ?? true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        assertMainThread()
        delegate?.textFieldDidBeginEditing(self)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        assertMainThread()
        return delegate?.textFieldShouldEndEditing(self) ?? true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        assertMainThread()
        delegate?.textField(self, didEndEditing: .committed)
    }

    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        assertMainThread()
        delegate?.textField(self, didEndEditing: TextFieldElementEndEditingReason(reason: reason))
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        assertMainThread()
        var value = textField.text ?? String.empty
        let start = value.index(value.startIndex, offsetBy: range.location)
        let end = value.index(start, offsetBy: range.length)
        let range: Range<String.Index> = start..<end
        value.replaceSubrange(range, with: string)
        if let fn = validation {
            return fn(value)
        }
        guard let delegate = self.delegate else {
            return true
        }
        return delegate.textField(self, shouldReplaceTo: value, in: range)
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        assertMainThread()
        return delegate?.textFieldShouldClear(self) ?? true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        assertMainThread()
        if let fn = returnAction {
            return fn()
        }
        return delegate?.textFieldShouldReturn(self) ?? true
    }

    // MARK: - Configuring a Element’s Visual Appearance
    @discardableResult
    public func text(_ value: NSAttributedString?) -> Self {
        _text = value
        if Runner.isMain(), let view = self.view {
            view.attributedText = value
        } else {
            pendingState.text = value
            registerPendingState()
        }
        layout.markDirty()
        return self
    }

    @discardableResult
    public func placeholder(_ value: String?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.placeholder = value
        } else {
            pendingState.placeholder = value
            registerPendingState()
        }
        layout.markDirty()
        return self
    }

    @discardableResult
    public func placeholder(_ value: NSAttributedString?) -> Self {
        placeholder = value
        if Runner.isMain(), let view = self.view {
            view.attributedPlaceholder = value
        } else {
            pendingState.attributedPlaceholder = value
            registerPendingState()
        }
        layout.markDirty()
        return self
    }

    @discardableResult
    public func clearButtonMode(_ value: UITextField.ViewMode) -> Self {
        if Runner.isMain(), let view = self.view {
            view.clearButtonMode = value
        } else {
            pendingState.clearButtonMode = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func keyboard(_ value: UIKeyboardType) -> Self {
        if Runner.isMain(), let view = self.view {
            view.keyboardType = value
        } else {
            pendingState.keyboard = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func returnKey(_ value: UIReturnKeyType) -> Self {
        if Runner.isMain(), let view = self.view {
            view.returnKeyType = value
        } else {
            pendingState.returnKey = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func secure(_ value: Bool) -> Self {
        if Runner.isMain(), let view = self.view {
            view.isSecureTextEntry = value
        } else {
            pendingState.secure = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func textAlignment(_ value: NSTextAlignment) -> Self {
        if Runner.isMain(), let view = self.view {
            view.textAlignment = value
        } else {
            pendingState.textAlignment = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func font(_ value: UIFont?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.font = value
        } else {
            pendingState.font = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func systemFont(size: CGFloat, weight: UIFont.Weight = .regular) -> Self {
        let font: UIFont
        if #available(iOS 8.2, *) {
            font = UIFont.systemFont(ofSize: size, weight: weight)
        } else {
            font = UIFont.systemFont(ofSize: size)
        }
        return self.font(font)
    }

    @discardableResult
    public func color(_ value: UIColor?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.textColor = value
        } else {
            pendingState.color = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func textAttributes(_ value: [NSAttributedString.Key: Any]) -> Self {
        if Runner.isMain(), let view = self.view {
            view.defaultTextAttributes = value
        } else {
            pendingState.textAttributes = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func textAttributes(template: AttributedString) -> Self {
        var attributes: [NSAttributedString.Key: Any] = [:]
        for (key, value) in template.attributes {
            attributes[key] = value
        }
        return textAttributes(attributes)
    }

    static func measureText(_ element: TextFieldElement?, width: Double, widthMode: MeasureMode,
                            height: Double, heightMode: MeasureMode) -> Size {
        guard let view = element else {
            return Size.zero
        }
        // FIXME: Text field size > label size ?
        if let text = view._text ?? view.placeholder {
            let size = CGSize(width: width, height: height)
            let options: NSStringDrawingOptions = []
            return Size(cgSize: text.boundingSize(size: size, options: options).ceiled)
        }
        return Size.zero
    }
}
