
extension Collection {

    /// Splits into an array of subsequences each with the given length.
    ///
    /// - Parameter length: Length of each subsequence of the returned array.
    public func split(length: Int) -> [SubSequence] {
        stride(from: 0, to: count, by: length).map {
            let lower = index(startIndex, offsetBy: $0)
            let upper = index(lower, offsetBy: length)
            return self[lower..<upper]
        }
    }
}

extension Collection {

    /// Creates a new collection containing the specified number of copies of
    /// the receiver.
    ///
    /// - Parameter count: The number of times to repeat the value passed in the
    ///                    repeating parameter. count must be zero or greater.
    public func repeating(_ count: Int) -> [Self] {
        Array(repeating: self, count: count)
    }
}
