// Copyright © 2019 JABT Labs. All rights reserved.
//
// This file is part of PathKit. The full PathKit copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation

/// A series of connected line segments in 2-dimensional space, specified by a sequence of points.
public struct Polyline: Equatable {
    /// An ordered list of points which specify the vertices of `self`.
    public var vertices: [Point]

    /// Creates a polyline.
    ///
    /// - Parameters:
    ///   - vertices: The vertices of the polyline being created.
    public init(vertices: [Point]) {
        self.vertices = vertices
    }
}

extension Polyline: ApproximatelyEquatable {
    /// Evaluates if the two polylines are approximately equal. The two polylines are deemed approximately
    /// equal if the distance between their corresponding vertices are all less than `accuracy`.
    public static func equal(_ lhs: Polyline, _ rhs: Polyline, accuracy: Double) -> Bool {
        return [Point].equal(lhs.vertices, rhs.vertices, accuracy: accuracy)
    }
}

extension Polyline {
    /// The sequence of line segments comprising `self`.
    var lineSegments: [LineSegment] {
        return zip(vertices, vertices.dropFirst()).map { (start, end) in LineSegment(start: start, end: end)}
    }

    /// The length of `self`, that is the sum of the lengths of the line segments comprising `self`.
    public var length: Double {
        return lineSegments.reduce(0) { $0 + $1.length }
    }
}
