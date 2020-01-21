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
import CoreGraphics
import QuartzCore

public class ElementState {
    var applyToLayer = false
    // For UIView
    public var bounds: CGRect?
    public var center: CGPoint?
    public var backgroundColor: UIColor??
    public var clips: Bool?
    public var hidden: Bool?
    public var tintColor: UIColor?
    public var interactive: Bool?
    public var alpha: Double?
    public var contentMode: UIView.ContentMode?
    // For CALayer
    public var cornerRadius: CGFloat?
    public var borderColor: CGColor??
    public var borderWidth: CGFloat?
    public var shadowOpacity: Float?
    public var shadowRadius: CGFloat?
    public var shadowOffset: CGSize?
    public var shadowColor: CGColor??
    public var shadowPath: CGPath??

    public var needsDisplay: Bool = false
    public var needsLayout: Bool = false

    public required init() {
        // Do nothing.
    }

    public func apply(view: UIView) {
        assertMainThread()
        if let bounds = self.bounds {
            view.bounds = bounds
        }
        if let center = self.center {
            view.center = center
        }
        if let backgroundColor = self.backgroundColor {
            view.backgroundColor = backgroundColor
        }
        if let clips = self.clips {
            view.clipsToBounds = clips
        }
        if let hidden = self.hidden {
            view.isHidden = hidden
        }
        if let tintColor = self.tintColor {
            view.tintColor = tintColor
        }
        if let interactive = self.interactive {
            view.isUserInteractionEnabled = interactive
        }
        if let alpha = self.alpha {
            view.alpha = CGFloat(alpha)
        }
        if let contentMode = self.contentMode {
            view.contentMode = contentMode
        }
        let layer = view.layer
        if let cornerRadius = self.cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        if let borderColor = self.borderColor {
            layer.borderColor = borderColor
        }
        if let borderWidth = self.borderWidth {
            layer.borderWidth = borderWidth
        }
        if let shadowOpacity = self.shadowOpacity {
            layer.shadowOpacity = shadowOpacity
        }
        if let shadowRadius = self.shadowRadius {
            layer.shadowRadius = shadowRadius
        }
        if let shadowOffset = self.shadowOffset {
            layer.shadowOffset = shadowOffset
        }
        if let shadowColor = self.shadowColor {
            layer.shadowColor = shadowColor
        }
        if let shadowPath = self.shadowPath {
            layer.shadowPath = shadowPath
        }
        if needsDisplay {
            if applyToLayer {
                layer.setNeedsDisplay()
            } else {
                view.setNeedsDisplay()
            }
        }
        invalidate()
    }

    public func apply(layer: CALayer) {
        assertMainThread()
        if let bounds = self.bounds {
            layer.bounds = bounds
        }
        if let center = self.center {
            layer.position = center
        }
        if let backgroundColor = self.backgroundColor {
            layer.backgroundColor = backgroundColor?.cgColor
        }
        if let clips = self.clips {
            layer.masksToBounds = clips
        }
        if let hidden = self.hidden {
            layer.isHidden = hidden
        }
        if let alpha = self.alpha {
            layer.opacity = Float(alpha)
        }
        if let cornerRadius = self.cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        if let borderColor = self.borderColor {
            layer.borderColor = borderColor
        }
        if let borderWidth = self.borderWidth {
            layer.borderWidth = borderWidth
        }
        if let shadowOpacity = self.shadowOpacity {
            layer.shadowOpacity = shadowOpacity
        }
        if let shadowRadius = self.shadowRadius {
            layer.shadowRadius = shadowRadius
        }
        if let shadowOffset = self.shadowOffset {
            layer.shadowOffset = shadowOffset
        }
        if let shadowColor = self.shadowColor {
            layer.shadowColor = shadowColor
        }
        if let shadowPath = self.shadowPath {
            layer.shadowPath = shadowPath
        }
        if needsDisplay {
            layer.setNeedsDisplay()
        }
        invalidate()
    }

    public func invalidate() {
        bounds = nil
        center = nil
        backgroundColor = nil
        clips = nil
        hidden = nil
        tintColor = nil
        interactive = nil
        alpha = nil
        contentMode = nil
        cornerRadius = nil
        borderColor = nil
        borderWidth = nil
        shadowOpacity = nil
        shadowRadius = nil
        shadowOffset = nil
        shadowColor = nil
        shadowPath = nil
        needsDisplay = false
    }
}
#endif // #if os(iOS)
