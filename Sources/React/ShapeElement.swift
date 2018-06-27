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

public class ShapeElementState: ElementState {
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

    public var fillRule: ShapeElement.FillRule {
        get {
            return _fillRule ?? ShapeElement.FillRule.nonZero
        }
        set {
            _fillRule = newValue
        }
    }
    var _fillRule: ShapeElement.FillRule?

    public var lineCap: ShapeElement.LineCap {
        get {
            return _lineCap ?? ShapeElement.LineCap.butt
        }
        set {
            _lineCap = newValue
        }
    }
    var _lineCap: ShapeElement.LineCap?

    public var lineDashPattern: [Int]? {
        get {
            return _lineDashPattern ?? nil
        }
        set {
            _lineDashPattern = newValue
        }
    }
    var _lineDashPattern: [Int]??

    public var lineDashPhase: CGFloat {
        get {
            return _lineDashPhase ?? 0
        }
        set {
            _lineDashPhase = newValue
        }
    }
    var _lineDashPhase: CGFloat?

    public var lineJoin: ShapeElement.LineJoin {
        get {
            return _lineJoin ?? ShapeElement.LineJoin.miter
        }
        set {
            _lineJoin = newValue
        }
    }
    var _lineJoin: ShapeElement.LineJoin?

    public var lineWidth: CGFloat {
        get {
            return _lineWidth ?? 0
        }
        set {
            _lineWidth = newValue
        }
    }
    var _lineWidth: CGFloat?

    public var miterLimit: CGFloat {
        get {
            return _miterLimit ?? 10
        }
        set {
            _miterLimit = newValue
        }
    }
    var _miterLimit: CGFloat?

    public var strokeColor: CGColor? {
        get {
            return _strokeColor ?? nil
        }
        set {
            _strokeColor = newValue
        }
    }
    var _strokeColor: CGColor??

    public var strokeStart: CGFloat {
        get {
            return _strokeStart ?? 0
        }
        set {
            _strokeStart = inner(newValue, min: 0, max: 1)
        }
    }
    var _strokeStart: CGFloat?

    public var strokeEnd: CGFloat {
        get {
            return _strokeEnd ?? 1.0
        }
        set {
            _strokeEnd = inner(newValue, min: 0, max: 1)
        }
    }
    var _strokeEnd: CGFloat?

    public override func apply(layer: CALayer) {
        if let shape = layer as? CAShapeLayer {
            apply(shapeLayer: shape)
        } else {
            super.apply(layer: layer)
        }
    }

    public func apply(shapeLayer layer: CAShapeLayer) {
        if let path = _path {
            layer.path = path
        }
        if let fillColor = _fillColor {
            layer.fillColor = fillColor
        }
        if let fillRule = _fillRule {
            layer.fillRule = fillRule.value
        }
        if let lineCap = _lineCap {
            layer.lineCap = lineCap.value
        }
        if let lineDashPattern = _lineDashPattern {
            layer.lineDashPattern = lineDashPattern?.map(NSNumber.init(value:))
        }
        if let lineDashPhase = _lineDashPhase {
            layer.lineDashPhase = lineDashPhase
        }
        if let lineJoin = _lineJoin {
            layer.lineJoin = lineJoin.value
        }
        if let lineWidth = _lineWidth {
            layer.lineWidth = lineWidth
        }
        if let miterLimit = _miterLimit {
            layer.miterLimit = miterLimit
        }
        if let strokeColor = _strokeColor {
            layer.strokeColor = strokeColor
        }
        if let strokeStart = _strokeStart {
            layer.strokeStart = strokeStart
        }
        if let strokeEnd = _strokeEnd {
            layer.strokeEnd = strokeEnd
        }
        super.apply(layer: layer)
    }

    public override func invalidate() {
        _path = nil
        _fillColor = nil
        _fillRule = nil
        _lineCap = nil
        _lineDashPattern = nil
        _lineDashPhase = nil
        _lineJoin = nil
        _lineWidth = nil
        _miterLimit = nil
        _strokeColor = nil
        _strokeStart = nil
        _strokeEnd = nil
        super.invalidate()
    }
}

open class ShapeElement: BasicLayerElement<CAShapeLayer> {
    var _shapeState: ShapeElementState?
    public override var pendingState: ShapeElementState {
        let state = _shapeState ?? ShapeElementState()
        if _shapeState == nil {
            _shapeState = state
            _pendingState = state
        }
        return state
    }

    // MARK: - Configuring a Element’s Visual Appearance
    @discardableResult
    public func path(_ value: CGPath?) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.path = value
        } else {
            pendingState.path = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func path(_ value: UIBezierPath?) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.path = value?.cgPath
        } else {
            pendingState.path = value?.cgPath
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func fillColor(_ value: CGColor?) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.fillColor = value
        } else {
            pendingState.fillColor = value
            registerPendingState()
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
        if Runner.isMain(), let layer = layer {
            layer.fillColor = value
        } else {
            pendingState.fillColor = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func fillRule(_ value: ShapeElement.FillRule) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.fillRule = value.value
        } else {
            pendingState.fillRule = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func lineCap(_ value: ShapeElement.LineCap) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.lineCap = value.value
        } else {
            pendingState.lineCap = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func lineDashPattern(_ value: [Int]?) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.lineDashPattern = value?.map(NSNumber.init(value:))
        } else {
            pendingState.lineDashPattern = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func lineDashPhase(_ value: CGFloat) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.lineDashPhase = value
        } else {
            pendingState.lineDashPhase = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func lineJoin(_ value: ShapeElement.LineJoin) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.lineJoin = value.value
        } else {
            pendingState.lineJoin = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func lineWidth(_ value: CGFloat) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.lineWidth = value
        } else {
            pendingState.lineWidth = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func miterLimit(_ value: CGFloat) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.miterLimit = value
        } else {
            pendingState.miterLimit = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func strokeColor(_ value: CGColor?) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.strokeColor = value
        } else {
            pendingState.strokeColor = value
            registerPendingState()
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
        if Runner.isMain(), let layer = layer {
            layer.strokeColor = value
        } else {
            pendingState.strokeColor = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func strokeStart(_ value: CGFloat) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.strokeStart = value
        } else {
            pendingState.strokeStart = value
            registerPendingState()
        }
        return self
    }

    @discardableResult
    public func strokeEnd(_ value: CGFloat) -> Self {
        if Runner.isMain(), let layer = layer {
            layer.strokeEnd = value
        } else {
            pendingState.strokeEnd = value
            registerPendingState()
        }
        return self
    }

    public enum FillRule {
        case nonZero
        case evenOdd

        var value: String {
            switch self {
            case .nonZero:
                return kCAFillRuleNonZero
            case .evenOdd:
                return kCAFillRuleEvenOdd
            }
        }
    }

    public enum LineCap {
        case butt
        case round
        case square

        var value: String {
            switch self {
            case .butt:
                return kCALineCapButt
            case .round:
                return kCALineCapRound
            case .square:
                return kCALineCapSquare
            }
        }
    }

    public enum LineJoin {
        case miter
        case round
        case bevel

        var value: String {
            switch self {
            case .miter:
                return kCALineJoinMiter
            case .round:
                return kCALineJoinRound
            case .bevel:
                return kCALineJoinBevel
            }
        }
    }
}