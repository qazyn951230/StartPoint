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

@testable import StartPoint
import XCTest

func _baselineFunc(width: Double, height: Double) -> Double {
    return height / 2
}

func _measure1(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
    return Size(width: 42, height: 50)
}

func _measure2(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
    return Size(width: 279, height: 126)
}

func createLayout(_ direction: FlexDirection, _ width: Double, _ height: Double,
                  _ alignBaseline: Bool) -> FlexLayout {
    let layout = FlexLayout()
    layout.flexDirection(direction)
    layout.width(StyleValue.length(width))
    layout.height(StyleValue.length(height))
    if alignBaseline {
        layout.alignItems(AlignItems.baseline)
    }
    return layout
}

// Generated from YGAlignBaselineTest.cpp
class AlignBaselineTests: FlexTestCase {

    // Test case for bug in T32999822
    // Generated from test: align_baseline_parent_ht_not_specified
    func testAlignBaselineParentHtNotSpecified() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignContent(AlignContent.stretch)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(340))
        root.maxHeight(StyleValue.length(170))
        root.minHeight(StyleValue.length(0))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(0)
        root_child0.flexShrink(1)
        root_child0.measureSelf = _measure1
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexGrow(0)
        root_child1.flexShrink(1)
        root_child1.measureSelf = _measure2
        root.insert(root_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 340)
        XCTAssertEqual(root.box.height, 126)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.width, 42)
        XCTAssertEqual(root_child0.box.height, 50)
        XCTAssertEqual(root_child0.box.top, 76)

        XCTAssertEqual(root_child1.box.left, 42)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.width, 279)
        XCTAssertEqual(root_child1.box.height, 126)
    }

    // Generated from test: align_baseline_with_no_parent_ht
    func testAlignBaselineWithNoParentHt() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(150))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(50))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(40))
        root_child1.baselineMethod = _baselineFunc
        root.insert(root_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 70)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 50)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 30)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 40)
    }

    // Generated from test: align_baseline_with_no_baseline_func_and_no_parent_ht
    func testAlignBaselineWithNoBaselineFuncAndNoParentHt() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(150))

        let root_child0 = FlexLayout()
        root_child0.width(StyleValue.length(50))
        root_child0.height(StyleValue.length(80))
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.width(StyleValue.length(50))
        root_child1.height(StyleValue.length(50))
        root.insert(root_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.left, 0)
        XCTAssertEqual(root.box.top, 0)
        XCTAssertEqual(root.box.width, 150)
        XCTAssertEqual(root.box.height, 80)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)
        XCTAssertEqual(root_child0.box.width, 50)
        XCTAssertEqual(root_child0.box.height, 80)

        XCTAssertEqual(root_child1.box.left, 50)
        XCTAssertEqual(root_child1.box.top, 30)
        XCTAssertEqual(root_child1.box.width, 50)
        XCTAssertEqual(root_child1.box.height, 50)
    }

    // Generated from test: align_baseline_parent_using_child_in_column_as_reference
    func testAlignBaselineParentUsingChildInColumnAsReference() {
        let root: FlexLayout = createLayout(FlexDirection.row, 1000, 1000, true)

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1: FlexLayout = createLayout(FlexDirection.column, 500, 800, false)
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 300, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.baselineMethod = _baselineFunc
        root_child1_child1.isReferenceBaseline = true
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 100)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 0)
        XCTAssertEqual(root_child1_child1.box.top, 300)
    }

    // Generated from test: align_baseline_parent_using_child_with_padding_in_column_as_reference
    func testAlignBaselineParentUsingChildWithPaddingInColumnAsReference() {
        let root: FlexLayout = createLayout(FlexDirection.row, 1000, 1000, true)

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1: FlexLayout = createLayout(FlexDirection.column, 500, 800, false)
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 300, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.baselineMethod = _baselineFunc
        root_child1_child1.isReferenceBaseline = true
        root_child1_child1.padding(left: StyleValue.length(100))
        root_child1_child1.padding(right: StyleValue.length(100))
        root_child1_child1.padding(top: StyleValue.length(100))
        root_child1_child1.padding(bottom: StyleValue.length(100))
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 100)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 0)
        XCTAssertEqual(root_child1_child1.box.top, 300)
    }

    // Generated from test: align_baseline_parent_with_padding_using_child_in_column_as_reference
    func testAlignBaselineParentWithPaddingUsingChildInColumnAsReference() {
        let root: FlexLayout = createLayout(FlexDirection.row, 1000, 1000, true)

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1: FlexLayout = createLayout(FlexDirection.column, 500, 800, false)
        root_child1.padding(left: StyleValue.length(100))
        root_child1.padding(right: StyleValue.length(100))
        root_child1.padding(top: StyleValue.length(100))
        root_child1.padding(bottom: StyleValue.length(100))
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 300, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.baselineMethod = _baselineFunc
        root_child1_child1.isReferenceBaseline = true
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 0)

        XCTAssertEqual(root_child1_child0.box.left, 100)
        XCTAssertEqual(root_child1_child0.box.top, 100)

        XCTAssertEqual(root_child1_child1.box.left, 100)
        XCTAssertEqual(root_child1_child1.box.top, 400)
    }

    // Generated from test: align_baseline_parent_with_margin_using_child_in_column_as_reference
    func testAlignBaselineParentWithMarginUsingChildInColumnAsReference() {
        let root: FlexLayout = createLayout(FlexDirection.row, 1000, 1000, true)

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1: FlexLayout = createLayout(FlexDirection.column, 500, 800, false)
        root_child1.margin(left: StyleValue.length(100))
        root_child1.margin(right: StyleValue.length(100))
        root_child1.margin(top: StyleValue.length(100))
        root_child1.margin(bottom: StyleValue.length(100))
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 300, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.baselineMethod = _baselineFunc
        root_child1_child1.isReferenceBaseline = true
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 600)
        XCTAssertEqual(root_child1.box.top, 100)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 0)
        XCTAssertEqual(root_child1_child1.box.top, 300)
    }

    // Generated from test: align_baseline_parent_using_child_with_margin_in_column_as_reference
    func testAlignBaselineParentUsingChildWithMarginInColumnAsReference() {
        let root: FlexLayout = createLayout(FlexDirection.row, 1000, 1000, true)

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1: FlexLayout = createLayout(FlexDirection.column, 500, 800, false)
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 300, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.baselineMethod = _baselineFunc
        root_child1_child1.isReferenceBaseline = true
        root_child1_child1.margin(left: StyleValue.length(100))
        root_child1_child1.margin(right: StyleValue.length(100))
        root_child1_child1.margin(top: StyleValue.length(100))
        root_child1_child1.margin(bottom: StyleValue.length(100))
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 0)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 100)
        XCTAssertEqual(root_child1_child1.box.top, 400)
    }

    // Generated from test: align_baseline_parent_using_child_in_row_as_reference
    func testAlignBaselineParentUsingChildInRowAsReference() {
        let root: FlexLayout = createLayout(FlexDirection.row, 1000, 1000, true)

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1: FlexLayout = createLayout(FlexDirection.row, 500, 800, true)
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 500, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.baselineMethod = _baselineFunc
        root_child1_child1.isReferenceBaseline = true
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 100)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 500)
        XCTAssertEqual(root_child1_child1.box.top, 300)
    }

    // Generated from test: align_baseline_parent_using_child_with_padding_in_row_as_reference
    func testAlignBaselineParentUsingChildWithPaddingInRowAsReference() {
        let root: FlexLayout = createLayout(FlexDirection.row, 1000, 1000, true)

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1: FlexLayout = createLayout(FlexDirection.row, 500, 800, true)
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 500, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.baselineMethod = _baselineFunc
        root_child1_child1.isReferenceBaseline = true
        root_child1_child1.padding(left: StyleValue.length(100))
        root_child1_child1.padding(right: StyleValue.length(100))
        root_child1_child1.padding(top: StyleValue.length(100))
        root_child1_child1.padding(bottom: StyleValue.length(100))
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 100)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 500)
        XCTAssertEqual(root_child1_child1.box.top, 300)
    }

    // Generated from test: align_baseline_parent_using_child_with_margin_in_row_as_reference
    func testAlignBaselineParentUsingChildWithMarginInRowAsReference() {
        let root: FlexLayout = createLayout(FlexDirection.row, 1000, 1000, true)

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1: FlexLayout = createLayout(FlexDirection.row, 500, 800, true)
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 500, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.baselineMethod = _baselineFunc
        root_child1_child1.isReferenceBaseline = true
        root_child1_child1.margin(left: StyleValue.length(100))
        root_child1_child1.margin(right: StyleValue.length(100))
        root_child1_child1.margin(top: StyleValue.length(100))
        root_child1_child1.margin(bottom: StyleValue.length(100))
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 100)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 600)
        XCTAssertEqual(root_child1_child1.box.top, 300)
    }

    // Generated from test: align_baseline_parent_using_child_in_column_as_reference_with_no_baseline_func
    func testAlignBaselineParentUsingChildInColumnAsReferenceWithNoBaselineFunc() {
        let root: FlexLayout = createLayout(FlexDirection.row, 1000, 1000, true)

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1: FlexLayout = createLayout(FlexDirection.column, 500, 800, false)
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 300, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.isReferenceBaseline = true
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 100)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 0)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 0)
        XCTAssertEqual(root_child1_child1.box.top, 300)
    }

    // Generated from test: align_baseline_parent_using_child_in_row_as_reference_with_no_baseline_func
    func testAlignBaselineParentUsingChildInRowAsReferenceWithNoBaselineFunc() {
        let root: FlexLayout = createLayout(FlexDirection.row, 1000, 1000, true)

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1: FlexLayout = createLayout(FlexDirection.row, 500, 800, true)
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 500, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.isReferenceBaseline = true
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 100)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 500)
        XCTAssertEqual(root_child1_child1.box.top, 100)
    }

    // Generated from test: align_baseline_parent_using_child_in_column_as_reference_with_height_not_specified
    func testAlignBaselineParentUsingChildInColumnAsReferenceWithHeightNotSpecified() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(1000))

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexDirection(FlexDirection.column)
        root_child1.width(StyleValue.length(500))
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 300, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.baselineMethod = _baselineFunc
        root_child1_child1.isReferenceBaseline = true
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.height, 800)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 100)
        XCTAssertEqual(root_child1.box.height, 700)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 0)
        XCTAssertEqual(root_child1_child1.box.top, 300)
    }

    // Generated from test: align_baseline_parent_using_child_in_row_as_reference_with_height_not_specified
    func testAlignBaselineParentUsingChildInRowAsReferenceWithHeightNotSpecified() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(1000))

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexDirection(FlexDirection.row)
        root_child1.width(StyleValue.length(500))
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 500, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.baselineMethod = _baselineFunc
        root_child1_child1.isReferenceBaseline = true
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.height, 900)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 400)
        XCTAssertEqual(root_child1.box.height, 500)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 500)
        XCTAssertEqual(root_child1_child1.box.top, 0)
    }

    // Generated from test: align_baseline_parent_using_child_in_column_as_reference_with_no_baseline_func_and_height_not_specified
    func testAlignBaselineParentUsingChildInColumnAsReferenceWithNoBaselineFuncAndHeightNotSpecified() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(1000))

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexDirection(FlexDirection.column)
        root_child1.width(StyleValue.length(500))
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 300, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.isReferenceBaseline = true
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.height, 700)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 100)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 0)
        XCTAssertEqual(root_child1.box.height, 700)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 0)
        XCTAssertEqual(root_child1_child1.box.top, 300)
    }

    // Generated from test: align_baseline_parent_using_child_in_row_as_reference_with_no_baseline_func_and_height_not_specified
    func testAlignBaselineParentUsingChildInRowAsReferenceWithNoBaselineFuncAndHeightNotSpecified() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(AlignItems.baseline)
        root.width(StyleValue.length(1000))

        let root_child0: FlexLayout = createLayout(FlexDirection.column, 500, 600, false)
        root.insert(root_child0, at: 0)

        let root_child1 = FlexLayout()
        root_child1.flexDirection(FlexDirection.row)
        root_child1.width(StyleValue.length(500))
        root.insert(root_child1, at: 1)

        let root_child1_child0: FlexLayout = createLayout(FlexDirection.column, 500, 500, false)
        root_child1.insert(root_child1_child0, at: 0)

        let root_child1_child1: FlexLayout = createLayout(FlexDirection.column, 500, 400, false)
        root_child1_child1.isReferenceBaseline = true
        root_child1.insert(root_child1_child1, at: 1)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root.box.height, 700)

        XCTAssertEqual(root_child0.box.left, 0)
        XCTAssertEqual(root_child0.box.top, 0)

        XCTAssertEqual(root_child1.box.left, 500)
        XCTAssertEqual(root_child1.box.top, 200)
        XCTAssertEqual(root_child1.box.height, 500)

        XCTAssertEqual(root_child1_child0.box.left, 0)
        XCTAssertEqual(root_child1_child0.box.top, 0)

        XCTAssertEqual(root_child1_child1.box.left, 500)
        XCTAssertEqual(root_child1_child1.box.top, 0)
    }
}
