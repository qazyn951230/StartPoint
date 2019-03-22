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

// UITableViewCellAccessoryType, Table width => n
// Cell                     2x          3x
// none                     n           n
// disclosureIndicator      n - 33      n - 38
// detailDisclosureButton   n - 67      n - 72
// checkmark                n - 39      n - 44
// detailButton             n - 47      n - 52
open class TableCellElement: BasicElement, Identified {
    static let offset: Double = Device.scale < 2.5 ? 0 : 5
    public private(set) var accessory: UITableViewCell.AccessoryType = .none
    public private(set) var selectionStyle: UITableViewCell.SelectionStyle = .default
    var underlayCell: UITableViewCell?

    public init(children: [BasicElement] = []) {
        super.init(framed: true, children: children)
        layout.padding(left: .length(15 + TableCellElement.offset))
    }

    public var identifier: String {
        return ElementTableCell.identifier
    }

    public func build(in cell: UITableViewCell) {
        assertMainThread()
//        if underlayCell == cell {
//            return
//        }
        var old: BasicElement?
        if let container = cell as? ElementContainer {
            old = container.element
            container.element = self
        } else {
            old = cell._element
            cell._element = self
        }
        if old != nil {
            old?.removeFromOwner()
        } else {
            for subview in cell.contentView.subviews {
                subview.removeFromSuperview()
            }
        }
        super.build(in: cell.contentView)
        cell.accessoryType = accessory
        cell.selectionStyle = selectionStyle
    }

    // Cell height do include separator bar
    // eg. cell calculated height   => 44
    //     cell content height      => 43.5 @2x
    override func calculateFrame(left: Double, top: Double, apply: Bool) {
        super.calculateFrame(left: 0, top: 0, apply: apply)
    }

    @discardableResult
    public func accessory(_ value: UITableViewCell.AccessoryType) -> Self {
        accessory = value
        switch value {
        case .none:
            layout.padding(right: 0)
        case .disclosureIndicator:
            layout.padding(right: .length(33 + TableCellElement.offset))
        case .detailDisclosureButton:
            layout.padding(right: .length(67 + TableCellElement.offset))
        case .checkmark:
            layout.padding(right: .length(39 + TableCellElement.offset))
        case .detailButton:
            layout.padding(right: .length(47 + TableCellElement.offset))
        }
        return self
    }

    @discardableResult
    public func selectionStyle(_ value: UITableViewCell.SelectionStyle) -> Self {
        selectionStyle = value
        return self
    }
}

open class DefaultCellElement: TableCellElement {
    public let content: StackElement
    public let image: ImageElement
    public let title: LabelElement

    public convenience init(image: UIImage?, title: NSAttributedString?) {
        let right: StyleValue = image != nil ? 15 : 0
        let _image = ImageElement().sizedImage(image)
            .style { flex in
                flex.margin(right: right)
            }
        let _title = LabelElement().text(title)
        self.init(image: _image, title: _title)
    }

    public init(image: ImageElement, title: LabelElement) {
        self.image = image
        self.title = title
        content = StackElement.horizontal(child: image, title)
            .style { flex in
                flex.flex(1).flexDirection(.row).alignItems(.center)
                    .width(.match)
            }
        super.init(children: [content])
        layout.minHeight(float: 44)
    }
}

open class SubtitleCellElement: TableCellElement {
    public let content: StackElement
    public let image: ImageElement
    public let title: LabelElement
    public let subtitle: LabelElement

    public convenience init(image: UIImage?, title: NSAttributedString?, subtitle: NSAttributedString?) {
        let right: StyleValue = image != nil ? 15 : 0
        let _image = ImageElement().sizedImage(image)
            .style { flex in
                flex.margin(right: right)
            }
        let _title = LabelElement().text(title)
        let _subtitle = LabelElement().text(subtitle)
            .style { flex in
                flex.margin(top: 1)
            }
        self.init(image: _image, title: _title, subtitle: _subtitle)
    }

    public init(image: ImageElement, title: LabelElement, subtitle: LabelElement) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        let right = StackElement.vertical(child: title, subtitle)
        content = StackElement.horizontal(any: image, right)
            .style { flex in
                flex.flex(1).flexDirection(.row).alignItems(.center)
                    .width(.match)
            }
        super.init(children: [content])
        layout.minHeight(float: 44)
    }
}

open class DetailCellElement: TableCellElement {
    public let content: StackElement
    public let image: ImageElement
    public let title: LabelElement
    public let detail: LabelElement

    public convenience init(image: UIImage?, title: NSAttributedString?, detail: NSAttributedString?) {
        let right: StyleValue = image != nil ? 15 : 0
        let _image = ImageElement().sizedImage(image)
            .style { flex in
                flex.margin(right: right)
            }
        let _title = LabelElement().text(title)
        let _detail = LabelElement().text(detail)
            .style { flex in
                flex.margin(right: 15).margin(left: .auto)
            }
        self.init(image: _image, title: _title, detail: _detail)
    }

    public init(image: ImageElement, title: LabelElement, detail: LabelElement) {
        self.image = image
        self.title = title
        self.detail = detail
        content = StackElement.horizontal(any: image, title, detail)
            .style { flex in
                flex.flex(1).flexDirection(.row).alignItems(.center)
                    .width(.match)
            }
        super.init(children: [content])
        layout.minHeight(float: 44)
    }
}

final class TableSectionDataMap: ArrayScrollSectionMap {
    typealias ItemType = TableCellElement
    typealias ViewType = ViewElement

    let header: ViewElement?
    let footer: ViewElement?
    let items: [TableCellElement]

    init(items: [TableCellElement], header: ViewElement?, footer: ViewElement?) {
        self.items = items
        self.header = header
        self.footer = footer
    }

    init(items: [TableCellElement], header: NSAttributedString?, footer: NSAttributedString?) {
        self.items = items
        let text = LabelElement().text(header).multiLine()
        let _header = ViewElement(children: [text])
        self.header = _header
        let text2 = LabelElement().text(footer).multiLine()
        let _footer = ViewElement(children: [text2])
        self.footer = _footer
    }

    func flatted() -> [BasicElement] {
        var array: [BasicElement] = items
        array.append(any: header)
        array.append(any: footer)
        return array
    }
}

final class TableDataMap: ArrayScrollDataMap {
    typealias SectionType = TableSectionDataMap

    let sections: [TableSectionDataMap]

    init(sections: [TableSectionDataMap] = []) {
        self.sections = sections
    }

    func flatted() -> [BasicElement] {
        return sections.flatMap {
            $0.flatted()
        }
    }
}
