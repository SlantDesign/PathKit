// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

/// A line in 2-dimensional space represented in its normal form.
public struct Line {
    /// The inclination of the normal segment in radians.
    /// The normal segment joins the origin with the closest point on the line to the origin.
    public var angle: Angle

    /// The length of the normal segment.
    /// The normal segment joins the origin with the closest point on the line to the origin.
    public var distanceFromOrigin: Double

    /// Creates a line in normal form.
    ///
    /// - Parameters:
    ///   - angle: The inclination of the line.
    ///   - distanceFromOrigin: The length of the normal segment from the origin to the line.
    public init(angle: Angle, distanceFromOrigin: Double) {
        self.angle = angle
        self.distanceFromOrigin = distanceFromOrigin
    }

    /// Determines whether `point` is on `self`.
    ///
    /// - Parameters:
    ///   - point: The point that may or may not be on `self`
    ///   - accuracy: The accuracy used to determine if the point lies on `self`.
    /// - Returns: True if `point` is on `self` within the given accuracy.
    public func contains(_ point: Point, accuracy: Double) -> Bool {
        return Double.equal(distance(to: point), 0, accuracy: accuracy)
    }

    /// Returns the shortest distance between `point` and `self`.
    /// - Parameter point: The point to calculate the distance from.
    public func distance(to point: Point) -> Double {
        return abs(signedDistance(to: point))
    }

    /// Returns the (shortest) signed distance between `point` and `self`.
    /// - Parameter point: The point to calculate the distance from.
    public func signedDistance(to point: Point) -> Double {
        let dotProduct = Vector(head: point, tail: .zero) • Vector.unitVector(with: angle)
        return dotProduct - distanceFromOrigin
    }
}
