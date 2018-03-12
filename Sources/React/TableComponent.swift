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

public final class TableSectionDataMap {
    public internal(set) var header: ViewComponent?
    public internal(set) var headerTitle: String?
    public internal(set) var footer: ViewComponent?
    public internal(set) var footerTitle: String?
    public internal(set) var item: [TableCellComponent] = []

    public init(rows: Int) {
        item.reserveCapacity(rows)
    }

    public var items: Int {
        return item.count
    }

    public func append(cell: TableCellComponent) {
        item.append(cell)
    }

    public func setHeader(_ component: ViewComponent?, or title: String?) {
        header = component
        if component == nil {
            headerTitle = title
        }
    }

    public func setFooter(_ component: ViewComponent?, or title: String?) {
        footer = component
        if component == nil {
            footerTitle = title
        }
    }

    internal func flatted() -> [BasicComponent] {
        var array: [BasicComponent] = item
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

    public func itemComponent(at indexPath: IndexPath) -> TableCellComponent {
        let section = self.section.object(at: indexPath.section)
        let item = section?.item.object(at: indexPath.row)
        return item ?? TableCellComponent()
    }

    internal func flatted() -> [BasicComponent] {
        return section.flatMap {
            $0.flatted()
        }
    }
}

public final class TableDataController: NSObject, UITableViewDelegate, UITableViewDataSource {
    let mainQueue: OperationQueue = OperationQueue.main
    var currentMap: TableDataMap = TableDataMap()
    var editingQueue: DispatchQueue? = nil

    override init() {
        super.init()
        editingQueue = DispatchQueue(label: "com.start.point.data.controller." + stringAddress(self))
    }

    // TODO: reloadData with completion
    public func reloadData(in table: TableComponent, dataSource: TableComponentDataSource) {
        assertMainThread()
        guard let view = table.view else {
            return
        }
        let map = reloadSections(in: table, dataSource: dataSource)
        map.width = view.frame.width
        layoutSections(data: map, completion: TableDataController.prepareUpdate(this: self,
            paddingMap: map, view: view))
    }

    internal func reloadSections(in table: TableComponent, dataSource: TableComponentDataSource) -> TableDataMap {
        let sections = dataSource.numberOfSections(in: table)
        let map = TableDataMap(sections: sections)
        for i in 0..<sections {
            let rows = dataSource.tableComponent(table, numberOfRowsIn: i)
            let section = TableSectionDataMap(rows: rows)
            for j in 0..<rows {
                let k = IndexPath(item: j, section: i)
                section.append(cell: dataSource.tableComponent(table, itemAt: k))
            }
            section.setHeader(dataSource.tableComponent(table, headerIn: i),
                or: dataSource.tableComponent(table, headerTitleIn: i))
            section.setFooter(dataSource.tableComponent(table, footerIn: i),
                or: dataSource.tableComponent(table, footerTitleIn: i))
            map.append(section: section)
        }
        return map
    }

    internal func layoutSections(data: TableDataMap, completion: @escaping () -> Void) {
        let width = Double(data.width)
        let array = data.flatted()
        guard array.count > 0 else {
            completion()
            return
        }
        editingQueue?.async {
            let queue = DispatchQueue.global(qos: .default)
            queue.apply(iterations: array.count) { index in
                let component: BasicComponent = array[index]
                component.layout(width: width)
            }
            completion()
        }
    }

    internal static func prepareUpdate(this: TableDataController, paddingMap: TableDataMap, view: UITableView)
            -> () -> Void {
        return {
            this.mainQueue.addOperation {
                this.currentMap = paddingMap
                view.reloadData()
            }
        }
    }

    // MARK: UITableViewDataSource
    @objc public func numberOfSections(in tableView: UITableView) -> Int {
        return currentMap.sections
    }

    @objc public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMap.items(in: section)
    }

    @objc public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = currentMap.itemComponent(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: component.identifier, for: indexPath)
        component.build(in: cell)
        return cell
    }

    @objc public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let component = currentMap.itemComponent(at: indexPath)
        // FIXME: Table view cell separator?
        return component.frame.height
    }
}

open class TableComponent: Component<UITableView> {
    public weak var delegate: TableComponentDelegate?
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

    override func _buildView() -> UITableView {
        let view = super._buildView()
        view.delegate = dataController
        view.dataSource = dataController
        return view
    }

    public func reloadData() {
        guard view != nil, let source = dataSource else {
            return
        }
        dataController.reloadData(in: self, dataSource: source)
    }
}

public final class ComponentTableViewCell: UITableViewCell {
    public static let identifier: String = "ComponentTableViewCell"
}
