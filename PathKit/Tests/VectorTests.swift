// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import XCTest

class VectorTests: XCTestCase {


    func testLengthZero() {
        XCTAssert(Vector.zero.length == 0)
    }

    func testApproximateEquality() {
        let v1 = Vector(dx: 1.0, dy: 0)
        let v2 = Vector(dx: 1.009, dy: 0)
        let v3 = Vector(dx: 1.01, dy: 0)
        XCTAssert(Vector.equal(v1, v2, accuracy: 0.01))
        XCTAssertFalse(Vector.equal(v3, v1, accuracy: 0.01))
        XCTAssertFalse(Vector.equal(v1, v3, accuracy: 0.01))
    }
}
