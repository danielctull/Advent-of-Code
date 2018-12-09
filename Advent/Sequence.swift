
// MARK: - First Duplicate

extension Sequence where Element: Hashable {

    /// Returns the element which is first duplicated in the sequence.
    ///
    /// For example in the sequence `A, B, C, D, E, F, A, B, C`, the first
    /// duplicate element is `A`.
    public var firstDuplicate: Element? {

        var elements: Set<Element> = []

        return first { element -> Bool in
            let contains = elements.contains(element)
            elements.insert(element)
            return contains
        }
    }
}
