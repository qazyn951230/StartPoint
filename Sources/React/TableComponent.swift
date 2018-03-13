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

public protocol TableComponentDelegate: class {
    func tableComponent(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

public protocol TableComponentDataSource: class {
    // Items
    func numberOfSections(in table: TableComponent) -> Int
    func tableComponent(_ table: TableComponent, numberOfRowsIn section: Int) -> Int
    func tableComponent(_ table: TableComponent, itemAt indexPath: IndexPath) -> TableCellComponent
    // Header & footer
    func tableComponent(_ table: TableComponent, headerIn section: Int) -> ViewComponent?
    func tableComponent(_ table: TableComponent, footerIn section: Int) -> ViewComponent?
    func tableComponent(_ table: TableComponent, headerTitleIn section: Int) -> String?
    func tableComponent(_ table: TableComponent, footerTitleIn section: Int) -> String?
}

public extension TableComponentDataSource {
    public func numberOfSections(in table: TableComponent) -> Int {
        return 0
    }

    public func tableComponent(_ table: TableComponent, numberOfRowsIn section: Int) -> Int {
        return 0
    }

    public func tableComponent(_ table: TableComponent, headerIn section: Int) -> ViewComponent? {
        return nil
    }

    public func tableComponent(_ table: TableComponent, footerIn section: Int) -> ViewComponent? {
        return nil
    }

    public func tableComponent(_ table: TableComponent, headerTitleIn section: Int) -> String? {
        return nil
    }

    public func tableComponent(_ table: TableComponent, footerTitleIn section: Int) -> String? {
        return nil
    }
}

open class TableComponent: Component<UITableView> {
    public weak var delegate: TableComponentDelegate? {
        didSet {
            dataController.delegate = delegate
        }
    }
    public weak var dataSource: TableComponentDataSource?
    public let dataController = TableDataController()

    public convenience init(style: UITableViewStyle = .grouped, children: [BasicComponent] = []) {
        self.init(children: children) {
            let view = UITableView(frame: .zero, style: style)
            view.register(ComponentTableViewCell.self, forCellReuseIdentifier: ComponentTableViewCell.identifier)
            return view
        }
    }

    public override init(children: [BasicComponent] = [], creator: @escaping () -> UITableView) {
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
    }

    public func reloadData(completion: (() -> Void)? = nil) {
        guard view != nil, let source = dataSource else {
            return
        }
        dataController.reloadData(in: self, dataSource: source, completion: completion)
    }
}

public final class ComponentTableViewCell: UITableViewCell {
    public static let identifier: String = "ComponentTableViewCell"
}
