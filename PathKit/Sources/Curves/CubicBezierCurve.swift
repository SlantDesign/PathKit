// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

/// A cubic bezier curve in 2-dimensional space.
public struct CubicBezierCurve {
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

extension CubicBezierCurve {
    /// Returns a point along the `self` corresponding to a parameter value within the closed interval [0, 1].
    ///
    /// The parameter value `t` is clamped to the closed interval [0, 1].
    ///
    /// - Parameter t: The parameter used to calculate the point on the cubic bezier curve.
    /// - Returns: A point along the line passing through `self`.
    public func point(at t: Double) -> Point {
        let t = clamp(t, min: 0, max: 1)
        let t_2 = t * t
        let t_3 = t * t * t

        let q = 1 - t
        let q_2 = q * q
        let q_3 = q * q_2

        var v = q_3 * Vector(head: start, tail: .zero)
        v += 3 * q_2 * t * Vector(head: c1, tail: .zero)
        v += 3 * q * t_2 * Vector(head: c2, tail: .zero)
        v += t_3 * Vector(head: end, tail: .zero)
        return Point(x: v.dx, y: v.dy)
    }
}
