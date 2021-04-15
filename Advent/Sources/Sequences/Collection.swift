
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
