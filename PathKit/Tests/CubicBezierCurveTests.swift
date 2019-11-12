// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import XCTest

class CubicBezierCurveTests: XCTestCase {

    func testPoint() {
        var start = Point.zero
        var end = Point(x: 1, y: 1)
        var c1 = Point(x: 0.25, y: 0.25)
        var c2 = Point(x: 0.75, y: 0.75)
        var curve = CubicBezierCurve(start: start, c1: c1, c2: c2, end: end)

        XCTAssertEqual(curve.point(at: 0), start)
        XCTAssertEqual(curve.point(at: 1), end)
        XCTAssertEqual(curve.point(at: 0.5), Point(x: 0.5, y: 0.5))

        start = Point(x: -1, y: 1)
        end = Point(x: 1, y: 1)
        c1 = Point(x: 0, y: 0)
        c2 = Point(x: 0, y: 0)

        curve = CubicBezierCurve(start: start, c1: c1, c2: c2, end: end)
        XCTAssertEqual(curve.point(at: 0), start)
        XCTAssertEqual(curve.point(at: 1), end)
        XCTAssertEqual(curve.point(at: 0.5), Point(x: 0, y: 0.25))

        XCTAssertEqual(curve.point(at: -1), start)
        XCTAssertEqual(curve.point(at: 2), end)
    }

    func testSplit() {
        let start = Point.zero
        let c1 = Point(x: 0.0, y: 1.0)
        let c2 = Point(x: 1.0, y: 1.0)
        let end = Point(x: 1.0, y: 0)
        let curve = CubicBezierCurve(start: start, c1: c1, c2: c2, end: end)
        let splittingPoint = curve.point(at: 0.5)
        let subCurves = curve.split(at: 0.5)

        XCTAssertEqual(curve.start, subCurves.0.start)
        XCTAssertEqual(curve.point(at: 0.25), subCurves.0.point(at: 0.5))
        XCTAssertEqual(splittingPoint, subCurves.0.end)

        XCTAssertEqual(splittingPoint, subCurves.1.start)
        XCTAssertEqual(curve.point(at: 0.75), subCurves.1.point(at: 0.5))
        XCTAssertEqual(curve.end, subCurves.1.end)
    }
}
