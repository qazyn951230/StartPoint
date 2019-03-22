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

public final class LabelElement: Element<UILabel>, BinderText {
    var _rawText: String?
    var _text: NSAttributedString?
    var _attributes: [NSAttributedString.Key: Any]?
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

    public var text: Binder<String?>? {
        assertMainThread()
        return view?.rx.text
    }

    public var attributedText: Binder<NSAttributedString?>? {
        assertMainThread()
        return view?.rx.attributedText
    }

    public override init(children: [BasicElement] = []) {
        super.init(children: children)
        layout.measureSelf = { [weak self] (w, wm, h, hm) in
            LabelElement.measureText(self, width: w, widthMode: wm, height: h, heightMode: hm)
        }
    }

    // MARK: - Observing Element-Related Changes
    public func bind<T>(target: T, source method: @escaping (T) -> (LabelElement) -> Void) where T: AnyObject {
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
        if Runner.isMain(), let view = self.view {
            view.lineBreakMode = value
        } else {
            pendingState.lineBreak = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func attributes(_ value: [NSAttributedString.Key: Any], text: String?) -> Self {
        _attributes = value
        _rawText = text
        if let _text = text {
            return self.text(NSAttributedString(string: _text, attributes: value))
        } else {
            return self.text(nil)
        }
    }

    // BinderText
    public func text(from object: Driver<String>) -> Disposable? {
        assertMainThread()
        if let map = _attributes, let _text = attributedText {
            return object.map { (v: String) in
                return NSAttributedString(string: v, attributes: map)
            }.drive(_text)
        } else if let _text2 = text {
            return object.drive(_text2)
        }
        return nil
    }

    public func text(any object: Driver<String?>) -> Disposable? {
        assertMainThread()
        if let map = _attributes, let _text = attributedText {
            return object.map { (v: String?) -> NSAttributedString? in
                if let t = v {
                    return NSAttributedString(string: t, attributes: map)
                }
                return nil
            }.drive(_text)
        } else if let _text2 = text {
            return object.drive(_text2)
        }
        return nil
    }

    public func text(from object: Observable<String>) -> Disposable? {
        assertMainThread()
        if let map = _attributes, let _text = attributedText {
            return object.map { (v: String) in
                return NSAttributedString(string: v, attributes: map)
            }.bind(to: _text)
        } else if let _text2 = text {
            return object.bind(to: _text2)
        }
        return nil
    }

    public func text(any object: Observable<String?>) -> Disposable? {
        assertMainThread()
        if let map = _attributes, let _text = attributedText {
            return object.map { (v: String?) -> NSAttributedString? in
                if let t = v {
                    return NSAttributedString(string: t, attributes: map)
                }
                return nil
            }.bind(to: _text)
        } else if let _text2 = text {
            return object.bind(to: _text2)
        }
        return nil
    }

    static func measureText(_ element: LabelElement?, width: Double, widthMode: MeasureMode,
                            height: Double, heightMode: MeasureMode) -> Size {
        guard let element = element else {
            return Size.zero
        }
        let text = element._text ?? NSAttributedString(string: element._rawText ?? "永",
            attributes: element._attributes)
        let w = width.isNaN ? Double.greatestFiniteMagnitude : width
        let h = height.isNaN ? Double.greatestFiniteMagnitude : height
        let size = CGSize(width: w, height: h)
        let options: NSStringDrawingOptions = element.autoLines ? [.usesLineFragmentOrigin] : []
        var textSize: CGSize = text.boundingSize(size: size, options: options)
        if element.autoLines {
            return Size(cgSize: textSize.ceiled)
        } else {
            textSize = textSize.setHeight(textSize.height * CGFloat(element.lines))
            return Size(cgSize: textSize.ceiled)
        }
    }
}

public final class LayoutManager: NSLayoutManager {
    public override func showCGGlyphs(_ glyphs: UnsafePointer<CGGlyph>, positions: UnsafePointer<CGPoint>,
                                      count glyphCount: Int, font: UIFont, matrix textMatrix: CGAffineTransform,
                                      attributes: [NSAttributedString.Key: Any], in graphicsContext: CGContext) {
        // Force foreground color for NSAttributedString.Key.link
        if let color = attributes[NSAttributedString.Key.foregroundColor] as? UIColor {
            graphicsContext.setFillColor(color.cgColor)
        }
        super.showCGGlyphs(glyphs, positions: positions, count: glyphCount, font: font,
            matrix: textMatrix, attributes: attributes, in: graphicsContext)
    }
}

public final class AsyncLabelElement: Element<AsyncLabel>, AsyncLabelDelegate {
    var _text: NSTextStorage?
    let layoutManager: LayoutManager
    let textContainer: NSTextContainer

    public override var pendingState: ElementState {
        let state = _pendingState ?? ElementState()
        state.applyToLayer = true
        if _pendingState == nil {
            _pendingState = state
        }
        return state
    }

    public override init(children: [BasicElement] = []) {
        layoutManager = LayoutManager()
#if os(macOS)
        layoutManager.backgroundLayoutEnabled = false
#endif
        textContainer = NSTextContainer()
        textContainer.lineFragmentPadding = 0
        layoutManager.addTextContainer(textContainer)
        super.init(children: children)
        layout.measureSelf = { [weak self] (w, wm, h, hm) in
            AsyncLabelElement.measureText(self, width: w, widthMode: wm, height: h, heightMode: hm)
        }
    }

    override func createView() -> AsyncLabel {
        let view = AsyncLabel(frame: CGRect.zero)
        view.layoutManager = layoutManager
        view.textContainer = textContainer
        return view
    }

    override func calculateFrame(left: Double, top: Double, apply: Bool) {
        super.calculateFrame(left: left, top: top, apply: apply)
        textContainer.size = _frame.cgSize
        layoutManager.ensureLayout(for: textContainer)
    }

    override func applyState(to view: AsyncLabel) {
        super.applyState(to: view)
        view.delegate = self
        view.text = _text
    }

    public func asyncLabel(_ label: AsyncLabel, didSelectURL url: URL, at range: NSRange) {
        Log.debug(url, range)
    }

    // MARK: - Configuring a Element’s Visual Appearance
    @discardableResult
    public func numberOfLines(_ value: Int) -> Self {
        textContainer.maximumNumberOfLines = value
        if Runner.isMain(), let view = self.view {
            view.setNeedsDisplay()
        } else {
            pendingState.needsDisplay = true
            registerPendingState()
        }
        layout.markDirty()
        return self
    }

    @discardableResult
    public func text(_ value: NSAttributedString?) -> Self {
        _text = value.map(NSTextStorage.init(attributedString:))
        _text?.addLayoutManager(layoutManager)
        if Runner.isMain(), let view = self.view {
            view.text = _text
            view.setNeedsDisplay()
        } else {
            pendingState.needsDisplay = true
            registerPendingState()
        }
        layout.markDirty()
        return self
    }

    @discardableResult
    public func multiLine(_ value: Bool = true) -> Self {
        textContainer.maximumNumberOfLines = value ? 0 : 1 // no limits
        if Runner.isMain(), let view = self.view {
            view.setNeedsDisplay()
        } else {
            pendingState.needsDisplay = true
            registerPendingState()
        }
        layout.markDirty()
        return self
    }

//    @discardableResult
//    public func textAlignment(_ value: NSTextAlignment) -> Self {
//        if Runner.isMain(), let view = self.view {
//            view.setNeedsDisplay()
//        } else {
//            pendingState.textAlignment = value
//            registerPendingState()
//        }
//        return self
//    }

    @discardableResult
    public func lineBreak(_ value: NSLineBreakMode) -> Self {
        textContainer.lineBreakMode = value
        if Runner.isMain(), let view = self.view {
            view.setNeedsDisplay()
        } else {
            pendingState.needsDisplay = true
            registerPendingState()
        }
        layout.markDirty()
        return self
    }

    static func measureText(_ element: AsyncLabelElement?, width: Double, widthMode: MeasureMode,
                            height: Double, heightMode: MeasureMode) -> Size {
        guard let element = element else {
            return Size.zero
        }
        let layoutManager = element.layoutManager
        let textContainer = element.textContainer
        let size = CGSize(width: width.isNaN ? CGFloat.greatestFiniteMagnitude : CGFloat(width),
            height: height.isNaN ? CGFloat.greatestFiniteMagnitude : CGFloat(height))
        textContainer.size = size
        layoutManager.ensureLayout(for: textContainer)
        let rect = layoutManager.usedRect(for: textContainer)
        Log.debug(size, rect)
        return Size(cgSize: rect.size).ceiled
    }
}
