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

open class RecyclerCellComponent: Component<UIView>, Identified {
    public private(set) var key: AnyHashable

    public init(key: AnyHashable, children: [BasicComponent] = []) {
        self.key = key
        super.init(children: children)
    }

    open var identifier: String {
        return ComponentCollectionViewCell.identifier
    }

    open override var hashValue: Int {
        return key.hashValue
    }

    open func build(in cell: UICollectionViewCell) {
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
            build(in: cell.contentView)
        }
    }

    open override func applyState(to view: UIView) {
        pendingState.frame = pendingState.frame.setOrigin(.zero)
        super.applyState(to: view)
    }
}

open class RecyclerViewComponent: Component<UIView>, Identified {
    public private(set) var key: AnyHashable

    public init(key: AnyHashable, children: [BasicComponent]) {
        self.key = key
        super.init(children: children)
    }

    open var identifier: String {
        return ComponentCollectionReusableView.identifier
    }

    open override var hashValue: Int {
        return key.hashValue
    }
}

public final class RecyclerSectionComponent: BasicComponent {
    public let items: [RecyclerCellComponent]
    public let header: RecyclerViewComponent?
    public let footer: RecyclerViewComponent?

    public init(items: [RecyclerCellComponent], header: RecyclerViewComponent? = nil,
                footer: RecyclerViewComponent? = nil) {
        self.items = items
        self.header = header
        self.footer = footer
        var children: [BasicComponent] = items
        children.insert(nil: header, at: 0)
        children.append(nil: footer)
        super.init(framed: false, children: items)
    }

    var count: Int {
        return items.count
    }

    public override var hashValue: Int {
        var value = items.hashValue
        if let header = self.header {
            value ^= header.hashValue
        }
        if let footer = self.header {
            value ^= footer.hashValue
        }
        return value
    }
}

public final class RecyclerFlexComponent: BasicComponent {
    public let sections: [RecyclerSectionComponent]

    public init(sections: [RecyclerSectionComponent] = []) {
        self.sections = sections
        super.init(framed: false, children: sections)
    }

    var isEmpty: Bool {
        return sections.isEmpty
    }

    var isNotEmpty: Bool {
        return sections.isNotEmpty
    }

    var count: Int {
        return sections.count
    }

    public override var hashValue: Int {
        return sections.hashValue
    }

    func section(at index: Int) -> RecyclerSectionComponent? {
        return sections.object(at: index)
    }

    func item(at indexPath: IndexPath) -> RecyclerCellComponent? {
        let section = sections.object(at: indexPath.section)
        return section?.items.object(at: indexPath.row)
    }

    func header(at indexPath: IndexPath) -> RecyclerViewComponent? {
        let section = sections.object(at: indexPath.section)
        return section?.header
    }

    func footer(at indexPath: IndexPath) -> RecyclerViewComponent? {
        let section = sections.object(at: indexPath.section)
        return section?.footer
    }

    func view(kind: String, at indexPath: IndexPath) -> RecyclerViewComponent? {
        switch kind {
        case UICollectionElementKindSectionHeader:
            return header(at: indexPath)
        case UICollectionElementKindSectionFooter:
            return footer(at: indexPath)
        default:
            return nil
        }
    }
}