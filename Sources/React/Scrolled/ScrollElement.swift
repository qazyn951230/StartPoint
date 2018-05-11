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

import UIKit
import CoreGraphics

public typealias ScrollElement = BasicScrollElement<UIScrollView>

open class ScrollElementState: ElementState {
    public var contentSize: CGSize {
        get {
            return _contentSize ?? CGSize.zero
        }
        set {
            _contentSize = newValue
        }
    }
    var _contentSize: CGSize?

    public var horizontalIndicator: Bool {
        get {
            return _horizontalIndicator ?? true
        }
        set {
            _horizontalIndicator = newValue
        }
    }
    var _horizontalIndicator: Bool?

    public var verticalIndicator: Bool {
        get {
            return _verticalIndicator ?? true
        }
        set {
            _verticalIndicator = newValue
        }
    }
    var _verticalIndicator: Bool?

    public var pagingEnabled: Bool {
        get {
            return _pagingEnabled ?? false
        }
        set {
            _pagingEnabled = newValue
        }
    }
    var _pagingEnabled: Bool?

    open override func apply(view: UIView) {
        if let scrollView = view as? UIScrollView {
            apply(scrollView: scrollView)
        } else {
            super.apply(view: view)
        }
    }

    open func apply(scrollView: UIScrollView) {
        if let contentSize = _contentSize {
            scrollView.contentSize = contentSize
        }
        if let horizontalIndicator = _horizontalIndicator {
            scrollView.showsHorizontalScrollIndicator = horizontalIndicator
        }
        if let verticalIndicator = _verticalIndicator {
            scrollView.showsVerticalScrollIndicator = verticalIndicator
        }
        super.apply(view: scrollView)
    }

    open override func invalidate() {
        _contentSize = nil
        super.invalidate()
    }
}

open class BasicScrollElement<ScrollView: UIScrollView>: Element<ScrollView> {
    var _scrollState: ScrollElementState?

    public let content: StackElement

//    public override init(children: [BasicElement] = []) {
//        content = StackElement(children: [])
//            .layout { flex in
//                flex.positionType(.absolute)
//            }
//        var array = children
//        array.insert(content, at: 0)
//        super.init(children: array)
//    }

    public init(content: StackElement) {
#if DEBUG
        if content.layout.style.positionType  != PositionType.absolute {
            Log.warn("Scroll content \(content) should use absolute position type")
        }
#endif
        self.content = content
        super.init(children: [content])
    }

    public convenience init(children: [BasicElement] = [], direction: UICollectionViewScrollDirection? = nil) {
        let content = StackElement(children: children)
        if direction == UICollectionViewScrollDirection.horizontal {
            content.layout.positionType(.absolute)
                .flexDirection(.row).height(.match)
        } else if direction == UICollectionViewScrollDirection.vertical {
            content.layout.positionType(.absolute)
                .flexDirection(.column).width(.match)
        }
        self.init(content: content)
    }

    public override var pendingState: ScrollElementState {
        let state = _scrollState ?? ScrollElementState()
        if _scrollState == nil {
            _scrollState = state
            _pendingState = state
        }
        return state
    }

    open override func applyState(to view: ScrollView) {
        if _scrollState?._contentSize == nil {
            Log.debug(_frame, content._frame)
            view.contentSize = content._frame.cgSize
//            let total: CGRect = children.reduce(CGRect.zero) { (result: CGRect, next: BasicElement) in
//                return result.union(next.frame)
//            }
//            view.contentSize = total.size
        }
        super.applyState(to: view)
    }

    @discardableResult
    public func contentStyle(_ method: (FlexLayout) -> Void) -> Self {
        method(content.layout)
        return self
    }
}

extension BasicScrollElement {
    @discardableResult
    public func contentSize(_ value: CGSize) -> Self {
        if mainThread(), let view = view {
            view.contentSize = value
        } else {
            pendingState.contentSize = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func horizontalIndicator(_ value: Bool) -> Self {
        if mainThread(), let view = view {
            view.showsHorizontalScrollIndicator = value
        } else {
            pendingState.horizontalIndicator = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func verticalIndicator(_ value: Bool) -> Self {
        if mainThread(), let view = view {
            view.showsVerticalScrollIndicator = value
        } else {
            pendingState.verticalIndicator = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func indicator(_ value: Bool) -> Self {
        if mainThread(), let view = view {
            view.showsHorizontalScrollIndicator = value
            view.showsVerticalScrollIndicator = value
        } else {
            pendingState.horizontalIndicator = value
            pendingState.verticalIndicator = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func indicator(horizontal: Bool, vertical: Bool) -> Self {
        if mainThread(), let view = view {
            view.showsHorizontalScrollIndicator = horizontal
            view.showsVerticalScrollIndicator = vertical
        } else {
            pendingState.horizontalIndicator = horizontal
            pendingState.verticalIndicator = vertical
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func paging(_ value: Bool) -> Self {
        if mainThread(), let view = view {
            view.isPagingEnabled = value
        } else {
            pendingState.pagingEnabled = value
            registerPendingState()
        }
        return self
    }
}