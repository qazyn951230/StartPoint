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

#if os(iOS)
import UIKit
import RxSwift
import RxCocoa

public protocol TapEvent {
    var tap: ControlEvent<Void>? { get }

    func tap(to object: BehaviorRelay<Void>) -> Disposable?
    func tap(to object: PublishRelay<Void>) -> Disposable?
}

public extension TapEvent {
    func tap(to object: BehaviorRelay<Void>) -> Disposable? {
        assertMainThread()
        return self.tap?.bind(to: object)
    }

    func tap(to object: PublishRelay<Void>) -> Disposable? {
        assertMainThread()
        return self.tap?.bind(to: object)
    }
}

extension Element: TapEvent where View: UIButton {
    public var tap: ControlEvent<Void>? {
        return view?.rx.tap
    }
}
#endif // #if os(iOS)
