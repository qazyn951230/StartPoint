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

import Contacts
import AddressBook
import RxSwift
import RxCocoa

public struct ContactPermission: PermissionItem {
    public func status() -> Driver<Permission> {
        if #available(iOS 9.0, *) {
            let result = ContactPermission.normalize(CNContactStore.authorizationStatus(for: .contacts))
            return Driver.just(result)
        } else {
            let result = ContactPermission.normalize(ABAddressBookGetAuthorizationStatus())
            return Driver.just(result)
        }
    }

    public func request() -> Driver<Permission> {
        return Observable.create { observer in
            if #available(iOS 9.0, *) {
                CNContactStore().requestAccess(for: .contacts) { (granted, _) in
                    let status = granted ? Permission.authorized : Permission.denied
                    observer.onNext(status)
                    observer.on(.completed)
                }
            } else {
                ABAddressBookRequestAccessWithCompletion(nil) { (granted, _) in
                    let status = granted ? Permission.authorized : Permission.denied
                    observer.onNext(status)
                    observer.on(.completed)
                }
            }
            return Disposables.create()
        }.asDriver(onErrorJustReturn: Permission.denied)
    }

    @available(iOS 9.0, *)
    public static func normalize(_ status: CNAuthorizationStatus) -> Permission {
        switch status {
        case .authorized:
            return .authorized
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .notDetermined
        }
    }

    public static func normalize(_ status: ABAuthorizationStatus) -> Permission {
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
