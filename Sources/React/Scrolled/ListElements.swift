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

#if os(iOS)
import CoreGraphics

public final class ListSectionElement: BasicElement, ArrayScrollSectionMap {
    public typealias ItemType = TableCellElement
    public typealias ViewType = ViewElement

    public let items: [TableCellElement]
    // FIXME: Section with margin and padding
    public let header: ViewElement?
    public let footer: ViewElement?

    var headerHeight: CGFloat {
        let h: CGFloat = header?.frame.height ?? 0
        let m = layout.box.margin.top
        let p = layout.box.padding.top
        return h + CGFloat(m + p)
    }

    var footerHeight: CGFloat {
        let h: CGFloat = footer?.frame.height ?? 0
        let m = layout.box.margin.bottom
        let p = layout.box.padding.bottom
        return h + CGFloat(m + p)
    }

    public init(items: [TableCellElement], header: ViewElement? = nil,
                footer: ViewElement? = nil) {
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

public final class ListDataElement: BasicElement, ArrayScrollDataMap {
    public typealias SectionType = ListSectionElement
    public let sections: [ListSectionElement]

    public init(sections: [ListSectionElement] = []) {
        self.sections = sections
        super.init(framed: false, children: sections)
    }

    // FIXME: Table view with header view
    func headerHeight(at section: Int) -> CGFloat {
        if let map = self.section(at: section) {
            return map.headerHeight
        }
        return 0
    }

    // FIXME: Table view with footer view
    func footerHeight(at section: Int) -> CGFloat {
        if let map = self.section(at: section) {
            return map.footerHeight
        }
        return 0
    }

    public override func hash(into hasher: inout Hasher) {
        hasher.combine(sections)
    }
}
#endif // #if os(iOS)
