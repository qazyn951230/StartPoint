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

import AVFoundation
import RxSwift
import RxCocoa

public struct CameraPermission: PermissionItem {
    public func status() -> Driver<Permission> {
        let result = CameraPermission.normalize(AVCaptureDevice.authorizationStatus(for: AVMediaType.video))
        return Driver.just(result)
    }

    public func request() -> Driver<Permission> {
        return Observable.create { observer in
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                let status = granted ? Permission.authorized : Permission.denied
                observer.onNext(status)
                observer.on(.completed)
            }
            return Disposables.create()
        }.asDriver(onErrorJustReturn: Permission.denied)
    }

    public static func normalize(_ status: AVAuthorizationStatus) -> Permission {
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
