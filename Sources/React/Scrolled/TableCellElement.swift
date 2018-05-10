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

// UITableViewCellAccessoryType Table width => n
// Cell                     2x          3x
// none                     n           n
// disclosureIndicator      n - 33      n - 38
// detailDisclosureButton   n - 67      n - 72
// checkmark                n - 39      n - 44
// detailButton             n - 47      n - 52

open class TableCellElement: Element<UIView>, Identified {
    internal static let offset: Double = Device.scale < 2.5 ? 0 : 5
    public private(set) var accessory: UITableViewCellAccessoryType = .none
    public private(set) var selectionStyle: UITableViewCellSelectionStyle = .default

    public override init(children: [BasicElement] = []) {
        super.init(children: children)
        layout.margin(left: .length(15 + TableCellElement.offset))
    }

    open var identifier: String {
        return ElementTableViewCell.identifier
    }

    open func build(in cell: UITableViewCell) {
        assertMainThread()
        if let view = self.view {
            if view.superview != cell.contentView {
                cell.contentView.subviews.forEach {
                    $0.removeFromSuperview()
                }
                view.removeFromSuperview()
                cell.contentView.addSubview(view)
            }
        } else {
            cell.contentView.subviews.forEach {
                $0.removeFromSuperview()
            }
            super.build(in: cell.contentView)
        }
        cell.accessoryType = accessory
        cell.selectionStyle = selectionStyle
    }

    @discardableResult
    public func accessory(_ value: UITableViewCellAccessoryType) -> Self {
        accessory = value
        switch value {
        case .none:
            layout.margin(right: 0)
        case .disclosureIndicator:
            layout.margin(right: .length(33 + TableCellElement.offset))
        case .detailDisclosureButton:
            layout.margin(right: .length(67 + TableCellElement.offset))
        case .checkmark:
            layout.margin(right: .length(39 + TableCellElement.offset))
        case .detailButton:
            layout.margin(right: .length(47 + TableCellElement.offset))
        }
        return self
    }

    @discardableResult
    public func selectionStyle(_ value: UITableViewCellSelectionStyle) -> Self {
        selectionStyle = value
        return self
    }
}
