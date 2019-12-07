
extension Sequence {

    /// Returns a sequence containing all the permutations of the sequence.
    ///
    /// Implemented using Heap's algorithm.
    /// https://en.wikipedia.org/wiki/Heap%27s_algorithm
    public var permutations: PermutationsSequence<Self> {
        PermutationsSequence(base: self)
    }
}

public struct PermutationsSequence<Base: Sequence> {
    fileprivate let base: Base
}

extension PermutationsSequence: Sequence {

    public typealias Element = [Base.Element]

    public func makeIterator() -> Iterator {
        Iterator(base: Array(base))
    }
}

extension PermutationsSequence {

    public struct Iterator {
        fileprivate var base: [Base.Element]
        private var iteration = 0
        private var stackState: [Int] // c in Heap's algorithm
        private var isFirst = true

        init(base: [Base.Element]) {
            self.base = base
            stackState = Array(repeating: 0, count: base.count)
        }
    }
}

extension PermutationsSequence.Iterator: IteratorProtocol {

    // From the non-recursive version of Heap's algorithm.
    // https://en.wikipedia.org/wiki/Heap%27s_algorithm#Details_of_the_algorithm

    public mutating func next() -> [Base.Element]? {

        guard !isFirst else {
            isFirst = false
            return base
        }

        while iteration < base.count {

            if stackState[iteration] < iteration {
                if iteration.isMultiple(of: 2) {
                    base.swapAt(0, iteration)
                } else {
                    base.swapAt(stackState[iteration], iteration)
                }

                stackState[iteration] += 1
                iteration = 0
                return base

            } else {
                stackState[iteration] = 0
                iteration += 1
            }
        }

        return nil
    }
}
