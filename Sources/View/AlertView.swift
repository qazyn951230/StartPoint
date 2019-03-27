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

open class BasicAlertView: Hashable {
    public var view: UIView?
    public let root: BasicElement

    public init() {
        root = BasicElement().style { flex in
            flex.size(Device.size).alignItems(.center).justifyContent(.center)
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(address(of: self))
    }

    open func buildView() {
        // Do nothing.
    }

    // For FP
    public func show() {
        show(animated: true)
    }

    public func show(animated: Bool) {
        if view == nil {
            buildView()
        }
        guard let view = view else {
            return
        }
        let window = BasicAlertView.alertWindow()
        window.makeKeyAndVisible()
        BasicAlertView.alerts.append(self)
        if animated {
            view.alpha = 0
            window.addSubview(view)
            UIView.animate(withDuration: 0.3) {
                view.alpha = 1
            }
        } else {
            window.addSubview(view)
        }
    }

    // For FP
    public func dismiss() {
        dismiss(animated: true)
    }

    public func dismiss(animated: Bool) {
        guard let view = view else {
            return
        }
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0
            }, completion: { _ in
                view.removeFromSuperview()
                if BasicAlertView.window?.subviews.count < 1 {
                    BasicAlertView.window = nil
                    BasicAlertView.alerts.removeAll()
                }
            })
        } else {
            view.removeFromSuperview()
            if BasicAlertView.window?.subviews.count < 1 {
                BasicAlertView.window = nil
                BasicAlertView.alerts.removeAll()
            }
        }
        if let index = BasicAlertView.alerts.firstIndex(of: self) {
            BasicAlertView.alerts.remove(at: index)
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

    public private(set) static var window: UIWindow?
    private static var alerts: [BasicAlertView] = []

    public static func alertWindow() -> UIWindow {
        if let old = window {
            return old
        }
        let new = UIWindow(frame: UIScreen.main.bounds)
        new.windowLevel = UIWindow.Level.alert
        new.backgroundColor = UIColor.hex(0x04040F, alpha: 0.4)
        window = new
        return new
    }

    public static func ==(lhs: BasicAlertView, rhs: BasicAlertView) -> Bool {
        return lhs === rhs
    }
}

public final class StartAlertView: BasicAlertView {
    let content: VisualEffectElement = {
        let effect = UIBlurEffect(style: .light)
        return VisualEffectElement(effect: effect)
            .cornerRadius(14)
            .backgroundColor(UIColor(white: 1.0, alpha: 0.8))
            .style { flex in
                flex.width(.percentage(72)).minWidth(float: 250)
                    .alignItems(.center)
            }
    }()
//    let content: Element<UIView> = {
//        return Element<UIView>()
//            .cornerRadius(14)
//            .backgroundColor(UIColor(white: 1.0, alpha: 0.8))
//            .style { flex in
//                flex.width(.percentage(72)).minWidth(float: 250)
//                    .alignItems(.center)
//            }
//    }()
    var buttons: BasicElement?

    public override init() {
        super.init()
        root.addChild(content)
    }

    public override func buildView() {
        root.layout()
        view = content.buildView()
    }

    @discardableResult
    public func title(_ value: NSAttributedString) -> StartAlertView {
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
    public func title(_ value: String) -> StartAlertView {
        let text = AttributedString(value).color(UIColor.black)
            .systemFont(17, weight: .semibold).done()
        return title(text)
    }

    @discardableResult
    public func text(_ value: NSAttributedString) -> StartAlertView {
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
    public func text(_ value: String) -> StartAlertView {
        let _text = AttributedString(value).color(UIColor.black)
            .systemFont(13).done()
        return text(_text)
    }

    @discardableResult
    public func action(_ value: NSAttributedString) -> StartAlertView {
        let button = ButtonElement().title(value)
        return self.button(button)
    }

    @discardableResult
    public func button(_ value: ButtonElement) -> StartAlertView {
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
