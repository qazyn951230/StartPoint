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

public protocol TableElementDelegate: class {
    func tableElement(_ element: TableElement, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    func tableElement(_ element: TableElement, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    func tableElement(_ element: TableElement, didSelectRowAt indexPath: IndexPath)
    func tableElement(_ element: TableElement, didDeselectRowAt indexPath: IndexPath)
}

public extension TableElementDelegate {
    func tableElement(_ element: TableElement, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }

    func tableElement(_ element: TableElement, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }

    func tableElement(_ element: TableElement, didSelectRowAt indexPath: IndexPath) {
        // Do nothing.
    }

    func tableElement(_ element: TableElement, didDeselectRowAt indexPath: IndexPath) {
        // Do nothing.
    }
}

public protocol TableElementDataSource: class {
    // Items
    func numberOfSections(in table: TableElement) -> Int
    func tableElement(_ table: TableElement, numberOfRowsIn section: Int) -> Int
    func tableElement(_ table: TableElement, itemAt indexPath: IndexPath) -> TableCellElement
    // Header & footer
    func tableElement(_ table: TableElement, headerIn section: Int) -> ViewElement?
    func tableElement(_ table: TableElement, footerIn section: Int) -> ViewElement?
    func tableElement(_ table: TableElement, headerTitleIn section: Int) -> NSAttributedString?
    func tableElement(_ table: TableElement, footerTitleIn section: Int) -> NSAttributedString?
}

public extension TableElementDataSource {
    func tableElement(_ table: TableElement, headerIn section: Int) -> ViewElement? {
        return nil
    }

    func tableElement(_ table: TableElement, footerIn section: Int) -> ViewElement? {
        return nil
    }

    func tableElement(_ table: TableElement, headerTitleIn section: Int) -> NSAttributedString? {
        return nil
    }

    func tableElement(_ table: TableElement, footerTitleIn section: Int) -> NSAttributedString? {
        return nil
    }
}

public class TableElement: BasicTableElement {
    public var delegate: TableElementDelegate? {
        get {
            return dataController.delegate
        }
        set {
            dataController.delegate = newValue
        }
    }
    public var dataSource: TableElementDataSource? {
        get {
            return dataController.dataSource
        }
        set {
            dataController.dataSource = newValue
        }
    }
    let dataController = TableDataController()

    public override func applyState(to view: UITableView) {
        view.delegate = dataController
        view.dataSource = dataController
        super.applyState(to: view)
    }

    public func reloadData(completion: (() -> Void)? = nil) {
        assertMainThread()
        dataController.reloadData(completion: completion)
    }
}
