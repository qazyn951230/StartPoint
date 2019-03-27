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

public protocol ListElementDelegate: class {
    func listElement(_ element: ListElement, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    func listElement(_ element: ListElement, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    func listElement(_ element: ListElement, didSelectRowAt indexPath: IndexPath)
    func listElement(_ element: ListElement, didDeselectRowAt indexPath: IndexPath)
}

public extension ListElementDelegate {
    func listElement(_ element: ListElement, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }

    func listElement(_ element: ListElement, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }

    func listElement(_ element: ListElement, didSelectRowAt indexPath: IndexPath) {
        // Do nothing.
    }

    func listElement(_ element: ListElement, didDeselectRowAt indexPath: IndexPath) {
        // Do nothing.
    }
}

public class ListElement: BasicTableElement {
    public var delegate: ListElementDelegate? {
        get {
            return dataController.delegate
        }
        set {
            dataController.delegate = newValue
        }
    }
    let dataController = ListDataController()

    public override init(children: [BasicElement]) {
        super.init(children: children)
        dataController.owner = self
    }

    public override func applyState(to view: UITableView) {
        view.delegate = dataController
        view.dataSource = dataController
        super.applyState(to: view)
    }

    public func reload(to map: ListDataElement, completion: (() -> Void)? = nil) {
        assertMainThread()
        dataController.update(to: map, completion: completion)
    }

    public func reload(section: Int, to element: ListSectionElement, completion: (() -> Void)? = nil) {
        assertMainThread()
        let map = dataController.currentMap.replace(section: element, at: section)
        dataController.update(to: map, completion: completion)
    }

    public func index(from indexPath: IndexPath) -> Int {
        let map = dataController.currentMap
        if indexPath.section > map.count {
            return 0
        }
        var i = 0
        for index in 0..<indexPath.section {
            i += map.itemCount(in: index)
        }
        return i + indexPath.row
    }

    public override func cellElement(at indexPath: IndexPath) -> TableCellElement? {
        return dataController.currentMap.item(at: indexPath)
    }

    public func cellElement<T>(at indexPath: IndexPath, as result: T.Type) -> T? where T: TableCellElement {
        return cellElement(at: indexPath) as? T
    }

    public override func indexPath(from cellElement: TableCellElement) -> IndexPath? {
        var section = 0
        var row = 0
        for sections in dataController.currentMap.sections {
            row = 0
            for item in sections.items {
                if item == cellElement {
                    return IndexPath(row: row, section: section)
                }
                row += 1
            }
            section += 1
        }
        return nil
    }
}
