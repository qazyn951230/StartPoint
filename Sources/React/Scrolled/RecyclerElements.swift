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

open class RecyclerCellElement: Element<UIView>, Identified {
    public private(set) var key: AnyHashable

    public init(key: AnyHashable, children: [BasicElement] = []) {
        self.key = key
        super.init(children: children)
    }

    public var identifier: String {
        return ElementCollectionCell.identifier
    }

    public override func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }

    public func build(in cell: UICollectionViewCell) {
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

    public override func applyState(to view: UIView) {
        pendingState.frame = pendingState.frame?.setOrigin(.zero)
        super.applyState(to: view)
    }
}

open class RecyclerViewElement: Element<UIView>, Identified {
    public private(set) var key: AnyHashable

    public init(key: AnyHashable, children: [BasicElement]) {
        self.key = key
        super.init(children: children)
    }

    public var identifier: String {
        return ElementReusableView.identifier
    }

    public override func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
}

public final class RecyclerSectionElement: BasicElement, ArrayScrollSectionMap {
    public typealias ItemType = RecyclerCellElement
    public typealias ViewType = RecyclerViewElement

    public let items: [RecyclerCellElement]
    public let header: RecyclerViewElement?
    public let footer: RecyclerViewElement?

    public init(items: [RecyclerCellElement], header: RecyclerViewElement? = nil,
                footer: RecyclerViewElement? = nil) {
        self.items = items
        self.header = header
        self.footer = footer
        var children: [BasicElement] = items
        children.insert(any: header, at: 0)
        children.append(any: footer)
        super.init(framed: false, children: items)
    }

    public override func hash(into hasher: inout Hasher) {
        hasher.combine(items)
        hasher.combine(header)
        hasher.combine(footer)
    }
}

public final class RecyclerDataElement: BasicElement, ArrayScrollDataMap {
    public typealias SectionType = RecyclerSectionElement

    public let sections: [RecyclerSectionElement]

    public init(sections: [RecyclerSectionElement] = []) {
        self.sections = sections
        super.init(framed: false, children: sections)
    }

    public override func hash(into hasher: inout Hasher) {
        hasher.combine(sections)
    }

    func view(kind: String, at indexPath: IndexPath) -> RecyclerViewElement? {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return header(at: indexPath)
        case UICollectionView.elementKindSectionFooter:
            return footer(at: indexPath)
        default:
            return nil
        }
    }
}
