
import Algorithms

extension Sequence {

    public var trianglePairs: TrianglePairsSequence<Self> {
        return TrianglePairsSequence(base: self)
    }
}

public struct TrianglePairsSequence<Base: Sequence> {
    fileprivate let base: Base
}

extension TrianglePairsSequence: Sequence {

    public func makeIterator() -> Iterator {
        return Iterator(base: base)
    }
}

extension TrianglePairsSequence {

    public struct Iterator {

        private var iterator: Zip2Sequence<RepeatingElementsSequence<EnumeratedSequence<[Base.Element]>>, Cycle<[EnumeratedSequence<[Base.Element]>.Element]>>.Iterator

        private var observedPairs: Set<Pair> = []

        fileprivate init(base: Base) {
            let array = Array(base)
            let repeating = Array(array.enumerated()).cycled()
            let repeatingElements = array.enumerated().repeatingElements(array.count)
            iterator = zip(repeatingElements, repeating).makeIterator()
        }
    }
}

extension TrianglePairsSequence.Iterator: IteratorProtocol {

    mutating public func next() -> (Base.Element, Base.Element)? {

        var next: ((offset: Int, element: Base.Element), (offset: Int, element: Base.Element))
        var pair: Pair

        repeat {
            guard let n = iterator.next() else { return nil }
            next = n
            pair = Pair(n.0.offset, n.1.offset)
        } while observedPairs.contains(pair) || next.0.offset == next.1.offset

        observedPairs.insert(pair)
        return (next.0.element, next.1.element)
    }
}

extension TrianglePairsSequence.Iterator {

    private struct Pair: Hashable {

        let lhs: Int
        let rhs: Int

        init(_ value1: Int, _ value2: Int) {
            if value1 < value2 {
                lhs = value1
                rhs = value2
            } else {
                lhs = value2
                rhs = value1
            }
        }
    }
}
