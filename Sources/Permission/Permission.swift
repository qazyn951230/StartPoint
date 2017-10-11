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

import Foundation
import RxSwift
import RxCocoa

public enum PermissionType {
    case photo
    case camera
    case location
}

public enum Permission {
    case notDetermined
    case authorized
    case denied

    public static func status(_ type: PermissionType) -> Permission {
        switch type {
        case .photo:
            return PhotoPermission.status()
        case .camera:
            return CameraPermission.status()
        case .location:
            return LocationPermission.status()
        }
    }

    public static func request(_ type: PermissionType) -> Driver<Permission> {
        switch type {
        case .photo:
            return PhotoPermission.request()
        case .camera:
            return CameraPermission.request()
        case .location:
            return LocationPermission.request()
        }
    }

    public static func firstRequest(_ type: PermissionType) -> Driver<Permission> {
        func fn(status: Permission) -> Driver<Permission> {
            switch status {
            case .notDetermined:
                return Permission.request(type)
            default:
                return Driver.just(status)
            }
        }

        return Driver.just(type)
            .map(Permission.status)
            .flatMap(fn)
    }
}
