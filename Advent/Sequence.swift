
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

// MARK: - Count by Element

extension Sequence where Element: Hashable {

    /// Returns a dictionary of unique elements to the amount of times that
    /// element exists in the sequence.
    ///
    /// For example, the sequence
    ///
    /// `A, B, C, D, A, B, A, A, B, C`
    ///
    /// will return:
    ///
    /// `[A: 4, B: 3, C: 2, D: 1]`
    public var countByElement: [Element: Int] {

        return reduce(into: [:]) { result, element in
            result[element, default: 0] += 1
        }
    }
}
