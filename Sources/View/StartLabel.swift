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

public final class StartLabel: UIView, AsyncLayerDelegate {
    public var text: NSAttributedString? {
        get {
            return textStorage
        }
        set {
            let new = newValue ?? NSAttributedString()
            textStorage.setAttributedString(new)
        }
    }
    let textStorage = NSTextStorage()
    let layoutManager = NSLayoutManager()
    let textContainer: NSTextContainer

    public override convenience init(frame: CGRect) {
        self.init(frame: frame, textContainer: nil)
    }

    public init(frame: CGRect, textContainer: NSTextContainer?) {
        self.textContainer = textContainer ?? NSTextContainer()
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        textContainer = NSTextContainer()
        super.init(coder: aDecoder)
        initialization()
    }

    func initialization() {
        let foo = AttributedString("foobar").color(UIColor.red)
            .systemFont(17).done()
        textStorage.setAttributedString(foo)
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
    }

//    public override func display(_ layer: CALayer) {
//        super.display(layer)
//    }
//
//    public override func draw(_ layer: CALayer, in ctx: CGContext) {
//        super.draw(layer, in: ctx)
//    }
//
//    @available(iOS 10.0, *)
//    public override func layerWillDraw(_ layer: CALayer) {
//        super.layerWillDraw(layer)
//    }
//
//    public override func layoutSublayers(of layer: CALayer) {
//        super.layoutSublayers(of: layer)
//    }

//    public override func action(for layer: CALayer, forKey event: String) -> CAAction? {
//        return super.action(for: layer, forKey: event)
//    }

    // AsyncLayerDelegate
    public func asyncLayer(_ layer: AsyncLayer, display asynchronous: Bool) {
//        UIGraphicsBeginImageContextWithOptions(bounds.size, layer.isOpaque, layer.contentsScale)
        UIGraphicsBeginImageContextWithOptions(CGSize(200, 200), layer.isOpaque, layer.contentsScale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.saveGState()
        let foo = AttributedString("foobar").color(UIColor.red)
            .systemFont(34).done()
        foo.draw(at: bounds.origin)
        context.restoreGState()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        layer.contents = image?.cgImage
    }

    public override class var layerClass: AnyClass {
        return AsyncLayer.self
    }
}
