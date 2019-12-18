
extension Sequence {

    /// Creates a sequence which repeats the receiver's elements.
    public func repeating() -> RepeatingSequence<Self> {
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
        private var pointer = 0

        fileprivate init(base: [Element]) {
            self.base = base
        }
    }
}

extension RepeatingSequence.Iterator: IteratorProtocol {

    mutating public func next() -> Base.Element? {

        defer {
            pointer += 1
            if pointer >= base.count { pointer = 0 }
        }

        return base[pointer]
    }
}
