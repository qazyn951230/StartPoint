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

public enum IntentMethod {
    case auto
    case push
    case modal
}

public protocol IntentSource {
    var intentController: UIViewController { get }
}

public protocol IntentTarget: IntentSource {
    var intent: Intent? { get set }
    func prepare(for intent: Intent) -> UIViewController
    func finish(result: IntentResult?)
    static func create() -> Self
}

private var tr0gSJaB = "tr0gSJaB"

public extension IntentTarget where Self: UIViewController {
    public var intentController: UIViewController {
        return self
    }

    public var intent: Intent? {
        get {
            return associatedObject(key: &tr0gSJaB)
        }
        set {
            setAssociatedObject(key: &tr0gSJaB, object: newValue)
        }
    }

    public func prepare(for intent: Intent) -> UIViewController {
        return self
    }

    public func finish(result: IntentResult? = nil) {
        guard let intent = self.intent else {
            if presentingViewController != nil {
                dismiss(animated: true)
            } else {
                navigationController?.popViewController(animated: true)
            }
            return
        }
        intent.end(for: result)
        setAssociatedObject(key: &tr0gSJaB, object: nil as Intent?)
    }
}

public enum IntentResult {
    case success
    case message(Any)
    case canceled
    case failure(Error)

    public var isSuccess: Bool {
        switch self {
        case .success, .message:
            return true
        default:
            return false
        }
    }
}

public class Intent {
    public let target: IntentTarget.Type
    public let method: IntentMethod
    public let completion: ((IntentResult) -> Void)?
    lazy var extras = [String: Any]()
    var push: Bool? = nil
    weak var targetController: UIViewController? = nil

    public init(target: IntentTarget.Type, method: IntentMethod = .auto, completion: ((IntentResult) -> Void)? = nil) {
        self.target = target
        self.method = method
        self.completion = completion
    }

    public func add(extra value: Any, key: String) {
        extras[key] = value
    }

    public func extra(key: String) -> Any? {
        return extras[key]
    }

    public func start(in source: IntentSource) {
        var destination = target.create()
        destination.intent = self
        let controller = destination.prepare(for: self)
        targetController = controller
        push = Intent.display(source: source.intentController, target: controller, method: method)
    }

    public func start(with controller: UIViewController) {
        var destination = target.create()
        destination.intent = self
        let t = destination.prepare(for: self)
        targetController = t
        push = Intent.display(source: controller, target: t, method: method)
    }

    public func transition(_ function: (IntentTarget) -> Void) {
        var destination = target.create()
        destination.intent = self
        function(destination)
    }

    public func end(for result: IntentResult? = nil) {
        guard let push = self.push, let controller = targetController else {
            return
        }
        if push {
            controller.navigationController?.popViewController(animated: true)
        } else {
            controller.dismiss(animated: true)
        }
        if let result = result {
            completion?(result)
        }
    }

    static func display(source: UIViewController, target: UIViewController, method: IntentMethod) -> Bool {
        let push: Bool
        switch method {
        case .push:
            push = true
        case .modal:
            push = false
        case .auto:
            push = (source.navigationController != nil || source is UINavigationController) &&
                !(target is UINavigationController)
        }
        if push {
            if let navigation = source as? UINavigationController {
                navigation.pushViewController(target, animated: true)
            } else {
                source.navigationController?.pushViewController(target, animated: true)
            }
        } else {
            source.present(target, animated: true)
        }
        return push
    }
}
