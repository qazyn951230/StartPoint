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

open class RecyclerCellComponent: Component<UIView>, Identified {
    var data: AnyHashable

    public init(data: AnyHashable, children: [BasicComponent] = []) {
        self.data = data
        super.init(children: children)
    }

    open var identifier: String {
        return ComponentCollectionViewCell.identifier
    }

    open override var hashValue: Int {
        return data.hashValue
    }

    open func build(in cell: UICollectionViewCell) {
        assertMainThread()
        if let view = self.view {
            if view.superview != cell.contentView {
                cell.contentView.subviews.forEach {
                    $0.removeFromSuperview()
                }
                view.removeFromSuperview()
                cell.contentView.addSubview(view)
            }
        } else {
            cell.contentView.subviews.forEach {
                $0.removeFromSuperview()
            }
            build(in: cell.contentView)
        }
    }

    open override func applyState(to view: UIView) {
        pendingState.frame = pendingState.frame.setOrigin(.zero)
        super.applyState(to: view)
    }
}

open class RecyclerViewComponent: Component<UIView>, Identified {
    var data: AnyHashable

    public init(data: AnyHashable, children: [BasicComponent]) {
        self.data = data
        super.init(children: children)
    }

    open var identifier: String {
        return ComponentCollectionReusableView.identifier
    }

    open override var hashValue: Int {
        return data.hashValue
    }
}

public final class RecyclerSectionComponent: BasicComponent {
    public let items: [RecyclerCellComponent]
    public let header: RecyclerViewComponent?
    public let footer: RecyclerViewComponent?

    public init(items: [RecyclerCellComponent], header: RecyclerViewComponent? = nil,
                footer: RecyclerViewComponent? = nil) {
        self.items = items
        self.header = header
        self.footer = footer
        var children: [BasicComponent] = items
        children.insert(nil: header, at: 0)
        children.append(nil: footer)
        super.init(framed: false, children: items)
    }

    var count: Int {
        return items.count
    }

    public override var hashValue: Int {
        var value = items.hashValue
        if let header = self.header {
            value ^= header.hashValue
        }
        if let footer = self.header {
            value ^= footer.hashValue
        }
        return value
    }
}

public final class RecyclerFlexComponent: BasicComponent {
    public let sections: [RecyclerSectionComponent]

    public init(sections: [RecyclerSectionComponent] = []) {
        self.sections = sections
        super.init(framed: false, children: sections)
    }

    var isEmpty: Bool {
        return sections.isEmpty
    }

    var isNotEmpty: Bool {
        return sections.isNotEmpty
    }

    var count: Int {
        return sections.count
    }

    public override var hashValue: Int {
        return sections.hashValue
    }

    func section(at index: Int) -> RecyclerSectionComponent? {
        return sections.object(at: index)
    }

    func item(at indexPath: IndexPath) -> RecyclerCellComponent? {
        let section = sections.object(at: indexPath.section)
        return section?.items.object(at: indexPath.row)
    }

    func header(at indexPath: IndexPath) -> RecyclerViewComponent? {
        let section = sections.object(at: indexPath.section)
        return section?.header
    }

    func footer(at indexPath: IndexPath) -> RecyclerViewComponent? {
        let section = sections.object(at: indexPath.section)
        return section?.footer
    }

    func view(kind: String, at indexPath: IndexPath) -> RecyclerViewComponent? {
        switch kind {
        case UICollectionElementKindSectionHeader:
            return header(at: indexPath)
        case UICollectionElementKindSectionFooter:
            return footer(at: indexPath)
        default:
            return nil
        }
    }
}


final class RecyclerSectionData: Hashable {
    var items: [RecyclerCellComponent]
    var header: RecyclerViewComponent?
    var footer: RecyclerViewComponent?

    init(size: Int) {
        items = []
        items.reserveCapacity(size)
    }

    var count: Int {
        return items.count
    }

    var hashValue: Int {
        var value = items.hashValue
        if let header = self.header {
            value ^= header.hashValue
        }
        if let footer = self.header {
            value ^= footer.hashValue
        }
        return value
    }

    func append(cell: RecyclerCellComponent) {
        items.append(cell)
    }

    func insert(cell: RecyclerCellComponent, at index: Int) {
        if index > -1 && index <= items.count {
            items.insert(cell, at: index)
        } else {
            items.append(cell)
        }
    }

    static func ==(lhs: RecyclerSectionData, rhs: RecyclerSectionData) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

final class RecyclerDataMap: Hashable {
    var sections: [RecyclerSectionData]

    init(size: Int = 0) {
        sections = []
        sections.reserveCapacity(size)
    }

    var count: Int {
        return sections.count
    }

    var hashValue: Int {
        return sections.hashValue
    }

    func section(at index: Int) -> RecyclerSectionData? {
        return sections.object(at: index)
    }

    func item(at indexPath: IndexPath) -> RecyclerCellComponent? {
        guard let section = sections.object(at: indexPath.section) else {
            return nil
        }
        return section.items.object(at: indexPath.row)
    }

    static func ==(lhs: RecyclerDataMap, rhs: RecyclerDataMap) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

final class AttributesCache {
    private var map: [IndexPath: UICollectionViewLayoutAttributes] = [:]

    subscript(indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        get {
            return map[indexPath]
        }
        set {
            map[indexPath] = newValue
        }
    }

    func removeAll() {
        map.removeAll()
    }

    func reserveCapacity(_ minimumCapacity: Int) {
        map.reserveCapacity(minimumCapacity)
    }
}

final class RecyclerDataController: UICollectionViewLayout, UICollectionViewDataSource {
    let mainQueue: OperationQueue = OperationQueue.main
//    var currentMap: RecyclerDataMap = RecyclerDataMap()
    var currentMap: RecyclerFlexComponent = RecyclerFlexComponent()
    var editingQueue: DispatchQueue? = nil
    var cellAttributesCache: AttributesCache = AttributesCache()
    var viewAttributesCache: [String: AttributesCache] = [:]

    override init() {
        // editingQueue can not init here
        super.init()
        editingQueue = DispatchQueue(label: "com.start.point.data.controller." + stringAddress(self))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        editingQueue = DispatchQueue(label: "com.start.point.data.controller." + stringAddress(self))
    }

    func update(to paddingMap: RecyclerFlexComponent, completion: (() -> Void)?) {
        guard let view = collectionView else {
            currentMap = paddingMap
            return
        }
        layout(map: paddingMap) { [weak self] in
            guard let this = self else {
                return
            }
            this.mainQueue.addOperation {
                this.currentMap = paddingMap
                view.reloadData()
                completion?()
            }
        }
    }

    func layout(map: RecyclerFlexComponent, completion: @escaping () -> Void) {
        guard map.isNotEmpty else {
            completion()
            return
        }
        let _width: CGFloat? = collectionView?.frame.width
        let width: Double = _width.map(Double.init) ?? Double.nan
        editingQueue?.async {
            let queue = DispatchQueue.global(qos: .default)
            queue.sync {
                map.layout(width: width, height: Double.nan)
            }
            completion()
        }
    }

    // MARK: - UICollectionViewLayout
    override var collectionViewContentSize: CGSize {
        return currentMap.frame.size
    }

    override func prepare() {
        // TODO: layout if needed?
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        assertMainThread()
        var result: [UICollectionViewLayoutAttributes] = []
        var index = 0
        for section in currentMap.sections {
            if (section.frame.intersects(rect)) {
                let indexPath = IndexPath(row: 0, section: index)
                if let header = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                    at: indexPath), !(header.frame.intersection(rect).isEmpty) {
                    result.append(header)
                }
                if let footer = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionFooter,
                    at: indexPath), !(footer.frame.intersection(rect).isEmpty) {
                    result.append(footer)
                }
                for row in 0..<section.count {
                    let indexPath = IndexPath(row: row, section: index)
                    if let item = layoutAttributesForItem(at: indexPath), item.frame.intersects(rect) {
                        result.append(item)
                    }
                }
            }
            index += 1
        }
        return result.count > 0 ? result : nil
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        assertMainThread()
        if let cache = cellAttributesCache[indexPath] {
            return cache
        }
        guard let item = currentMap.item(at: indexPath) else {
            return nil
        }
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = item.frame
        // TODO: Adjust z index
        cellAttributesCache[indexPath] = attributes
        return attributes
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        assertMainThread()
        if let cache = viewAttributesCache[elementKind]?[indexPath] {
            return cache
        }
        guard let view = currentMap.view(kind: elementKind, at: indexPath) else {
            return nil
        }
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = view.frame
        // TODO: Adjust z index
        if let caches = viewAttributesCache[elementKind] {
            caches[indexPath] = attributes
        } else {
            let caches = AttributesCache()
            caches[indexPath] = attributes
            viewAttributesCache[elementKind] = caches
        }
        return attributes
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return currentMap.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMap.section(at: section)?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = currentMap.item(at: indexPath)
        let id = item?.identifier ?? ComponentCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
        item?.build(in: cell)
        return cell
    }
}

public final class RecyclerComponent: Component<UICollectionView> {
    let dataController: RecyclerDataController = RecyclerDataController()

    public override init(children: [BasicComponent] = []) {
        let viewLayout = dataController
        super.init(children: children) {
            let view = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
            ComponentCollectionViewCell.register(to: view)
            ComponentCollectionReusableView.register(to: view)
            view.dataSource = viewLayout
            return view
        }
    }

    deinit {
        if let collection = view {
            runOnMain {
                collection.delegate = nil
                collection.dataSource = nil
            }
        }
    }

    public override func applyState(to view: UICollectionView) {
        super.applyState(to: view)
    }

    public func reload(to map: RecyclerFlexComponent) {
        map.layout.copy(from: layout)
        dataController.update(to: map, completion: nil)
    }
}
