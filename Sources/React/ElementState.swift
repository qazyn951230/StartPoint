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
import CoreGraphics
import QuartzCore

public protocol ElementProperty {
    // UIView
    var frame: CGRect { get }
    var backgroundColor: UIColor? { get }
    var clips: Bool { get }
    var hidden: Bool { get }
    var tintColor: UIColor { get }
    var userInteractionEnabled: Bool { get }
    // CALayer
    var cornerRadius: CGFloat { get }
    var borderColor: CGColor? { get }
    var borderWidth: CGFloat { get }
    var shadowOpacity: Float { get }
    var shadowRadius: CGFloat { get }
    var shadowOffset: CGSize { get }
    var shadowColor: CGColor? { get }
    var shadowPath: CGPath? { get }
}

open class ElementState: ElementProperty {
    public var frame: CGRect {
        get {
            return _frame ?? CGRect.zero
        }
        set {
            _frame = newValue
        }
    }
    var _frame: CGRect?

    public var backgroundColor: UIColor? {
        get {
            return _backgroundColor ?? nil
        }
        set {
            _backgroundColor = newValue
        }
    }
    var _backgroundColor: UIColor??

    public var clips: Bool {
        get {
            return _clips ?? false
        }
        set {
            _clips = newValue
        }
    }
    var _clips: Bool?

    public var hidden: Bool {
        get {
            return _hidden ?? false
        }
        set {
            _hidden = newValue
        }
    }
    var _hidden: Bool?

    public var tintColor: UIColor {
        get {
            return _tintColor ?? UIView().tintColor ?? UIColor.white
        }
        set {
            _tintColor = newValue
        }
    }
    var _tintColor: UIColor?

    public var userInteractionEnabled: Bool {
        get {
            return _userInteractionEnabled ?? true
        }
        set {
            _userInteractionEnabled = newValue
        }
    }
    var _userInteractionEnabled: Bool?

    // MARK: Layer properties
    public var cornerRadius: CGFloat {
        get {
            return _cornerRadius ?? 0
        }
        set {
            _cornerRadius = newValue
        }
    }
    var _cornerRadius: CGFloat?

    public var borderColor: CGColor? {
        get {
            return _borderColor ?? nil
        }
        set {
            _borderColor = newValue
        }
    }
    var _borderColor: CGColor??

    public var borderWidth: CGFloat {
        get {
            return _borderWidth ?? 0
        }
        set {
            _borderWidth = newValue
        }
    }
    var _borderWidth: CGFloat?

    public var shadowOpacity: Float {
        get {
            return _shadowOpacity ?? 0
        }
        set {
            _shadowOpacity = newValue
        }
    }
    var _shadowOpacity: Float?

    public var shadowRadius: CGFloat {
        get {
            return _shadowRadius ?? 0
        }
        set {
            _shadowRadius = newValue
        }
    }
    var _shadowRadius: CGFloat?

    public var shadowOffset: CGSize {
        get {
            return _shadowOffset ?? CGSize.zero
        }
        set {
            _shadowOffset = newValue
        }
    }
    var _shadowOffset: CGSize?

    public var shadowColor: CGColor? {
        get {
            return _shadowColor ?? nil
        }
        set {
            _shadowColor = newValue
        }
    }
    var _shadowColor: CGColor??

    public var shadowPath: CGPath? {
        get {
            return _shadowPath ?? nil
        }
        set {
            _shadowPath = newValue
        }
    }
    var _shadowPath: CGPath??

    public required init() {
        // Do nothing.
    }

    open func apply(view: UIView) {
        assertMainThread()
        let layer = view.layer
        if let frame = _frame {
            view.frame = frame
        }
        if let backgroundColor = _backgroundColor {
            view.backgroundColor = backgroundColor
        }
        if let clips = _clips {
            view.clipsToBounds = clips
        }
        if let hidden = _hidden {
            view.isHidden = hidden
        }
        if let tintColor = _tintColor {
            view.tintColor = tintColor
        }
        if let cornerRadius = _cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        if let borderColor = _borderColor {
            layer.borderColor = borderColor
        }
        if let borderWidth = _borderWidth {
            layer.borderWidth = borderWidth
        }
        if let shadowOpacity = _shadowOpacity {
            layer.shadowOpacity = shadowOpacity
        }
        if let shadowRadius = _shadowRadius {
            layer.shadowRadius = shadowRadius
        }
        if let shadowOffset = _shadowOffset {
            layer.shadowOffset = shadowOffset
        }
        if let shadowColor = _shadowColor {
            layer.shadowColor = shadowColor
        }
        if let shadowPath = _shadowPath {
            layer.shadowPath = shadowPath
        }
        invalidate()
    }

    open func apply(layer: CALayer) {
        assertMainThread()
        if let frame = _frame {
            layer.frame = frame
        }
        if let backgroundColor = _backgroundColor {
            layer.backgroundColor = backgroundColor?.cgColor
        }
        if let clips = _clips {
            layer.masksToBounds = clips
        }
        if let hidden = _hidden {
            layer.isHidden = hidden
        }
        if let cornerRadius = _cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        if let borderColor = _borderColor {
            layer.borderColor = borderColor
        }
        if let borderWidth = _borderWidth {
            layer.borderWidth = borderWidth
        }
        if let shadowOpacity = _shadowOpacity {
            layer.shadowOpacity = shadowOpacity
        }
        if let shadowRadius = _shadowRadius {
            layer.shadowRadius = shadowRadius
        }
        if let shadowOffset = _shadowOffset {
            layer.shadowOffset = shadowOffset
        }
        if let shadowColor = _shadowColor {
            layer.shadowColor = shadowColor
        }
        if let shadowPath = _shadowPath {
            layer.shadowPath = shadowPath
        }
        invalidate()
    }

    open func invalidate() {
        _frame = nil
        _backgroundColor = nil
        _clips = nil
        _hidden = nil
        _tintColor = nil
        _userInteractionEnabled = nil

        _cornerRadius = nil
        _borderColor = nil
        _borderWidth = nil
        _shadowOpacity = nil
        _shadowRadius = nil
        _shadowOffset = nil
        _shadowColor = nil
        _shadowPath = nil
    }
}

open class LabelElementState: ElementState {
    public var text: NSAttributedString? {
        get {
            return _text ?? nil
        }
        set {
            _text = newValue
        }
    }
    var _text: NSAttributedString??

    public var numberOfLines: Int {
        get {
            return _numberOfLines ?? 1
        }
        set {
            _numberOfLines = newValue
        }
    }
    var _numberOfLines: Int?

    open override func apply(view: UIView) {
        if let label = view as? UILabel {
            apply(label: label)
        } else {
            super.apply(view: view)
        }
    }

    open func apply(label: UILabel) {
        if let text = _text {
            label.attributedText = text
        }
        if let numberOfLines = _numberOfLines {
            label.numberOfLines = numberOfLines
        }
        super.apply(view: label)
    }

    open override func invalidate() {
        _text = nil
        _numberOfLines = nil
        super.invalidate()
    }
}

open class ImageElementState: ElementState {
    public var image: UIImage? {
        get {
            return _image ?? nil
        }
        set {
            _image = newValue
        }
    }
    var _image: UIImage??

    public var highlightedImage: UIImage? {
        get {
            return _highlightedImage ?? nil
        }
        set {
            _highlightedImage = newValue
        }
    }
    var _highlightedImage: UIImage??

    public override var userInteractionEnabled: Bool {
        get {
            return _userInteractionEnabled ?? false
        }
        set {
            _userInteractionEnabled = newValue
        }
    }

    open override func apply(view: UIView) {
        if let imageView = view as? UIImageView {
            apply(imageView: imageView)
        } else {
            super.apply(view: view)
        }
    }

    open func apply(imageView: UIImageView) {
        if let image = _image {
            imageView.image = image
        }
        if let highlightedImage = _highlightedImage {
            imageView.highlightedImage = highlightedImage
        }
        super.apply(view: imageView)
    }

    open override func invalidate() {
        _image = nil
        _highlightedImage = nil
        super.invalidate()
    }
}

extension UIControlState: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }

    public static func ==(lhs: UIControlState, rhs: UIControlState) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}