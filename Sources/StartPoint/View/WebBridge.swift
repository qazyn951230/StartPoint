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

#if os(iOS)
import WebKit
import RxSwift

public enum Bridge {
    case empty((AnyNotation) throws -> Void)
    case json((AnyNotation) throws -> [String: Any])
    case async((AnyNotation) throws -> Observable<[String: Any]>)
}

public final class WebBridge {
    var bridges: [String: Bridge] = [:]
    private let bag = DisposeBag()

#if DEBUG
    static let code = "var SPJSBridge=function(){var bridge=window.webkit.messageHandlers.SPJSBridge;var post=bridge.postMessage.bind(bridge);var pool={};var last=0;var SPJSBridge={};SPJSBridge.event=function(callback){SPJSBridge.callback=callback};SPJSBridge.run=function(event,option,callback){var id=\"\"+last;pool[id]=callback;last+=1;post({id:id,event:event,option:option})};SPJSBridge.onEvent=function(id,event){SPJSBridge.callback&&SPJSBridge.callback(id,event)};SPJSBridge.on=function(json){var event=JSON.parse(json);var id=event.id;var callback=pool[id];delete pool[id];if(callback==null){return}if(event.error){callback.failure&&callback.failure({message:event.message})}else{callback.success&&callback.success({body:event.body,message:event.message})}};return SPJSBridge}();window.SPJSBridge=SPJSBridge;"
#else
    static let code = "var SPJSBridge=function(){var e=window.webkit.messageHandlers.SPJSBridge,i=e.postMessage.bind(e),r={},c=0,s={event:function(e){s.callback=e},run:function(e,n,s){var a=\"\"+c;r[a]=s,c+=1,i({id:a,event:e,option:n})},onEvent:function(e,n){s.callback&&s.callback(e,n)},on:function(e){var n=JSON.parse(e),s=n.id,a=r[s];delete r[s],null!=a&&(n.error?a.failure&&a.failure({message:n.message}):a.success&&a.success({body:n.body,message:n.message}))}};return s}();window.SPJSBridge=SPJSBridge;"
#endif

    public init() {
        // Do nothing.
    }

    public func register(id: String, handler: @escaping (AnyNotation) throws -> Void) {
        bridges[id] = .empty(handler)
    }

    public func register(id: String, json handler: @escaping (AnyNotation) throws -> [String: Any]) {
        bridges[id] = .json(handler)
    }

    public func register(id: String, async handler: @escaping (AnyNotation) throws -> Observable<[String: Any]>) {
        bridges[id] = .async(handler)
    }

    public func handle(message: WKScriptMessage) {
        guard let webView = message.webView else {
            return
        }
        let json = AnyNotation(message.body)
        let body: AnyNotation = json[typed: "body"]
        let messageId: String = json <| "id"
        guard let id: String = json["event"].stringValue, id.isNotEmpty else {
            Log.error("WebBridge message has no id", message.body)
            return
        }
        guard let handler = bridges[id] else {
            Log.error("WebBridge message has no handler, id =\(id)")
            return
        }
        switch handler {
        case let .empty(fn):
            do {
                try fn(body)
                onSuccess(id: messageId, result: [:], webView: webView)
            } catch (let error) {
                onFailure(id: messageId, error: error, webView: webView)
                Log.error(error)
            }
        case let .json(fn):
            do {
                let result = try fn(body)
                onSuccess(id: messageId, result: result, webView: webView)
            } catch (let error) {
                onFailure(id: messageId, error: error, webView: webView)
                Log.error(error)
            }
        case let .async(fn):
            do {
                let method = try fn(body)
                method.subscribe(onNext: { [weak self] result in
                    self?.onSuccess(id: messageId, result: result, webView: webView)
                }, onError: { [weak self] error in
                    self?.onFailure(id: messageId, error: error, webView: webView)
                }).disposed(by: bag)
            } catch (let error) {
                onFailure(id: messageId, error: error, webView: webView)
                Log.error(error)
            }
        }
    }

    func onSuccess(id: String, result: [String: Any], webView: WKWebView) {
        let body: [String: Any] = ["id": id, "body": result, "message": "success", "error": false]
        sendCode(body, webView: webView)
    }

    func onFailure(id: String, error: Error, webView: WKWebView) {
        let body: [String: Any] = ["id": id, "message": error.localizedDescription, "error": true]
        sendCode(body, webView: webView)
    }

    func sendCode(_ any: [String: Any], webView: WKWebView) {
        guard let data = try? JSONSerialization.data(withJSONObject: any),
              let json = String(data: data, encoding: .utf8) else {
            Log.error("JSON encode failed")
            return
        }
        let code = "window.SPJSBridge.on('\(json)')"
        sendCode(code, webView: webView)
    }

    func sendCode(_ code: String, webView: WKWebView) {
#if DEBUG
        webView.evaluateJavaScript(code) { value, error in
            if (error != nil) {
                Log.error(any: value, error)
            } else {
                Log.debug(any: value, error)
            }
        }
#else
        webView.evaluateJavaScript(code)
#endif
    }

    public static func inject(to contentController: WKUserContentController) {
        let script = WKUserScript(source: code, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        contentController.addUserScript(script)
    }
}
#endif // #if os(iOS)
