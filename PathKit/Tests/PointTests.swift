// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import XCTest

class PointTests: XCTestCase {

    func testApproximateEquality() {
        let p1 = Point(x: 1.0, y: 0)
        let p2 = Point(x: 1.009, y: 0)
        let p3 = Point(x: 1.01, y: 0)
        XCTAssert(Point.equal(p1, p2, accuracy: 0.01))
        XCTAssertFalse(Point.equal(p3, p1, accuracy: 0.01))
        XCTAssertFalse(Point.equal(p1, p3, accuracy: 0.01))
    }

    func testDistance() {
        let p1 = Point(x: 3, y: 4)
        XCTAssert(distance(Point.zero, p1) == 5)
        XCTAssert(squareDistance(.zero, p1) == 25)
    }

    func testLerp() {
        let p1 = Point(x: 6, y: 8)
        XCTAssert(lerp(.zero, p1, at: 0) == .zero)
        XCTAssert(lerp(.zero, p1, at: 1) == p1)
        XCTAssert(lerp(.zero, p1, at: 0.5) == Point(x: 3, y: 4))
    }
}
