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

#if PERMISSION_MOTION

import CoreMotion
import RxSwift
import RxCocoa

public struct MotionPermission: PermissionItem {
    public func status() -> Driver<Permission> {
        if #available(iOS 11.0, *) {
            let result = MotionPermission.normalize(CMPedometer.authorizationStatus())
            return Driver.just(result)
        } else {
            return Driver.just(Permission.authorized)
        }
    }

    public func request() -> Driver<Permission> {
        return Observable.create { observer in
            let pedometer = CMPedometer()
            let code = Int(CMErrorMotionActivityNotAuthorized.rawValue)
            pedometer.startUpdates(from: Date()) { (data: CMPedometerData?, error: Error?) in
                if let e = error as NSError?, e.code == code {
                    observer.onNext(Permission.denied)
                } else {
                    observer.onNext(Permission.authorized)
                }
                observer.onCompleted()
                pedometer.stopUpdates()
            }
            return Disposables.create()
        }.asDriver(onErrorJustReturn: Permission.denied)
    }

    @available(iOS 11.0, *)
    public static func normalize(_ status: CMAuthorizationStatus) -> Permission {
        switch status {
        case .authorized:
            return .authorized
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .notDetermined
        }
    }
}

#endif
