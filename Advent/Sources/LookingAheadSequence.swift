
extension Sequence {

    public func lookingAhead(_ count: Int) -> LookingAheadSequence<Self> {
        return LookingAheadSequence(base: self, count: count)
    }
}

public struct LookingAheadSequence<Base: Sequence> {
    fileprivate let base: Base
    fileprivate let count: Int
}

extension LookingAheadSequence: Sequence {

    public func makeIterator() -> Iterator {
        return Iterator(base: base, count: count)
    }
}

extension LookingAheadSequence {

    public struct Iterator {

        private let count: Int
        private var iterator: Base.Iterator
        private var elements: [Base.Element] = []

        fileprivate init(base: Base, count: Int) {
            self.iterator = base.makeIterator()
            self.count = count
        }
    }
}

extension LookingAheadSequence.Iterator: IteratorProtocol {

    mutating public func next() -> [Base.Element]? {

        guard elements.count == count else {
            // Setup first time

            while elements.count < count {
                guard let next = iterator.next() else { return nil }
                elements.append(next)
            }

            return elements
        }

        guard let next = iterator.next() else {
            return nil
        }

        elements.removeFirst()
        elements.append(next)
        return elements
    }
}
