// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

/// A cubic bezier curve in 2-dimensional space.
public struct BezierCurve {
    /// The starting point of `self`.
    public var start: Point

    /// The first control point of `self`.
    public var c1: Point

    /// The second control point of `self`.
    public var c2: Point

    /// The endpoint of `self`.
    public var end: Point

    /// Creates a cubic bezier curve beginning at `start` and ending at `end` with control points c1 and c2.
    ///
    /// - Parameters:
    ///   - start: The starting point of the curve.
    ///   - c1: The first control point of the curve.
    ///   - c2: The second control point of the curve.
    ///   - end: The end point of the curve.
    public init(start: Point, c1: Point, c2: Point, end: Point) {
        self.start = start
        self.c1 = c1
        self.c2 = c2
        self.end = end
    }
}
