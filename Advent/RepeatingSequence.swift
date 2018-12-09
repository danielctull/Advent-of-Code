
extension Sequence {

    /// Creates a sequence which repeats the receiver's elements.
    public var repeating: RepeatingSequence<Self> {
        return RepeatingSequence(base: self)
    }
}

/// A sequence which repeats the elements of a given sequence.
public struct RepeatingSequence<Base: Sequence> {
    fileprivate let base: Base
}

extension RepeatingSequence: Sequence {

    public func makeIterator() -> Iterator {
        return Iterator(base: Array(base))
    }
}

extension RepeatingSequence {

    public struct Iterator {
        private let base: [Element]
        private var iterator: Array<Element>.Iterator

        fileprivate init(base: [Element]) {
            self.base = base
            self.iterator = base.makeIterator()
        }
    }
}

extension RepeatingSequence.Iterator: IteratorProtocol {

    mutating public func next() -> Base.Element? {

        if let element = iterator.next() { return element }

        iterator = base.makeIterator()
        return iterator.next()
    }
}
