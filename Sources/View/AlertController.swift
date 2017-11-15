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
import RxSwift

public protocol AlertAction {
    var title: String { get }
}

extension String: AlertAction {
    public var title: String {
        return self
    }
}

public class AlertController<Action:AlertAction> {
    let style: UIAlertControllerStyle
    var title: String? = nil
    var message: String? = nil
    var actions: [Action]? = nil
    var cancelAction: AlertAction? = nil
    var destructiveAction: Action? = nil

    var ignoreCancel: Bool = true

    public init(style: UIAlertControllerStyle = .alert) {
        self.style = style
    }

    public func title(_ value: String) -> AlertController {
        self.title = value
        return self
    }

    public func message(_ value: String) -> AlertController {
        self.message = value
        return self
    }

    public func actions(_ value: Action...) -> AlertController {
        self.actions = value
        return self
    }

    public func appendAction(_ value: Action) -> AlertController {
        actions = actions ?? []
        actions?.append(value)
        return self
    }

    public func cancelAction(_ value: AlertAction) -> AlertController {
        self.cancelAction = value
        return self
    }

    public func ignoreCancel(_ value: Bool) -> AlertController {
        self.ignoreCancel = value
        return self
    }

    public func destructiveAction(_ value: Action) -> AlertController {
        self.destructiveAction = value
        return self
    }

    public func show(in viewController: UIViewController) -> Observable<Action> {
        return AlertController.show(alert: self, in: viewController)
    }

    private static func show(alert: AlertController, in viewController: UIViewController) -> Observable<Action> {
        return Observable<Action>.create { observer in
            let controller = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
            if let actions = alert.actions {
                for action in actions {
                    let t = UIAlertAction(title: action.title, style: .default) { _ in
                        observer.on(.next(action))
                        observer.on(.completed)
                    }
                    controller.addAction(t)
                }
            }
            if !alert.ignoreCancel, let cancel = alert.cancelAction as? Action {
                let t = UIAlertAction(title: cancel.title, style: .cancel) { _ in
                    observer.on(.next(cancel))
                    observer.on(.completed)
                }
                controller.addAction(t)
            } else if let cancel = alert.cancelAction {
                let t = UIAlertAction(title: cancel.title, style: .cancel) { _ in
                    observer.on(.completed)
                }
                controller.addAction(t)
            }
            if let destructive = alert.destructiveAction {
                let t = UIAlertAction(title: destructive.title, style: .destructive) { _ in
                    observer.on(.next(destructive))
                    observer.on(.completed)
                }
                controller.addAction(t)
            }
            viewController.present(controller, animated: true)
            return Disposables.create {
                controller.dismiss(animated: false)
            }
        }
    }
}


