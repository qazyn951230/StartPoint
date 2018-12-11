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

public final class TableElementState: ElementState {
    public var separatorStyle: UITableViewCell.SeparatorStyle?
    public var separatorColor: UIColor??
    public var separatorInset: UIEdgeInsets?

    public override func apply(view: UIView) {
        if let table = view  as? UITableView {
            apply(tableView: table)
        } else {
            super.apply(view: view)
        }
    }

    public func apply(tableView view: UITableView) {
        if let separatorStyle = self.separatorStyle {
            view.separatorStyle = separatorStyle
        }
        if let separatorColor = self.separatorColor {
            view.separatorColor = separatorColor
        }
        if let separatorInset = self.separatorInset {
            view.separatorInset = separatorInset
        }
        super.apply(view: view)
    }

    public override func invalidate() {
        super.invalidate()
        separatorStyle = nil
        separatorColor = nil
        separatorInset = nil
    }
}

open class BasicTableElement: Element<UITableView> {
    var _state: TableElementState?
    public override var pendingState: TableElementState {
        let state = _state ?? TableElementState()
        if _state == nil {
            _state = state
            _pendingState = state
        }
        return state
    }

    public override init(children: [BasicElement]) {
        super.init(children: children)
    }

    public convenience init(style: UITableView.Style = .grouped, children: [BasicElement] = []) {
        self.init(children: children)
        creator = {
            let view = UITableView(frame: .zero, style: style)
            ElementTableCell.register(to: view)
            return view
        }
    }

    deinit {
        if let table = view {
            Runner.onMain {
                table.delegate = nil
                table.dataSource = nil
            }
        }
    }

    public var selectedRow: IndexPath? {
        assertMainThread()
        return view?.indexPathForSelectedRow
    }

    public var selectedRows: [IndexPath] {
        assertMainThread()
        return view?.indexPathsForSelectedRows ?? []
    }

    public func select(row: IndexPath?, animated: Bool = true, position: UITableView.ScrollPosition = .middle) {
        assertMainThread()
        view?.selectRow(at: row, animated: animated, scrollPosition: position)
    }

    public func deselect(row: IndexPath, animated: Bool = true) {
        assertMainThread()
        view?.deselectRow(at: row, animated: animated)
    }

    public func cellElement(at indexPath: IndexPath) -> TableCellElement? {
        return nil
    }

    public func indexPath(from cellElement: TableCellElement) -> IndexPath? {
        return nil
    }

    @discardableResult
    public func separatorStyle(_ value: UITableViewCell.SeparatorStyle) -> Self {
        if Runner.isMain(), let view = self.view {
            view.separatorStyle = value
        } else {
            pendingState.separatorStyle = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func separatorColor(_ value: UIColor?) -> Self {
        if Runner.isMain(), let view = self.view {
            view.separatorColor = value
        } else {
            pendingState.separatorColor = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func separatorInset(_ value: UIEdgeInsets) -> Self {
        if Runner.isMain(), let view = self.view {
            view.separatorInset = value
        } else {
            pendingState.separatorInset = value
            registerPendingState()
        }
        return self
    }
}
