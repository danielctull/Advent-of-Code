
extension Collection where Element: Equatable {

    /// Finds the indices of all the elements that are equal to the given
    /// element.
    ///
    /// - Parameter elementToFind: The element to search for.
    /// - Returns: An array of indices.
    public func indices(of elementToFind: Element) -> [Index] {

        return enumerated().compactMap { (offset, element) in

            guard element == elementToFind else { return nil }

            return index(startIndex, offsetBy: offset)
        }
    }
}

extension Collection {

    /// Splits into an array of subsequences each with the given length.
    ///
    /// - Parameter length: Length of each subsequence of the returned array.
    public func split(length: Int) -> [SubSequence] {
        let amount = (count / length)
        let range = (0..<amount)
        return range.map { item in
            let lower = index(startIndex, offsetBy: item * length)
            let upper = index(lower, offsetBy: length)
            return self[lower..<upper]
        }
    }
}
