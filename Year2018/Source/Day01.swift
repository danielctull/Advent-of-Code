
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
