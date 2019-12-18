
public func product<Sequence1: Sequence, Sequence2: Sequence>(_ sequence1: Sequence1, _ sequence2: Sequence2) -> ProductSequence<Sequence1, Sequence2> {
    return ProductSequence(base1: sequence1, base2: sequence2)
}

public struct ProductSequence<Base1: Sequence, Base2: Sequence> {
    fileprivate let base1: Base1
    fileprivate let base2: Base2
}

extension ProductSequence: Sequence {

    public func makeIterator() -> Iterator {
        return Iterator(base1: base1, base2: base2)
    }
}

extension ProductSequence {

    public struct Iterator {

        private var iterator: Zip2Sequence<RepeatingSequence<Base1>, RepeatingElementsSequence<Base2>>.Iterator

        fileprivate init(base1: Base1, base2: Base2) {
            let sequence1 = base1.repeating()
            let sequence2 = base2.repeatingElements(Array(base1).count)
            iterator = zip(sequence1, sequence2).makeIterator()
        }
    }
}

extension ProductSequence.Iterator: IteratorProtocol {

    mutating public func next() -> (Base1.Element, Base2.Element)? {
        return iterator.next()
    }
}
