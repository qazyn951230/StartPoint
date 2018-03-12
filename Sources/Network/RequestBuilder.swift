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
import Dispatch
import SwiftyJSON

public class RequestBuilder {
    public let url: String
    public let method: HTTPMethod
    public private(set) var scheduler: SerialDispatchQueueScheduler = MainScheduler.instance
    public private(set) var queue: DispatchQueue = DispatchQueue.main

    public private(set) var parameters = [String: Any]()
    public private(set) var headers = [String: String]()
    public private(set) var encoding: ParameterEncoding = URLEncoding.default

    public private(set) var debug = false

#if DEBUG
    public private(set) var logKeys = [String]()
    public private(set) var file: String = String.empty
    public private(set) var function: String = String.empty
    public private(set) var line: Int = 0
#endif

    public init(url: String, method: HTTPMethod) {
        self.url = url
        self.method = method
    }

    public func parameter(_ value: Any, key: String, log: Bool = true) -> RequestBuilder {
        parameters[key] = value
#if DEBUG
        if log {
            logKeys.append(key)
        }
#endif
        return self
    }

    public func parameters(_ value: [String: Any], append: Bool = true, log: Bool = true) -> RequestBuilder {
        if append {
            for (k, v) in value {
                self.parameters[k] = v
            }
        } else {
            self.parameters = value
        }
#if DEBUG
        if log {
            logKeys.append(contentsOf: value.keys)
        }
#endif
        return self
    }

    public func header(_ value: String, key: String, log: Bool = true) -> RequestBuilder {
        headers[key] = value
#if DEBUG
        if log {
            logKeys.append(key)
        }
#endif
        return self
    }

    public func headers(_ value: [String: String], append: Bool = true, log: Bool = true) -> RequestBuilder {
        if append {
            for (k, v) in value {
                self.headers[k] = v
            }
        } else {
            self.headers = value
        }
#if DEBUG
        if log {
            logKeys.append(contentsOf: value.keys)
        }
#endif
        return self
    }

    public func encoding(_ value: URLEncoding) -> RequestBuilder {
        self.encoding = value
        return self
    }

    public func encoding(custom value: ParameterEncoding) -> RequestBuilder {
        self.encoding = value
        return self
    }

    public func encoding(json value: JSONEncoding) -> RequestBuilder {
        self.encoding = value
        return self
    }

    public func scheduler(_ value: SerialDispatchQueueScheduler, queue: DispatchQueue) -> RequestBuilder {
        self.scheduler = value
        self.queue = queue
        return self
    }

    public func debug(_ value: Bool = true) -> RequestBuilder {
        self.debug = value
        return self
    }

    public func debug(file: String, function: String, line: Int) -> RequestBuilder {
#if DEBUG
        self.file = file
        self.function = function
        self.line = line
#endif
        return self
    }

    public func build(session: SessionManager = SessionManager.default) -> Observable<DataRequest> {
        func _build(build: RequestBuilder) -> DataRequest {
            return session.request(build.url, method: build.method, parameters: build.parameters,
                encoding: build.encoding, headers: build.headers)
        }

        return Observable<RequestBuilder>.just(self, scheduler: scheduler)
            .map(_build)
    }
}
