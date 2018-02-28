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

//import UIKit
//import CoreGraphics
//
//public typealias ScrollComponent = BasicScrollComponent<UIScrollView>
//
//open class ScrollComponentState: ComponentState {
//    public var contentSize: CGSize {
//        get {
//            return _contentSize ?? CGSize.zero
//        }
//        set {
//            _contentSize = newValue
//        }
//    }
//    var _contentSize: CGSize?
//}
//
//open class BasicScrollComponent<Scroll: UIScrollView>: Component<Scroll> {
//    var _scrollState: ScrollComponentState?
//    public override var pendingState: ScrollComponentState {
//        let state = _scrollState ?? ScrollComponentState()
//        if _scrollState == nil {
//            _scrollState = state
//            _pendingState = state
//        }
//        return state
//    }
//
//    public override func layout(width: Double, height: Double) {
//        layout.width(.length(width)).height(.length(height))
//        super.layout(width: width, height: height)
//    }
//}