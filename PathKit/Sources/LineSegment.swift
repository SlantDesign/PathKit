// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

public struct LineSegment: Equatable, ApproximatelyEquatable {
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
    /// Evaluates if the two line segments are approximately equal. The two line segments are deemed approximately
    /// equal if the distance between their start points and the distance between their end points are both less than
    /// `accuracy`.
    public static func equal(_ lhs: LineSegment, _ rhs: LineSegment, accuracy: Double) -> Bool {
        return Point.equal(lhs.start, rhs.start, accuracy: accuracy) && Point.equal(lhs.end, rhs.end, accuracy: accuracy)
    }
}

extension LineSegment {
    /// The Euclidean distance from `start` to `end`.
    public var length: Double {
        return distance(start, end)
    }

    /// A vector which points from the start point to the end point of `self`.
    public var vector: Vector {
        return Vector(head: end, tail: start)
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
        let startVector = Vector(head: rhs.start, tail: lhs.start)
        let lhsVector = lhs.vector
        let rhsVector = rhs.vector
        let parallel = Vector.areParallel(lhsVector, rhsVector, accuracy: accuracy)
        let collinear = Vector.areParallel(startVector, lhsVector, accuracy: accuracy)
        let zeroToOne = 0.0...1.0

        if parallel && collinear {
            // lines are collinear
            let unitVectorR = lhsVector.unitVector
            let t0 = startVector • unitVectorR
            let t1 = t0 + rhsVector • unitVectorR
            let range = (rhsVector • lhsVector < 0) ? t1...t0 : t0...t1

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
            let rXs = lhsVector ✕ rhsVector
            let t = startVector ✕ rhsVector / rXs
            let u = startVector ✕ lhsVector / rXs

            if zeroToOne.contains(t) && zeroToOne.contains(u) {
                // line segments intersect at single point
                return Intersection.finite([lhs.start + t * lhsVector])
            } else {
                // line segments are not parallel and do not intersect
                return .empty
            }
        }
    }
}
