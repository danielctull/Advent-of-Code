
extension Range where Bound: Numeric {

    public mutating func incrementLowerBound() {
        self = (lowerBound+1)..<upperBound
    }

    public mutating func incrementUpperBound() {
        self = lowerBound..<(upperBound+1)
    }
}
