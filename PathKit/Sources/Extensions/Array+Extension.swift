// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

extension Array: ApproximatelyEquatable where Element: ApproximatelyEquatable {
    public typealias Accuracy = Element.Accuracy

    public static func equal(_ lhs: Array<Element>, _ rhs: Array<Element>, accuracy: Accuracy) -> Bool {
        return zip(lhs, rhs).allSatisfy {
            Element.equal($0.0, $0.1, accuracy: accuracy)
        }
    }
}
