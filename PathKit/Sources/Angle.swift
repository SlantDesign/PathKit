// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

public struct Angle: Equatable {

    public static let π = Angle(radians: Double.pi)
    public static let τ = Angle(radians: 2 * Double.pi)

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

    /// True if the angle is positive, false otherwise.
    public var isPositive: Bool {
        return 0.0 < radians
    }

    /// A positive normalized angle between 0 and 2π.
    public var positiveNormalized: Angle {
        let angle = Angle(radians: radians.truncatingRemainder(dividingBy: Angle.τ.radians))
        return isPositive ? angle : angle + Angle.τ
    }

    /// Returns the angular distance between two angles.
    ///
    /// For example the distance between 1 and -360 degrees is 1 degree.
    public static func distance(_ lhs: Angle, _ rhs: Angle) -> Angle {
        var angleDifference = abs(lhs.positiveNormalized.radians - rhs.positiveNormalized.radians)
        let complementaryAgnleDiff = Angle.τ.radians - angleDifference
        angleDifference = min(angleDifference, complementaryAgnleDiff)
        return Angle(radians: angleDifference)
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

extension Angle: Comparable {
    public static func < (lhs: Angle, rhs: Angle) -> Bool {
        return lhs.radians < rhs.radians
    }
}

extension Angle: ApproximatelyEquatable {
    public static func equal(_ lhs: Angle, _ rhs: Angle, accuracy: Angle) -> Bool {
        return distance(lhs, rhs) <= accuracy
    }
}
