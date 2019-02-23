// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

public protocol ApproximatelyEquatable {
    associatedtype Accuracy
    /// Returns a Boolean value indicating whether two values are equal within a given accuracy.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    ///   - accuracy: The accuracy used to determine if `lhs` is approximately equal to `rhs`.
    static func equal(_ lhs: Self, _ rhs: Self, accuracy: Accuracy) -> Bool
}
