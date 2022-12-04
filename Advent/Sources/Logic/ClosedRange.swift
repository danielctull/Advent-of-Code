
extension ClosedRange {

    @inlinable
    public func isSuperset(of other: Self) -> Bool {
        lowerBound <= other.lowerBound && upperBound >= other.upperBound
    }

    @inlinable
    public func isSubset(of other: Self) -> Bool {
        other.isSuperset(of: self)
    }
}
