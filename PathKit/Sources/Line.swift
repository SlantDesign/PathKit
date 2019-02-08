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
    public var 𝜭: Angle

    /// The length of the normal segment.
    /// The normal segment joins the origin with the closest point on the line to the origin.
    public var p: Double

    /// Determines whether `point` is on the line.
    public func contains(_ point: Point) -> Bool {
        return (point.y * sin(𝜭) + point.x * cos(𝜭)) == p
    }
}
