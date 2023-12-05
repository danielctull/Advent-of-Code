
extension Range {

    public func contains(_ other: Self) -> Bool {
        lowerBound <= other.lowerBound && other.upperBound <= upperBound
    }
}

extension Range where Bound: Numeric {

    public mutating func incrementLowerBound() {
        self = (lowerBound+1)..<upperBound
    }

    public mutating func incrementUpperBound() {
        self = lowerBound..<(upperBound+1)
    }
}

private enum Compare: Equatable {
    case same
    case less
    case more

    init<Value: Comparable>(_ lhs: Value, _ rhs: Value) {
        if lhs < rhs { self = .less; return }
        if lhs > rhs { self = .more; return }
        self = .same
    }
}

extension Range {

    public func intersection(_ other: Self) -> (intersection: Self?, remainder: [Self]) {

        switch (Compare(lowerBound, other.lowerBound), Compare(upperBound, other.upperBound), Compare(upperBound, other.lowerBound), Compare(lowerBound, other.upperBound)) {

        case (_, _, .less, _),
             (_, _, .same, _),
             (_, _, _, .more),
             (_, _, _, .same):
            (
                intersection: nil,
                remainder: [other]
            )

        case (.less, .more, _, _),
             (.same, .more, _, _),
             (.less, .same, _, _),
             (.same, .same, _, _):
            (
                intersection: other,
                remainder: []
            )

        case (.more, .same, _, _):
            (
                intersection: self,
                remainder: [other.lowerBound..<lowerBound]
            )

        case (.same, .less, _, _):
            (
                intersection: self,
                remainder: [upperBound..<other.upperBound]
            )

        case (.more, .less, _, _):
            (
                intersection: self,
                remainder: [
                    other.lowerBound..<lowerBound,
                    upperBound..<other.upperBound,
                ]
            )

        case (.more, .more, _, .less):
            (
                intersection: lowerBound..<other.upperBound,
                remainder: [other.lowerBound..<lowerBound]
            )

        case (.less, .less, .more, _):
            (
                intersection: other.lowerBound..<upperBound,
                remainder: [upperBound..<other.upperBound]
            )
        }
    }
}
