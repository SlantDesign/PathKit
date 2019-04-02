// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

extension ClosedRange {
    public static func intersection(_ lhs: ClosedRange<Bound>, _ rhs: ClosedRange<Bound>) -> ClosedRange<Bound>? {
        let lowerBound = Swift.max(lhs.lowerBound, rhs.lowerBound)
        let upperBound = Swift.min(lhs.upperBound, rhs.upperBound)
        return lowerBound <= upperBound ? lowerBound...upperBound : nil
    }
}

extension ClosedRange: ApproximatelyEquatable where Bound: ApproximatelyEquatable {
    public typealias Accuracy = Bound.Accuracy

    public static func equal(_ lhs: ClosedRange<Bound>, _ rhs: ClosedRange<Bound>, accuracy: Accuracy) -> Bool {
        return Bound.equal(lhs.lowerBound, rhs.lowerBound, accuracy: accuracy) && Bound.equal(lhs.upperBound, rhs.upperBound, accuracy: accuracy)
    }
}

extension ClosedRange where Bound: ApproximatelyEquatable & AdditiveArithmetic {
    public func contains(_ element: Bound, accuracy: Bound) -> Bool {
        let extendedLowerBound = lowerBound - accuracy
        let extendedUpperBound = upperBound + accuracy
        let extendedRange = extendedLowerBound...extendedUpperBound
        return extendedRange.contains(element)
    }

    public func overlaps(_ other: ClosedRange<Bound>, accuracy: Bound) -> Bool {
        return contains(other.lowerBound, accuracy: accuracy) || contains(other.upperBound, accuracy: accuracy)
    }
}
