
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

extension LazySequenceProtocol {

    /// Returns the non-throwing results of mapping the given transformation
    /// over this sequence.
    ///
    /// Use this method to receive a sequence of successful values when your
    /// transformation can throw an error.
    ///
    /// Complexity: O(1)
    ///
    /// - Parameter transform: A throwing closure that accepts an element of
    ///                        this sequence as its argument and returns a
    ///                        value.
    public func compactThrowsMap<ElementOfResult>(
        _ transform: @escaping (Element) throws -> ElementOfResult
    ) -> LazyMapSequence<LazyFilterSequence<LazyMapSequence<Elements, ElementOfResult?>>, ElementOfResult> {

        compactMap { try? transform($0) }
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
        reduce(into: [:]) { result, element in
            result[element, default: 0] += 1
        }
    }
}

extension Sequence where Element: Hashable, Element: Comparable {

    /// Find the element that appears the majority of times.
    ///
    /// If there are the same number of elements, the value of the element will
    /// be used to compare instead.
    public var most: Element? {
        countByElement
            .max(by: \.value, \.key)
            .map(\.key)
    }

    /// Find the element that appears the fewest times.
    ///
    /// If there are the same number of these elements, the value of the element
    /// will be used to compare instead.
    public var least: Element? {
        countByElement
            .min(by: \.value, \.key)
            .map(\.key)
    }
}

extension Sequence {

    public func sorted<V1: Comparable>(
        by kp1: KeyPath<Element, V1>
    ) -> [Element] {
        sorted(by: { $0[keyPath: kp1] < $1[keyPath: kp1] })
    }

    public func sorted<V1: Comparable, V2: Comparable>(
        by kp1: KeyPath<Element, V1>,
        _ kp2: KeyPath<Element, V2>
    ) -> [Element] {
        sorted(by: {
            ($0[keyPath: kp1], $0[keyPath: kp2]) < ($1[keyPath: kp1], $1[keyPath: kp2])
        })
    }

    public func max<V1: Comparable>(
        by kp1: KeyPath<Element, V1>
    ) -> Element? {
        self.max(by: { $0[keyPath: kp1] < $1[keyPath: kp1] })
    }

    public func max<V1: Comparable, V2: Comparable>(
        by kp1: KeyPath<Element, V1>,
        _ kp2: KeyPath<Element, V2>
    ) -> Element? {
        self.max(by: {
            ($0[keyPath: kp1], $0[keyPath: kp2]) < ($1[keyPath: kp1], $1[keyPath: kp2])
        })
    }

    public func min<V1: Comparable>(
        by kp1: KeyPath<Element, V1>
    ) -> Element? {
        self.min(by: { $0[keyPath: kp1] < $1[keyPath: kp1] })
    }

    public func min<V1: Comparable, V2: Comparable>(
        by kp1: KeyPath<Element, V1>,
        _ kp2: KeyPath<Element, V2>
    ) -> Element? {
        self.min(by: {
            ($0[keyPath: kp1], $0[keyPath: kp2]) < ($1[keyPath: kp1], $1[keyPath: kp2])
        })
    }
}

struct NoElementsFound: Error {}

extension Sequence where Element: Comparable {

    public var min: Element {
        get throws {
            guard let min = self.min() else { throw NoElementsFound() }
            return min
        }
    }

    public var max: Element {
        get throws {
            guard let max = self.max() else { throw NoElementsFound() }
            return max
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

extension Sequence {

    /// Returns an array of errors thrown from executing the given function on
    /// each element of the sequence.
    ///
    /// - Returns: An array containing errors that are thrown.
    public func catching<E: Error, Return>(
        _ kind: E.Type,
        _ function: (Element) throws -> Return
    ) -> [E?] {
        map { element in
            do {
                _ = try function(element)
                return nil
            } catch let error as E {
                return error
            } catch {
                return nil
            }
        }
    }
}

// MARK: - Grouping

extension Sequence {

    /// Returns a dictionary grouping elements by a key.
    ///
    /// - Parameter key: A closure to fetch a key for the given element.
    /// - Returns: A dictionary of keys to an array of elements.
    public func group<Key: Hashable>(by key: (Element) -> Key) -> [Key: [Element]] {
        Dictionary(grouping: self, by: key)
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
    /// [1, 2, 3, 4].sum
    /// // -> 1 + 2 + 3 + 4
    /// // -> 10
    /// ```
    public var sum: Element { reduce(0, +) }

    /// The product of all the values in the sequence.
    ///
    /// ```
    /// [1, 2, 3, 4].product
    /// // -> 1 * 2 * 3 * 4
    /// // -> 24
    /// ```
    public var product: Element { reduce(1, *) }
}
