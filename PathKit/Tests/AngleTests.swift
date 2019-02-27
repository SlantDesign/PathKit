// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import XCTest

class AngleTests: XCTestCase {
    func testDegrees() {
        XCTAssert(Angle.zero.degrees == 0.0)
        XCTAssert(Angle.π.degrees == 180.0)
        XCTAssert(Angle.τ.degrees == 360.0)
        XCTAssert(Angle.τ.degrees + Angle.τ.degrees == 720.0)
    }

    func testIsNonNegative() {
        XCTAssert(Angle.π.isNonNegative)
        XCTAssert(Angle.τ.isNonNegative)
        XCTAssert(Angle(radians: 0.000000000001).isNonNegative)
        XCTAssert(Angle.zero.isNonNegative)
        XCTAssertFalse(Angle(radians: -0.000000000001).isNonNegative)
        XCTAssertFalse(Angle(radians: -1).isNonNegative)
    }

    func testPositiveNormalized() {
        XCTAssert(Angle.zero.positiveNormalized.radians == Angle.zero.radians)
        XCTAssert(Angle.π.positiveNormalized.radians == Angle.π.radians)
        XCTAssert((-Angle.π).positiveNormalized.radians == Angle.π.radians)
        XCTAssert(Angle.τ.positiveNormalized.radians == Angle.zero.radians)
        XCTAssert(-Angle.τ.positiveNormalized.radians == Angle.zero.radians)
        XCTAssert(Angle(degrees: -40 - 360).positiveNormalized.radians == Angle(degrees: 360 - 40).radians)

        let lhs = Angle(degrees: -40 - 360 * 2).positiveNormalized.radians
        let rhs = Angle(degrees: 360 - 40).radians
        XCTAssertEqual(lhs, rhs, accuracy: 0.000000000001)
    }

    func testDistance() {
        XCTAssert(Angle.distance(Angle.zero, Angle.zero) == Angle.zero)
        XCTAssert(Angle.distance(Angle.zero, Angle.τ) == Angle.zero)
        XCTAssert(Angle.distance(Angle.zero, 2 * Angle.τ) == Angle.zero)
        XCTAssert(Angle.distance(Angle.zero, Angle.π) == Angle.π)
        XCTAssert(Angle.distance(Angle.zero, 3 * Angle.π) == Angle.π)
        XCTAssert(Angle.distance(Angle.zero, -Angle.π) == Angle.π)
        XCTAssert(Angle.distance(Angle.zero, -Angle.π * 0.5) == Angle.π * 0.5)
    }

    func testCompare() {
        XCTAssertFalse(Angle.zero < Angle.zero)
        XCTAssert(Angle.zero < Angle.π)
        XCTAssert(Angle.zero < -Angle.π)
        XCTAssert(Angle.τ < Angle.π)
        XCTAssert(Angle.τ * 3 < Angle.π)
    }

    func testEquatable() {
        XCTAssert(Angle.zero == Angle.zero)
        XCTAssert(Angle.zero != Angle.π)
        XCTAssert(Angle.π == -Angle.π)
        XCTAssert(Angle.τ  == 2 * Angle.π)
        XCTAssert(Angle.τ  != -2 * Angle.π) // rounding error
        XCTAssert(Angle.τ == Angle.zero)
    }

    func testApproximatelyEquatable() {
        XCTAssert(Angle.equal(Angle.zero, Angle.zero, accuracy: Angle.smallestAngle))
        XCTAssert(Angle.equal(Angle.zero, Angle.zero, accuracy: Angle.smallestAngle))
        XCTAssert(Angle.equal(Angle.π, -Angle.π, accuracy: Angle.smallestAngle))
        XCTAssert(Angle.equal(Angle.τ, 2 * Angle.π, accuracy: Angle.smallestAngle))
        XCTAssert(Angle.equal(Angle.τ, Angle.zero, accuracy: Angle.smallestAngle))
        XCTAssert(Angle.equal(-Angle.τ, Angle.zero, accuracy: Angle.smallestAngle))
        XCTAssert(Angle.equal(Angle.τ, -2 * Angle.π, accuracy: Angle.smallestAngle))
        XCTAssert(Angle.equal(Angle.τ, 66 * Angle.π, accuracy: Angle(radians: 1.0e-14 )))
    }
}
