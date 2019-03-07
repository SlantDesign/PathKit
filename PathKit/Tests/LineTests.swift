// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import XCTest

class LineTests: XCTestCase {

    func testContainsVerticalLine() {
        var line = Line(angle: Angle.zero, distanceFromOrigin: 0)
        XCTAssert(line.contains(.zero, accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(line.contains(Point(x: 0, y: 2.4), accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(line.contains(Point(x: 0, y: -32.4), accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(line.contains(Point(x: 0, y: 0.3), accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(line.contains(Point(x: 0, y: -3223.4), accuracy: Double.leastNonzeroMagnitude))
        XCTAssertFalse(line.contains(Point(x: 10, y: 2.4), accuracy: Double.leastNonzeroMagnitude))
        XCTAssertFalse(line.contains(Point(x: 30, y: 0), accuracy: Double.leastNonzeroMagnitude))

        line = Line(angle: Angle.π, distanceFromOrigin: 0)
        XCTAssert(line.contains(.zero, accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(line.contains(Point(x: 0, y: 2.4), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: 0, y: -32.4), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: 0, y: 0.3), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: 0, y: -3223.4), accuracy: 1.0e-12))
        XCTAssertFalse(line.contains(Point(x: 10, y: 2.4), accuracy: 1.0e-1))
        XCTAssertFalse(line.contains(Point(x: 30, y: 0), accuracy: 1.0e-1))

        line = Line(angle: Angle.τ, distanceFromOrigin: 0)
        XCTAssert(line.contains(.zero, accuracy: Double.leastNonzeroMagnitude))
        XCTAssert(line.contains(Point(x: 0, y: 2.4), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: 0, y: -32.4), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: 0, y: 0.3), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: 0, y: -3223.4), accuracy: 1.0e-12))
        XCTAssertFalse(line.contains(Point(x: 10, y: 2.4), accuracy: 1.0e-1))
        XCTAssertFalse(line.contains(Point(x: 30, y: 0), accuracy: 1.0e-1))
    }

    func testContainsHorizontalLine() {
        var line = Line(angle: Angle.π/2, distanceFromOrigin: 1)
        XCTAssertFalse(line.contains(.zero, accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: 2.4, y: 1), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: -32.4, y: 1), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: 0.3, y: 1), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: -3223.4, y: 1), accuracy: 1.0e-9))
        XCTAssertFalse(line.contains(Point(x: 2.4, y: 10), accuracy: 1.0e-1))
        XCTAssertFalse(line.contains(Point(x: 0, y: 30), accuracy: 1.0e-1))

        line = Line(angle: 3*Angle.π/2, distanceFromOrigin: 1)
        XCTAssertFalse(line.contains(.zero, accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: 2.4, y: -1), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: -32.4, y: -1), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: 0.3, y: -1), accuracy: 1.0e-13))
        XCTAssert(line.contains(Point(x: -3223.4, y: -1), accuracy: 1.0e-9))
        XCTAssertFalse(line.contains(Point(x: 2.4, y: 10), accuracy: 1.0e-1))
        XCTAssertFalse(line.contains(Point(x: 0, y: 30), accuracy: 1.0e-1))
    }
}
