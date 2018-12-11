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

public class LabelElementState: ElementState {
    public var text: NSAttributedString??
    public var numberOfLines: Int?
    public var textAlignment: NSTextAlignment?
    public var lineBreak: NSLineBreakMode?

    public override func apply(view: UIView) {
        if let label = view as? UILabel {
            apply(label: label)
        } else {
            super.apply(view: view)
        }
    }

    public func apply(label view: UILabel) {
        if let text = self.text {
            view.attributedText = text
        }
        if let numberOfLines = self.numberOfLines {
            view.numberOfLines = numberOfLines
        }
        if let textAlignment = self.textAlignment {
            view.textAlignment = textAlignment
        }
        if let lineBreak = self.lineBreak {
            view.lineBreakMode = lineBreak
        }
        super.apply(view: view)
    }

    public override func invalidate() {
        super.invalidate()
        text = nil
        numberOfLines = nil
        textAlignment = nil
        lineBreak = nil
    }
}

open class LabelElement: Element<UILabel> {
    private var _text: NSAttributedString?
//    private var _lineBreak: NSLineBreakMode?
    private var lines: Int = 1
    private var autoLines: Bool = false
    private var _labelState: LabelElementState?

    public override var pendingState: LabelElementState {
        let state = _labelState ?? LabelElementState()
        if _labelState == nil {
            _labelState = state
            _pendingState = state
        }
        return state
    }

    public override init(children: [BasicElement] = []) {
        super.init(children: children)
        layout.measureSelf = { [weak self] (w, wm, h, hm) in
            LabelElement.measureText(self, width: w, widthMode: wm, height: h, heightMode: hm)
        }
    }

    // MARK: - Configuring a Element’s Visual Appearance
    @discardableResult
    public func numberOfLines(_ value: Int) -> Self {
        lines = value
        if Runner.isMain(), let view = self.view {
            view.numberOfLines = value
        } else {
            pendingState.numberOfLines = value
            registerPendingState()
        }
        layout.markDirty()
        return self
    }

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
    public func multiLine(_ value: Bool = true) -> Self {
        lines = value ? 0 : 1
        autoLines = value
        if Runner.isMain(), let view = self.view {
            view.numberOfLines = lines
        } else {
            pendingState.numberOfLines = lines
            registerPendingState()
        }
        layout.markDirty()
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
    public func lineBreak(_ value: NSLineBreakMode) -> Self {
//        _lineBreak = value
        if Runner.isMain(), let view = self.view {
            view.lineBreakMode = value
        } else {
            pendingState.lineBreak = value
            registerPendingState()
        }
        return self
    }

    static func measureText(_ element: LabelElement?, width: Double, widthMode: MeasureMode,
                            height: Double, heightMode: MeasureMode) -> Size {
        guard let element = element, let text = element._text else {
            return Size.zero
        }
        let w = width.isNaN ? Double.greatestFiniteMagnitude : width
        let h = height.isNaN ? Double.greatestFiniteMagnitude : height
        let size = CGSize(width: w, height: h)
        let options: NSStringDrawingOptions = element.autoLines ? [.usesLineFragmentOrigin] : []
//        if element.autoLines, let mode = element._lineBreak,
//           mode == NSLineBreakMode.byCharWrapping || mode == NSLineBreakMode.byWordWrapping {
//            options.update(with: .truncatesLastVisibleLine)
//        }
        // TODO: Ceil the size, not the cgsize
        var textSize: CGSize = text.boundingSize(size: size, options: options)
        if element.autoLines {
            return Size(cgSize: textSize.ceiled)
        } else {
            // FIXME: multi-line text size
            textSize = textSize.setHeight(textSize.height * CGFloat(element.lines))
            return Size(cgSize: textSize.ceiled)
        }
    }
}
