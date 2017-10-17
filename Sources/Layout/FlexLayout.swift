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
import CoreGraphics

open class FlexLayout: Equatable {
    public private(set) weak var view: LayoutView?
    public internal(set) var style: FlexStyle
    public internal(set) var dirty: Bool = true
    public internal(set) weak var parent: FlexLayout? = nil
    public internal(set) var children: [FlexLayout] = []

    public var layoutType: LayoutType = .default // nodeType
    public var measureSelf: Bool = false {
        didSet {
            layoutType = measureSelf ? .default : .text
        }
    }
    weak var nextChild: FlexLayout? = nil
    // YGResolveFlexGrow
    var computedFlexGrow: Double { // Root nodes flexGrow should always be 0
        return (parent == nil || style.flex.grow.isNaN) ? 0 : style.flex.grow
    }
    // YGNodeResolveFlexShrink
    var computedFlexShrink: Double { // Root nodes flexShrink should always be 0
        return (parent == nil || style.flex.shrink.isNaN) ? 0 : style.flex.shrink
    }
    var flexed: Bool {
        return style.positionType == .relative &&
            (computedFlexGrow != 0 || computedFlexShrink != 0)
    }
    var computedFlexBasis: Double = Double.nan

    var lastParentDirection: Direction? = nil
    let box: FlexBox = FlexBox()
    var cachedLayout: LayoutCache? = nil // performLayout == true
    var cachedMeasurements: [LayoutCache] = [] // performLayout == false
    var lineIndex = 0

    public var baseline: Double { // YGBaseline
        var baselineChild: FlexLayout? = nil
        for child: FlexLayout in children {
            if child.lineIndex > 0 {
                break
            }
            if child.style.absoluteLayout {
                continue
            }
            if computedAlignItem(child: child) == AlignItems.baseline {
                baselineChild = child
                break
            }
            if baselineChild == nil {
                baselineChild = child
            }
        }
        if let c = baselineChild {
            return c.baseline + c.box.position[FlexDirection.column]
        } else {
            return box.measuredDimension(direction: FlexDirection.column)
        }
    }

    // YGIsBaselineLayout
    var isBaselineLayout: Bool {
        if style.flexDirection.isColumn {
            return false
        }
        if style.alignItems == AlignItems.baseline {
            return true
        }
        for child in children {
            if child.style.relativeLayout && child.style.alignSelf == AlignSelf.baseline {
                return true
            }
        }
        return false
    }

    public var frame: CGRect {
        return CGRect(x: box.left, y: box.top, width: box.width, height: box.height)
    }

    public init(view: LayoutView? = nil) {
        self.view = view
        style = FlexStyle()
        // TODO: measureSelf & layoutType
        measureSelf = view?.measureSelf ?? false
        layoutType = measureSelf ? .text : .default
    }

    @discardableResult
    public func bind(view: LayoutView) -> Self {
        self.view = view
        measureSelf = view.measureSelf
        layoutType = .text
        return self
    }

    open func markDirty() { // YGNodeMarkDirtyInternal
        if dirty {
            return
        }
        dirty = true
        computedFlexBasis = Double.nan
        parent?.markDirty()
    }

    open func invalidate() {
        box.position = .zero
        box.width = Double.nan
        box.height = Double.nan
//        computedFlexBasis = 0
        box.measuredWidth = 0
        box.measuredHeight = 0
    }

    // MARK: - Managing Child layouts
    public func append(_ child: FlexLayout) {
        guard child.parent == nil else {
            // TODO: Warning
            return
        }
        children.append(child)
        child.parent = self
        markDirty()
    }

    public func append(view: LayoutView) -> FlexLayout {
//        if let v = self.view {
//            if let t = view.superview {
//                if t != v {
//                    // FIXME: throw Error
//                    return FlexLayout()
//                }
//            } else {
//                v.addSubview(view)
//            }
//        }
        let layout = FlexLayout(view: view)
        append(layout)
        return layout
    }

    public func insert(_ child: FlexLayout, at index: Int) { // YGNodeInsertChild
        guard child.parent == nil else {
            // TODO: Warning
            return
        }
        children.insert(child, at: index)
        child.parent = self
        markDirty()
    }

    public func remove(_ child: FlexLayout) { // // YGNodeRemoveChild
        if let index = children.index(of: child) {
            children.remove(at: index)
            child.invalidate()
            child.parent = nil
            markDirty()
        }
    }

    public func removeAll() {
        guard children.count > 0 else {
            return
        }
        for child in children {
            child.invalidate()
            child.parent = nil
        }
        children.removeAll()
        markDirty()
    }

    public func child(at index: Int) -> FlexLayout? {
        guard index > 0 && index < children.count else {
            return nil
        }
        return children[index]
    }

    @discardableResult
    public func append(to layout: FlexLayout) -> Self {
        layout.append(self)
        return self
    }

    open func apply(to view: LayoutView? = nil) {
        apply(to: view, left: 0, top: 0)
    }

    public func apply(to view: LayoutView?, left: Double, top: Double) {
        var left = left
        var top = top
        if let view = view ?? self.view {
            let rect = CGRect(x: left + box.left, y: top + box.top, width: box.width, height: box.height)
            view.frame = rect
            left = 0
            top = 0
        } else {
            left += box.left
            top += box.top
        }
        children.forEach {
            $0.apply(to: nil, left: left, top: top)
        }
    }

    public func layout(width: Int?, height: Int?) {
        let width: Double? = width.map(Double.init)
        let height: Double? = height.map(Double.init)
        layout(width: width, height: height)
    }

    public func layout(width: Double? = nil, height: Double? = nil) {
        let width: Double = width ?? Double.nan
        let height: Double = height ?? Double.nan
        let direction: Direction = style.direction == .inherit ? .ltr : style.direction
        calculate(width: width, height: height, direction: direction)
    }

    public func layout(width: CGFloat?, height: CGFloat?) {
        let width: Double? = width.map(Double.init)
        let height: Double? = height.map(Double.init)
        layout(width: width, height: height)
    }

    open func measure(width: CGFloat, widthMode: MeasureMode, height: CGFloat, heightMode: MeasureMode) -> CGSize {
        guard let view = self.view else {
            return CGSize.zero
        }
        let width: CGFloat = widthMode.resolve(width)
        let height: CGFloat = heightMode.resolve(height)
        let size = view.sizeThatFits(CGSize(width: width, height: height))
        return size.ceiled
    }

    // MARK: Equatable
    open static func ==(lhs: FlexLayout, rhs: FlexLayout) -> Bool {
        return lhs === rhs
    }

    // MARK: Debug
    public func debug(file: String = #file, function: String = #function, line: Int = #line) {
#if DEBUG
        func fn(layout: FlexLayout) {
            print(layout.frame)
            layout.children.forEach(fn)
        }

        Log.debug("", file: file, function: function, line: line)
        fn(layout: self)
#endif
    }
}
