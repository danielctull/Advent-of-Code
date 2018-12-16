
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
