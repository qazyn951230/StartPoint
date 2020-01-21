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

public protocol BinderText {
    var text: Binder<String?>? { get }
    var attributedText: Binder<NSAttributedString?>? { get }

    func text(from object: Driver<String>) -> Disposable?
    func text(any object: Driver<String?>) -> Disposable?
    func text(from object: Observable<String>) -> Disposable?
    func text(any object: Observable<String?>) -> Disposable?

    func attributedText(from object: Driver<NSAttributedString>) -> Disposable?
    func attributedText(any object: Driver<NSAttributedString?>) -> Disposable?
    func attributedText(from object: Observable<NSAttributedString>) -> Disposable?
    func attributedText(any object: Observable<NSAttributedString?>) -> Disposable?
}

public extension BinderText {
    func text(from object: Driver<String>) -> Disposable? {
        assertMainThread()
        guard let value = text else {
            return nil
        }
        return object.drive(value)
    }

    func text(any object: Driver<String?>) -> Disposable? {
        assertMainThread()
        guard let value = text else {
            return nil
        }
        return object.drive(value)
    }

    func text(from object: Observable<String>) -> Disposable? {
        assertMainThread()
        guard let value = text else {
            return nil
        }
        return object.bind(to: value)
    }

    func text(any object: Observable<String?>) -> Disposable? {
        assertMainThread()
        guard let value = text else {
            return nil
        }
        return object.bind(to: value)
    }

    func attributedText(from object: Driver<NSAttributedString>) -> Disposable? {
        assertMainThread()
        guard let value = attributedText else {
            return nil
        }
        return object.drive(value)
    }

    func attributedText(any object: Driver<NSAttributedString?>) -> Disposable? {
        assertMainThread()
        guard let value = attributedText else {
            return nil
        }
        return object.drive(value)
    }

    func attributedText(from object: Observable<NSAttributedString>) -> Disposable? {
        assertMainThread()
        guard let value = attributedText else {
            return nil
        }
        return object.bind(to: value)
    }

    func attributedText(any object: Observable<NSAttributedString?>) -> Disposable? {
        assertMainThread()
        guard let value = attributedText else {
            return nil
        }
        return object.bind(to: value)
    }
}
#endif // #if os(iOS)
