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

#if PermissionHealth

import HealthKit
import RxSwift
import RxCocoa

public struct HealthPermission: PermissionItem {
    public func available() -> Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    
    public func status() -> Driver<Permission> {
        // To help protect the user’s privacy, your app does not know whether
        // the user granted or denied permission to read data from HealthKit.
        // If the user denied permission, attempts to query data from HealthKit
        // return only samples that your app successfully saved to the HealthKit store.
        return Driver.just(Permission.notDetermined)
    }
    
    public func request() -> Driver<Permission> {
        let store = HKHealthStore()
        let types = self.types()
        return Observable.create { observer in
            // A Boolean value that indicates whether the request was processed successfully.
            // This value does not indicate whether permission was actually granted.
            // This parameter is false if an error occurred while processing the request;
            // otherwise, it is true.
            store.requestAuthorization(toShare: nil, read: types) { (success, error) in
                observer.onNext(Permission.authorized)
                observer.on(.completed)
            }
            return Disposables.create()
        }.asDriver(onErrorJustReturn: Permission.denied)
    }
    
    private func type() -> HKObjectType? {
        return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
    }
    
    private func types() -> Set<HKObjectType> {
        guard let value = type() else {
            return Set()
        }
        return Set([value])
    }
}

#endif
