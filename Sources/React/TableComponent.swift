// MIT License
//
// Copyright (c) 2017 qazyn951230 qazyn951230@gmail.com
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

open class TableCellComponentState: ComponentState {
    public var accessory: UITableViewCellAccessoryType {
        get {
            return _accessory ?? UITableViewCellAccessoryType.none
        }
        set {
            _accessory = newValue
        }
    }
    var _accessory: UITableViewCellAccessoryType?

    open override func apply(view: UIView) {
        if let cell = view as? UITableViewCell {
            apply(cell: cell)
        } else {
            super.apply(view: view)
        }
    }

    open func apply(cell: UITableViewCell) {
        if let accessory = _accessory {
            cell.accessoryType = accessory
        }
        super.apply(view: cell)
    }

    open override func invalidate() {
        _accessory = nil
        super.invalidate()
    }
}

open class TableCellComponent: Component<UIView>, Identified {
    open var identifier: String {
        return "TableCellComponent"
    }

    @discardableResult
    open func buildView(in cell: UITableViewCell) -> UIView {
        return super.buildView(in: cell.contentView)
    }
}

public typealias TableComponent = BasicTableComponent<UITableView>

open class BasicTableComponent<Table: UITableView>: Component<Table> {
    public convenience init(style: UITableViewStyle = .grouped, children: [BasicComponent] = []) {
        self.init(children: children) {
            Table.init(frame: .zero, style: style)
        }
    }

    public override init(children: [BasicComponent] = [], creator: @escaping () -> Table) {
        super.init(children: children, creator: creator)
    }
}
