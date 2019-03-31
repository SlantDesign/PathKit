// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

extension Double: ApproximatelyEquatable {
    public static func equal(_ lhs: Double, _ rhs: Double, accuracy: Double) -> Bool {
        return abs(lhs - rhs) < accuracy
    }
}
