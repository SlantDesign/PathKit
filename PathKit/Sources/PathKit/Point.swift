// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

/// A data structure used to represnet a point in 2-dimensional Cartesian coordinate system.
/// The components of the point are represented using double precision floating points.
public struct Point: Equatable {
    /// The x-coordinate of the point.
    public var x: Double

    /// The y-coordinate of the point.
    public var y: Double

    /// Creates a point at the origin.
    public init() {
        self = .zero
    }

    /// Creates a point from its components.
    ///
    /// - Parameters:
    ///   - x: The x-component of the point.
    ///   - y: The y-component of the point.
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

extension Point {

    /// A point at located at the origin.
    public static var zero = Point(x: 0, y: 0)

    /// Creates a point from its components.
    ///
    /// - Parameters:
    ///   - x: The x-component of the point.
    ///   - y: The y-component of the point.
    public init(x: Int, y: Int) {
        self.x = Double(x)
        self.y = Double(y)
    }
}

extension Point : CustomDebugStringConvertible {

    /// A textual representation of this instance, suitable for debugging.
    public var debugDescription: String {
        return "Point(\(x), \(y))"
    }
}
