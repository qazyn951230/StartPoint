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

// Generated from YGRoundingMeasureFuncTest.cpp
class RoundingMeasureFuncTests: FlexTestCase {
    func _measureFloor(width _: Double, widthMode _: MeasureMode, height _: Double, heightMode _: MeasureMode) -> Size {
        return Size(width: 10.2, height: 10.2)
    }

    func _measureCeil(width _: Double, widthMode _: MeasureMode, height _: Double, heightMode _: MeasureMode) -> Size {
        return Size(width: 10.5, height: 10.5)
    }

    func _measureFractial(width _: Double, widthMode _: MeasureMode, height _: Double, heightMode _: MeasureMode) -> Size {
        return Size(width: 0.5, height: 0.5)
    }

    // Generated from test: rounding_feature_with_custom_measure_func_floor
    func testRoundingFeatureWithCustomMeasureFuncFloor() { let root = FlexLayout()

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measureFloor
        root.insert(root_child0, at: 0)

        FlexStyle.scale = 0.0

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root_child0.box.width, 10.2)
        XCTAssertEqual(root_child0.box.height, 10.2)

        FlexStyle.scale = 1.0

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.width, 11)
        XCTAssertEqual(root_child0.box.height, 11)

        FlexStyle.scale = 2.0

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root_child0.box.width, 10.5)
        XCTAssertEqual(root_child0.box.height, 10.5)

        FlexStyle.scale = 4.0

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.width, 10.25)
        XCTAssertEqual(root_child0.box.height, 10.25)

        FlexStyle.scale = 1.0 / 3.0

        root.calculate(direction: Direction.rtl)

        XCTAssertEqual(root_child0.box.width, 12.0)
        XCTAssertEqual(root_child0.box.height, 12.0)
    }

    // Generated from test: rounding_feature_with_custom_measure_func_ceil
    func testRoundingFeatureWithCustomMeasureFuncCeil() { let root = FlexLayout()

        let root_child0 = FlexLayout()
        root_child0.measureSelf = _measureCeil
        root.insert(root_child0, at: 0)

        FlexStyle.scale = 1.0

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.width, 11)
        XCTAssertEqual(root_child0.box.height, 11)
    }

    // Generated from test: rounding_feature_with_custom_measure_and_fractial_matching_scale
    func testRoundingFeatureWithCustomMeasureAndFractialMatchingScale() { let root = FlexLayout()

        let root_child0 = FlexLayout()
        root_child0.position(left: StyleValue.length(73.625))
        root_child0.measureSelf = _measureFractial
        root.insert(root_child0, at: 0)

        FlexStyle.scale = 2.0

        root.calculate(direction: Direction.ltr)

        XCTAssertEqual(root_child0.box.width, 0.5)
        XCTAssertEqual(root_child0.box.height, 0.5)
        XCTAssertEqual(root_child0.box.left, 73.5)
    }
}
