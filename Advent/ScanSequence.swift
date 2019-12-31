
extension Sequence {

    /// Returns a sequence containing the results of combining the elements of
    /// the sequence using the given transform.
    ///
    /// This can be seen as applying the reduce function to each element and
    /// providing these results as a sequence.
    ///
    /// ```
    /// let values = [1, 2, 3, 4]
    /// let sequence = values.scan(0, +)
    /// print(Array(sequence))
    ///
    /// -> prints [1, 3, 6, 10]
    /// ```
    ///
    /// - Parameters:
    ///   - initial: The value to use as the initial accumulating value.
    ///   - transform: A closure that combines an accumulating value and
    ///     an element of the sequence.
    /// - Returns: A sequence of transformed elements.
    public func scan<Result>(
        _ initial: Result,
        _ transform: @escaping (Result, Element) -> Result
    ) -> ScanSequence<Result, Self> {
        ScanSequence(base: self, initial: initial, transform: transform)
    }
}

/// A sequence of applying a transform to the element of a sequence and the
/// previously transformed result.
public struct ScanSequence<Result, Base: Sequence> {
    fileprivate let base: Base
    fileprivate let initial: Result
    fileprivate let transform: (Result, Base.Element) -> Result
}

extension ScanSequence {

    public struct Iterator {
        fileprivate var base: Base.Iterator
        fileprivate var result: Result
        fileprivate let transform: (Result, Base.Element) -> Result
    }
}

extension ScanSequence.Iterator: IteratorProtocol {

    public mutating func next() -> Result? {
        guard let element = base.next() else { return nil }
        result = transform(result, element)
        return result
    }
}

extension ScanSequence: Sequence {

    public func makeIterator() -> Iterator {
        Iterator(base: base.makeIterator(),
                 result: initial,
                 transform: transform)
    }

    public var underestimatedCount: Int { base.underestimatedCount }
}

