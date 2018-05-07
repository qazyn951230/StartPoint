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
    func tableElement(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

public protocol TableElementDataSource: class {
    // Items
    func numberOfSections(in table: TableElement) -> Int
    func tableElement(_ table: TableElement, numberOfRowsIn section: Int) -> Int
    func tableElement(_ table: TableElement, itemAt indexPath: IndexPath) -> TableCellElement
    // Header & footer
    func tableElement(_ table: TableElement, headerIn section: Int) -> ViewElement?
    func tableElement(_ table: TableElement, footerIn section: Int) -> ViewElement?
    func tableElement(_ table: TableElement, headerTitleIn section: Int) -> String?
    func tableElement(_ table: TableElement, footerTitleIn section: Int) -> String?
}

public extension TableElementDataSource {
    public func numberOfSections(in table: TableElement) -> Int {
        return 0
    }

    public func tableElement(_ table: TableElement, numberOfRowsIn section: Int) -> Int {
        return 0
    }

    public func tableElement(_ table: TableElement, headerIn section: Int) -> ViewElement? {
        return nil
    }

    public func tableElement(_ table: TableElement, footerIn section: Int) -> ViewElement? {
        return nil
    }

    public func tableElement(_ table: TableElement, headerTitleIn section: Int) -> String? {
        return nil
    }

    public func tableElement(_ table: TableElement, footerTitleIn section: Int) -> String? {
        return nil
    }
}

open class TableElement: Element<UITableView> {
    public weak var delegate: TableElementDelegate? {
        didSet {
            dataController.delegate = delegate
        }
    }
    public weak var dataSource: TableElementDataSource?
    public let dataController = TableDataController()

    public convenience init(style: UITableViewStyle = .grouped, children: [BasicElement] = []) {
        self.init(children: children) {
            let view = UITableView(frame: .zero, style: style)
            ElementTableViewCell.register(to: view)
            return view
        }
    }

    public override init(children: [BasicElement] = [], creator: @escaping () -> UITableView) {
        super.init(children: children, creator: creator)
    }

    deinit {
        if let table = view {
            runOnMain {
                table.delegate = nil
                table.dataSource = nil
            }
        }
    }

    open override func applyState(to view: UITableView) {
        view.delegate = dataController
        view.dataSource = dataController
        super.applyState(to: view)
        reloadData()
    }

    public func reloadData(completion: (() -> Void)? = nil) {
        assertMainThread()
        guard view != nil, let source = dataSource else {
            return
        }
        dataController.reloadData(in: self, dataSource: source, completion: completion)
    }
}

public final class ElementTableViewCell: UITableViewCell {
    public static let identifier: String = "ElementTableViewCell"
}
