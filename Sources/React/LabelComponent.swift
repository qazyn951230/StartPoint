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

public typealias LabelComponent = BasicLabelComponent<UILabel>

public class BasicLabelComponent<Label: UILabel>: Component<Label> {
    var text: NSAttributedString?
    var lines: Int = 0

    var _labelState: LabelComponentState?
    public override var pendingState: LabelComponentState {
        let state = _labelState ?? LabelComponentState()
        if _labelState == nil {
            _labelState = state
            _pendingState = state
        }
        return state
    }

    public override init(children: [BasicComponent] = []) {
        super.init(children: children)
        layout.measureSelf = measure
    }

    public override init(children: [BasicComponent], creator: @escaping () -> Label) {
        super.init(children: children, creator: creator)
        layout.measureSelf = measure
    }

    func measure(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
        if let text = text {
            let size = CGSize(width: width, height: height)
            let options: NSStringDrawingOptions = lines < 1 ? [.usesLineFragmentOrigin] : []
            // TODO: Ceil the size, not the cgsize
            return Size(cgSize: text.boundingSize(size: size, options: options).ceiled)
        }
        return Size.zero
    }

    @discardableResult
    public func numberOfLines(_ value: Int) -> Self {
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
    public func text(string: String?, font: UIFont? = nil, color: UIColor = UIColor.black) -> Self {
        let value = AttributedString.create(string)?.color(color)
            .font(font ?? UIFont.systemFont(ofSize: 17)).done()
        return text(value)
    }

    @discardableResult
    public func text(string: String?, size: CGFloat, color: UIColor = UIColor.black) -> Self {
        let value = AttributedString.create(string)?.color(color)
            .font(UIFont.systemFont(ofSize: size)).done()
        return text(value)
    }

    @discardableResult
    public func multiLine(_ value: Bool = true) -> Self {
        lines = value ? 0 : 1
        if mainThread(), let view = view {
            view.numberOfLines = lines
        } else {
            pendingState.numberOfLines = lines
        }
        layout.markDirty()
        return self
    }
}
