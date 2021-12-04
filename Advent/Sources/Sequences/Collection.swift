
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

extension Collection {

    /// Transposes this collection of collections of elements.
    ///
    /// Given:
    /// ```
    /// ["A1", "B1", "C1"],
    /// ["A2", "B2", "C2"],
    /// ["A3", "B3", "C3"],
    /// ["A4", "B4", "C4"],
    /// ```
    /// this will return:
    /// ```
    /// ["A1", "A2", "A3", "A4"],
    /// ["B1", "B2", "B3", "B4"],
    /// ["C1", "C2", "C3", "C4"],
    /// ```
    ///
    /// **Note:**
    /// This should only be called where the collections have the same length!
    ///
    /// - Returns: The transposed array.
    public func transpose<C, E>() -> [[E]] where C == Element, C: Collection, C.Element == E {
        self[startIndex].indices.map { index in
            map { $0[index] }
        }
    }
}
