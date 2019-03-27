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

public protocol ReactiveRequest {
    func resume()
    func cancel()
    func response(queue: DispatchQueue?, completionHandler: @escaping (DefaultDataResponse) -> Void) -> Self
}

extension DataRequest: ReactiveRequest {
    // Do nothing.
}

public extension Reactive where Base: SessionManager {
    func request<Request>(request: Request) -> Observable<Request>
        where Request: ReactiveRequest {
        let manager: SessionManager = self.base
        let start = manager.startRequestsImmediately
        return Observable<Request>.create { observer in
            observer.on(.next(request))
            _ = request.response(queue: nil) { response in
                if let error = response.error {
                    observer.on(.error(error))
                } else {
                    observer.on(.completed)
                }
            }
            if !start {
                request.resume()
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    func request<Request>(creator: @escaping (SessionManager) throws -> Request) -> Observable<Request>
        where Request: ReactiveRequest {
        return Observable.just(base)
            .map(creator)
            .flatMap(request(request:))
    }

    func request<Request>(creator: @escaping (SessionManager) throws -> Observable<Request>)
            -> Observable<Request> where Request: ReactiveRequest {
        return Observable.just(base)
            .flatMap(creator)
            .flatMap(request(request:))
    }

    func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil,
                        encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil)
            -> Observable<DataRequest> {
        return request { manager in
            return manager.request(url, method: method, parameters: parameters,
                encoding: encoding, headers: headers)
        }
    }

    func upload(formData: @escaping (MultipartFormData) -> Void,
                       with urlRequest: URLRequestConvertible) -> Observable<UploadRequest> {
        let manager: SessionManager = self.base
        return Observable<UploadRequest>.create { observer in
            manager.upload(multipartFormData: formData, with: urlRequest) { result in
                switch result {
                case let .success(request, _, _):
                    observer.on(.next(request))
                    observer.on(.completed)
                case let .failure(error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func upload(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil,
                       formData: @escaping (MultipartFormData) -> Void,
                       encoding: ParameterEncoding = URLEncoding.default,
                       headers: HTTPHeaders? = nil) -> Observable<UploadRequest> {
        func fn(manager: SessionManager) throws -> Observable<UploadRequest> {
            let request = manager.request(url, method: method, parameters: parameters,
                encoding: encoding, headers: headers)
            guard let urlRequest = request.request else {
                throw NSError(domain: "com.undev.start.point", code: 404)
            }
            return manager.rx.upload(formData: formData, with: urlRequest)
        }

        return request(creator: fn)
    }
}
