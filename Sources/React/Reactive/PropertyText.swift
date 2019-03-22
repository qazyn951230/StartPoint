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

import UIKit
import RxSwift
import RxCocoa

public protocol PropertyText {
    var text: ControlProperty<String?>? { get }
    var attributedText: ControlProperty<NSAttributedString?>? { get }

    func text(from object: Driver<String>) -> Disposable?
    func text(any object: Driver<String?>) -> Disposable?
    func text(to object: BehaviorRelay<String>) -> Disposable?
    func text(any object: BehaviorRelay<String?>) -> Disposable?

    func attributedText(from object: Driver<NSAttributedString>) -> Disposable?
    func attributedText(any: Driver<NSAttributedString?>) -> Disposable?
    func attributedText(any object: BehaviorRelay<NSAttributedString?>) -> Disposable?
}

public extension PropertyText {
    public func text(from object: Driver<String>) -> Disposable? {
        assertMainThread()
        guard let value = text else {
            return nil
        }
        return object.drive(value)
    }

    public func text(any object: Driver<String?>) -> Disposable? {
        assertMainThread()
        guard let value = text else {
            return nil
        }
        return object.drive(value)
    }

    public func attributedText(from object: Driver<NSAttributedString>) -> Disposable? {
        assertMainThread()
        guard let value = attributedText else {
            return nil
        }
        return object.drive(value)
    }

    public func attributedText(any object: Driver<NSAttributedString?>) -> Disposable? {
        assertMainThread()
        guard let value = attributedText else {
            return nil
        }
        return object.drive(value)
    }

    public func text(to object: BehaviorRelay<String>) -> Disposable? {
        assertMainThread()
        guard let value = text else {
            return nil
        }
        return value.orEmpty.bind(to: object)
    }

    public func text(any object: BehaviorRelay<String?>) -> Disposable? {
        assertMainThread()
        guard let value = text else {
            return nil
        }
        return value.bind(to: object)
    }

    public func attributedText(any object: BehaviorRelay<NSAttributedString?>) -> Disposable? {
        assertMainThread()
        guard let value = attributedText else {
            return nil
        }
        return value.bind(to: object)
    }
}
