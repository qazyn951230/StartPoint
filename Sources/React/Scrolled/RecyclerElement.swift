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

#if os(iOS)
import UIKit

public protocol RecyclerElementDelegate: class {
    func recyclerElement(_ Element: RecyclerElement, shouldSelectItemAt indexPath: IndexPath) -> Bool
    func recyclerElement(_ Element: RecyclerElement, didSelectItemAt indexPath: IndexPath)
    func recyclerElement(_ Element: RecyclerElement, shouldDeselectItemAt indexPath: IndexPath) -> Bool
    func recyclerElement(_ Element: RecyclerElement, didDeselectItemAt indexPath: IndexPath)
}

public extension RecyclerElementDelegate {
    func recyclerElement(_ Element: RecyclerElement, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func recyclerElement(_ Element: RecyclerElement, didSelectItemAt indexPath: IndexPath) {
        // Do nothing.
    }

    func recyclerElement(_ Element: RecyclerElement, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func recyclerElement(_ Element: RecyclerElement, didDeselectItemAt indexPath: IndexPath) {
        // Do nothing.
    }
}

public final class RecyclerElement: Element<UICollectionView> {
    public var delegate: RecyclerElementDelegate? {
        get {
            return dataController.delegate
        }
        set {
            dataController.delegate = newValue
        }
    }
    let dataController: RecyclerDataController = RecyclerDataController()

    public override init(children: [BasicElement] = []) {
        let viewLayout = dataController
        super.init(children: children)
        creator = {
            let view = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
            ElementCollectionCell.register(to: view)
            ElementReusableView.register(to: view)
            return view
        }
    }

    deinit {
        if let collection = view {
            Runner.onMain {
                collection.delegate = nil
                collection.dataSource = nil
            }
        }
    }

    public override func applyState(to view: UICollectionView) {
        view.dataSource = dataController
        view.delegate = dataController
        super.applyState(to: view)
    }

    public func reload(to map: RecyclerDataElement, completion: (() -> Void)? = nil) {
        dataController.update(to: map, completion: completion)
    }

    public func select(item: IndexPath, animated: Bool = true,
                       position: UICollectionView.ScrollPosition = .centeredVertically) {
        assertMainThread()
        view?.selectItem(at: item, animated: animated, scrollPosition: position)
    }

    public func deselect(item: IndexPath, animated: Bool = true) {
        assertMainThread()
        view?.deselectItem(at: item, animated: animated)
    }
}
#endif // #if os(iOS)
