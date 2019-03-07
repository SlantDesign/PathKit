// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import XCTest

class LineSegmentTests: XCTestCase {
    func testLength() {
        let p1 = Point(x: 4, y: 34)
        let p2 = Point(x: -3245, y: 34)
        let l1 = LineSegment(start: p1, end: p2)
        let l2 = LineSegment(start: p2, end: p1)
        XCTAssert(l1.length == l2.length)
    }

    func testIntersection() {
        // Identical lines
        var p11 = Point.zero
        var p12 = Point(x: 1, y: 0)
        var p21 = p11
        var p22 = p12
        var l1 = LineSegment(start: p11, end: p12)
        var l2 = LineSegment(start: p21, end: p22)
        XCTAssert(LineSegment.intersection(l1, l2, accuracy: Double.leastNonzeroMagnitude) == Intersection.infinite)

        // Partially overlapping
        p11 = Point.zero
        p12 = Point(x: 12, y: 12)
        p21 = Point(x: 33, y: 33)
        p22 = Point(x: 11, y: 11)
        l1 = LineSegment(start: p11, end: p12)
        l2 = LineSegment(start: p21, end: p22)
        XCTAssert(LineSegment.intersection(l1, l2, accuracy: Double.leastNonzeroMagnitude) == Intersection.infinite)

        // Partially overlapping (opposite line directions)
        p11 = Point.zero
        p12 = Point(x: 12, y: 12)
        p21 = Point(x: 11, y: 11)
        p22 = Point(x: 33, y: 33)
        l1 = LineSegment(start: p11, end: p12)
        l2 = LineSegment(start: p21, end: p22)
        XCTAssert(LineSegment.intersection(l1, l2, accuracy: Double.leastNonzeroMagnitude) == Intersection.infinite)

        // Parallel, Collinear but disjoint
        p11 = Point.zero
        p12 = Point(x: 12, y: 12)
        p21 = Point(x: 14, y: 14)
        p22 = Point(x: 33, y: 33)
        l1 = LineSegment(start: p11, end: p12)
        l2 = LineSegment(start: p21, end: p22)
        XCTAssert(LineSegment.intersection(l1, l2, accuracy: Double.leastNonzeroMagnitude) == Intersection.empty)

        // Parallel non intersecting lines
        p11 = Point.zero
        p12 = Point(x: 1, y: 0)
        p21 = Point(x: 0, y: 1)
        p22 = Point(x: 1, y: 1)
        l1 = LineSegment(start: p11, end: p12)
        l2 = LineSegment(start: p21, end: p22)
        XCTAssert(LineSegment.intersection(l1, l2, accuracy: Double.leastNonzeroMagnitude) == Intersection.empty)

        // Intersecting at single point
        p11 = Point(x: -33, y: 0)
        p12 = Point(x: 33, y: 0)
        p21 = Point(x: 0, y: 1)
        p22 = Point(x: 0, y: -1)
        l1 = LineSegment(start: p11, end: p12)
        l2 = LineSegment(start: p21, end: p22)
        XCTAssert(LineSegment.intersection(l1, l2, accuracy: Double.leastNonzeroMagnitude) == Intersection.finite([.zero]))

        // End points touching
        p11 = .zero
        p12 = Point(x: 0, y: 1)
        p21 = Point(x: 1, y: 1)
        p22 = .zero
        l1 = LineSegment(start: p11, end: p12)
        l2 = LineSegment(start: p21, end: p22)
        XCTAssert(LineSegment.intersection(l1, l2, accuracy: Double.leastNonzeroMagnitude) == Intersection.finite([.zero]))

        // End point touching line
        p11 = Point(x: -1, y: 1)
        p12 = Point(x: 1, y: 1)
        p21 = Point(x: 1, y: 1)
        p22 = .zero
        l1 = LineSegment(start: p11, end: p12)
        l2 = LineSegment(start: p21, end: p22)
        XCTAssert(LineSegment.intersection(l1, l2, accuracy: Double.leastNonzeroMagnitude) == Intersection.finite([p21]))

        // Non-Parallel, non-intersecting
        p11 = .zero
        p12 = Point(x: 1, y: 1)
        p21 = Point(x: -1, y: -1)
        p22 = Point(x: -1, y: -2)
        l1 = LineSegment(start: p11, end: p12)
        l2 = LineSegment(start: p21, end: p22)
        XCTAssert(LineSegment.intersection(l1, l2, accuracy: Double.leastNonzeroMagnitude) == Intersection.empty)

        // Very Close parallel lines
        p11 = .zero
        p12 = Point(x: 1, y: 1)
        l1 = LineSegment(start: p11, end: p12)
        var offset = Vector(dx: Double.leastNonzeroMagnitude, dy: 0)
        l2 = l1.offset(by: offset)
        XCTAssert(LineSegment.intersection(l1, l2, accuracy: Double.leastNonzeroMagnitude) == Intersection.empty)

        // Very Close parallel lines (less accuracy)
        p11 = .zero
        p12 = Point(x: 1, y: 1)
        l1 = LineSegment(start: p11, end: p12)
        offset = Vector(dx: Double.leastNonzeroMagnitude, dy: 0)
        l2 = l1.offset(by: offset)
        XCTAssert(LineSegment.intersection(l1, l2, accuracy: 1.0e-10) == Intersection.infinite)
    }
}
