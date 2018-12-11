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

final class RecyclerDataController: UICollectionViewLayout, DataController,
    UICollectionViewDataSource, UICollectionViewDelegate {
    typealias DataType = RecyclerDataElement
    typealias ViewType = UICollectionView

    let mainQueue: OperationQueue = OperationQueue.main
    var currentMap: RecyclerDataElement = RecyclerDataElement()
    var editingQueue: DispatchQueue?
    var cellAttributesCache: AttributesCache = AttributesCache()
    var viewAttributesCache: [String: AttributesCache] = [:]
    weak var delegate: RecyclerElementDelegate?
    weak var owner: RecyclerElement?

    override init() {
        // editingQueue can not init here
        super.init()
        editingQueue = DispatchQueue(label: "com.start.point.data.controller." + address(of: self))
    }

    required init?(coder aDecoder: NSCoder) {
        // editingQueue can not init here
        super.init(coder: aDecoder)
        editingQueue = DispatchQueue(label: "com.start.point.data.controller." + address(of: self))
    }

    func update(to paddingMap: RecyclerDataElement, completion: (() -> Void)?) {
        guard owner != nil else {
            currentMap = paddingMap
            return
        }
        // FIXME: zero width
        let width = owner?._frame.width ?? 0
        layout(map: paddingMap, width: width) { [weak self] in
            guard let this = self else {
                return
            }
            this.mainQueue.addOperation {
                this.currentMap = paddingMap
                let view: UICollectionView? = this.owner?.view
                view?.reloadData()
                completion?()
            }
        }
    }

    func layout(map: RecyclerDataElement, width: Double, completion: @escaping () -> Void) {
        if map.isEmpty {
            completion()
            return
        }
        editingQueue?.async {
            map.layout(width: width)
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
                if let header = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath), !(header.frame.intersection(rect).isEmpty) {
                    result.append(header)
                }
                if let footer = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: indexPath), !(footer.frame.intersection(rect).isEmpty) {
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

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath)
            -> UICollectionViewLayoutAttributes? {
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

    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return currentMap.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMap.itemCount(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
            -> UICollectionViewCell {
        guard let item = currentMap.item(at: indexPath) else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: ElementCollectionCell.identifier,
                for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.identifier, for: indexPath)
        item.build(in: cell)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let item = currentMap.view(kind: kind, at: indexPath) else {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                withReuseIdentifier: ElementReusableView.identifier, for: indexPath)
        }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
            withReuseIdentifier: item.identifier, for: indexPath)
        item.build(in: view)
        return view
    }

    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let element = owner, let target = delegate {
            return target.recyclerElement(element, shouldSelectItemAt: indexPath)
        }
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let element = owner {
            delegate?.recyclerElement(element, didSelectItemAt: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let element = owner, let target = delegate {
            return target.recyclerElement(element, shouldDeselectItemAt: indexPath)
        }
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let element = owner {
            delegate?.recyclerElement(element, didDeselectItemAt: indexPath)
        }
    }
}
