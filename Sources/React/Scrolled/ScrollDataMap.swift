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

import Foundation

public protocol ScrollSectionMap {
    associatedtype ItemType
    associatedtype ViewType

    var header: ViewType? { get }
    var footer: ViewType? { get }

    var isEmpty: Bool { get }
    var count: Int { get }

    func item(at index: Int) -> ItemType?
}

public protocol ScrollDataMap {
    associatedtype SectionType: ScrollSectionMap

    var isEmpty: Bool { get }
    var count: Int { get }

    func section(at index: Int) -> SectionType?
    func item(at indexPath: IndexPath) -> SectionType.ItemType?
    func itemCount(in section: Int) -> Int
    func header(in section: Int) -> SectionType.ViewType?
    func header(at indexPath: IndexPath) -> SectionType.ViewType?
    func footer(in section: Int) -> SectionType.ViewType?
    func footer(at indexPath: IndexPath) -> SectionType.ViewType?
}

public extension ScrollDataMap {
    func item(at indexPath: IndexPath) -> SectionType.ItemType? {
        return section(at: indexPath.section)?.item(at: indexPath.row)
    }

    func itemCount(in section: Int) -> Int {
        return self.section(at: section)?.count ?? 0
    }

    func header(in section: Int) -> SectionType.ViewType? {
        return self.section(at: section)?.header
    }

    func header(at indexPath: IndexPath) -> SectionType.ViewType? {
        return section(at: indexPath.section)?.header
    }

    func footer(in section: Int) -> SectionType.ViewType? {
        return self.section(at: section)?.footer
    }

    func footer(at indexPath: IndexPath) -> SectionType.ViewType? {
        return section(at: indexPath.section)?.footer
    }
}

public protocol ArrayScrollSectionMap: ScrollSectionMap {
    var items: [ItemType] { get }

    init(items: [ItemType], header: ViewType?, footer: ViewType?)
}

extension ArrayScrollSectionMap {
    public var isEmpty: Bool {
        return items.isEmpty
    }

    public var count: Int {
        return items.count
    }

    public func item(at index: Int) -> ItemType? {
        return items.object(at: index)
    }
}

public protocol ArrayScrollDataMap: ScrollDataMap {
    var sections: [SectionType] { get }

    init(sections: [SectionType])

    func items(in section: Int) -> [SectionType.ItemType]
    func replace(section: SectionType, at index: Int) -> Self
    func replace(item: SectionType.ItemType, at indexPath: IndexPath) -> Self
}

extension ArrayScrollDataMap {
    public var isEmpty: Bool {
        return sections.isEmpty
    }

    public var count: Int {
        return sections.count
    }

    public func section(at index: Int) -> SectionType? {
        return sections.object(at: index)
    }
}

extension ArrayScrollDataMap where SectionType: ArrayScrollSectionMap {
    public func items(in section: Int) -> [SectionType.ItemType] {
        return self.section(at: section)?.items ?? []
    }

    public func replace(section: SectionType, at index: Int) -> Self {
        let array = sections.replaced(at: index, with: section)
        return Self.init(sections: array)
    }

    public func replace(item: SectionType.ItemType, at indexPath: IndexPath) -> Self {
        let section = indexPath.section
        guard let temp = self.section(at: section) else {
            return self
        }
        let row = indexPath.row
        let items = temp.items.replaced(at: row, with: item)
        let value = SectionType.init(items: items, header: temp.header, footer: temp.footer)
        let array = sections.replaced(at: section, with: value)
        return Self.init(sections: array)
    }
}
