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
import CoreGraphics

public final class TableSectionDataMap {
    public internal(set) var header: ViewElement?
    public internal(set) var headerTitle: String?
    public internal(set) var footer: ViewElement?
    public internal(set) var footerTitle: String?
    public internal(set) var item: [TableCellElement] = []

    public init(rows: Int) {
        item.reserveCapacity(rows)
    }

    public var items: Int {
        return item.count
    }

    public func append(cell: TableCellElement) {
        item.append(cell)
    }

    public func setHeader(_ element: ViewElement?, or title: String?) {
        header = element
        if element == nil {
            headerTitle = title
        }
    }

    public func setFooter(_ element: ViewElement?, or title: String?) {
        footer = element
        if element == nil {
            footerTitle = title
        }
    }

    internal func flatted() -> [BasicElement] {
        var array: [BasicElement] = item
        array.append(nil: header)
        array.append(nil: footer)
        return array
    }
}

public final class TableDataMap {
    public internal(set) var section: [TableSectionDataMap] = []
    internal var width: CGFloat = 0

    public var sections: Int {
        return section.count
    }

    public init(sections: Int = 0) {
        section.reserveCapacity(sections)
    }

    public func append(section: TableSectionDataMap) {
        self.section.append(section)
    }

    public func items(in section: Int) -> Int {
        return self.section[section].items
    }

    public func itemElement(at indexPath: IndexPath) -> TableCellElement {
        let section = self.section.object(at: indexPath.section)
        let item = section?.item.object(at: indexPath.row)
        return item ?? TableCellElement()
    }

    internal func flatted() -> [BasicElement] {
        return section.flatMap {
            $0.flatted()
        }
    }
}

public final class TableDataController: NSObject, UITableViewDelegate, UITableViewDataSource {
    let mainQueue: OperationQueue = OperationQueue.main
    var currentMap: TableDataMap = TableDataMap()
    var editingQueue: DispatchQueue? = nil
    weak var delegate: TableElementDelegate?

    override init() {
        // editingQueue can not init here
        super.init()
        editingQueue = DispatchQueue(label: "com.start.point.data.controller." + address(of: self))
    }

    public func reloadData(in table: TableElement, dataSource: TableElementDataSource, completion: (() -> Void)?) {
        assertMainThread()
        guard let view = table.view else {
            return
        }
        let map = reloadSections(in: table, dataSource: dataSource)
        map.width = view.frame.width
        let fn = TableDataController.prepareUpdate(this: self, paddingMap: map,
            view: view, completion: completion)
        layoutSections(data: map, completion: fn)
    }

    internal func reloadSections(in table: TableElement, dataSource: TableElementDataSource) -> TableDataMap {
        let sections = dataSource.numberOfSections(in: table)
        let map = TableDataMap(sections: sections)
        for i in 0..<sections {
            let rows: Int = dataSource.tableElement(table, numberOfRowsIn: i)
            let section = TableSectionDataMap(rows: rows)
            for j in 0..<rows {
                let k = IndexPath(item: j, section: i)
                section.append(cell: dataSource.tableElement(table, itemAt: k))
            }
            section.setHeader(dataSource.tableElement(table, headerIn: i),
                or: dataSource.tableElement(table, headerTitleIn: i))
            section.setFooter(dataSource.tableElement(table, footerIn: i),
                or: dataSource.tableElement(table, footerTitleIn: i))
            map.append(section: section)
        }
        return map
    }

    internal func layoutSections(data: TableDataMap, completion: @escaping () -> Void) {
        let width = Double(data.width)
        let array = data.flatted()
        guard array.isNotEmpty else {
            completion()
            return
        }
        editingQueue?.async {
            let queue = DispatchQueue.global(qos: .default)
            queue.apply(iterations: array.count) { index in
                let element: BasicElement = array[index]
                element.layout(width: width)
            }
            completion()
        }
    }

    internal static func prepareUpdate(this: TableDataController, paddingMap: TableDataMap, view: UITableView,
                                       completion: (() -> Void)?) -> () -> Void {
        return {
            this.mainQueue.addOperation {
                this.currentMap = paddingMap
                view.reloadData()
                completion?()
            }
        }
    }

    @objc public func numberOfSections(in tableView: UITableView) -> Int {
        return currentMap.sections
    }

    @objc public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMap.items(in: section)
    }

    @objc public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = currentMap.itemElement(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: element.identifier, for: indexPath)
        element.build(in: cell)
        return cell
    }

    @objc public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let element = currentMap.itemElement(at: indexPath)
        // FIXME: Table view cell separator?
        return element.frame.height
    }

    @objc public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableElement(tableView, didSelectRowAt: indexPath)
    }
}
