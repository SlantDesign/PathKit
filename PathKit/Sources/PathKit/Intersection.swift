// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

/// Struct used to represent the points at which 2 planar curves intersect.
public enum Intersection {
    /// Intersect over finitely many points
    case finite([Point])

    /// Intersect over infinitely many points.
    case infinite

    /// Empty intersection
    case empty
}