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

public typealias TextFieldComponent = BasicTextFieldComponent<UITextField>

open class TextFieldComponentState: ComponentState {
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

    open override func apply(view: UIView) {
        if let textField = view as? UITextField {
            apply(textField: textField)
        } else {
            super.apply(view: view)
        }
    }

    open func apply(textField: UITextField) {
        if let text = _text {
            textField.attributedText = text
        }
        if let placeholder = _placeholder {
            textField.attributedPlaceholder = placeholder
        }
        super.apply(view: textField)
    }

    open override func invalidate() {
        _text = nil
        _placeholder = nil
        super.invalidate()
    }
}

open class BasicTextFieldComponent<TextField: UITextField>: Component<TextField> {
    var text: NSAttributedString?
    var placeholder: NSAttributedString?

    var _textFieldState: TextFieldComponentState?
    public override var pendingState: TextFieldComponentState {
        let state = _textFieldState ?? TextFieldComponentState()
        if _textFieldState == nil {
            _textFieldState = state
            _pendingState = state
        }
        return state
    }

    public override init(children: [BasicComponent] = []) {
        super.init(children: children)
        layout.measureSelf = measure
    }

    public override init(children: [BasicComponent], creator: @escaping () -> TextField) {
        super.init(children: children, creator: creator)
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

    @discardableResult
    public func text(_ value: NSAttributedString?) -> Self {
        text = value
        if mainThread(), let view = view {
            view.attributedText = value
        } else {
            pendingState.text = value
        }
        layout.markDirty()
        return self
    }

    @discardableResult
    public func placeholder(_ value: NSAttributedString?) -> Self {
        placeholder = value
        if mainThread(), let view = view {
            view.attributedPlaceholder = value
        } else {
            pendingState.placeholder = value
        }
        layout.markDirty()
        return self
    }
}
