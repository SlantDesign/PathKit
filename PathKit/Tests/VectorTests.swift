// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import XCTest

class VectorTests: XCTestCase {

    func testLength() {
        XCTAssert(Vector.zero.length == 0)
        XCTAssert(Vector(dx: 3, dy: 4).length == 5)
        XCTAssert(Vector(dx: 3, dy: 4).lengthSquared == 25)
    }

    func testNormalized() {
        XCTAssert(Vector(dx: 3, dy: 4).normalized.length == 1)
    }

    func testApproximateEquality() {
        let v1 = Vector(dx: 1.0, dy: 0)
        let v2 = Vector(dx: 1.009, dy: 0)
        let v3 = Vector(dx: 1.01, dy: 0)
        XCTAssert(Vector.equal(v1, v2, accuracy: 0.01))
        XCTAssertFalse(Vector.equal(v3, v1, accuracy: 0.01))
        XCTAssertFalse(Vector.equal(v1, v3, accuracy: 0.01))
    }

    func testAreParallel() {
        // identical
        var v1 = Vector(dx: 0, dy: 1)
        var v2 = Vector(dx: 0, dy: 1)
        XCTAssert(Vector.areParallel(v1, v2, accuracy: Double.leastNonzeroMagnitude))

        // parallel
        v1 = Vector(dx: 1, dy: 1)
        v2 = Vector(dx: 4, dy: 4)
        XCTAssert(Vector.areParallel(v1, v2, accuracy: Double.leastNonzeroMagnitude))

        // parallel, opposite direction
        v1 = Vector(dx: 0, dy: 1)
        v2 = Vector(dx: 0, dy: -1)
        XCTAssert(Vector.areParallel(v1, v2, accuracy: Double.leastNonzeroMagnitude))

        v1 = Vector(dx: 0, dy: 1)
        v2 = Vector(dx: 0, dy: -32)
        XCTAssert(Vector.areParallel(v1, v2, accuracy: Double.leastNonzeroMagnitude))

        // perpendicular
        v1 = Vector(dx: 0, dy: 1)
        v2 = Vector(dx: 1, dy: 0)
        XCTAssertFalse(Vector.areParallel(v1, v2, accuracy: 0.1))

        // non-parallel
        v1 = Vector(dx: 1, dy: 1)
        v2 = Vector(dx: 1, dy: 0)
        XCTAssertFalse(Vector.areParallel(v1, v2, accuracy: 0.1))

        v1 = Vector(dx: 1, dy: 1)
        v2 = Vector(dx: -1, dy: 0)
        XCTAssertFalse(Vector.areParallel(v1, v2, accuracy: 0.1))
    }
}
