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

import Alamofire
import RxSwift

extension SessionManager: ReactiveCompatible {
    // Do nothing.
}

public extension Reactive where Base: SessionManager {
    public func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil,
                        encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil)
            -> Observable<DataRequest> {
        return Observable<DataRequest>.create { observer in
            let manager: SessionManager = self.base
            let request: DataRequest = manager.request(url, method: method, parameters: parameters,
                encoding: encoding, headers: headers)
            observer.on(.next(request))
            request.response { response in
                if let error = response.error {
                    observer.on(.error(error))
                } else {
                    observer.on(.completed)
                }
            }
            if !manager.startRequestsImmediately {
                request.resume()
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
