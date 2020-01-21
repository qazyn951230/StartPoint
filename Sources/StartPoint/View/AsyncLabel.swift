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

final class AsyncLabelTask: AsyncLayerTask {
    let layer: AsyncLayer
    let layoutManager: NSLayoutManager?
    let textContainer: NSTextContainer?

    let backgroundColor: UIColor?
    let bounds: CGRect
    let contentScale: CGFloat
    let insets: UIEdgeInsets
    let opaque: Bool

    init(layer: AsyncLayer, view: AsyncLabel) {
        self.layer = layer
        layoutManager = view.layoutManager
        textContainer = view.textContainer
        backgroundColor = view.backgroundColor
        bounds = view.bounds
        insets = UIEdgeInsets.zero
        contentScale = layer.contentsScale
        opaque = layer.isOpaque
    }

    func display(cancelled: () -> Bool) -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: bounds.size)
            return renderer.image { _ in
                self.drawContent()
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, contentScale)
            defer {
                UIGraphicsEndImageContext()
            }
            drawContent()
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    }

    private func drawContent() {
        guard let layoutManager = self.layoutManager, let textContainer = self.textContainer else {
            return
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            assertFail("This is no good without a context.")
            return
        }
        context.saveGState()
        context.translateBy(x: insets.left, y: insets.top)
        if let backgroundColor = self.backgroundColor {
            backgroundColor.setFill()
            UIRectFill(bounds)
        }
        let range = layoutManager.glyphRange(for: textContainer)
        let origin = CGPoint(x: insets.left, y: insets.right)
        layoutManager.drawBackground(forGlyphRange: range, at: origin)
        layoutManager.drawGlyphs(forGlyphRange: range, at: origin)
        context.restoreGState()
    }
}

public protocol AsyncLabelDelegate: class {
    func asyncLabel(_ label: AsyncLabel, didSelectURL url: URL, at range: NSRange)
}

public final class AsyncLabel: UIView, AsyncLayerDelegate {
    var layoutManager: LayoutManager?
    var textContainer: NSTextContainer?
    var text: NSAttributedString?

    weak var delegate: AsyncLabelDelegate? {
        didSet {
            isUserInteractionEnabled = isUserInteractionEnabled || delegate != nil
        }
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if delegate != nil {
            return
        }
        super.touchesBegan(touches, with: event)
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if delegate != nil {
            return
        }
        super.touchesMoved(touches, with: event)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let delegate = self.delegate, let point = touchPoint(for: touches) {
            let (url, range) = touchURL(at: point)
            guard let url2 = url else {
                return
            }
            Runner.main { [weak self] in
                guard let this = self else {
                    return
                }
                delegate.asyncLabel(this, didSelectURL: url2, at: range)
            }
            return
        }
        super.touchesEnded(touches, with: event)
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if delegate != nil {
            return
        }
        super.touchesCancelled(touches, with: event)
    }

//    @available(iOS 9.1, *)
//    public override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
//        super.touchesEstimatedPropertiesUpdated(touches)
//    }

    private func touchPoint(for touches: Set<UITouch>) -> CGPoint? {
        guard let touch = touches.first else {
            return nil
        }
        return touch.location(in: self)
    }

    private func touchURL(at point: CGPoint) -> (URL?, NSRange) {
        guard let layoutManager = self.layoutManager, let textContainer = self.textContainer,
              let text = self.text else {
            return (nil, NSRange(location: 0, length: 0))
        }
        let range = NSRange(location: 0, length: text.length)
        var url: URL?
        var range2 = NSRange(location: 0, length: 0)
        text.enumerateAttribute(NSAttributedString.Key.link, in: range) {
            (value: Any?, textRange: NSRange, stop: UnsafeMutablePointer<ObjCBool>) in
            let rect = layoutManager.boundingRect(forGlyphRange: textRange, in: textContainer)
            if rect.contains(point) {
                url = value as? URL
                range2 = textRange
                stop.pointee = ObjCBool(true)
            }
        }
        Log.debug(range, range2, text.attributedSubstring(from: range2).string)
        return (url, range2)
    }

    // AsyncLayerDelegate
    public func asyncLayerDisplayTask(for layer: AsyncLayer) -> AsyncLayerTask {
        return AsyncLabelTask(layer: layer, view: self)
    }

    public override class var layerClass: AnyClass {
        return AsyncLayer.self
    }
}
#endif
