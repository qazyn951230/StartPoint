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

open class FlexView: UIView {
    public let root: BasicElement = BasicElement(framed: false, children: [])

    open override var bounds: CGRect {
        didSet {
            root.layout.size(bounds.size)
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }

    open func initialization() {
        // Do nothing.
    }

    open func layout() {
        root.layout()
        root.build(in: self)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        root.layout(width: Double(size.width), height: Double(size.height))
        return root._frame.cgSize
    }
}

open class BasicAlertView: FlexView {
    open override func initialization() {
        frame = CGRect(origin: .zero, size: Device.size)
        root.layout.size(Device.size).alignItems(.center).justifyContent(.center)
        backgroundColor = UIColor.hex(0x04040F, alpha: 0.4)
    }

    public func show(in view: UIView, animated: Bool = true) {
        if animated {
            alpha = 0
            view.addSubview(self)
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.alpha = 1
            }
        } else {
            view.addSubview(self)
        }
    }

    public func show(inWindow view: UIView, animated: Bool = true) {
        guard let window = view.window else {
            return
        }
        show(in: window, animated: animated)
    }

    public func show(in controller: UIViewController, animated: Bool = true) {
        show(in: controller.view, animated: animated)
    }

    public func dismiss(animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.alpha = 0
            }, completion: { [weak self] _ in
                self?.removeFromSuperview()
            })
        } else {
            removeFromSuperview()
        }
    }

//    public enum Animator {
//        case `default`
//    }
//
//    public enum ScrimStyle {
//        case `default`
//        case transparent
//    }
}

public final class AlertView: BasicAlertView {
    var content: BasicElement = BasicElement()
//    let content: Element<UIVisualEffectView> = {
//        let element = Element<UIVisualEffectView>()
//        element.creator = {
//            let effect: UIBlurEffect
//            if #available(iOS 10.0, *) {
//                effect = UIBlurEffect(style: .regular)
//            } else {
//                effect = UIBlurEffect(style: .light)
//            }
//            return UIVisualEffectView(effect: effect)
//        }
//        return element
//    }()
    var buttons: BasicElement?

    public override func initialization() {
        super.initialization()
        let effect = UIBlurEffect(style: .light)
        let _content = VisualEffectElement(effect: effect)
            .cornerRadius(14)
            .backgroundColor(UIColor(white: 1.0, alpha: 0.8))
            .style { flex in
                flex.width(.percentage(0.72)).minWidth(float: 250)
                    .alignItems(.center)
            }
        root.addChild(_content)
        content = _content
    }

    @discardableResult
    public func title(_ value: NSAttributedString) -> AlertView {
        content.layout.padding(top: 19)
        let label = LabelElement().text(value).multiLine()
            .textAlignment(.center)
            .style { flex in
                flex.margin(horizontal: 16)
            }
        content.addChild(label)
        return self
    }

    @discardableResult
    public func title(_ value: String) -> AlertView {
        let text = AttributedString(value).color(UIColor.black)
            .systemFont(17, weight: .semibold).done()
        return title(text)
    }

    @discardableResult
    public func text(_ value: NSAttributedString) -> AlertView {
        content.layout.padding(top: 19)
        let label = LabelElement().text(value).multiLine()
            .textAlignment(.center)
            .style { flex in
                flex.margin(horizontal: 16).margin(top: 1)
            }
        content.addChild(label)
        return self
    }

    @discardableResult
    public func text(_ value: String) -> AlertView {
        let _text = AttributedString(value).color(UIColor.black)
            .systemFont(13).done()
        return text(_text)
    }

    @discardableResult
    public func action(_ value: NSAttributedString) -> AlertView {
        let button = ButtonElement().title(value)
        return addButton(button)
    }

    @discardableResult
    func addButton(_ value: ButtonElement) -> AlertView {
        value.layout.flex(1).height(float: 44)
        buttonsElement().addChild(value)
        return self
    }

    func buttonsElement() -> BasicElement {
        if let element = buttons {
            return element
        }
        let line = LayerElement()
            .backgroundColor(hex: 0xdbdbdb)
            .style { flex in
                flex.height(float: 1).width(.match)
            }
        let element = BasicElement().style { flex in
            flex.flexDirection(.row).width(.match)
        }
        buttons = element

        let footer = BasicElement(children: [line, element]).style { flex in
            flex.margin(top: 18).width(.match)
        }
        content.addChild(footer)
        return element
    }

//    public enum Style {
//        case `default`
//        case material
//    }
}