// Copyright © 2020 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import XCTest

class FatLineTests: XCTestCase {

    func testContainsVerticalLine() {
        var line = Line(angle: Angle.zero, distanceFromOrigin: 0)
        var fatLine = FatLine(line: line, d_range: -1...1)
        XCTAssert(fatLine.contains(.zero, accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(fatLine.contains(Point(x: -1, y: 2.4), accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(fatLine.contains(Point(x: 1, y: -32.4), accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(fatLine.contains(Point(x: 0.5, y: 0.3), accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(fatLine.contains(Point(x: -0.4, y: -3223.4), accuracy: Double.leastNonzeroMagnitude))
        XCTAssertFalse(fatLine.contains(Point(x: -10, y: 2.4), accuracy: Double.leastNonzeroMagnitude))
        XCTAssertFalse(fatLine.contains(Point(x: 30, y: 0), accuracy: Double.leastNonzeroMagnitude))

        line = Line(angle: Angle.π, distanceFromOrigin: 0)
        fatLine = FatLine(line: line, d_range: -1...1)
        XCTAssert(fatLine.contains(.zero, accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(fatLine.contains(Point(x: -1, y: 2.4), accuracy: 1.0e-14))
        XCTAssert(fatLine.contains(Point(x: 1, y: -32.4), accuracy: 1.0e-14))
        XCTAssert(fatLine.contains(Point(x: 0.5, y: 0.3), accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(fatLine.contains(Point(x: -0.4, y: -3223.4), accuracy: Double.leastNonzeroMagnitude))
        XCTAssertFalse(fatLine.contains(Point(x: -10, y: 2.4), accuracy: Double.leastNonzeroMagnitude))
        XCTAssertFalse(fatLine.contains(Point(x: 30, y: 0), accuracy: Double.leastNonzeroMagnitude))
    }

    func testContainsHorizontalLine() {
        let line = Line(angle: Angle.π/2, distanceFromOrigin: 1)
        let fatLine = FatLine(line: line, d_range: -1...5)
        XCTAssert(fatLine.contains(.zero, accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(fatLine.contains(Point(x: 0, y: 6), accuracy: 1.0e-13))
        XCTAssert(fatLine.contains(Point(x: 0, y: 5), accuracy: 1.0e-13))
        XCTAssert(fatLine.contains(Point(x: 0, y: 3), accuracy: 1.0e-13))
        XCTAssertFalse(fatLine.contains(Point(x: 0, y: 6.0000001), accuracy: Double.leastNonzeroMagnitude))
        XCTAssertFalse(fatLine.contains(Point(x: -0, y: -0.00000000001), accuracy: Double.leastNonzeroMagnitude))
        XCTAssertFalse(fatLine.contains(Point(x: 0, y: -5), accuracy: 1.0e-9))
        XCTAssertFalse(fatLine.contains(Point(x: 0, y: -1000), accuracy: 1.0e-10))
    }

    func testDistanceHorizontalLine() {
        let line = Line(angle: Angle.π/2, distanceFromOrigin: 1)
        let fatLine = FatLine(line: line, d_range: -1...5)
        XCTAssertEqual(fatLine.distance(to: .zero), 0)
        XCTAssertEqual(fatLine.distance(to: Point(x: 0, y: 6)), 0)
        XCTAssertEqual(fatLine.distance(to: Point(x: 0, y: 5)), 0)
        XCTAssertEqual(fatLine.distance(to: Point(x: 0, y: 3)), 0)
        XCTAssertEqual(fatLine.distance(to: Point(x: 0, y: 6.0000001)), 0.0000001, accuracy: 0.000000001)
        XCTAssertEqual(fatLine.distance(to: Point(x: -0, y: -0.00000000001)), 0.00000000001, accuracy: 0.000000001)
        XCTAssertEqual(fatLine.distance(to: Point(x: 0, y: -5)), 5, accuracy: 0.000000001)
        XCTAssertEqual(fatLine.distance(to: Point(x: 0, y: -1000)), 1000, accuracy: 0.000000001)
    }
}
