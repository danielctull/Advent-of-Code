
extension Sequence {

    /// Creates a sequence which repeats the receiver's elements a given number
    /// of times.
    ///
    /// For example:
    ///
    /// `[1, 2, 3, 4].repeatingElements(3)`
    ///
    /// will return the sequence:
    ///
    /// `1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4`
    ///
    /// - Parameter count: The amount of times to repeat the elements.
    /// - Returns: The sequence of repeated elements.
    public func repeatingElements(_ count: Int) -> RepeatingElementsSequence<Self> {
        return RepeatingElementsSequence(base: self, count: count)
    }
}

public struct RepeatingElementsSequence<Base: Sequence> {
    fileprivate let base: Base
    fileprivate let count: Int
}

extension RepeatingElementsSequence: Sequence {

    public func makeIterator() -> Iterator {
        return Iterator(baseIterator: base.makeIterator(), count: count)
    }
}

extension RepeatingElementsSequence {

    public struct Iterator {

        private var baseIterator: Base.Iterator
        private let count: Int

        private var currentCount: Int
        private var currentElement: Base.Element?

        fileprivate init(baseIterator: Base.Iterator, count: Int) {
            self.baseIterator = baseIterator
            self.count = count

            currentElement = self.baseIterator.next()
            currentCount = 0
        }
    }
}

extension RepeatingElementsSequence.Iterator: IteratorProtocol {

    public mutating func next() -> Base.Element? {

        guard count > 0 else { return nil }

        if currentCount >= count {
            currentCount = 0
            currentElement = baseIterator.next()
        }

        currentCount += 1
        return currentElement
    }
}
