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

import XCTest
@testable import StartPoint

func webLayout() -> FlexLayout {
    let layout: FlexLayout = FlexLayout()
    layout.style.flexDirection = FlexDirection.row
    layout.style.alignContent = AlignContent.stretch
    layout.style.flexShrink = 1
    return layout
}

enum Edge {
    case left
    case top
    case right
    case bottom
    case leading
    case trailing
    case horizontal
    case vertical
}

extension FlexLayout {
    @discardableResult
    func margin(edge: Edge, _ value: StyleValue) -> FlexLayout {
        switch edge {
        case .left:
            return margin(left: value)
        case .top:
            return margin(top: value)
        case .right:
            return margin(right: value)
        case .bottom:
            return margin(bottom: value)
        case .leading:
            return margin(leading: value)
        case .trailing:
            return margin(trailing: value)
        case .horizontal:
            return margin(horizontal: value)
        case .vertical:
            return margin(vertical: value)
        }
    }
    
    func layoutMargin(edge: Edge) -> Double {
        switch edge {
        case .left:
            return box.margin.left
        case .top:
            return box.margin.top
        case .right:
            return box.margin.right
        case .bottom:
            return box.margin.bottom
        case .leading:
            return box.direction == Direction.ltr ? box.margin.left : box.margin.right
        case .trailing:
            return box.direction == Direction.ltr ? box.margin.right : box.margin.left
        case .horizontal:
            return box.margin.left == box.margin.right ? box.margin.left : Double.nan
        case .vertical:
            return box.margin.top == box.margin.bottom ? box.margin.top : Double.nan
        }
    }
    
    @discardableResult
    func padding(edge: Edge, _ value: StyleValue) -> FlexLayout {
        switch edge {
        case .left:
            return padding(left: value)
        case .top:
            return padding(top: value)
        case .right:
            return padding(right: value)
        case .bottom:
            return padding(bottom: value)
        case .leading:
            return padding(leading: value)
        case .trailing:
            return padding(trailing: value)
        case .horizontal:
            return padding(horizontal: value)
        case .vertical:
            return padding(vertical: value)
        }
    }
    
    func layoutPadding(edge: Edge) -> Double {
        switch edge {
        case .left:
            return box.padding.left
        case .top:
            return box.padding.top
        case .right:
            return box.padding.right
        case .bottom:
            return box.padding.bottom
        case .leading:
            return box.direction == Direction.ltr ? box.padding.left : box.padding.right
        case .trailing:
            return box.direction == Direction.ltr ? box.padding.right : box.padding.left
        case .horizontal:
            return box.padding.left == box.padding.right ? box.padding.left : Double.nan
        case .vertical:
            return box.padding.top == box.padding.bottom ? box.padding.top : Double.nan
        }
    }
}

class FlexTestCase: XCTestCase {
    override class func setUp() {
        super.setUp()
        FlexStyle.scale = 1.0
    }
}
