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

public typealias ShapeComponent = BasicShapeComponent<CAShapeLayer>

open class ShapeComponentState: ComponentState {
    public var path: CGPath? {
        get {
            return _path ?? nil
        }
        set {
            _path = newValue
        }
    }
    var _path: CGPath??

    public var fillColor: CGColor? {
        get {
            return _fillColor ?? nil
        }
        set {
            _fillColor = newValue
        }
    }
    var _fillColor: CGColor??

    public var strokeColor: CGColor? {
        get {
            return _strokeColor ?? nil
        }
        set {
            _strokeColor = newValue
        }
    }
    var _strokeColor: CGColor??

    open override func apply(layer: CALayer) {
        if let shape = layer as? CAShapeLayer {
            apply(layer: shape)
        } else {
            super.apply(layer: layer)
        }
    }

    open func apply(layer: CAShapeLayer) {
        if let path = _path {
            layer.path = path
        }
        if let fillColor = _fillColor {
            layer.fillColor = fillColor
        }
        if let strokeColor = _strokeColor {
            layer.strokeColor = strokeColor
        }
        super.apply(layer: layer)
    }

    open override func invalidate() {
        _path = nil
        _fillColor = nil
        _strokeColor = nil
        super.invalidate()
    }
}

open class BasicShapeComponent<ShapeLayer: CAShapeLayer>: BasicLayerComponent<ShapeLayer> {
    var _shapeState: ShapeComponentState?
    public override var pendingState: ShapeComponentState {
        let state = _shapeState ?? ShapeComponentState()
        if _shapeState == nil {
            _shapeState = state
            _pendingState = state
        }
        return state
    }

    @discardableResult
    public func path(_ value: CGPath?) -> Self {
        if mainThread(), let layer = layer {
            layer.path = value
        } else {
            pendingState.path = value
        }
        return self
    }

    @discardableResult
    public func path(_ value: UIBezierPath?) -> Self {
        if mainThread(), let layer = layer {
            layer.path = value?.cgPath
        } else {
            pendingState.path = value?.cgPath
        }
        return self
    }

    @discardableResult
    public func fillColor(_ value: CGColor?) -> Self {
        if mainThread(), let layer = layer {
            layer.fillColor = value
        } else {
            pendingState.fillColor = value
        }
        return self
    }

    @discardableResult
    public func fillColor(_ value: UIColor?) -> Self {
        return fillColor(value?.cgColor)
    }

    @discardableResult
    public func fillColor(hex: UInt32) -> Self {
        let value = UIColor.hex(hex).cgColor
        if mainThread(), let layer = layer {
            layer.fillColor = value
        } else {
            pendingState.fillColor = value
        }
        return self
    }

    @discardableResult
    public func strokeColor(_ value: CGColor?) -> Self {
        if mainThread(), let layer = layer {
            layer.strokeColor = value
        } else {
            pendingState.strokeColor = value
        }
        return self
    }

    @discardableResult
    public func strokeColor(_ value: UIColor?) -> Self {
        return strokeColor(value?.cgColor)
    }

    @discardableResult
    public func strokeColor(hex: UInt32) -> Self {
        let value = UIColor.hex(hex).cgColor
        if mainThread(), let layer = layer {
            layer.strokeColor = value
        } else {
            pendingState.strokeColor = value
        }
        return self
    }
}