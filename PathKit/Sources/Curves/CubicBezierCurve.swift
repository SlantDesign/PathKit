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

extension CubicBezierCurve: ApproximatelyEquatable {
    public static func equal(_ lhs: CubicBezierCurve, _ rhs: CubicBezierCurve, accuracy: Double) -> Bool {
        return Point.equal(lhs.start, rhs.start, accuracy: accuracy)
            && Point.equal(lhs.end, rhs.end, accuracy: accuracy)
            && Point.equal(lhs.c1, rhs.c1, accuracy: accuracy)
            && Point.equal(lhs.c2, rhs.c2, accuracy: accuracy)
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

    /// Returns a pair of cubic bezier curves that are obtained by splitting `self` at the point P corresponding
    /// to a parameter value `t` contained within the closed interval [0, 1].
    ///
    /// The parameter value `t` is clamped to the closed interval [0, 1].
    ///
    /// - Parameter t: The parameter value used to obtain the point at which to split `self`.
    /// - Returns: A pair of Bezier curves whose union is equivalent to `self`.
    public func split(at t: Double) -> (CubicBezierCurve, CubicBezierCurve) {
        let t = clamp(t, min: 0, max: 1)
        let q = 1 - t

        let v00 = Vector(head: start, tail: .zero)
        let v01 = Vector(head: c1, tail: .zero)
        let v02 = Vector(head: c2, tail: .zero)
        let v03 = Vector(head: end, tail: .zero)
        let v10 = q * v00 + t * v01
        let v11 = q * v01 + t * v02
        let v12 = q * v02 + t * v03
        let v20 = q * v10 + t * v11
        let v21 = q * v11 + t * v12
        let v30 = q * v20 + t * v21

        let splitPoint = Point(x: v30.dx, y: v30.dy)
        let curve1 = CubicBezierCurve(start: start,
                                      c1: Point(x: v10.dx, y: v10.dy),
                                      c2: Point(x: v20.dx, y: v20.dy),
                                      end: splitPoint)

        let curve2 = CubicBezierCurve(start: splitPoint,
                                      c1: Point(x: v21.dx, y: v21.dy),
                                      c2: Point(x: v12.dx, y: v12.dy),
                                      end: end)
        return (curve1, curve2)
    }
}
