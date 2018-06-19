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

#if PermissionEnable && LocationPermissionEnable
import CoreLocation
import RxSwift
import RxCocoa

extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate
}

public class RxLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>,
    DelegateProxyType, CLLocationManagerDelegate {
    public init(locationManager: CLLocationManager) {
        super.init(parentObject: locationManager, delegateProxy: RxLocationManagerDelegateProxy.self)
    }

    public class func registerKnownImplementations() {
        self.register { RxLocationManagerDelegateProxy(locationManager: $0) }
    }
}

public extension Reactive where Base: CLLocationManager {
    public var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        return RxLocationManagerDelegateProxy.proxy(for: base)
    }

    public var didChangeAuthorization: Observable<CLAuthorizationStatus> {
        let selector = #selector(CLLocationManagerDelegate.locationManager(_:didChangeAuthorization:))
        return delegate.methodInvoked(selector)
            .map { object in
                if object.count > 1, let code = object[1] as? Int32,
                   let result = CLAuthorizationStatus(rawValue: code) {
                    return result
                } else {
                    throw RxCocoaError.castingError(object: object, targetType: CLAuthorizationStatus.self)
                }
            }
    }
}

public struct LocationPermission: PermissionItem {
    public func status() -> Driver<Permission> {
        guard CLLocationManager.locationServicesEnabled() else {
            return Driver.just(Permission.denied)
        }
        let result = LocationPermission.normalize(CLLocationManager.authorizationStatus())
        return Driver.just(result)
    }

    public func request() -> Driver<Permission> {
        guard CLLocationManager.locationServicesEnabled() else {
            return Driver.just(Permission.denied)
        }
        let manager: CLLocationManager = CLLocationManager()
        return Observable.just(manager)
            .do(onNext: { $0.requestWhenInUseAuthorization() })
            .flatMap { (manager: CLLocationManager) in
                manager.rx.didChangeAuthorization
            }.skipWhile { (status: CLAuthorizationStatus) in
                status == CLAuthorizationStatus.notDetermined
            }.take(1)
            .map(LocationPermission.normalize)
            .asDriver(onErrorJustReturn: Permission.denied)
    }

    public static func normalize(_ status: CLAuthorizationStatus) -> Permission {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            return .authorized
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .notDetermined
        }
    }
}
#endif // PermissionEnable && LocationPermissionEnable
