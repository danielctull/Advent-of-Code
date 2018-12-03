
import Advent
import Foundation

public struct Day01 {

    public init() {}

    public func part1(input: Input) -> Int {

        let result = input
            .lines
            .compactMap { Int($0.string) }
            .reduce(into: 0, +=)

        return result
    }

    public func part2(input: Input) -> Int {

        var frequencies: Set<Int> = []
        var frequency = 0

        var lines = input
            .lines
            .repeating
            .lazy
            .compactMap { Int($0.string) }
			.makeIterator()

		while !frequencies.contains(frequency) {
			frequencies.insert(frequency)
			frequency += lines.next()!
		}

		return frequency
    }
}



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
