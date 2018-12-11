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

final class TableDataController: NSObject, DataController, UITableViewDelegate, UITableViewDataSource {
    typealias DataType = TableDataMap
    typealias ViewType = UITableView

    let mainQueue: OperationQueue = OperationQueue.main
    var currentMap: TableDataMap = TableDataMap()
    var editingQueue: DispatchQueue? = nil
    weak var delegate: TableElementDelegate?
    weak var dataSource: TableElementDataSource?
    weak var owner: TableElement?

    override init() {
        // editingQueue can not init here
        super.init()
        editingQueue = DispatchQueue(label: "com.start.point.data.controller." + address(of: self))
    }

    func reloadData(completion: (() -> Void)?) {
        guard let source = dataSource, let element = owner else {
            completion?()
            return
        }
        let paddingMap = collectDataMap(from: element, source: source)
        update(to: paddingMap, completion: completion)
    }

    func update(to paddingMap: TableDataMap, completion: (() -> Void)?) {
        // FIXME: zero width
        let width = owner?._frame.width ?? 0
        layout(map: paddingMap, width: width) { [weak self] in
            guard let this = self else {
                return
            }
            this.mainQueue.addOperation {
                this.currentMap = paddingMap
                let view: UITableView? = this.owner?.view
                view?.reloadData()
                completion?()
            }
        }
    }

    func layout(map: TableDataMap, width: Double, completion: @escaping () -> Void) {
        if map.isEmpty {
            completion()
            return
        }
        let array = map.flatted()
        editingQueue?.async {
            let queue = DispatchQueue.global(qos: .default)
            queue.apply(iterations: array.count) { index in
                let element: BasicElement = array[index]
                element.layout(width: width)
            }
            completion()
        }
    }

    func collectDataMap(from element: TableElement, source: TableElementDataSource) -> TableDataMap {
        let n = source.numberOfSections(in: element)
        guard n > 0 else {
            return TableDataMap(sections: [])
        }
        var sections: [TableSectionDataMap] = []
        sections.reserveCapacity(n)
        for i in 0..<n {
            let m = source.tableElement(element, numberOfRowsIn: i)
            var rows: [TableCellElement] = []
            rows.reserveCapacity(m)
            for j in 0..<m {
                let index = IndexPath(row: j, section: i)
                rows.append(source.tableElement(element, itemAt: index))
            }
            let header = source.tableElement(element, headerIn: i)
            let footer = source.tableElement(element, footerIn: i)
            if header != nil && footer != nil {
                let map = TableSectionDataMap(items: rows, header: header, footer: footer)
                sections.append(map)
                continue
            }
            let header2 = source.tableElement(element, headerTitleIn: i)
            let footer2 = source.tableElement(element, footerTitleIn: i)
            let map2 = TableSectionDataMap(items: rows, header: header2, footer: footer2)
            sections.append(map2)
        }
        return TableDataMap(sections: sections)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return currentMap.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMap.itemCount(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let element: TableCellElement = currentMap.item(at: indexPath) else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ElementTableCell.identifier, for: indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: element.identifier, for: indexPath)
        element.build(in: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let element = currentMap.item(at: indexPath) else {
            return tableView.rowHeight
        }
        return element.frame.height
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let element = owner, let target = delegate {
            return target.tableElement(element, willSelectRowAt: indexPath)
        } else {
            return indexPath
        }
    }

    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        if let element = owner, let target = delegate {
            return target.tableElement(element, willDeselectRowAt: indexPath)
        } else {
            return indexPath
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let element = owner {
            delegate?.tableElement(element, didSelectRowAt: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let element = owner {
            delegate?.tableElement(element, didDeselectRowAt: indexPath)
        }
    }
}
