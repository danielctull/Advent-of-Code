
extension Sequence {

    /// Returns a sequence of the results of combining the elements of the
    /// sequence using the given transform.
    ///
    /// This can be seen like `reduce`, but storing each stages result.
    ///
    /// For example:
    ///
    /// `[1, 2, 3, 4, 5, 6].accumulating(0, +)`
    ///
    /// will return the sequence:
    ///
    /// `0, 1, 3, 6, 10, 15, 21`
    ///
    /// - Parameters:
    ///   - initial: The value to use as the initial accumulating value.
    ///              initial is passed to transform the first time the closure
    ///              is executed.
    ///   - transform: A closure that combines an accumulating value and an
    ///                element of the sequence into a new accumulating value, to
    ///                be used in the next call of the transform closure or
    ///                returned to the caller.
    /// - Returns: The sequence of accumulating values.
    public func accumulating<Result>(
        _ initial: Result,
        _ transform: @escaping (Result, Element) -> Result
    ) -> AccumulatingSequence<Self, Result> {

        return AccumulatingSequence(base: self, initial: initial, transform: transform)
    }
}

public struct AccumulatingSequence<Base: Sequence, Result> {
    fileprivate let base: Base
    fileprivate let initial: Result
    fileprivate let transform: (Result, Base.Element) -> Result
}

extension AccumulatingSequence: Sequence {

    public func makeIterator() -> Iterator {
        return Iterator(iterator: base.makeIterator(), value: initial, transform: transform)
    }
}

extension AccumulatingSequence {

    public struct Iterator {
        fileprivate var iterator: Base.Iterator
        fileprivate var value: Result?
        fileprivate var transform: (Result, Base.Element) -> Result
    }
}

extension AccumulatingSequence.Iterator: IteratorProtocol {

    public mutating func next() -> Result? {

        guard let current = value else {
            return nil
        }

        if let element = iterator.next() {
            value = transform(current, element)
        } else {
            value = nil
        }

        return current
    }
}
