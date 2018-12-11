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

#if PermissionNotification

import UIKit
import UserNotifications
import RxSwift
import RxCocoa

public struct NotificationOptions: OptionSet {
    public let rawValue: Int

    public static let badge = NotificationOptions(rawValue: 1 << 0)
    public static let alert = NotificationOptions(rawValue: 1 << 0)
    public static let sound = NotificationOptions(rawValue: 1 << 0)

    public static let `default`: NotificationOptions = [.badge, .alert, .sound]

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    @available(iOS 10.0, *)
    var options: UNAuthorizationOptions {
        var result: UNAuthorizationOptions = []
        if self.contains(.badge) {
            result.insert(.badge)
        }
        if self.contains(.sound) {
            result.insert(.sound)
        }
        if self.contains(.alert) {
            result.insert(.alert)
        }
        return result
    }

    var settings: UIUserNotificationSettings {
        var types: UIUserNotificationType = []
        if self.contains(.badge) {
            types.insert(.badge)
        }
        if self.contains(.sound) {
            types.insert(.sound)
        }
        if self.contains(.alert) {
            types.insert(.alert)
        }
        return UIUserNotificationSettings(types: types, categories: nil)
    }
}

public struct NotificationPermission: PermissionItem {
    let options: NotificationOptions

    public init(options: NotificationOptions = NotificationOptions.default) {
        self.options = options
    }

    public func status() -> Driver<Permission> {
        if #available(iOS 10.0, *) {
            return Observable.create { (observer: AnyObserver<Permission>) in
                let center = UNUserNotificationCenter.current()
                center.getNotificationSettings { (settings: UNNotificationSettings) in
                    switch settings.authorizationStatus {
                    case .denied:
                        observer.onNext(Permission.denied)
                    case .notDetermined:
                        observer.onNext(Permission.notDetermined)
                    case .authorized, .provisional:
                        observer.onNext(Permission.authorized)
                    }
                }
                return Disposables.create()
            }.asDriver(onErrorJustReturn: Permission.notDetermined)
        } else {
            let settings = UIApplication.shared.currentUserNotificationSettings
            let result: Permission = settings?.types.isEmpty == true ? .denied : .authorized
            return Driver.just(result)
        }
    }

    public func request() -> Driver<Permission> {
        if #available(iOS 10.0, *) {
            let options = self.options.options
            return Observable.create { (observer: AnyObserver<Permission>) in
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: options) { (granted: Bool, error: Error?) in
                    if let error = error {
                        observer.onError(error)
                    } else {
                        let next = granted ? Permission.authorized : Permission.denied
                        observer.onNext(next)
                    }
                }
                return Disposables.create()
            }.asDriver(onErrorJustReturn: Permission.denied)
        } else {
            UIApplication.shared.registerUserNotificationSettings(options.settings)
            return Driver.just(Permission.denied)
        }
    }
}

#endif