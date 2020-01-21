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

// Generated from YGMeasureCacheTest.cpp
class MeasureCacheTests: FlexTestCase {

    var measureCount = 0

    override func setUp() {
        super.setUp()
        measureCount = 0
    }

    func _measureMax(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
        measureCount += 1
        let w: Double = widthMode.isUndefined ? 10 : width
        let h: Double = heightMode.isUndefined ? 10 : height
        return Size(width: w, height: h)
    }

    func _measureMin(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
        measureCount += 1
        let w: Double = (widthMode.isUndefined || (widthMode.isAtMost && width > 10)) ? 10 : width
        let h: Double = (heightMode.isUndefined || heightMode.isAtMost && height > 10) ? 10 : height
        return Size(width: w, height: h)
    }

    func _measure_84_49(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
        measureCount += 1
        return Size(width: 84.0, height: 49.0)
    }

    // Generated from test: measure_once_single_flexible_child
    func testMeasureOnceSingleFlexibleChild() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measureMax
        root_child0.flexGrow(1)
        root.insert(root_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(measureCount, 1)
    }

    // Generated from test: remeasure_with_same_exact_width_larger_than_needed_height
    func testRemeasureWithSameExactWidthLargerThanNeededHeight() {
        let root = FlexLayout()

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measureMin
        root.insert(root_child0, at: 0)

        root.calculate(width: 100, height: 100, direction: Direction.ltr)
        root.calculate(width: 100, height: 50, direction: Direction.ltr)

        XCTAssertEqual(measureCount, 1)
    }

    // Generated from test: remeasure_with_same_atmost_width_larger_than_needed_height
    func testRemeasureWithSameAtmostWidthLargerThanNeededHeight() {
        let root = FlexLayout()
        root.alignItems(.flexStart)

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measureMin
        root.insert(root_child0, at: 0)

        root.calculate(width: 100, height: 100, direction: Direction.ltr)
        root.calculate(width: 100, height: 50, direction: Direction.ltr)

        XCTAssertEqual(measureCount, 1)
    }

    // Generated from test: remeasure_with_computed_width_larger_than_needed_height
    func testRemeasureWithComputedWidthLargerThanNeededHeight() {
        let root = FlexLayout()
        root.alignItems(.flexStart)

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measureMin
        root.insert(root_child0, at: 0)

        root.calculate(width: 100, height: 100, direction: Direction.ltr)
        root.alignItems(.stretch)
        root.calculate(width: 10, height: 50, direction: Direction.ltr)

        XCTAssertEqual(measureCount, 1)
    }

    // Generated from test: remeasure_with_atmost_computed_width_undefined_height
    func testRemeasureWithAtmostComputedWidthUndefinedHeight() {
        let root = FlexLayout()
        root.alignItems(.flexStart)

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measureMin
        root.insert(root_child0, at: 0)

        root.calculate(width: 100, height: Double.nan, direction: Direction.ltr)
        root.calculate(width: 10, height: Double.nan, direction: Direction.ltr)

        XCTAssertEqual(measureCount, 1)
    }

    // Generated from test: remeasure_with_already_measured_value_smaller_but_still_float_equal
    func testRemeasureWithAlreadyMeasuredValueSmallerButStillFloatEqual() {
        let root = FlexLayout()
        root.width(StyleValue.length(288.0))
        root.height(StyleValue.length(288.0))
        root.flexDirection(FlexDirection.row)

        let root_child0 = FlexLayout()
        root_child0.padding(value: StyleValue.length(2.88))
        root_child0.flexDirection(FlexDirection.row)
        root.insert(root_child0, at: 0)

        let root_child0_child0 = FlexLayout()
        root_child0_child0.measureSelf = _measure_84_49
        root_child0.insert(root_child0_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(measureCount, 1)
    }
}
