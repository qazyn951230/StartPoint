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
import QuartzCore

public class ShapeElementState: ElementState {
    public var path: CGPath??
    public var fillColor: CGColor??
    public var fillRule: ShapeElement.FillRule?
    public var lineCap: ShapeElement.LineCap?
    public var lineDashPattern: [Int]??
    public var lineDashPhase: CGFloat?
    public var lineJoin: ShapeElement.LineJoin?
    public var lineWidth: CGFloat?
    public var miterLimit: CGFloat?
    public var strokeColor: CGColor??
    public var strokeStart: CGFloat?
    public var strokeEnd: CGFloat?

    public override func apply(layer: CALayer) {
        if let shape = layer as? CAShapeLayer {
            apply(shapeLayer: shape)
        } else {
            super.apply(layer: layer)
        }
    }

    public func apply(shapeLayer layer: CAShapeLayer) {
        if let path = self.path {
            layer.path = path
        }
        if let fillColor = self.fillColor {
            layer.fillColor = fillColor
        }
        if let fillRule = self.fillRule {
            layer.fillRule = fillRule.value
        }
        if let lineCap = self.lineCap {
            layer.lineCap = lineCap.value
        }
        if let lineDashPattern = self.lineDashPattern {
            layer.lineDashPattern = lineDashPattern?.map(NSNumber.init(value:))
        }
        if let lineDashPhase = self.lineDashPhase {
            layer.lineDashPhase = lineDashPhase
        }
        if let lineJoin = self.lineJoin {
            layer.lineJoin = lineJoin.value
        }
        if let lineWidth = self.lineWidth {
            layer.lineWidth = lineWidth
        }
        if let miterLimit = self.miterLimit {
            layer.miterLimit = miterLimit
        }
        if let strokeColor = self.strokeColor {
            layer.strokeColor = strokeColor
        }
        if let strokeStart = self.strokeStart {
            layer.strokeStart = strokeStart
        }
        if let strokeEnd = self.strokeEnd {
            layer.strokeEnd = strokeEnd
        }
        super.apply(layer: layer)
    }

    public override func invalidate() {
        super.invalidate()
        path = nil
        fillColor = nil
        fillRule = nil
        lineCap = nil
        lineDashPattern = nil
        lineDashPhase = nil
        lineJoin = nil
        lineWidth = nil
        miterLimit = nil
        strokeColor = nil
        strokeStart = nil
        strokeEnd = nil
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

        var value: CAShapeLayerFillRule {
            switch self {
            case .nonZero:
                return CAShapeLayerFillRule.nonZero
            case .evenOdd:
                return CAShapeLayerFillRule.evenOdd
            }
        }
    }

    public enum LineCap {
        case butt
        case round
        case square

        var value: CAShapeLayerLineCap {
            switch self {
            case .butt:
                return CAShapeLayerLineCap.butt
            case .round:
                return CAShapeLayerLineCap.round
            case .square:
                return CAShapeLayerLineCap.square
            }
        }
    }

    public enum LineJoin {
        case miter
        case round
        case bevel

        var value: CAShapeLayerLineJoin {
            switch self {
            case .miter:
                return CAShapeLayerLineJoin.miter
            case .round:
                return CAShapeLayerLineJoin.round
            case .bevel:
                return CAShapeLayerLineJoin.bevel
            }
        }
    }
}
#endif // #if os(iOS)
