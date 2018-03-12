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

public final class RxImagePickerDelegateProxy: RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {
    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }
}

public extension Reactive where Base: UIImagePickerController {
    public var didFinishPickingMediaWithInfo: Observable<[String: Any]> {
        let selector = #selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:))
        return delegate.methodInvoked(selector)
            .map { object in
                if object.count > 1, let result = object[1] as? [String: Any] {
                    return result
                } else {
                    throw RxCocoaError.castingError(object: object, targetType: [String: Any].self)
                }
            }
    }

    public var didCancel: Observable<Void> {
        let selector = #selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:))
        return delegate.methodInvoked(selector)
            .map(Function.nothing)
    }
}

public extension UIImagePickerController {
    public static func rxController(_ picker: UIImagePickerController, in viewController: UIViewController,
                                    animated: Bool = true) -> Observable<UIImagePickerController> {
        return Observable<UIImagePickerController>.create { observer in
            viewController.present(picker, animated: animated)
            observer.on(.next(picker))

            let disposable = picker.rx
                .didCancel
                .subscribe(onNext: {
                picker.dismiss(animated: animated)
            })
            let disposable2 = Disposables.create {
                picker.dismiss(animated: animated)
            }
            return Disposables.create(disposable, disposable2)
        }
    }
}
