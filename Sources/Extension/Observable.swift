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

import RxSwift

public extension ObservableType {
    @inlinable
    public static func first(_ method: () throws -> E) -> Observable<E> {
        do {
            let e = try method()
            return Observable<E>.just(e)
        } catch let error {
            return Observable<E>.error(error)
        }
    }

#if RxCompactMap
    public func compactMap<R>(_ transform: @escaping (E) throws -> R?) -> Observable<R> {
        return Observable<R>.create { observer in
            let subscription = self.subscribe { e in
                switch e {
                case .next(let value):
                    do {
                        if let result = try transform(value) {
                            observer.on(.next(result))
                        }
                    } catch let e {
                        observer.on(.error(e))
                    }
                case .error(let error):
                    observer.on(.error(error))
                case .completed:
                    observer.on(.completed)
                }
            }
            return subscription
        }
    }
#endif
}
