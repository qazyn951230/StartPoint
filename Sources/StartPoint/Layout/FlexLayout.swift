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

public final class FlexLayout: Equatable {
    // MARK: Public properties
    public let style: FlexStyle = FlexStyle()
    public internal(set) weak var parent: FlexLayout? = nil
    public internal(set) var children: [FlexLayout] = []
    public internal(set) var dirty: Bool = false
    // When owner apply new layout, it should set to false
    public var hasNewLayout: Bool = false
    // nodeType
    public var layoutType: LayoutType = .default
    public var measureSelf: ((Double, MeasureMode, Double, MeasureMode) -> Size)? {
        didSet {
            layoutType = measureSelf == nil ? .default : .text
        }
    }
    public var baselineMethod: ((Double, Double) -> Double)?
    // MARK: Internal properties
    let box: FlexBox = FlexBox()
    weak var nextChild: FlexLayout? = nil
    var lastParentDirection: Direction? = nil
    var cachedLayout: LayoutCache? = nil // performLayout == true
    var cachedMeasurements: [LayoutCache] = [] // performLayout == false
    var lineIndex = 0
    var isReferenceBaseline = false

    public init() {
        // Do nothing.
    }

    // YGResolveFlexGrow
    var computedFlexGrow: Double {
        // Root nodes flexGrow should always be 0
        return (parent == nil || style.flex.grow.isNaN) ? 0 : style.flex.grow
    }
    // YGNodeResolveFlexShrink
    var computedFlexShrink: Double {
        // Root nodes flexShrink should always be 0
        return (parent == nil || style.flex.shrink.isNaN) ? 0 : style.flex.shrink
    }
    var flexible: Bool {
        return style.positionType == .relative && (computedFlexGrow != 0 || computedFlexShrink != 0)
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

    // YGNodeMarkDirty
    public func markDirty() {
        // Only a layout with measure function should manually mark self dirty
        if measureSelf != nil {
            _markDirty()
        }
    }

    // markDirtyAndPropogate
    func _markDirty() {
        if dirty {
            return
        }
        dirty = true
        box.computedFlexBasis = Double.nan
        parent?._markDirty()
    }

    public func invalidate() {
        box.invalidate()
        cachedLayout = nil
        cachedMeasurements.removeAll()
    }

    public func copyStyle(from layout: FlexLayout) {
        if style != layout.style {
            style.copy(from: layout.style)
            _markDirty()
        }
    }

    func copy(from layout: FlexLayout) {
        copyStyle(from: layout)
        box.copy(from: layout.box)
        dirty = layout.dirty
        layoutType = layout.layoutType
        measureSelf = layout.measureSelf
        nextChild = layout.nextChild
        box.computedFlexBasis = layout.box.computedFlexBasis
        lastParentDirection = layout.lastParentDirection
        cachedLayout = layout.cachedLayout
        cachedMeasurements = layout.cachedMeasurements
        lineIndex = layout.lineIndex
    }

    // YGNodeClone
    public func copy() -> FlexLayout {
        let layout = FlexLayout()
        layout.copy(from: self)
        layout.children = children
        layout.parent = nil
        return layout
    }

    public func copyChildrenIfNeeded() {
        guard children.count > 0 else {
            return
        }
        guard let first = children.first, first.parent != self else {
            // If the first child has this node as its parent, we assume that it is already unique.
            // We can do this because if we have it has a child, that means that its parent was at some
            // point cloned which made that subtree immutable.
            // We also assume that all its sibling are cloned as well.
            return
        }
        children = children.map {
            let child = $0.copy()
            child.parent = self
            return child
        }
    }

    func frame(left: Double, top: Double) -> Rect {
        return Rect(x: left + box.left, y: top + box.top, width: box.width, height: box.height)
    }

    // MARK: - Managing Child layouts
    public func append(_ child: FlexLayout) {
        guard child.parent == nil else {
//            assertFail("Append a layout with parent")
            return
        }
        copyChildrenIfNeeded()
        children.append(child)
        child.parent = self
        _markDirty()
    }

    // YGNodeInsertChild
    public func insert(_ child: FlexLayout, at index: Int) {
        guard child.parent == nil else {
//            assertFail("Append a layout with parent")
            return
        }
        copyChildrenIfNeeded()
        children.insert(child, at: index)
        child.parent = self
        _markDirty()
    }

    public func replace<C>(_ subrange: Range<Int>, with newElements: C) where C.Element == FlexLayout, C: Collection {
        guard subrange.lowerBound > -1 && subrange.upperBound <= children.count else {
            return
        }
        let old: ArraySlice<FlexLayout> = children[subrange]
        old.forEach { layout in
            layout.invalidate()
            layout.parent = nil
        }
        children.replaceSubrange(subrange, with: newElements)
        newElements.forEach { new in
            new.parent = self
        }
        _markDirty()
    }
    
    public func replace(at index: Int, with element: FlexLayout) {
        guard let old = children.at(index) else {
            return
        }
        children.replace(at: index, with: element)
        old.invalidate()
        old.parent = nil
        element.parent = self
        _markDirty()
    }

    public func replaceAll<C>(_ newElements: C) where C.Element == FlexLayout, C: Collection {
        replace(0..<children.count, with: newElements)
    }

    // YGNodeRemoveChild
    public func remove(_ child: FlexLayout) {
        guard children.count > 0 else {
            return
        }
        if let first = children.first, first.parent == self {
            // If the first child has this node as its parent, we assume that it is already unique.
            // We can now try to delete a child in this list.
            if let index = children.firstIndex(of: child) {
                children.remove(at: index)
                child.invalidate()
                child.parent = nil
                _markDirty()
            }
            return
        }
        var array = [FlexLayout]()
        for item in children {
            if item != child {
                let layout: FlexLayout = item.copy()
                layout.parent = self
                array.append(layout)
            } else {
                child._markDirty()
                continue
            }
        }
        children = array
    }

    public func removeAll() {
        guard children.count > 0 else {
            return
        }
        if let first = children.first, first.parent == self {
            // If the first child has this node as its parent, we assume that this child set is unique.
            for child in children {
                child.invalidate()
                child.parent = nil
            }
        }
        children.removeAll()
        _markDirty()
    }

    public func child(at index: Int) -> FlexLayout? {
        guard index > -1 && index < children.count else {
            return nil
        }
        return children[index]
    }

    @discardableResult
    public func append(to layout: FlexLayout) -> Self {
        layout.append(self)
        return self
    }

    // YGNodeCalculateLayout, YGNodeCalculateLayoutWithContext
    public func calculate(width: Double = .nan, height: Double = .nan, direction: Direction = .ltr) {
        FlexBox.totalGeneration += 1
        resolveDimensions()
        let (_width, widthMode) = layoutMode(size: width, resolvedSize: box.resolvedWidth,
            maxSize: style.computedMaxWidth, direction: .row)
        let (_height, heightMode) = layoutMode(size: height, resolvedSize: box.resolvedHeight,
            maxSize: style.computedMaxHeight, direction: .column)
        let success = layoutInternal(width: _width, height: _height, widthMode: widthMode, heightMode: heightMode,
            parentWidth: width, parentHeight: height, direction: direction, layout: true, reason: "initial")
        if success {
            setPosition(for: style.direction, main: width, cross: height, width: width)
            roundPosition(scale: FlexStyle.scale, absoluteLeft: 0, absoluteTop: 0)
        }
    }

    func measure(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
        return measureSelf?(width, widthMode, height, heightMode) ?? Size.zero
    }

    func baseline(width: Double, height: Double) -> Double {
        return baselineMethod?(width, height) ?? 0.0
    }

    // YGBaseline
    func baseline() -> Double {
        if baselineMethod != nil {
            return baseline(width: box.measuredWidth, height: box.measuredHeight)
        }
        var baselineChild: FlexLayout? = nil
        for child: FlexLayout in children {
            if child.lineIndex > 0 {
                break
            }
            if child.style.absoluteLayout {
                continue
            }
            if computedAlignItem(child: child) == AlignItems.baseline || child.isReferenceBaseline {
                baselineChild = child
                break
            }
            if baselineChild == nil {
                baselineChild = child
            }
        }
        if let child = baselineChild {
            return child.baseline() + child.box.position.top
        } else {
            return box.measuredHeight
        }
    }

    // MARK: Equatable
    public static func ==(lhs: FlexLayout, rhs: FlexLayout) -> Bool {
        return lhs === rhs
    }
}
