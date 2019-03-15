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

final class ListDataController: NSObject, DataController, UITableViewDelegate, UITableViewDataSource {
    typealias DataType = ListDataElement
    typealias ViewType = UITableView

    let mainQueue: OperationQueue = OperationQueue.main
    var currentMap: ListDataElement = ListDataElement()
    var editingQueue: DispatchQueue?
    weak var delegate: ListElementDelegate?
    weak var owner: ListElement?

    override init() {
        // editingQueue can not init here
        super.init()
        editingQueue = DispatchQueue(label: "com.start.point.data.controller." + address(of: self))
    }

    func update(to paddingMap: ListDataElement, completion: (() -> Void)?) {
        guard owner != nil else {
            currentMap = paddingMap
            return
        }
        // FIXME: zero width
        let width = owner?._frame.width ?? 0
        layout(map: paddingMap, width: width) { [weak  self] in
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

    func layout(map: ListDataElement, width: Double, completion: @escaping () -> Void) {
        if map.isEmpty {
            completion()
            return
        }
        editingQueue?.async {
            map.layout(width: width, height: Double.nan)
            completion()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return currentMap.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMap.itemCount(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let element = currentMap.item(at: indexPath) else {
            return tableView.dequeueReusableCell(withIdentifier: ElementTableCell.identifier, for: indexPath)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: element.identifier, for: indexPath)
        element.build(in: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let element: TableCellElement? = currentMap.item(at: indexPath)
        return element?.frame.height ?? tableView.rowHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return currentMap.headerHeight(at: section)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return currentMap.footerHeight(at: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let element: ViewElement? = currentMap.header(in: section)
        return element?.buildView()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let element: ViewElement? = currentMap.footer(in: section)
        return element?.buildView()
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let element = owner {
            return delegate?.listElement(element, willSelectRowAt: indexPath) ?? indexPath
        }
        return indexPath
    }

    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        if let element = owner {
            return delegate?.listElement(element, willDeselectRowAt: indexPath) ?? indexPath
        }
        return indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let element = owner {
            delegate?.listElement(element, didSelectRowAt: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let element = owner {
            delegate?.listElement(element, didDeselectRowAt: indexPath)
        }
    }
}
