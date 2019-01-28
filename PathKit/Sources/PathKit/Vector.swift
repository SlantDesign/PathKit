// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

/// A data structure used to represnet a 2-dimensional vector in a Cartesian coordinate system.
/// The components of the vector are represented using double precision floating points.
public struct Vector: Equatable {

    /// The x-component of the vector.
    public var dx: Double

    /// The y-component of the vector.
    public var dy: Double

    /// Creates a vector with magnitude zero.
    public init() {
        self = .zero
    }

    /// Creates a vector from its components.
    ///
    /// - Parameters:
    ///   - dx: The x-component of the vector.
    ///   - dy: The y-component of the vector.
    public init(dx: Double, dy: Double) {
        self.dx = dx
        self.dy = dy
    }
}

extension Vector {

    /// Vector of magnitude zero.
    public static var zero: Vector {
        return Vector(dx: 0, dy: 0)
    }

    /// Creates a vector from `dx` and `dy`.
    ///
    /// - Parameters:
    ///   - dx: The x-component of the vector.
    ///   - dy: The y-component of the vector.
    public init(dx: Int, dy: Int) {
        self.dx = Double(dx)
        self.dy = Double(dy)
    }

    /// Creates a vector pointing to `point`.
    ///
    /// - Parameter point: The point used to create the vector.
    public init(_ point: Point) {
        dx = point.x
        dy = point.y
    }
}

extension Vector : CustomDebugStringConvertible {

    /// A textual representation of this instance, suitable for debugging.
    public var debugDescription: String {
        return "Vector(\(dx), \(dy))"
    }
}

infix operator • : MultiplicationPrecedence

public extension Vector {
    /// Returns the sum of two vectors.
    public static func + (lhs: Vector, rhs: Vector) -> Vector {
        return Vector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }

    /// Returns the difference between two vectors.
    public static func - (lhs: Vector, rhs: Vector) -> Vector {
        return Vector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
    }

    /// Returns the scalar multiplication between a vector and a double precision scalar.
    public static func * (lhs: Vector, rhs: Double) -> Vector {
        return Vector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }

    /// Returns the scalar multiplication between a double precision scalar and a vector.
    public static func * (lhs: Double, rhs: Vector) -> Vector {
        return Vector(dx: rhs.dx * lhs, dy: rhs.dy * lhs)
    }

    /// Returns the scalar multiplication between a vector and an integer.
    public static func * (lhs: Vector, rhs: Int) -> Vector {
        return Vector(dx: lhs.dx * Double(rhs), dy: lhs.dy * Double(rhs))
    }

    /// Returns the scalar multiplication between an integer and a vector.
    public static func * (lhs: Int, rhs: Vector) -> Vector {
        return Vector(dx: rhs.dx * Double(lhs), dy: rhs.dy * Double(lhs))
    }

    /// Returns the dot product between two vectors.
    public static func • (lhs: Vector, rhs: Vector) -> Double {
        return rhs.dx * lhs.dx + rhs.dy * lhs.dy
    }

    /// Returns the scalar division of vector by a scalar.
    public static func / (lhs: Vector, rhs: Double) -> Vector {
        return Vector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
    }

    /// Returns the inverse vector of `self`.
    public static prefix func - (vector: Vector) -> Vector {
        return Vector(dx: -vector.dx, dy: -vector.dy)
    }

    public static func += (lhs: inout Vector, rhs: Vector) {
        lhs.dx += rhs.dx
        lhs.dy += rhs.dy
    }

    public static func -= (lhs: inout Vector, rhs: Vector) {
        lhs.dx += rhs.dx
        lhs.dy += rhs.dy
    }

    public static func *= (lhs: inout Vector, rhs: Double) {
        lhs.dx *= rhs
        lhs.dy *= rhs
    }

    public static func /= (lhs: inout Vector, rhs: Double) {
        lhs.dx /= rhs
        lhs.dy /= rhs
    }

    /// Returns the vector's length.
    public var length: Double {
        return hypot(dx, dy)
    }

    /// Returns the square of the vector's length.
    public var lengthSquared: Double {
        return self • self
    }

    /// Returns a unit vector with the same direction as `self`.
    public var normalized: Vector {
        return self / length
    }
}
