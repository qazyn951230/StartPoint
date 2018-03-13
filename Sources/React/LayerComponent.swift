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

public typealias LayerComponent = BasicLayerComponent<CALayer>

open class BasicLayerComponent<Layer: CALayer>: BasicComponent {
    public internal(set) var layer: Layer?
    public internal(set) var creator: (() -> Layer)?

    private let _children: [BasicLayerComponent]

    override var _frame: Rect {
        didSet {
            if mainThread(), let layer = self.layer {
                layer.frame = _frame.cgRect
            } else {
                pendingState.frame = _frame.cgRect
            }
        }
    }

    public init(children: [BasicComponent] = []) {
        _children = children.flatMap {
            $0 as? BasicLayerComponent
        }
        super.init(framed: true, children: children)
    }

    public init(children: [BasicComponent], creator: @escaping () -> Layer) {
        self.creator = creator
        _children = children.flatMap {
            $0 as? BasicLayerComponent
        }
        super.init(framed: true, children: children)
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

    @discardableResult
    open func buildLayer(in layer: CALayer?) -> Layer {
        assertMainThread()
        let this = _buildLayer()
        layer?.addSublayer(this)
        _children.forEach {
            $0.build(in: this)
        }
        return this
    }

    public func build(in layer: CALayer) {
        assertMainThread()
        let this = _buildLayer()
        if let superlayer = this.superlayer {
            if superlayer != layer {
                this.removeFromSuperlayer()
                layer.addSublayer(this)
            }
        } else {
            layer.addSublayer(this)
        }
        _children.forEach {
            $0.build(in: this)
        }
    }

    public override func build(in view: UIView) {
        assertMainThread()
        let this = _buildLayer()
        let layer = view.layer
        if let superlayer = this.superlayer {
            if superlayer != layer {
                this.removeFromSuperlayer()
                layer.addSublayer(this)
            }
        } else {
            layer.addSublayer(this)
        }
        _children.forEach {
            $0.build(in: this)
        }
    }

    func _createLayer() -> Layer {
        assertMainThread()
        if let layer = self.layer {
            return layer
        }
        let this = creator?() ?? Layer.init()
//        if let container = this as? ComponentContainer {
//            container.component = self
//        } else {
//            this._component = self
//        }
        self.layer = this
        return this
    }

    func _buildLayer() -> Layer {
        let this = _createLayer()
        _pendingState?.apply(layer: this)
        return this
    }

#if DEBUG
    public override func debugMode() {
        backgroundColor(UIColor.random)
        super.debugMode()
    }
#endif

    @discardableResult
    public func backgroundColor(_ value: UIColor?) -> Self {
        if mainThread(), let layer = layer {
            layer.backgroundColor = value?.cgColor
        } else {
            pendingState.backgroundColor = value
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
        }
        return self
    }

    @discardableResult
    public func cornerRadius(_ value: CGFloat) -> Self {
        if mainThread(), let layer = layer {
            layer.cornerRadius = value
        } else {
            pendingState.cornerRadius = value
        }
        return self
    }

    @discardableResult
    public func borderColor(cgColor value: CGColor?) -> Self {
        if mainThread(), let layer = layer {
            layer.borderColor = value
        } else {
            pendingState.borderColor = value
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
        }
        return self
    }
}
