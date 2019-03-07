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
}
