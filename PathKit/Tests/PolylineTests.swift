// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import XCTest

class PolylineTests: XCTestCase {

    func testLength() {
        var polyline = Polyline(vertices: [])

        XCTAssertEqual(polyline.length, 0)

        var p1 = Point(x: 0, y: 0)
        var vertices = [p1]
        polyline = Polyline(vertices: vertices)
        XCTAssertEqual(polyline.length, 0)

        p1 = Point(x: 0, y: 0)
        vertices = [p1, p1]
        polyline = Polyline(vertices: vertices)
        XCTAssertEqual(polyline.length, 0)


        p1 = Point(x: 0, y: 0)
        var p2 = Point(x: 6, y: 8)
        vertices = [p1, p2, p1]
        polyline = Polyline(vertices: vertices)
        XCTAssertEqual(polyline.length, 20)
    }
}
