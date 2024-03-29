
import Advent
import Algorithms
import Foundation

public struct Day01 {

    public init() {}

    public func part1(input: Input) -> Int {

        return input
            .lines
            .compactMap(Int.init)
            .sum
    }

    public func part2(input: Input) -> Int {

        return input
            .lines
            .lazy
            .compactMap(Int.init)
            .cycled()
            .reductions(0, +)
            .firstDuplicate!
    }
}
