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

struct MeasureConstraint {
    let width: Double
    let widthMode: MeasureMode
    let height: Double
    let heightMode: MeasureMode
}

// Generated from YGMeasureModeTest.cpp
class MeasureModeTests: FlexTestCase {
    var constraintList: [MeasureConstraint] = []

    override func setUp() {
        super.setUp()
        constraintList = []
    }

    func _measure(width: Double, widthMode: MeasureMode, height: Double, heightMode: MeasureMode) -> Size {
        let constraint = MeasureConstraint(width: width, widthMode: widthMode,
                                           height: height, heightMode: heightMode)
        constraintList.append(constraint)
        let w: Double = widthMode.isUndefined ? 10 : width
        let h: Double = heightMode.isUndefined ? 10 : width
        return Size(width: w, height: h)
    }

    // Generated from test: exactly_measure_stretched_child_column
    func testExactlyMeasureStretchedChildColumn() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measure
        root.insert(root_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(constraintList.count, 1)

        XCTAssertEqual(constraintList[0].width, 100)
        XCTAssertEqual(constraintList[0].widthMode, MeasureMode.exactly)
    }

    // Generated from test: exactly_measure_stretched_child_row
    func testExactlyMeasureStretchedChildRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measure
        root.insert(root_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(constraintList.count, 1)

        XCTAssertEqual(constraintList[0].height, 100)
        XCTAssertEqual(constraintList[0].heightMode, MeasureMode.exactly)
    }

    // Generated from test: at_most_main_axis_column
    func testAtMostMainAxisColumn() {
        let root = FlexLayout()
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measure
        root.insert(root_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(constraintList.count, 1)

        XCTAssertEqual(constraintList[0].height, 100)
        XCTAssertEqual(constraintList[0].heightMode, MeasureMode.atMost)
    }

    // Generated from test: at_most_cross_axis_column
    func testAtMostCrossAxisColumn() {
        let root = FlexLayout()
        root.alignItems(.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measure
        root.insert(root_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(constraintList.count, 1)

        XCTAssertEqual(constraintList[0].width, 100)
        XCTAssertEqual(constraintList[0].widthMode, MeasureMode.atMost)
    }

    // Generated from test: at_most_main_axis_row
    func testAtMostMainAxisRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measure
        root.insert(root_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(constraintList.count, 1)

        XCTAssertEqual(constraintList[0].width, 100)
        XCTAssertEqual(constraintList[0].widthMode, MeasureMode.atMost)
    }

    // Generated from test: at_most_cross_axis_row
    func testAtMostCrossAxisRow() {
        let root = FlexLayout()
        root.flexDirection(FlexDirection.row)
        root.alignItems(.flexStart)
        root.width(StyleValue.length(100))
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measure
        root.insert(root_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(constraintList.count, 1)

        XCTAssertEqual(constraintList[0].height, 100)
        XCTAssertEqual(constraintList[0].heightMode, MeasureMode.atMost)
    }

    // Generated from test: flex_child
    func testFlexChild() {
        let root = FlexLayout()
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.measureSelf = _measure
        root.insert(root_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(constraintList.count, 2)

        XCTAssertEqual(constraintList[0].height, 100)
        XCTAssertEqual(constraintList[0].heightMode, MeasureMode.atMost)

        XCTAssertEqual(constraintList[1].height, 100)
        XCTAssertEqual(constraintList[1].heightMode, MeasureMode.exactly)
    }

    // Generated from test: flex_child_with_flex_basis
    func testFlexChildWithFlexBasis() {
        let root = FlexLayout()
        root.height(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.flexGrow(1)
        root_child0.flexBasis(0)
        root_child0.measureSelf = _measure
        root.insert(root_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(constraintList.count, 1)

        XCTAssertEqual(constraintList[0].height, 100)
        XCTAssertEqual(constraintList[0].heightMode, MeasureMode.exactly)
    }

    // Generated from test: overflow_scroll_column
    func testOverflowScrollColumn() {
        let root = FlexLayout()
        root.alignItems(.flexStart)
        root.overflow(Overflow.scroll)
        root.height(StyleValue.length(100))
        root.width(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measure
        root.insert(root_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(constraintList.count, 1)

        XCTAssertEqual(constraintList[0].width, 100)
        XCTAssertEqual(constraintList[0].widthMode, MeasureMode.atMost)

        XCTAssertTrue(constraintList[0].height.isNaN)
        XCTAssertEqual(constraintList[0].heightMode, MeasureMode.undefined)
    }

    // Generated from test: overflow_scroll_row
    func testOverflowScrollRow() {
        let root = FlexLayout()
        root.alignItems(.flexStart)
        root.flexDirection(FlexDirection.row)
        root.overflow(Overflow.scroll)
        root.height(StyleValue.length(100))
        root.width(StyleValue.length(100))

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measure
        root.insert(root_child0, at: 0)

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(constraintList.count, 1)

        XCTAssertTrue(constraintList[0].width.isNaN)
        XCTAssertEqual(constraintList[0].widthMode, MeasureMode.undefined)

        XCTAssertEqual(constraintList[0].height, 100)
        XCTAssertEqual(constraintList[0].heightMode, MeasureMode.atMost)
    }
}
