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

open class TabBar: UITabBar {
    public let root: BasicElement = BasicElement()
    private var _items: [UITabBarItem]?

//    open override var items: [UITabBarItem]? {
//        get {
//            return _items
//        }
//        set {
//            _items = newValue
//        }
//    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }

    open func initialization() {
        root.layout.justifyContent(.center)
    }

    open func layout() {
        root.layout(width: Device.width, height: 49)
        root.build(in: self)
//        root.layout.print(options: .layout)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

//    open override func sizeThatFits(_ size: CGSize) -> CGSize {
//        root.layout(width: size.width, height: size.height)
//        return root._frame.cgSize
//    }

    open override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
//         super.setItems(items, animated: animated)
        if _items != nil {
            return
        }
        _items = items
        if let array = items {
            let list = array.map(TabBar.tabButton)
            list.forEachIndexed { (v, i) in
                root.insertElement(v, at: i)
            }
            setNeedsLayout()
        }
    }

    private static func tabButton(_ item: UITabBarItem) -> FlexButtonElement {
        let button = FlexButtonElement()
        button.backgroundColor(UIColor.white)
        let title = AttributedString(any: item.title)?.systemFont(12)
            .color(hex: 0x333333).done()
        button.title(title).image(item.image, for: .normal)
            .image(item.selectedImage, for: .selected)
        button.imageStyle { flex in
            flex.size(24).margin(bottom: 4)
        }
        button.style { flex in
            flex.flex(1).flexDirection(.column)
        }
        return button
    }
}
