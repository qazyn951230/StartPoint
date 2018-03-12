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

import Foundation
import RxSwift
import RxCocoa

public protocol PermissionItem {
    func status() -> Driver<Permission>
    func request() -> Driver<Permission>
}

public enum PermissionType {
    case photo
    case camera
    case location
    case notification(NotificationOptions)

    var item: PermissionItem {
        switch self {
        case .photo:
            return PhotoPermission()
        case .camera:
            return CameraPermission()
        case .location:
            return LocationPermission()
        case .notification(let options):
            return NotificationPermission(options: options)
        }
    }
}

// https://github.com/delba/Permission
public enum Permission {
    case notDetermined
    case authorized
    case denied

    public static func status(_ type: PermissionType) -> Driver<Permission> {
        return type.item.status()
    }

    public static func request(_ type: PermissionType) -> Driver<Permission> {
        return type.item.request()
    }

    public static func firstRequest(_ type: PermissionType) -> Driver<Permission> {
        let item = type.item
        return item.status().flatMap { (permission: Permission) -> Driver<Permission> in
            switch permission {
            case .notDetermined:
                return item.request()
            default:
                return Driver.just(permission)
            }
        }
    }
}
