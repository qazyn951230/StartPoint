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
import QuartzCore

public typealias LayerElement = BasicLayerElement<CALayer>

open class BasicLayerElement<Layer: CALayer>: BasicElement {
    public internal(set) var layer: Layer?
    public internal(set) var creator: (() -> Layer)?

    var _loaded: [(BasicLayerElement<Layer>, Layer) -> Void]?
    private let _children: [BasicLayerElement]

    override var _frame: Rect {
        didSet {
            if mainThread(), let layer = self.layer {
                layer.frame = _frame.cgRect
            } else {
                pendingState.frame = _frame.cgRect
                registerPendingState()
            }
        }
    }

    public init(children: [BasicElement] = []) {
        _children = children.compactMap {
            $0 as? BasicLayerElement
        }
        super.init(framed: true, children: children)
    }

    public init(children: [BasicElement], creator: @escaping () -> Layer) {
        self.creator = creator
        _children = children.compactMap {
            $0 as? BasicLayerElement
        }
        super.init(framed: true, children: children)
    }

    public override var loaded: Bool {
        return layer != nil
    }
    override var _layer: CALayer? {
        return layer
    }

    override var layered: Bool {
        return true
    }

    deinit {
        creator = nil
        if let layer = self.layer {
            if mainThread() {
                layer.removeFromSuperlayer()
            } else {
                DispatchQueue.main.async {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }

    public func loaded(then method: @escaping (BasicLayerElement<Layer>, Layer) -> Void) {
        if mainThread(), let layer = self.layer {
            method(self, layer)
        } else {
            _loaded = _loaded ?? []
            _loaded?.append(method)
        }
    }

    override func _removeFromOwner() {
        super._removeFromOwner()
        layer?.removeFromSuperlayer()
    }

    open override func build(in view: UIView) {
        build(in: view.layer)
    }

    open override func build(in layer: CALayer) {
        assertMainThread()
        let this = buildLayer()
        if let superlayer = this.superlayer {
            if superlayer != layer {
                this.removeFromSuperlayer()
                layer.addSublayer(this)
            }
        } else {
            layer.addSublayer(this)
        }
    }

    open func buildLayer() -> Layer {
        assertMainThread()
        if let l = self.layer {
            return l
        }
        let this = _createLayer()
        applyState(to: this)
        buildChildren(in: this)
        if let methods = _loaded {
            methods.forEach {
                $0(self, this)
            }
        }
        _loaded = nil
        return this
    }

    func _createLayer() -> Layer {
        assertMainThread()
        if let layer = self.layer {
            return layer
        }
        let this = creator?() ?? Layer.init()
        creator = nil
        if let container = this as? ElementContainer {
            container.element = self
        } else {
            this._element = self
        }
        self.layer = this
        return this
    }

    public override func apply() {
        assertMainThread()
        if let layer = self.layer {
            applyState(to: layer)
        }
    }

    open func applyState(to layer: Layer) {
        assertMainThread()
        _pendingState?.apply(layer: layer)
    }

    public override func registerPendingState() {
        if layer == nil {
            return
        }
        super.registerPendingState()
    }

    open func buildChildren(in layer: CALayer) {
        if children.isEmpty {
            return
        }
        children.forEach {
            $0.build(in: layer)
        }
    }

#if DEBUG
    public override func debugMode() {
        backgroundColor(UIColor.random)
        super.debugMode()
    }
#endif
}

extension BasicLayerElement {
    @discardableResult
    public func backgroundColor(_ value: UIColor?) -> Self {
        if mainThread(), let layer = layer {
            layer.backgroundColor = value?.cgColor
        } else {
            pendingState.backgroundColor = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func backgroundColor(hex: UInt32) -> Self {
        let value = UIColor.hex(hex)
        if mainThread(), let layer = layer {
            layer.backgroundColor = value.cgColor
        } else {
            pendingState.backgroundColor = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func cornerRadius(_ value: CGFloat) -> Self {
        if mainThread(), let layer = layer {
            layer.cornerRadius = value
        } else {
            pendingState.cornerRadius = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func borderColor(cgColor value: CGColor?) -> Self {
        if mainThread(), let layer = layer {
            layer.borderColor = value
        } else {
            pendingState.borderColor = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func borderColor(_ value: UIColor?) -> Self {
        return borderColor(cgColor: value?.cgColor)
    }

    @discardableResult
    public func borderColor(hex value: UInt32) -> Self {
        return borderColor(cgColor: UIColor.hex(value).cgColor)
    }

    @discardableResult
    public func borderWidth(_ value: CGFloat) -> Self {
        if mainThread(), let layer = layer {
            layer.borderWidth = value
        } else {
            pendingState.borderWidth = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func border(color: UIColor?, width: CGFloat) -> Self {
        if mainThread(), let layer = layer {
            layer.borderColor = color?.cgColor
            layer.borderWidth = width
        } else {
            let state = pendingState
            state.borderColor = color?.cgColor
            state.borderWidth = width
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func border(hex value: UInt32, width: CGFloat) -> Self {
        let color = UIColor.hex(value).cgColor
        if mainThread(), let layer = layer {
            layer.borderColor = color
            layer.borderWidth = width
        } else {
            let state = pendingState
            state.borderColor = color
            state.borderWidth = width
            registerPendingState()
        }
        return self
    }
}
