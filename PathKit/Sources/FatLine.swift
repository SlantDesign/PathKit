// Copyright © 2020 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

/// An object representing the region between two parallel lines.
public struct FatLine {
    /// A line parallel to `self` used to define it.
    public var line: Line

    /// The minimum distance between any point contained by `self` and its reference line.
    public var d_min: Double {
        return d_range.lowerBound
    }

    /// The maximum distance between any point contained by `self` and its reference line.
    public var d_max: Double {
        return d_range.upperBound
    }

    /// An upper and lower bound on the distance between any point contained by `self` and its reference line.
    public var d_range: ClosedRange<Double>

    /// Creates a line in normal form.
    ///
    /// - Parameters:
    ///   - line: A line parallel to `self`.
    ///   - d_min: The minimum distance between any point contained by `self` and its reference line.
    ///   - d_max: The maximum distance between any point contained by `self` and its reference line.
    public init(line: Line, d_range: ClosedRange<Double>) {
        self.line = line
        self.d_range = d_range
    }

    /// Determines whether `point` is on `self`.
    ///
    /// - Parameters:
    ///   - point: The point that may or may not be on `self`
    ///   - accuracy: The accuracy used to determine if the point lies on `self`.
    /// - Returns: True if `point` is on `self` within the given accuracy.
    public func contains(_ point: Point, accuracy: Double) -> Bool {
        return d_range.contains(line.signedDistance(to: point), accuracy: accuracy)
    }

    /// Returns the shortest distance between `point` and `self`.
    /// - Parameter point: The point to calculate the distance from.
    public func distance(to point: Point) -> Double {
        let signedDistance = line.signedDistance(to: point)
        if d_max < signedDistance {
            return signedDistance - d_max
        } else if d_min > signedDistance {
            return d_min - signedDistance
        } else {
            return 0
        }
    }
}
