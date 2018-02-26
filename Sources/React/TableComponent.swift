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

public typealias TableComponent = BasicTableComponent<UITableView, ComponentState>
//public typealias TableCellComponent = BasicTableCellComponent<UITableViewCell>
//
//open class BasicTableCellComponent<Cell: UITableViewCell>: Component<Cell>, Identified {
//    open var identifier: String {
//        return "BasicTableCellComponent"
//    }
//
//    open var height: CGFloat {
//        // layout.layout()
//        return 0 // layout.frame.height
//    }
//
//    public init(style: UITableViewCellStyle = .default) {
//        let id = self.identifier
//        super.init {
//            Cell.init(style: style, reuseIdentifier: id)
//        }
//    }
//
//    @discardableResult
//    open func buildView() -> Cell {
//        assertMainThread()
//        let this = _buildView()
//        let content = this.contentView
//        subComponents?.forEach {
//            $0.build(in: content)
//        }
//        return this
//    }
//}

open class BasicTableComponent<Table: UITableView, State: ComponentState>: Component<Table, State> {
    public init(style: UITableViewStyle = .grouped) {
        super.init {
            Table.init(frame: .zero, style: style)
        }
    }
}
