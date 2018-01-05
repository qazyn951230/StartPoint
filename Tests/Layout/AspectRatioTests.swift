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

@testable import StartPoint
import XCTest

// Generated from YGAspectRatioTest.cpp
class AspectRatioTests: FlexTestCase {
    func _measure(width: CGFloat, widthMode: MeasureMode, height: CGFloat, heightMode _: MeasureMode) -> CGSize {
        let width: CGFloat = widthMode.isExactly ? width : 50
        let height: CGFloat = widthMode.isExactly ? height : 50
        return CGSize(width: width, height: height)
    }

    // Generated from test: aspect_ratio_cross_defined
    func testAspectRatioCrossDefined() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 50
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_main_defined
    func testAspectRatioMainDefined() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = 50
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_both_dimensions_defined_row
    func testAspectRatioBothDimensionsDefinedRow() {
        let root = FlexLayout()
        root.style.flexDirection = FlexDirection.row
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 100
        root_child0.style.height = 50
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: aspect_ratio_both_dimensions_defined_column
    func testAspectRatioBothDimensionsDefinedColumn() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 100
        root_child0.style.height = 50
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_align_stretch
    func testAspectRatioAlignStretch() {
        let root = FlexLayout()
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: aspect_ratio_flex_grow
    func testAspectRatioFlexGrow() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = 50
        root_child0.style.flexGrow = 1
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: aspect_ratio_flex_shrink
    func testAspectRatioFlexShrink() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = 150
        root_child0.style.flexShrink = 1
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: aspect_ratio_flex_shrink_2
    func testAspectRatioFlexShrink2() {
        let root = FlexLayout()
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = StyleValue.percentage(100)
        root_child0.style.flexShrink = 1
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.style.height = StyleValue.percentage(100)
        root_child1.style.flexShrink = 1
        root_child1.style.aspectRatio = 1
        root.append(root_child1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 50)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)
    }

    // Generated from test: aspect_ratio_basis
    func testAspectRatioBasis() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.flexBasis = 50
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_absolute_layout_width_defined
    func testAspectRatioAbsoluteLayoutWidthDefined() {
        let root = FlexLayout()
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.positionType = PositionType.absolute
        root_child0.style.position.left = 0
        root_child0.style.position.top = 0
        root_child0.style.width = 50
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_absolute_layout_height_defined
    func testAspectRatioAbsoluteLayoutHeightDefined() {
        let root = FlexLayout()
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.positionType = PositionType.absolute
        root_child0.style.position.left = 0
        root_child0.style.position.top = 0
        root_child0.style.height = 50
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_with_max_cross_defined
    func testAspectRatioWithMaxCrossDefined() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = 50
        root_child0.style.maxWidth = 40
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 40)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_with_max_main_defined
    func testAspectRatioWithMaxMainDefined() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 50
        root_child0.style.maxHeight = 40
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 40)
        XCTAssertEqual(root_child0.box.height, 40)
    }

    // Generated from test: aspect_ratio_with_min_cross_defined
    func testAspectRatioWithMinCrossDefined() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = 30
        root_child0.style.minWidth = 40
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 40)
        XCTAssertEqual(root_child0.box.height, 30)
    }

    // Generated from test: aspect_ratio_with_min_main_defined
    func testAspectRatioWithMinMainDefined() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 30
        root_child0.style.minHeight = 40
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 40)
        XCTAssertEqual(root_child0.box.height, 40)
    }

    // Generated from test: aspect_ratio_double_cross
    func testAspectRatioDoubleCross() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = 50
        root_child0.style.aspectRatio = 2
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_half_cross
    func testAspectRatioHalfCross() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = 100
        root_child0.style.aspectRatio = 0.5
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: aspect_ratio_double_main
    func testAspectRatioDoubleMain() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 50
        root_child0.style.aspectRatio = 0.5
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: aspect_ratio_half_main
    func testAspectRatioHalfMain() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 100
        root_child0.style.aspectRatio = 2
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_with_measure_func
    func testAspectRatioWithMeasureFunc() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = MeasureLayout()
        root_child0._measure = _measure
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_width_height_flex_grow_row
    func testAspectRatioWidthHeightFlexGrowRow() {
        let root = FlexLayout()
        root.style.flexDirection = FlexDirection.row
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 200

        let root_child0 = FlexLayout()
        root_child0.style.width = 50
        root_child0.style.height = 50
        root_child0.style.flexGrow = 1
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: aspect_ratio_width_height_flex_grow_column
    func testAspectRatioWidthHeightFlexGrowColumn() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 200
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 50
        root_child0.style.height = 50
        root_child0.style.flexGrow = 1
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: aspect_ratio_height_as_flex_basis
    func testAspectRatioHeightAsFlexBasis() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.flexDirection = FlexDirection.row
        root.style.width = 200
        root.style.height = 200

        let root_child0 = FlexLayout()
        root_child0.style.height = 50
        root_child0.style.flexGrow = 1
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.style.height = 100
        root_child1.style.flexGrow = 1
        root_child1.style.aspectRatio = 1
        root.append(root_child1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 75)
        XCTAssertEqual(root_child0.box.height, 75)

        XCTAssertEqual(root_child1.box.left, 75)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 125)
        XCTAssertEqual(root_child1.box.height, 125)
    }

    // Generated from test: aspect_ratio_width_as_flex_basis
    func testAspectRatioWidthAsFlexBasis() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 200
        root.style.height = 200

        let root_child0 = FlexLayout()
        root_child0.style.width = 50
        root_child0.style.flexGrow = 1
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        let root_child1 = FlexLayout()
        root_child1.style.width = 100
        root_child1.style.flexGrow = 1
        root_child1.style.aspectRatio = 1
        root.append(root_child1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 75)
        XCTAssertEqual(root_child0.box.height, 75)

        XCTAssertEqual(root_child1.box.left, 0)
        XCTAssertEqual(root_child1.box.top, 75)
        XCTAssertEqual(root_child1.box.width, 125)
        XCTAssertEqual(root_child1.box.height, 125)
    }

    // Generated from test: aspect_ratio_overrides_flex_grow_row
    func testAspectRatioOverridesFlexGrowRow() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.flexDirection = FlexDirection.row
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 50
        root_child0.style.flexGrow = 1
        root_child0.style.aspectRatio = 0.5
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 200)
    }

    // Generated from test: aspect_ratio_overrides_flex_grow_column
    func testAspectRatioOverridesFlexGrowColumn() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = 50
        root_child0.style.flexGrow = 1
        root_child0.style.aspectRatio = 2
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 100)
    }

    // Generated from test: aspect_ratio_left_right_absolute
    func testAspectRatioLeftRightAbsolute() {
        let root = FlexLayout()
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.positionType = PositionType.absolute
        root_child0.style.position.left = 10
        root_child0.style.position.top = 10
        root_child0.style.position.right = 10
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 80)
    }

    // Generated from test: aspect_ratio_top_bottom_absolute
    func testAspectRatioTopBottomAbsolute() {
        let root = FlexLayout()
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.positionType = PositionType.absolute
        root_child0.style.position.left = 10
        root_child0.style.position.top = 10
        root_child0.style.position.bottom = 10
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 10)
        XCTAssertEqual(root_child0.box.top, 10)
        XCTAssertEqual(root_child0.box.width, 80)
        XCTAssertEqual(root_child0.box.height, 80)
    }

    // Generated from test: aspect_ratio_width_overrides_align_stretch_row
    func testAspectRatioWidthOverridesAlignStretchRow() {
        let root = FlexLayout()
        root.style.flexDirection = FlexDirection.row
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 50
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_height_overrides_align_stretch_column
    func testAspectRatioHeightOverridesAlignStretchColumn() {
        let root = FlexLayout()
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = 50
        root_child0.style.aspectRatio = 1
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_allow_child_overflow_parent_size
    func testAspectRatioAllowChildOverflowParentSize() {
        let root = FlexLayout()
        root.style.alignItems = .flexStart
        root.style.width = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = 50
        root_child0.style.aspectRatio = 4
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 50)

        XCTAssertEqual(root_child0.box.width, 200)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_defined_main_with_margin
    func testAspectRatioDefinedMainWithMargin() {
        let root = FlexLayout()
        root.style.alignItems = .center
        root.style.justifyContent = JustifyContent.center
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.height = 50
        root_child0.style.aspectRatio = 1
        root_child0.style.margin.left = 10
        root_child0.style.margin.right = 10
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_defined_cross_with_margin
    func testAspectRatioDefinedCrossWithMargin() {
        let root = FlexLayout()
        root.style.alignItems = .center
        root.style.justifyContent = JustifyContent.center
        root.style.width = 100
        root.style.height = 100

        let root_child0 = FlexLayout()
        root_child0.style.width = 50
        root_child0.style.aspectRatio = 1
        root_child0.style.margin.left = 10
        root_child0.style.margin.right = 10
        root.append(root_child0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)
    }

    // Generated from test: aspect_ratio_should_prefer_explicit_height
    func testAspectRatioShouldPreferExplicitHeight() {
        // YGConfigSetUseWebDefaults(config, true);

        let root = webLayout()
        root.style.flexDirection = FlexDirection.column

        let root_child0 = webLayout()
        root_child0.style.flexDirection = FlexDirection.column
        root.append(root_child0)

        let root_child0_child0 = webLayout()
        root_child0_child0.style.flexDirection = FlexDirection.column
        root_child0_child0.style.height = 100
        root_child0_child0.style.aspectRatio = 2
        root_child0.append(root_child0_child0)

        root.calculate(width: 100, height: 200, direction: Direction.ltr)

        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 200)

        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.width, 200)
        XCTAssertEqual(root_child0_child0.box.height, 100)
    }

    // Generated from test: aspect_ratio_should_prefer_explicit_width
    func testAspectRatioShouldPreferExplicitWidth() {
        // YGConfigSetUseWebDefaults(config, true);

        let root = webLayout()
        root.style.flexDirection = FlexDirection.row

        let root_child0 = webLayout()
        root_child0.style.flexDirection = FlexDirection.row
        root.append(root_child0)

        let root_child0_child0 = webLayout()
        root_child0_child0.style.flexDirection = FlexDirection.row
        root_child0_child0.style.width = 100
        root_child0_child0.style.aspectRatio = 0.5
        root_child0.append(root_child0_child0)

        root.calculate(width: 200, height: 100, direction: Direction.ltr)

        XCTAssertEqual(root.box.width, 200)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 100)

        XCTAssertEqual(root_child0_child0.box.width, 100)
        XCTAssertEqual(root_child0_child0.box.height, 200)
    }

    // Generated from test: aspect_ratio_should_prefer_flexed_dimension
    func testAspectRatioShouldPreferFlexedDimension() {
        // YGConfigSetUseWebDefaults(config, true);

        let root = webLayout()

        let root_child0 = webLayout()
        root_child0.style.flexDirection = FlexDirection.column
        root_child0.style.aspectRatio = 2
        root_child0.style.flexGrow = 1
        root.append(root_child0)

        let root_child0_child0 = webLayout()
        root_child0_child0.style.aspectRatio = 4
        root_child0_child0.style.flexGrow = 1
        root_child0.append(root_child0_child0)

        root.calculate(width: 100, height: 100, direction: Direction.ltr)

        XCTAssertEqual(root.box.width, 100)
        XCTAssertEqual(root.box.height, 100)

        XCTAssertEqual(root_child0.box.width, 100)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child0_child0.box.width, 200)
        XCTAssertEqual(root_child0_child0.box.height, 50)
    }
}
