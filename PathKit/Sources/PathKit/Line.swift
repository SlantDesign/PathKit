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

    /// The euclidian distance from `start` to `end`.
    public var length: Double {
        return distance(start, end)
    }

    /// Evaluates the line at the given parameter value `t`.
    ///
    /// - Parameter t: A value between 0 and 1.
    /// - Returns: The point
    public func point(at t: Double) -> Point {
        return lerp(start, end, at: t)
    }

    /// Creates a line segment begins at the point `start` and ends the point `end`.
    ///
    /// - Parameters:
    ///   - start: The starting point of the line segment.
    ///   - end: The end point of the line segment.
    public init(start: Point, end: Point) {
        self.start = start
        self.end = start
    }
}
