// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

/// A line in 2-dimensional space represented in its normal form.
public struct Line {
    /// The inclination of the line in radians.
    public var angle: Angle

    /// The length of the normal segment.
    /// The normal segment joins the origin with the closest point on the line to the origin.
    public var distanceFromOrigin: Double

    /// Determines whether `point` is on `self`.
    ///
    /// - Parameters:
    ///   - point: The point that may or may not be on `self`
    ///   - accuracy: The accuracy used to determine if the point lies on `self`.
    /// - Returns: True if `point` is on `self` within the given accuracy.
    public func contains(_ point: Point, accuracy: Double) -> Bool {
        let dotProduct = Vector(head: point, tail: .zero) • Vector(angle: angle)
        return Double.equal(dotProduct, distanceFromOrigin, accuracy: accuracy)
    }
}
