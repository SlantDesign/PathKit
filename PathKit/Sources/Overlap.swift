// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

/// Struct used to represent the overlap of 2  planar curves.
public enum Overlap: Equatable, ApproximatelyEquatable {
    /// Overlap is a line segment
    case lineSegment(LineSegment)
}

extension Overlap {
    public static func equal(_ lhs: Overlap, _ rhs: Overlap, accuracy: Double) -> Bool {
        switch (lhs, rhs) {
        case (.lineSegment(let lhs), .lineSegment(let rhs)):
            return LineSegment.equal(lhs, rhs, accuracy: accuracy)
        }
    }
}
