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

// For CGFloat
import CoreGraphics

public extension FlexLayout {
    @discardableResult
    public func direction(_ value: Direction) -> FlexLayout {
        if (style.direction != value) {
            style.direction = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func flexDirection(_ value: FlexDirection) -> FlexLayout {
        if (style.flexDirection != value) {
            style.flexDirection = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func justifyContent(_ value: JustifyContent) -> FlexLayout {
        if (style.justifyContent != value) {
            style.justifyContent = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func alignContent(_ value: AlignContent) -> FlexLayout {
        if (style.alignContent != value) {
            style.alignContent = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func alignItems(_ value: AlignItems) -> FlexLayout {
        if (style.alignItems != value) {
            style.alignItems = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func alignSelf(_ value: AlignSelf) -> FlexLayout {
        if (style.alignSelf != value) {
            style.alignSelf = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func flexWrap(_ value: FlexWrap) -> FlexLayout {
        if (style.flexWrap != value) {
            style.flexWrap = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func overflow(_ value: Overflow) -> FlexLayout {
        if (style.overflow != value) {
            style.overflow = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func display(_ value: Display) -> FlexLayout {
        if (style.display != value) {
            style.display = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func flex(_ value: Flex) -> FlexLayout {
        if (style.flex != value) {
            style.flex = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func flexGrow(_ value: Double) -> FlexLayout {
        if (style.flexGrow != value) {
            // Flex default is Flex.None => flexGrow default is 0
            let resolved = value.isNaN ? 0: value
            style.flexGrow = resolved
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func flexShrink(_ value: Double) -> FlexLayout {
        if (style.flexShrink != value) {
            // Flex default is Flex.None => flexShrink default is 0
            let resolved = value.isNaN ? 0: value
            style.flexShrink = resolved
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func flexBasis(_ value: FlexBasis) -> FlexLayout {
        if (style.flexBasis != value) {
            style.flexBasis = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func positionType(_ value: PositionType) -> FlexLayout {
        if (style.positionType != value) {
            style.positionType = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func position(_ value: Position) -> FlexLayout {
        if (style.position != value) {
            style.position = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func position(value: StyleValue) -> FlexLayout {
        return position(Position(value))
    }

    @discardableResult
    public func position(float value: CGFloat) -> FlexLayout {
        return position(Position(StyleValue.length(Double(value))))
    }

    @discardableResult
    public func position(top: StyleValue, left: StyleValue, bottom: StyleValue, right: StyleValue) -> FlexLayout {
        return position(Position(top: top, left: left, bottom: bottom, right: right))
    }

    @discardableResult
    public func position(top: StyleValue, bottom: StyleValue, leading: StyleValue?, trailing: StyleValue?) -> FlexLayout {
        return position(Position(top: top, bottom: bottom, leading: leading, trailing: trailing))
    }

    @discardableResult
    public func position(top value: StyleValue) -> FlexLayout {
        if (style.position.top != value) {
            style.position.top = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func position(bottom value: StyleValue) -> FlexLayout {
        if (style.position.bottom != value) {
            style.position.bottom = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func position(left value: StyleValue) -> FlexLayout {
        if (style.position.left != value) {
            style.position.left = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func position(right value: StyleValue) -> FlexLayout {
        if (style.position.right != value) {
            style.position.right = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func position(leading value: StyleValue) -> FlexLayout {
        if (style.position.leading != value) {
            style.position.leading = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func position(trailing value: StyleValue) -> FlexLayout {
        if (style.position.trailing != value) {
            style.position.trailing = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func position(vertical value: StyleValue) -> FlexLayout {
        position(top: value)
        position(bottom: value)
        return self
    }

    @discardableResult
    public func position(horizontal value: StyleValue) -> FlexLayout {
        position(left: value)
        position(right: value)
        position(leading: value)
        position(trailing: value)
        return self
    }

    @discardableResult
    public func margin(_ value: StyleInsets) -> FlexLayout {
        if (style.margin != value) {
            style.margin = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func margin(value: StyleValue) -> FlexLayout {
        return margin(StyleInsets(value))
    }

    @discardableResult
    public func margin(float value: CGFloat) -> FlexLayout {
        return margin(StyleInsets(StyleValue.length(Double(value))))
    }

    @discardableResult
    public func margin(top: StyleValue, left: StyleValue, bottom: StyleValue, right: StyleValue) -> FlexLayout {
        return margin(StyleInsets(top: top, left: right, bottom: bottom, right: right))
    }

    @discardableResult
    public func margin(top: StyleValue, bottom: StyleValue, leading: StyleValue?, trailing: StyleValue?) -> FlexLayout {
        return margin(StyleInsets(top: top, bottom: bottom, leading: leading, trailing: trailing))
    }

    @discardableResult
    public func margin(top value: StyleValue) -> FlexLayout {
        if (style.margin.top != value) {
            style.margin.top = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func margin(bottom value: StyleValue) -> FlexLayout {
        if (style.margin.bottom != value) {
            style.margin.bottom = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func margin(left value: StyleValue) -> FlexLayout {
        if (style.margin.left != value) {
            style.margin.left = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func margin(right value: StyleValue) -> FlexLayout {
        if (style.margin.right != value) {
            style.margin.right = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func margin(leading value: StyleValue?) -> FlexLayout {
        if (style.margin.leading != value) {
            style.margin.leading = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func margin(trailing value: StyleValue?) -> FlexLayout {
        if (style.margin.trailing != value) {
            style.margin.trailing = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func margin(vertical value: StyleValue) -> FlexLayout {
        margin(top: value)
        margin(bottom: value)
        return self
    }

    @discardableResult
    public func margin(horizontal value: StyleValue) -> FlexLayout {
        margin(left: value)
        margin(right: value)
        return self
    }

    @discardableResult
    public func padding(_ value: StyleInsets) -> FlexLayout {
        if (style.padding != value) {
            style.padding = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func padding(value: StyleValue) -> FlexLayout {
        return padding(StyleInsets(value))
    }

    @discardableResult
    public func padding(float value: CGFloat) -> FlexLayout {
        return padding(StyleInsets(StyleValue.length(Double(value))))
    }

    @discardableResult
    public func padding(top: StyleValue, left: StyleValue, bottom: StyleValue, right: StyleValue) -> FlexLayout {
        return padding(StyleInsets(top: top, left: left, bottom: bottom, right: right))
    }

    @discardableResult
    public func padding(top: StyleValue, bottom: StyleValue, leading: StyleValue?, trailing: StyleValue?) -> FlexLayout {
        return padding(StyleInsets(top: top, bottom: bottom, leading: leading, trailing: trailing))
    }

    @discardableResult
    public func padding(top value: StyleValue) -> FlexLayout {
        if (style.padding.top != value) {
            style.padding.top = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func padding(bottom value: StyleValue) -> FlexLayout {
        if (style.padding.bottom != value) {
            style.padding.bottom = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func padding(left value: StyleValue) -> FlexLayout {
        if (style.padding.left != value) {
            style.padding.left = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func padding(right value: StyleValue) -> FlexLayout {
        if (style.padding.right != value) {
            style.padding.right = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func padding(leading value: StyleValue?) -> FlexLayout {
        if (style.padding.leading != value) {
            style.padding.leading = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func padding(trailing value: StyleValue?) -> FlexLayout {
        if (style.padding.trailing != value) {
            style.padding.trailing = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func padding(vertical value: StyleValue) -> FlexLayout {
        padding(top: value)
        padding(bottom: value)
        return self
    }

    @discardableResult
    public func padding(horizontal value: StyleValue) -> FlexLayout {
        padding(left: value)
        padding(right: value)
        return self
    }

    internal func border(_ value: StyleInsets) -> FlexLayout {
        if (style.border != value) {
            style.border = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func border(_ value: Double) -> FlexLayout {
        let insets = StyleInsets(StyleValue.length(value))
        return border(insets)
    }

    @discardableResult
    public func border(float value: CGFloat) -> FlexLayout {
        let insets = StyleInsets(StyleValue.length(Double(value)))
        return border(insets)
    }

    @discardableResult
    public func border(top: Double, left: Double, bottom: Double, right: Double) -> FlexLayout {
        return border(StyleInsets(top: StyleValue.length(top), left: StyleValue.length(left),
            bottom: StyleValue.length(bottom), right: StyleValue.length(right)))
    }

    @discardableResult
    public func border(top: Double, bottom: Double, leading: Double?, trailing: Double?) -> FlexLayout {
        return border(StyleInsets(top: StyleValue.length(top), bottom: StyleValue.length(bottom),
            leading: StyleValue.makeLength(leading), trailing: StyleValue.makeLength(trailing)))
    }

    @discardableResult
    public func border(top value: Double) -> FlexLayout {
        let v = StyleValue.length(value)
        if (style.border.top != v) {
            style.border.top = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func border(bottom value: Double) -> FlexLayout {
        let v = StyleValue.length(value)
        if (style.border.bottom != v) {
            style.border.bottom = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func border(left value: Double) -> FlexLayout {
        let v = StyleValue.length(value)
        if (style.border.left != v) {
            style.border.left = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func border(right value: Double) -> FlexLayout {
        let v = StyleValue.length(value)
        if (style.border.right != v) {
            style.border.right = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func border(leading value: Double?) -> FlexLayout {
        let v = StyleValue.makeLength(value)
        if (style.border.leading != v) {
            style.border.leading = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func border(trailing value: Double?) -> FlexLayout {
        let v = StyleValue.makeLength(value)
        if (style.border.trailing != v) {
            style.border.trailing = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func border(vertical value: Double) -> FlexLayout {
        let v = StyleValue.length(value)
        if (style.border.top != v) {
            style.border.top = v
            _markDirty()
        }
        if (style.border.bottom != v) {
            style.border.bottom = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func border(horizontal value: Double) -> FlexLayout {
        let v = StyleValue.length(value)
        if (style.border.left != v) {
            style.border.left = v
            _markDirty()
        }
        if (style.border.right != v) {
            style.border.right = v
            _markDirty()
        }
        if (style.border.leading != v) {
            style.border.leading = v
            _markDirty()
        }
        if (style.border.trailing != v) {
            style.border.trailing = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func width(_ value: StyleValue) -> FlexLayout {
        if (style.width != value) {
            style.width = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func width(float value: CGFloat) -> FlexLayout {
        return width(StyleValue.length(Double(value)))
    }

    @discardableResult
    public func height(_ value: StyleValue) -> FlexLayout {
        if (style.height != value) {
            style.height = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func height(float value: CGFloat) -> FlexLayout {
        return height(StyleValue.length(Double(value)))
    }

    @discardableResult
    public func size(_ value: Double) -> FlexLayout {
        let v = StyleValue(floatLiteral: value)
        if (style.width != v) {
            style.width = v
            _markDirty()
        }
        if (style.height != v) {
            style.height = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func size(float value: CGFloat) -> FlexLayout {
        let v = StyleValue.length(Double(value))
        if (style.width != v) {
            style.width = v
            _markDirty()
        }
        if (style.height != v) {
            style.height = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func size(_ value: CGSize) -> FlexLayout {
        return size(width: value.width, height: value.height)
    }

    @discardableResult
    public func size(width: CGFloat, height: CGFloat) -> FlexLayout {
        self.width(float: width)
        self.height(float: height)
        return self
    }

    @discardableResult
    public func minWidth(_ value: StyleValue) -> FlexLayout {
        if (style.minWidth != value) {
            style.minWidth = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func minWidth(float value: CGFloat) -> FlexLayout {
        return minWidth(StyleValue.length(Double(value)))
    }

    @discardableResult
    public func minHeight(_ value: StyleValue) -> FlexLayout {
        if (style.minHeight != value) {
            style.minHeight = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func minHeight(float value: CGFloat) -> FlexLayout {
        return minHeight(StyleValue.length(Double(value)))
    }

    @discardableResult
    public func minSize(_ value: Double) -> FlexLayout {
        let v = StyleValue(floatLiteral: value)
        if (style.minWidth != v) {
            style.minWidth = v
            _markDirty()
        }
        if (style.minHeight != v) {
            style.minHeight = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func minSize(float value: CGFloat) -> FlexLayout {
        let v = StyleValue.length(Double(value))
        if (style.minWidth != v) {
            style.minWidth = v
            _markDirty()
        }
        if (style.minHeight != v) {
            style.minHeight = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func minSize(_ value: CGSize) -> FlexLayout {
        return minSize(width: value.width, height: value.height)
    }

    @discardableResult
    public func minSize(width: CGFloat, height: CGFloat) -> FlexLayout {
        self.minWidth(float: width)
        self.minHeight(float: height)
        return self
    }

    @discardableResult
    public func maxWidth(_ value: StyleValue?) -> FlexLayout {
        if (style.maxWidth != value) {
            style.maxWidth = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func maxWidth(float value: CGFloat?) -> FlexLayout {
        let v: StyleValue?
        if let t = value {
            v = StyleValue.length(Double(t))
        } else {
            v = nil
        }
        return maxWidth(v)
    }

    @discardableResult
    public func maxHeight(_ value: StyleValue?) -> FlexLayout {
        if (style.maxHeight != value) {
            style.maxHeight = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func maxHeight(float value: CGFloat?) -> FlexLayout {
        let v: StyleValue?
        if let t = value {
            v = StyleValue.length(Double(t))
        } else {
            v = nil
        }
        return maxHeight(v)
    }

    @discardableResult
    public func maxSize(_ value: Double?) -> FlexLayout {
        let v: StyleValue?
        if let t = value {
            v = StyleValue(floatLiteral: t)
        } else {
            v = nil
        }
        if (style.maxWidth != v) {
            style.maxWidth = v
            _markDirty()
        }
        if (style.maxHeight != v) {
            style.maxHeight = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func maxSize(float value: CGFloat?) -> FlexLayout {
        let v: StyleValue?
        if let t = value {
            v = StyleValue.length(Double(t))
        } else {
            v = nil
        }
        if (style.maxWidth != v) {
            style.maxWidth = v
            _markDirty()
        }
        if (style.maxHeight != v) {
            style.maxHeight = v
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func maxSize(_ value: CGSize?) -> FlexLayout {
        return maxSize(width: value?.width, height: value?.height)
    }

    @discardableResult
    public func maxSize(width: CGFloat?, height: CGFloat?) -> FlexLayout {
        self.maxWidth(float: width)
        self.maxHeight(float: height)
        return self
    }

    @discardableResult
    public func aspectRatio(_ value: Double) -> FlexLayout {
        if (style.aspectRatio != value) {
            style.aspectRatio = value
            _markDirty()
        }
        return self
    }

    @discardableResult
    public func measure(_ value: @escaping (Double, MeasureMode, Double, MeasureMode) -> Size) -> FlexLayout {
        measureSelf = value
        return self
    }

    @discardableResult
    public func baseline(_ value: @escaping (Double, Double) -> Double) -> FlexLayout {
        baselineMethod = value
        return self
    }
}
