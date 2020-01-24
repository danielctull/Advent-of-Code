
import Advent
import Foundation

public struct Day01 {

    public init() {}

    public func part1(input: Input) -> Int {

        return input
            .lines
            .compactMap(Int.init)
            .reduce(0, +)
    }

    public func part2(input: Input) -> Int {

        return input
            .lines
            .compactMap(Int.init)
            .repeating()
            .accumulating(0, +)
            .firstDuplicate!
    }
}
