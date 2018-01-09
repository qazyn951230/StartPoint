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

import CoreGraphics

public extension FlexLayout {
    @discardableResult
    public func direction(_ value: Direction) -> Self {
        style.direction = value
        markDirty()
        return self
    }

    @discardableResult
    public func flexDirection(_ value: FlexDirection) -> Self {
        style.flexDirection = value
        markDirty()
        return self
    }

    @discardableResult
    public func justifyContent(_ value: JustifyContent) -> Self {
        style.justifyContent = value
        markDirty()
        return self
    }

    @discardableResult
    public func alignContent(_ value: AlignContent) -> Self {
        style.alignContent = value
        markDirty()
        return self
    }

    @discardableResult
    public func alignItems(_ value: AlignItems) -> Self {
        style.alignItems = value
        markDirty()
        return self
    }

    @discardableResult
    public func alignSelf(_ value: AlignSelf) -> Self {
        style.alignSelf = value
        markDirty()
        return self
    }

    @discardableResult
    public func flexWrap(_ value: FlexWrap) -> Self {
        style.flexWrap = value
        markDirty()
        return self
    }

    @discardableResult
    public func overflow(_ value: Overflow) -> Self {
        style.overflow = value
        markDirty()
        return self
    }

    @discardableResult
    public func display(_ value: Display) -> Self {
        style.display = value
        markDirty()
        return self
    }

    @discardableResult
    public func flex(_ value: Flex) -> Self {
        style.flex = value
        markDirty()
        return self
    }

    @discardableResult
    public func flexGrow(_ value: Double) -> Self {
        style.flexGrow = value
        markDirty()
        return self
    }

    @discardableResult
    public func flexShrink(_ value: Double) -> Self {
        style.flexShrink = value
        markDirty()
        return self
    }

    @discardableResult
    public func flexBasis(_ value: FlexBasis) -> Self {
        style.flexBasis = value
        markDirty()
        return self
    }

    @discardableResult
    public func positionType(_ value: PositionType) -> Self {
        style.positionType = value
        markDirty()
        return self
    }

    @discardableResult
    public func position(_ value: Position) -> Self {
        style.position = value
        markDirty()
        return self
    }

    @discardableResult
    public func position(top value: Double?) -> Self {
        style.position.top = value
        markDirty()
        return self
    }

    @discardableResult
    public func position(bottom value: Double?) -> Self {
        style.position.bottom = value
        markDirty()
        return self
    }

    @discardableResult
    public func position(left value: Double?) -> Self {
        style.position.left = value
        markDirty()
        return self
    }

    @discardableResult
    public func position(right value: Double?) -> Self {
        style.position.right = value
        markDirty()
        return self
    }

    @discardableResult
    public func position(leading value: Double?) -> Self {
        style.position.leading = value
        markDirty()
        return self
    }

    @discardableResult
    public func position(trailing value: Double?) -> Self {
        style.position.trailing = value
        markDirty()
        return self
    }

    @discardableResult
    public func position(vertical value: Double?) -> Self {
        style.position.top = value
        style.position.bottom = value
        markDirty()
        return self
    }

    @discardableResult
    public func position(horizontal value: Double?) -> Self {
        style.position.left = value
        style.position.right = value
        style.position.leading = value
        style.position.trailing = value
        markDirty()
        return self
    }

    @discardableResult
    public func margin(_ value: StyleInsets) -> Self {
        style.margin = value
        markDirty()
        return self
    }

    @discardableResult
    public func margin(top value: Int) -> Self {
        style.margin.top = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(top value: Double) -> Self {
        style.margin.top = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func margin(top value: CGFloat) -> Self {
        style.margin.top = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(bottom value: Int) -> Self {
        style.margin.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(bottom value: Double) -> Self {
        style.margin.bottom = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func margin(bottom value: CGFloat) -> Self {
        style.margin.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(left value: Int) -> Self {
        style.margin.left = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(left value: Double) -> Self {
        style.margin.left = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func margin(left value: CGFloat) -> Self {
        style.margin.left = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(right value: Int) -> Self {
        style.margin.right = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(right value: Double) -> Self {
        style.margin.right = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func margin(right value: CGFloat) -> Self {
        style.margin.right = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(leading value: Int?) -> Self {
        style.margin.leading = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(leading value: Double?) -> Self {
        style.margin.leading = value.map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(leading value: CGFloat?) -> Self {
        style.margin.leading = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(trailing value: Int?) -> Self {
        style.margin.trailing = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(trailing value: Double?) -> Self {
        style.margin.trailing = value.map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(trailing value: CGFloat?) -> Self {
        style.margin.trailing = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(vertical value: Int) -> Self {
        style.margin.top = StyleValue(floatLiteral: Double(value))
        style.margin.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(vertical value: Double) -> Self {
        style.margin.top = StyleValue(floatLiteral: value)
        style.margin.bottom = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func margin(vertical value: CGFloat) -> Self {
        style.margin.top = StyleValue(floatLiteral: Double(value))
        style.margin.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(horizontal value: Int) -> Self {
        style.margin.left = StyleValue(floatLiteral: Double(value))
        style.margin.right = StyleValue(floatLiteral: Double(value))
        style.margin.leading = StyleValue(floatLiteral: Double(value))
        style.margin.trailing = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func margin(horizontal value: Double) -> Self {
        style.margin.left = StyleValue(floatLiteral: value)
        style.margin.right = StyleValue(floatLiteral: value)
        style.margin.leading = StyleValue(floatLiteral: value)
        style.margin.trailing = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func margin(horizontal value: CGFloat) -> Self {
        style.margin.left = StyleValue(floatLiteral: Double(value))
        style.margin.right = StyleValue(floatLiteral: Double(value))
        style.margin.leading = StyleValue(floatLiteral: Double(value))
        style.margin.trailing = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(_ value: StyleInsets) -> Self {
        style.padding = value
        markDirty()
        return self
    }

    @discardableResult
    public func padding(top value: Int) -> Self {
        style.padding.top = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(top value: Double) -> Self {
        style.padding.top = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func padding(top value: CGFloat) -> Self {
        style.padding.top = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(bottom value: Int) -> Self {
        style.padding.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(bottom value: Double) -> Self {
        style.padding.bottom = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func padding(bottom value: CGFloat) -> Self {
        style.padding.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(left value: Int) -> Self {
        style.padding.left = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(left value: Double) -> Self {
        style.padding.left = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func padding(left value: CGFloat) -> Self {
        style.padding.left = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(right value: Int) -> Self {
        style.padding.right = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(right value: Double) -> Self {
        style.padding.right = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func padding(right value: CGFloat) -> Self {
        style.padding.right = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(leading value: Int?) -> Self {
        style.padding.leading = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(leading value: Double?) -> Self {
        style.padding.leading = value.map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(leading value: CGFloat?) -> Self {
        style.padding.leading = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(trailing value: Int?) -> Self {
        style.padding.trailing = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(trailing value: Double?) -> Self {
        style.padding.trailing = value.map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(trailing value: CGFloat?) -> Self {
        style.padding.trailing = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(vertical value: Int) -> Self {
        style.padding.top = StyleValue(floatLiteral: Double(value))
        style.padding.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(vertical value: Double) -> Self {
        style.padding.top = StyleValue(floatLiteral: value)
        style.padding.bottom = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func padding(vertical value: CGFloat) -> Self {
        style.padding.top = StyleValue(floatLiteral: Double(value))
        style.padding.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(horizontal value: Int) -> Self {
        style.padding.left = StyleValue(floatLiteral: Double(value))
        style.padding.right = StyleValue(floatLiteral: Double(value))
        style.padding.leading = StyleValue(floatLiteral: Double(value))
        style.padding.trailing = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func padding(horizontal value: Double) -> Self {
        style.padding.left = StyleValue(floatLiteral: value)
        style.padding.right = StyleValue(floatLiteral: value)
        style.padding.leading = StyleValue(floatLiteral: value)
        style.padding.trailing = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func padding(horizontal value: CGFloat) -> Self {
        style.padding.left = StyleValue(floatLiteral: Double(value))
        style.padding.right = StyleValue(floatLiteral: Double(value))
        style.padding.leading = StyleValue(floatLiteral: Double(value))
        style.padding.trailing = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(_ value: StyleInsets) -> Self {
        style.border = value
        markDirty()
        return self
    }

    @discardableResult
    public func border(top value: Int) -> Self {
        style.border.top = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(top value: Double) -> Self {
        style.border.top = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func border(top value: CGFloat) -> Self {
        style.border.top = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(bottom value: Int) -> Self {
        style.border.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(bottom value: Double) -> Self {
        style.border.bottom = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func border(bottom value: CGFloat) -> Self {
        style.border.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(left value: Int) -> Self {
        style.border.left = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(left value: Double) -> Self {
        style.border.left = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func border(left value: CGFloat) -> Self {
        style.border.left = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(right value: Int) -> Self {
        style.border.right = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(right value: Double) -> Self {
        style.border.right = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func border(right value: CGFloat) -> Self {
        style.border.right = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(leading value: Int?) -> Self {
        style.border.leading = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func border(leading value: Double?) -> Self {
        style.border.leading = value.map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func border(leading value: CGFloat?) -> Self {
        style.border.leading = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func border(trailing value: Int?) -> Self {
        style.border.trailing = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func border(trailing value: Double?) -> Self {
        style.border.trailing = value.map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func border(trailing value: CGFloat?) -> Self {
        style.border.trailing = value.map(Double.init).map(StyleValue.init(floatLiteral:))
        markDirty()
        return self
    }

    @discardableResult
    public func border(vertical value: Int) -> Self {
        style.border.top = StyleValue(floatLiteral: Double(value))
        style.border.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(vertical value: Double) -> Self {
        style.border.top = StyleValue(floatLiteral: value)
        style.border.bottom = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func border(vertical value: CGFloat) -> Self {
        style.border.top = StyleValue(floatLiteral: Double(value))
        style.border.bottom = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(horizontal value: Int) -> Self {
        style.border.left = StyleValue(floatLiteral: Double(value))
        style.border.right = StyleValue(floatLiteral: Double(value))
        style.border.leading = StyleValue(floatLiteral: Double(value))
        style.border.trailing = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func border(horizontal value: Double) -> Self {
        style.border.left = StyleValue(floatLiteral: value)
        style.border.right = StyleValue(floatLiteral: value)
        style.border.leading = StyleValue(floatLiteral: value)
        style.border.trailing = StyleValue(floatLiteral: value)
        markDirty()
        return self
    }

    @discardableResult
    public func border(horizontal value: CGFloat) -> Self {
        style.border.left = StyleValue(floatLiteral: Double(value))
        style.border.right = StyleValue(floatLiteral: Double(value))
        style.border.leading = StyleValue(floatLiteral: Double(value))
        style.border.trailing = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func width(_ value: StyleValue) -> Self {
        style.width = value
        markDirty()
        return self
    }

    @discardableResult
    public func width(float value: CGFloat) -> Self {
        style.width = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func height(_ value: StyleValue) -> Self {
        style.height = value
        markDirty()
        return self
    }

    @discardableResult
    public func height(float value: CGFloat) -> Self {
        style.height = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func size(_ value: Int) -> Self {
        style.width = StyleValue(floatLiteral: Double(value))
        style.height = style.width
        markDirty()
        return self
    }

    @discardableResult
    public func size(_ value: Double) -> Self {
        style.width = StyleValue(floatLiteral: value)
        style.height = style.width
        markDirty()
        return self
    }

    @discardableResult
    public func size(_ value: CGFloat) -> Self {
        style.width = StyleValue(floatLiteral: Double(value))
        style.height = style.width
        markDirty()
        return self
    }

    @discardableResult
    public func size(_ value: CGSize) -> Self {
        style.width = StyleValue(floatLiteral: Double(value.width))
        style.height = StyleValue(floatLiteral: Double(value.height))
        markDirty()
        return self
    }

    @discardableResult
    public func size(width: CGFloat, height: CGFloat) -> Self {
        style.width = StyleValue(floatLiteral: Double(width))
        style.height = StyleValue(floatLiteral: Double(height))
        markDirty()
        return self
    }

    @discardableResult
    public func minWidth(_ value: StyleValue) -> Self {
        style.minWidth = value
        markDirty()
        return self
    }

    @discardableResult
    public func minWidth(float value: CGFloat) -> Self {
        style.minWidth = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func minHeight(_ value: StyleValue) -> Self {
        style.minHeight = value
        markDirty()
        return self
    }

    @discardableResult
    public func minHeight(float value: CGFloat) -> Self {
        style.minHeight = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func minSize(_ value: CGSize) -> Self {
        style.minWidth = StyleValue(floatLiteral: Double(value.width))
        style.minHeight = StyleValue(floatLiteral: Double(value.height))
        markDirty()
        return self
    }

    @discardableResult
    public func maxWidth(_ value: StyleValue?) -> Self {
        style.maxWidth = value
        markDirty()
        return self
    }

    @discardableResult
    public func maxWidth(float value: CGFloat) -> Self {
        style.maxWidth = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func maxHeight(_ value: StyleValue?) -> Self {
        style.maxHeight = value
        markDirty()
        return self
    }

    @discardableResult
    public func maxHeight(float value: CGFloat) -> Self {
        style.maxHeight = StyleValue(floatLiteral: Double(value))
        markDirty()
        return self
    }

    @discardableResult
    public func maxSize(_ value: CGSize) -> Self {
        style.maxWidth = StyleValue(floatLiteral: Double(value.width))
        style.maxHeight = StyleValue(floatLiteral: Double(value.height))
        markDirty()
        return self
    }

    @discardableResult
    public func aspectRatio(_ value: Double) -> Self {
        style.aspectRatio = value
        markDirty()
        return self
    }
}
