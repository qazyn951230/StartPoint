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

// √ button padding
// TODO: title image padding
final public class ButtonLayout: FlexLayout {
    // Property
    public private(set) var title: NSAttributedString? = nil
    public private(set) var image: UIImage? = nil
    // Layout
    public private(set) var titleLayout: TextLayout? = nil
    public private(set) var imageLayout: FlexLayout? = nil

    public override init(view: LayoutView? = nil) {
        super.init(view: view)
        flexDirection(.row)
            .justifyContent(.center)
            .alignContent(.center)
            .alignItems(.center)
    }

    public func title(_ value: NSAttributedString) -> TextLayout {
        self.title = value
        let layout = TextLayout().text(value)
        self.titleLayout = layout.append(to: self)
        return layout
    }

    public func image(_ value: UIImage) -> FlexLayout {
        self.image = value
        let layout = FlexLayout().size(value.size)
        self.imageLayout = layout.append(to: self)
        return layout
    }

    @discardableResult
    public func titleLayout(_ value: TextLayout) -> ButtonLayout {
        // TODO: Remove
        if let t = self.titleLayout {
            remove(t)
        }
        self.titleLayout = value
        append(value)
        return self
    }

    @discardableResult
    public func imageLayout(_ value: FlexLayout) -> ButtonLayout {
        if let t = self.imageLayout {
            remove(t)
        }
        self.imageLayout = value
        append(value)
        return self
    }

    public override func apply(to view: LayoutView? = nil) {
        super.apply(to: view)
        guard let button: UIButton = (view ?? self.view) as? UIButton,
              let titleLayout = self.titleLayout,
              let imageLayout = self.imageLayout else {
            return
        }
        let buttonSize: CGSize = frame.size
        let titleSize: CGSize = titleLayout.frame.size
        let imageSize: CGSize = imageLayout.frame.size
        let paddingColumn = CGFloat(style.padding.total(direction: .column))
        switch style.flexDirection {
        case .rowReverse:
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width,
                bottom: 0, right: imageSize.width)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width + imageSize.width,
                bottom: 0, right: imageSize.width)
        case .column:
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width,
                bottom: titleSize.height - buttonSize.height + paddingColumn, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: imageSize.height - buttonSize.height + paddingColumn,
                left: 0, bottom: 0, right: -titleSize.width)
        case .columnReverse:
            button.titleEdgeInsets = UIEdgeInsets(top: titleSize.height - buttonSize.height + paddingColumn,
                left: -imageSize.width, bottom: 0, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0,
                bottom: imageSize.height - buttonSize.height + paddingColumn, right: -titleSize.width)
        default:
            break
        }
        button.contentEdgeInsets = style.padding.edgeInsets
//        Log.debug(button.titleEdgeInsets, button.imageEdgeInsets)
    }
}
