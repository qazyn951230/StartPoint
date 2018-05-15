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

public class TextFieldElementState: ElementState {
    public var text: NSAttributedString? {
        get {
            return _text ?? nil
        }
        set {
            _text = newValue
        }
    }
    var _text: NSAttributedString??

    public var placeholder: NSAttributedString? {
        get {
            return _placeholder ?? nil
        }
        set {
            _placeholder = newValue
        }
    }
    var _placeholder: NSAttributedString??

    public var clearButtonMode: UITextFieldViewMode {
        get {
            return _clearButtonMode ?? UITextFieldViewMode.never
        }
        set {
            _clearButtonMode = newValue
        }
    }
    var _clearButtonMode: UITextFieldViewMode?

    public var keyboard: UIKeyboardType {
        get {
            return _keyboard ?? UIKeyboardType.default
        }
        set {
            _keyboard = newValue
        }
    }
    var _keyboard: UIKeyboardType?

    public var returnKey: UIReturnKeyType {
        get {
            return _returnKey ?? UIReturnKeyType.default
        }
        set {
            _returnKey = newValue
        }
    }
    var _returnKey: UIReturnKeyType?

    public var secure: Bool {
        get {
            return _secure ?? false
        }
        set {
            _secure = newValue
        }
    }
    var _secure: Bool?

    public override func apply(view: UIView) {
        if let textField = view as? UITextField {
            apply(textField: textField)
        } else {
            super.apply(view: view)
        }
    }

    public func apply(textField: UITextField) {
        if let text = _text {
            textField.attributedText = text
        }
        if let placeholder = _placeholder {
            textField.attributedPlaceholder = placeholder
        }
        if let clearButtonMode = _clearButtonMode {
            textField.clearButtonMode = clearButtonMode
        }
        if let keyboard = _keyboard {
            textField.keyboardType = keyboard
        }
        if let returnKey = _returnKey {
            textField.returnKeyType = returnKey
        }
        if let secure = _secure {
            textField.isSecureTextEntry = secure
        }

        super.apply(view: textField)
    }

    public override func invalidate() {
        _text = nil
        _placeholder = nil
        _clearButtonMode = nil
        _keyboard = nil
        _clearButtonMode = nil
        _secure = nil
        super.invalidate()
    }
}

public class TextFieldElement: Element<UITextField> {
    var text: NSAttributedString?
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

    public override init(children: [BasicElement] = []) {
        super.init(children: children)
        layout.measureSelf = measure
    }

    func measure(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
        // FIXME: Text field size > label size ?
        if let text = text ?? placeholder {
            let size = CGSize(width: width, height: height)
            let options: NSStringDrawingOptions = []
            return Size(cgSize: text.boundingSize(size: size, options: options).ceiled)
        }
        return Size.zero
    }

    // MARK: - Configuring a Element’s Visual Appearance
    @discardableResult
    public func text(_ value: NSAttributedString?) -> Self {
        text = value
        if Runner.isMain(), let view = view {
            view.attributedText = value
        } else {
            pendingState.text = value
            registerPendingState()
        }
        layout.markDirty()
        return self
    }

    @discardableResult
    public func placeholder(_ value: NSAttributedString?) -> Self {
        placeholder = value
        if Runner.isMain(), let view = view {
            view.attributedPlaceholder = value
        } else {
            pendingState.placeholder = value
            registerPendingState()
        }
        layout.markDirty()
        return self
    }

    @discardableResult
    public func clearButtonMode(_ value: UITextFieldViewMode) -> Self {
        if Runner.isMain(), let view = view {
            view.clearButtonMode = value
        } else {
            pendingState.clearButtonMode = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func keyboard(_ value: UIKeyboardType) -> Self {
        if Runner.isMain(), let view = view {
            view.keyboardType = value
        } else {
            pendingState.keyboard = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func returnKey(_ value: UIReturnKeyType) -> Self {
        if Runner.isMain(), let view = view {
            view.returnKeyType = value
        } else {
            pendingState.returnKey = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func secure(_ value: Bool) -> Self {
        if Runner.isMain(), let view = view {
            view.isSecureTextEntry = value
        } else {
            pendingState.secure = value
            registerPendingState()
        }
        return self
    }
}
