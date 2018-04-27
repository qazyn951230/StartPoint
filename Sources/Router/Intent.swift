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

public enum ResolvedMethod {
    case push
    case modal

    public var isPush: Bool {
        return self == ResolvedMethod.push
    }

    public var isModal: Bool {
        return self == ResolvedMethod.modal
    }
}

public protocol IntentSource {
    var intentController: UIViewController { get }
}

public protocol IntentTarget: IntentSource {
    var intent: Intent? { get set }
    func prepare(for intent: Intent, method: ResolvedMethod) -> UIViewController
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

    public func prepare(for intent: Intent, method: ResolvedMethod) -> UIViewController {
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

    public func stringExtra(key: String) -> String? {
        return extras[key] as? String
    }

    public func doubleExtra(key: String) -> Double? {
        return extras[key] as? Double
    }

    public func intExtra(key: String) -> Int? {
        return extras[key] as? Int
    }

    public func start(in source: IntentSource) {
        start(with: source.intentController)
    }

    public func start(with controller: UIViewController) {
        let resolved = (method != IntentMethod.modal &&
            (controller.navigationController != nil || controller is UINavigationController)) ?
            ResolvedMethod.push : ResolvedMethod.modal
        var destination = self.target.create()
        destination.intent = self
        let target = destination.prepare(for: self, method: resolved)
        assertFalse(resolved == ResolvedMethod.push && target is UINavigationController,
            "Cannot push a UINavigationController")
        targetController = target
        display(source: controller, target: target, method: resolved)
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

    func display(source: UIViewController, target: UIViewController, method: ResolvedMethod) {
        switch method {
        case .push:
#if DEBUG
            assertFalse(target is UINavigationController, "Cannot push a UINavigationController")
            if let navigation = source.navigationController ?? (source as? UINavigationController) {
                navigation.pushViewController(target, animated: true)
                push = true
            } else {
                source.present(target, animated: true)
                push = false
            }
#else
            if let navigation = source.navigationController ?? (source as? UINavigationController),
               !(target is UINavigationController) {
                navigation.pushViewController(target, animated: true)
                push = true
            } else {
                source.present(target, animated: true)
                push = false
            }
#endif
        case .modal:
            source.present(target, animated: true)
            push = false
        }
    }
}
