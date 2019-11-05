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
import CoreGraphics

enum TransitionKind {
    case remove
    case insert
}

final class TransitionItem: Hashable {
    private(set) weak var element: BasicElement?
    let bounds: CGRect
    let center: CGPoint

    init(_ element: BasicElement, _ bounds: CGRect, _ center: CGPoint) {
        self.element = element
        self.bounds = bounds
        self.center = center
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(element)
    }

    static func ==(lhs: TransitionItem, rhs: TransitionItem) -> Bool {
        return lhs.element == rhs.element
    }
}

final class LayoutTransition {
    private var items: Set<TransitionItem> = []
    private weak var root: BasicElement?

    init(root: BasicElement?) {
        self.root = root
    }

    func append(element: BasicElement, bounds: CGRect, center: CGPoint) {
        _ = items.update(with: TransitionItem(element, bounds, center))
    }

    func commit() {
        let items = self.items
        Runner.main { [weak root = self.root] in
            _ = root?._buildView()
            LayoutTransition.apply(items: items)
            Log.debug("print")
            root?.layout.print(options: .layout)
        }
    }

    private static func apply(items: Set<TransitionItem>) {
        assertMainThread()
        for item in items {
            item.element?.applyFrame()
        }
    }
}
#endif // #if os(iOS)
