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

public typealias LabelElement = BasicLabelElement<UILabel>

open class BasicLabelElement<Label: UILabel>: Element<Label> {
    var text: NSAttributedString?
    var lines: Int = 1
    var autoLines: Bool = false

    var _labelState: LabelElementState?
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
        layout.measureSelf = measure
    }

    public override init(children: [BasicElement], creator: @escaping () -> Label) {
        super.init(children: children, creator: creator)
        layout.measureSelf = measure
    }

    func measure(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
        guard let text = text else {
            return Size.zero
        }
        let w = width.isNaN ? Double.greatestFiniteMagnitude : width
        let h = height.isNaN ? Double.greatestFiniteMagnitude : height
        let size = CGSize(width: w, height: h)
        let options: NSStringDrawingOptions = autoLines ? [.usesLineFragmentOrigin] : []
        // TODO: Ceil the size, not the cgsize
        var textSize: CGSize = text.boundingSize(size: size, options: options)
        if autoLines {
            return Size(cgSize: textSize.ceiled)
        } else {
            // FIXME: multi-line text size
            textSize = textSize.setHeight(textSize.height * CGFloat(lines))
            return Size(cgSize: textSize.ceiled)
        }
    }

    @discardableResult
    public func numberOfLines(_ value: Int) -> Self {
        lines = value
        if mainThread(), let view = view {
            view.numberOfLines = value
        } else {
            pendingState.numberOfLines = value
        }
        layout.markDirty()
        return self
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
    public func multiLine(_ value: Bool = true) -> Self {
        lines = value ? 0 : 1
        autoLines = value
        if mainThread(), let view = view {
            view.numberOfLines = lines
        } else {
            pendingState.numberOfLines = lines
        }
        layout.markDirty()
        return self
    }
}
