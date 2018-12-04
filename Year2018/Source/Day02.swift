
import Advent
import Foundation

public struct Day02 {

    public init() {}

    public func part1(input: Input) -> Int {

        let result = input
            .lines
            .compactMap { $0.string }
            .map { string in

            let characterCounts = string.countByElements.values
            let twos = characterCounts.contains(2) ? 1 : 0
            let threes = characterCounts.contains(3) ? 1 : 0
            return Result(twos: twos, threes: threes)

        }.reduce(Result(twos: 0, threes: 0), +)

        return result.twos * result.threes
    }

    public func part2(input: Input) -> String {

        return input
            .lines
            .compactMap { $0.string }
            .squared(ignoringSameIndex: true)
            .reduce("") { result, tuple in

            let sharedCharacters = zip(tuple.0, tuple.1).compactMap { tuple -> Character? in

                guard tuple.0 == tuple.1 else { return nil }

                return tuple.0
            }

            let sharedString = String(sharedCharacters)

            guard sharedString.count > result.count else { return result }

            return sharedString
        }
    }
}

// MARK: - Result

struct Result {
    let twos: Int
    let threes: Int
}

extension Result {

    static func + (lhs: Result, rhs: Result) -> Result {
        return Result(twos: lhs.twos + rhs.twos, threes: lhs.threes + rhs.threes)
    }
}

// MARK: - Count by Elements

extension Sequence where Element: Hashable {

    var countByElements: [Element: Int] {

        return reduce(into: [:]) { result, element in
            result[element, default: 0] += 1
        }
    }
}

// MARK: -

extension Collection {

    func squared(ignoringSameIndex: Bool = false) -> SquaredSequence<Self> {
        return SquaredSequence(base: self, ignoringSameIndex: ignoringSameIndex)
    }
}

struct SquaredSequence<Base: Collection>: Sequence, IteratorProtocol {

    private let base: Base
    private let ignoringSameIndex: Bool
    private var iterator: Zip2Sequence<RepeatingSequence<EnumeratedSequence<Base>>, RepeatingElementsSequence<EnumeratedSequence<Base>>>.Iterator

    init(base: Base, ignoringSameIndex: Bool) {
        self.base = base
        self.ignoringSameIndex = ignoringSameIndex
        let repeatingElements = base.enumerated().repeatingElements(base.count)
        let repeating = base.enumerated().repeating
        iterator = zip(repeating, repeatingElements).makeIterator()
    }

    mutating func next() -> (Base.Element, Base.Element)? {

        guard var next = iterator.next() else { return nil }

        guard ignoringSameIndex else {
            return (next.0.element, next.1.element)
        }

        if next.0.offset == next.1.offset {

            guard let n = iterator.next() else { return nil }

            next = n
        }

        return (next.0.element, next.1.element)
    }
}

// MARK: - RepeatingElementsSequence

extension Sequence {

    public func repeatingElements(_ count: Int) -> RepeatingElementsSequence<Self> {
        return RepeatingElementsSequence(base: self, count: count)
    }
}

public struct RepeatingElementsSequence<Base: Sequence> {
    let base: Base
    let count: Int
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

        init(baseIterator: Base.Iterator, count: Int) {
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
