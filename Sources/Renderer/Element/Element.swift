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

import Foundation
import UIKit
import CoreGraphics

public struct ElementFlag {
    public var hasGestureRecognizer = true
    public var asynchronously = true
    public var rasterizes = true
    public var bypassEnsureDisplay = true
    public var displaySuspended = true
    public var animateSizeChanges = true
    public var canClearContentsOfLayer = true
    public var canCallSetNeedsDisplayOfLayer = true
    public var implementsDrawRect = true
    public var implementsImageDisplay = true
    public var implementsDrawParameters = true
    public var isEnteringHierarchy = true
    public var isExitingHierarchy = true
    public var isInHierarchy = true
    public var visibilityNotificationsDisabled = true
    public var deallocating = false
}

public struct ElementOption: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let synchronous = ElementOption(rawValue: 0)
    public static let layoutInProgress = ElementOption(rawValue: 1 << 0)
}

open class Element: Hashable, CustomStringConvertible, CustomDebugStringConvertible {
    public let layout = FlexLayout()
    public let lock = MutexLock(recursive: true)
    public let flags = Atomic<ElementOption>([])
    public private(set) var flag = ElementFlag()
    internal var _pendingState: PendingState? = nil
    internal var pendingState: PendingState {
        return lock.locking {
            let state = _pendingState ?? PendingState()
            if _pendingState == nil {
                _pendingState = state
            }
            return state
        }
    }
    public private(set) var children: [Element]? = nil
    public private(set) var superElement: Element? = nil

    internal private(set) var hierarchyState: HierarchyState = []

    public var inHierarchy: Bool {
        return lock.locking {
            flag.isInHierarchy
        }
    }

    // __enterHierarchy
    internal func enterHierarchy() {
        assertMainThread()
        assertFalse(flag.isEnteringHierarchy, "Should not cause recursive enterHierarchy")
        lock.lock()
        defer {
            lock.unlock()
        }
        if !flag.isInHierarchy && !flag.visibilityNotificationsDisabled && !visibilityNotificationsDisabled {
            flag.isEnteringHierarchy = true
            flag.isInHierarchy = true
            lock.unlock()
            willEnterHierarchy()
            children?.forEach {
                $0.willEnterHierarchy()
            }
            lock.lock()
            flag.isEnteringHierarchy = false
        }
        if content == nil {
            let layer = rawLayer
            layer?.setNeedsDisplay()
            // TODO: Placeholder layer
        }
    }

    public var content: Any?

    public func willEnterHierarchy() {
        assertMainThread()
    }

    var visibilityNotificationsDisabled: Bool {
        return lock.locking {
            hierarchyState.contains(.transitioningSuperElement)
        }
    }

    internal var rawLayer: CALayer? {
        return nil
    }
    internal var rawView: UIView? {
        return nil
    }
    internal var loadedLayer: CALayer? {
        return nil
    }
    internal var loadedView: UIView? {
        return nil
    }

    private var _onDidLoad: [(Element) -> Void]? = nil
    public var hashValue: Int {
        return address(of: self).hashValue
    }

    public required init() {
        // Do nothing.
    }

    // MARK: - Lifecycle
    public func onDidLoad(_ method: @escaping (Element) -> Void) {
        lock.lock()
        if _loaded {
            lock.unlock()
            method(self)
        } else {
            var array = _onDidLoad ?? []
            _onDidLoad = array
            array.append(method)
            lock.unlock()
        }
    }

    // MARK: - Loading
    public var loaded: Bool { // nodeLoaded
        if mainThread() {
            // Because the view and layer can only be created and destroyed on Main, that is also the only thread
            // where the state of this property can change. As an optimization, we can avoid locking.
            return _loaded
        }
        return lock.locking {
            self._loaded
        }
    }

    internal var _loaded: Bool { // _locked_isNodeLoaded & __loaded(node)
        fatalError()
    }

    internal var shouldLoad: Bool { // _locked_shouldLoadViewOrLayer
        return !flag.deallocating && !hierarchyState._rasterized
    }

    private func _didLoad() {
        assertMainThread()
        didLoad()
        lock.lock()
        let array: [(Element) -> Void]? = _onDidLoad
        _onDidLoad = nil
        lock.unlock()
        array?.forEach {
            $0(self)
        }
    }

    open func didLoad() {
        assertMainThread()
    }

    // MARK: - Layout
    // __setNeedsLayout & invalidateCalculatedLayout
    internal func invalidateLayout() {
        lock.lock()
        defer {
            lock.unlock()
        }
        layout.markDirty()
    }

    // __layout
    internal func applyLayout() {
        assertThreadAffinity(element: self)
//        var loaded = false
//        lock.lock()
//        loaded = _loaded

    }

    // layoutThatFits:
    public func layout(size: CGSize) {
//        layout.layout(width: size.width, height: size.height)
    }

    // MARK: - Pending State
    // _locked_applyPendingStateToViewOrLayer
    internal func applyPendingState() {
        assertMainThread()
        assert(loaded, "Apply pending state need a view or layer")
    }

    @inline(__always)
    internal func couldApplyState() -> Bool { // ASDisplayNodeShouldApplyBridgedWriteToView
        let loaded = _loaded
        if mainThread() {
            return loaded
        }
        if loaded && !pendingState.dirty {

        }
        return false
    }

    open func layout(width: CGFloat, height: CGFloat) {
//        layout.layout(width: width, height: height)
    }

    // MARK: - Managing the element hierarchy

    // addSubnode & _addSubnode
    public func addSubelement(_ element: Element) {
        assertThreadAffinity(element: self)
        guard element != self && element.superElement != self else {
            return
        }
        lock.lock()
        let index = children?.count ?? 0
        let layerIndex: Int = rawLayer?.sublayers?.count ?? 0
        lock.unlock()
        insertSubelement(element, at: index, layerIndex: layerIndex)
    }

//    // insertSubnode:aboveSubnode: & _insertSubnode:aboveSubnode:
//    public func insertSubelement(_ element: Element, above subelement: Element) {
//        assertThreadAffinity(element: self)
//        if (subelement.superElement != self) {
//            assertFail("Element to insert above must be a subelement")
//            return
//        }
//    }
//
//    // insertSubnode:belowSubnode:
//    public func insertSubelement(_ element: Element, below subelement: Element) {
//
//    }

    // insertSubnode:atIndex: & _insertSubnodeSubviewOrSublayer
    public func insertSubelement(_ element: Element, at index: Int) {
        assertMainThread()
        assert(loaded, "should never be called before our own view is created")
        assert(index != Int.max, "Try to insert node on an index that was not found")
        guard index != Int.max else {
            return
        }
        // canUseViewAPI
        if self is ViewElement && element is ViewElement {
            if let view = element.loadedView {
                rawView?.insertSubview(view, at: index)
            }
        } else {
            if let layer = element.loadedLayer {
                rawLayer?.insertSublayer(layer, at: UInt32(index))
            }
        }
    }

//    public func replaceSubelement(_ element: Element, with other: Element) {
//    }

    // removeFromSupernode & _removeFromSupernode
    public func removeFromSuperElement() {
        assertThreadAffinity(element: self)
        lock.lock()
        weak var superElement = self.superElement
        weak var view = rawView
        weak var layer = rawLayer
        lock.unlock()
        remove(from: superElement, view: view, layer: layer)
    }

    // _removeFromSupernode:view:layer:
    internal func remove(from element: Element?, view: UIView?, layer: CALayer?) {
        element?.removeSubelement(self)
        if view != nil {
            view?.removeFromSuperview()
        } else {
            layer?.removeFromSuperlayer()
        }
    }

    // _addSubnodeViewsAndLayers
    internal func addAllSubelement() {
        assertMainThread()
        guard let array = children else {
            return
        }
        for child in array {
            // _addSubnodeSubviewOrSublayer
            let index: Int = rawLayer != nil ? (rawLayer?.sublayers?.count ?? 0) : Int.max
            insertSubelement(child, at: index)
        }
    }

    // _insertSubnode
    private func insertSubelement(_ element: Element, at index: Int, layerIndex: Int, remove: Bool = false) {
        guard element != self else {
            assertFail("Cannot insert a nil subelement or self as subelement")
            return
        }
        guard index != Int.max else {
            assertFail("Try to insert element on an index that was not found")
            return
        }
        if (self is LayerElement) && !(element is LayerElement) {
            assertFail("Cannot add a view element as a subelement of a layer element." +
                "super: \(self.debugDescription), subelement: \(element.debugDescription)")
            return
        }
        let count: Int = lock.locking {
            self.children?.count ?? 0
        }
        if index > count || index < 0 {
            assertFail("Cannot insert a subelement at index \(index). Count is \(count)")
            return
        }
//        if let parent = element.superElement {
//            // TODO: remove from super element
//        }
        lock.lock()
        children = children ?? []
        children?.insert(element, at: index)
        layout.insert(element.layout, at: index)
        lock.unlock()
        element.setSuperElement(self)
        if loaded {
            insertSubelement(element, at: layerIndex)
        }
    }

    // _removeSubnode
    internal func removeSubelement(_ element: Element) {
        assertThreadAffinity(element: self)
        guard element.superElement == self else {
            return
        }
        lock.lock()
        if let index = children?.index(of: element) {
            children?.remove(at: index)
        }
        layout.remove(element.layout)
        lock.unlock()
        element.setSuperElement(nil)
    }

    // _setSupernode
    private func setSuperElement(_ element: Element?) {
        var changed = false
        var old: Element? = nil
        lock.lock()
        if superElement != element {
            old = superElement
            superElement = element
            changed = true
        }
        lock.unlock()
        if changed {
            var state: HierarchyState = (element?.hierarchyState ?? old?.hierarchyState) ?? []
            if element != nil {
                enterHierarchyState(state)
            } else {
                state.formUnion(.layoutPending)
                exitHierarchyState(state)
            }
        }
    }

    private func enterHierarchyState(_ state: HierarchyState) {
        if state.isEmpty {
            return
        }
        Element.forEach(element: self) { element in
            element.hierarchyState.formUnion(state)
        }
    }

    private func exitHierarchyState(_ state: HierarchyState) {
        if state.isEmpty {
            return
        }
        let newState = state.subtracting(.all)
        Element.forEach(element: self) { element in
            element.hierarchyState.formIntersection(newState)
        }
    }

    public static func forEach(element: Element, _ body: (Element) throws -> Void) rethrows {
        try body(element)
        if let array = element.children {
            for child in array {
                try forEach(element: child, body)
            }
        }
    }

    // _recursivelyTriggerDisplayAndBlock
    fileprivate func triggerDisplay(synchronous: Bool) {
        assertMainThread()
    }

    // MARK: - Subclassing
    public var touchesBegan: ((Set<UITouch>, UIEvent?) -> Void)?
    public var touchesMoved: ((Set<UITouch>, UIEvent?) -> Void)?
    public var touchesEnded: ((Set<UITouch>, UIEvent?) -> Void)?
    public var touchesCancelled: ((Set<UITouch>, UIEvent?) -> Void)?

    // Equatable
    public static func ==(lhs: Element, rhs: Element) -> Bool {
        return lhs === rhs
    }

    // CustomStringConvertible
    open var description: String {
        return ""
    }
    // CustomDebugStringConvertible
    open var debugDescription: String {
        return ""
    }
}

struct Renderer {
    static let rendererQueue: RunLoopQueue<Element> = {
        return RunLoopQueue(runLoop: CFRunLoopGetMain(), retain: false) { (item, drained) in
            item?.triggerDisplay(synchronous: false)
        }
    }()
}
