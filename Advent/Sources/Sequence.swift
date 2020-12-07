
// MARK: - Inclusive Reduce

extension Sequence {

    public func reduce(
        _ transform: (Element, Element) throws -> Element
    ) rethrows -> Element? {
        var iterator = makeIterator()
        guard let initial = iterator.next() else { return nil }
        return try IteratorSequence(iterator).reduce(initial, transform)
    }
}

// MARK: - First Duplicate

extension LazySequenceProtocol where Element: Hashable {

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

// MARK: - Count

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

extension Sequence {

    public func count(
        where predicate: (Element) throws -> Bool
    ) rethrows -> Int {
        var count = 0
        for element in self {
            if try predicate(element) {
                count += 1
            }
        }
        return count
    }
}

extension Sequence where Element: Equatable {

    public func count(of element: Element) -> Int {
        count(where: { $0 == element })
    }
}

// MARK: - Grouping

extension Sequence {

    /// Returns a dictionary grouping elements by a key.
    ///
    /// - Parameter key: A closure to fetch a key for the given element.
    /// - Returns: A dictionary of keys to an array of elements.
    public func group<Key: Hashable>(by key: (Element) -> Key) -> [Key: [Element]] {
        return Dictionary(grouping: self, by: key)
    }
}

// MARK: - Maths

extension Sequence {

    /// Calculates the sum of a property of each element.
    ///
    /// - Parameter value: The value to be summed up.
    /// - Returns: The total sum of the values.
    public func sum<Value: Numeric>(
        of value: (Element) throws -> Value
    ) rethrows -> Value {
        try reduce(0) { try $0 + value($1) }
    }
}

extension Sequence where Element: Numeric {

    /// The sum of all the values in the sequence.
    ///
    /// ```
    /// [1, 2, 3, 4].sum()
    /// // -> 1 + 2 + 3 + 4
    /// // -> 10
    /// ```
    ///
    /// - Returns: The sum of all the values.
    public func sum() -> Element { reduce(0, +) }

    /// The product of all the values in the sequence.
    ///
    /// ```
    /// [1, 2, 3, 4].product()
    /// // -> 1 * 2 * 3 * 4
    /// // -> 24
    /// ```
    ///
    /// - Returns: The product of all the values.
    public func product() -> Element { reduce(1, *) }
}
