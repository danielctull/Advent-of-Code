
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
