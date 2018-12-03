
import Advent
import Foundation

public struct Day01 {

    public init() {}

    public func part1(input: Input) -> Int {

        return input
            .lines
            .compactMap { Int($0.string) }
            .reduce(0, +)
    }

    public func part2(input: Input) -> Int {

        return input
            .lines
            .compactMap { Int($0.string) }
            .repeating
            .accumulating(0, +)
            .firstDuplicate!
    }
}

// MARK: - RepeatingSequence

extension Sequence {

    var repeating: RepeatingSequence<Self> {
        return RepeatingSequence(base: self)
    }
}

struct RepeatingSequence<Base: Sequence> {
    let base: Base
}

extension RepeatingSequence: Sequence {

    func makeIterator() -> Iterator {
        return Iterator(base: Array(base))
    }
}

extension RepeatingSequence {

    struct Iterator {
        let base: [Element]
        var iterator: Array<Element>.Iterator

        init(base: [Element]) {
            self.base = base
            self.iterator = base.makeIterator()
        }
    }
}

extension RepeatingSequence.Iterator: IteratorProtocol {

    mutating func next() -> Base.Element? {

        if let element = iterator.next() { return element }

        iterator = base.makeIterator()
        return iterator.next()
    }
}

// MARK: - AccumulatingSequence

extension Sequence {

    func accumulating<Result>(
        _ initial: Result,
        _ transform: @escaping (Result, Element) -> Result
        ) -> AccumulatingSequence<Self, Result> {

        return AccumulatingSequence(base: self, initial: initial, transform: transform)
    }
}

struct AccumulatingSequence<Base: Sequence, Result> {
    let base: Base
    let initial: Result
    let transform: (Result, Base.Element) -> Result
}

extension AccumulatingSequence: Sequence {

    func makeIterator() -> Iterator {
        return Iterator(iterator: base.makeIterator(), value: initial, transform: transform)
    }
}

extension AccumulatingSequence {

    struct Iterator {
        var iterator: Base.Iterator
        var value: Result?
        var transform: (Result, Base.Element) -> Result
    }
}

extension AccumulatingSequence.Iterator: IteratorProtocol {

    mutating func next() -> Result? {

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

// MARK: - First Duplicate

extension Sequence where Element: Hashable {

    var firstDuplicate: Element? {

        var elements: Set<Element> = []

        return first { element -> Bool in
            let contains = elements.contains(element)
            elements.insert(element)
            return contains
        }
    }
}
