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

    /// Ceeates a point located at the head of `vector`.
    ///
    /// - Parameter vector: The vector used to create the point.
    public init(_ vector: Vector) {
        self.init()
        x = vector.dx
        y = vector.dy
    }
}

public extension Point {
    public static func + (lhs: Point, rhs: Vector) -> Point {
        return Point(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
    }

    public static func - (lhs: Point, rhs: Point) -> Vector {
        return Vector(dx: lhs.x - rhs.x, dy: lhs.y - rhs.y)
    }

    public static func - (lhs: Point, rhs: Vector) -> Point {
        return Point(x: lhs.x - rhs.dx, y: lhs.y - rhs.dy)
    }

    public static func * (lhs: Point, rhs: Double) -> Point {
        return Point(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    public static func * (lhs: Double, rhs: Point) -> Point {
        return Point(x: rhs.x * lhs, y: rhs.y * lhs)
    }

    public static func / (lhs: Point, rhs: Double) -> Point {
        return Point(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    public static prefix func - (point: Point) -> Point {
        return Point(x: -point.x, y: -point.y)
    }

    public static func += (lhs: inout Point, rhs: Vector) {
        lhs.x += rhs.dx
        lhs.y += rhs.dy
    }

    public static func -= (lhs: inout Point, rhs: Vector) {
        lhs.x -= rhs.dx
        lhs.y -= rhs.dy
    }
}

extension Point : CustomDebugStringConvertible {

    /// A textual representation of this instance, suitable for debugging.
    public var debugDescription: String {
        return "Point(\(x), \(y))"
    }
}

/// Point Linear interpolation.
public func lerp(_ lhs: Point, _ rhs: Point, at t: Double) -> Point {
    return lhs + (rhs - lhs) * t
}

/// Computes the euclidean distance between two points.
public func distance(_ a: Point, _ b: Point) -> Double {
    return (b - a).length
}

/// Computes the square of the euclidean distance between two points.
public func distanceSq(_ a: Point, _ b: Point) -> Double {
    return (b - a).lengthSquared
}
