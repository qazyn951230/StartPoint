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
import SwiftyJSON
import Foundation

extension Request: ReactiveCompatible {
    // Do nothing.
}

extension Reactive where Base: DataRequest {
    public func response<T: DataResponseSerializerProtocol>(serializer: T, queue: DispatchQueue? = nil)
            -> Observable<(DataResponse<T.SerializedObject>, T.SerializedObject)> {
        return Observable<(DataResponse<T.SerializedObject>, T.SerializedObject)>.create { observer in
            var request: DataRequest = self.base
            request = request.response(queue: queue, responseSerializer: serializer) {
                (response: DataResponse<T.SerializedObject>) in
                switch response.result {
                case .success(let object):
                    observer.on(.next((response, object)))
                    observer.on(.completed)
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    public func jsonResponse(queue: DispatchQueue? = nil, options: JSONSerialization.ReadingOptions = .allowFragments)
            -> Observable<(DataResponse<Any>, JSON)> {
        return Observable<(DataResponse<Any>, JSON)>.create { observer in
            var request: DataRequest = self.base
            request = request.responseJSON(queue: queue, options: options) { (response: DataResponse<Any>) in
                switch response.result {
                case .success(let object):
                    observer.on(.next((response, JSON(object))))
                    observer.on(.completed)
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    public func json(queue: DispatchQueue? = nil, options: JSONSerialization.ReadingOptions = .allowFragments)
            -> Observable<JSON> {
        return jsonResponse(queue: queue, options: options)
            .map(Function.second)
    }

    public func stringResponse(queue: DispatchQueue? = nil, encoding: String.Encoding? = .utf8)
            -> Observable<(DataResponse<String>, String)> {
        return Observable.create { observer in
            var request: DataRequest = self.base
            request = request.responseString(queue: queue, encoding: encoding) { (response: DataResponse<String>) in
                switch response.result {
                case .success(let object):
                    observer.on(.next((response, object)))
                    observer.on(.completed)
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    public func string(queue: DispatchQueue? = nil, encoding: String.Encoding? = .utf8) -> Observable<String> {
        return stringResponse(queue: queue, encoding: encoding)
            .map(Function.second)
    }

    public func dataResponse(queue: DispatchQueue? = nil) -> Observable<(DataResponse<Data>, Data)> {
        return Observable.create { observer in
            var request: DataRequest = self.base
            request = request.responseData(queue: queue) { (response: DataResponse<Data>) in
                switch response.result {
                case .success(let object):
                    observer.on(.next((response, object)))
                    observer.on(.completed)
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    public func data(queue: DispatchQueue? = nil) -> Observable<Data> {
        return dataResponse(queue: queue)
            .map(Function.second)
    }
}
