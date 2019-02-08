// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

public struct Angle: Equatable {

    public static let π = Angle(radians: Double.pi)

    public static let zero = Angle(radians: 0)

    /// Value in radians.
    public var radians: Double

    /// Value in degrees.
    public var degrees: Double {
        get {
            return radians * 180.0 / Double.pi
        }

        set {
            radians = newValue * Double.pi / 180.0
        }
    }

    // MARK: - Initializers

    /// Creates an Angle from a value in radians.
    ///
    /// - Parameter radians: angle in radians.
    public init(radians: Double) {
        self.radians = radians
    }

    /// Creates an Angle from a value in degrees.
    ///
    /// - Parameter degrees: angle in degrees.
    public init(degrees: Double) {
        self.radians = degrees * Double.pi / 180.0
    }

    // MARK: - Angle Operations

    public static prefix func - (angle: Angle) -> Angle {
        return Angle(radians: -angle.radians)
    }

    public static func + (lhs: Angle, rhs: Angle) -> Angle {
        return Angle(radians: lhs.radians + rhs.radians)
    }

    public static func += (lhs: inout Angle, rhs: Angle) {
        lhs = Angle(radians: lhs.radians + rhs.radians)
    }

    public static func - (lhs: Angle, rhs: Angle) -> Angle {
        return Angle(radians: lhs.radians - rhs.radians)
    }

    public static func -= (lhs: inout Angle, rhs: Angle) {
        lhs = Angle(radians: lhs.radians - rhs.radians)
    }

    public static func * (lhs: Double, rhs: Angle) -> Angle {
        return Angle(radians: lhs * rhs.radians)
    }

    public static func * (lhs: Angle, rhs: Double) -> Angle {
        return Angle(radians: lhs.radians * rhs)
    }

    public static func / (lhs: Double, rhs: Angle) -> Angle {
        return Angle(radians: lhs / rhs.radians)
    }

    public static func / (lhs: Angle, rhs: Double) -> Angle {
        return Angle(radians: lhs.radians / rhs)
    }
}

extension Angle : CustomDebugStringConvertible {

    /// A textual representation of this instance, suitable for debugging.
    public var debugDescription: String {
        return "\(degrees) degrees"
    }
}

// MARK: - Trigonometric functions

public func cos(_ angle: Angle) -> Double {
    return cos(angle.radians)
}

public func sin(_ angle: Angle) -> Double {
    return sin(angle.radians)
}

public func tan(_ angle: Angle) -> Double {
    return tan(angle.radians)
}
