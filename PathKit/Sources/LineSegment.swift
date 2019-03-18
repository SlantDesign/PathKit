// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

public struct LineSegment {
    /// The starting point of `self`.
    public var start: Point

    /// The endpoint of `self`.
    public var end: Point

    /// Creates a line segment beginning at `start` and ending at `end`.
    ///
    /// - Parameters:
    ///   - start: The starting point of the line segment.
    ///   - end: The end point of the line segment.
    /// - Precondition: The `start` point and `end` point of the line segment must be different.
    public init(start: Point, end: Point) {
        precondition(start != end)
        self.start = start
        self.end = end
    }
}

extension LineSegment {
    /// The Euclidean distance from `start` to `end`.
    public var length: Double {
        return distance(start, end)
    }

    /// Returns a point along the line passing through `self` using point linear interpolation.
    ///
    /// - Parameter t: The interpolation parameter used to calculate the point.
    /// - Returns: A point along the line passing through `self`.
    public func point(at t: Double) -> Point {
        return lerp(start, end, at: t)
    }

    public func offset(by vector: Vector) -> LineSegment {
        return LineSegment(start: start + vector, end: end + vector)
    }

    /// Computes the intersection of two line segments.
    /// Source: https://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
    public static func intersection(_ lhs: LineSegment, _ rhs: LineSegment, accuracy: Double) -> Intersection {
        let p = lhs.start
        let q = rhs.start
        let qp = Vector(head: q, tail: p)
        let r = Vector(head: lhs.end, tail: lhs.start)
        let s = Vector(head: rhs.end, tail: rhs.start)
        let parallel = Vector.areParallel(r, s, accuracy: accuracy)
        let collinear = Vector.areParallel(qp, r, accuracy: accuracy)
        let zeroToOne = 0.0...1.0

        if parallel && collinear {
            // lines are collinear
            let unitVectorR = r.unitVector
            let t0 = qp • unitVectorR
            let t1 = t0 + s • unitVectorR
            let range = (s • r < 0) ? t1...t0 : t0...t1

            if range.overlaps(zeroToOne) {
                // line segments overlap
                return .infinite
            } else {
                // line segments are disjoint
                return .empty
            }
        } else if parallel {
            // lines are parallel and non-intersecting
            return .empty
        } else {
            let rXs = r ✕ s
            let t = qp ✕ s / rXs
            let u = qp ✕ r / rXs

            if zeroToOne.contains(t) && zeroToOne.contains(u) {
                // line segments intersect at single point
                return Intersection.finite([p + t * r])
            } else {
                // line segments are not parallel and do not intersect
                return .empty
            }
        }
    }
}
