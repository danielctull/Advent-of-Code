
import Advent
import Foundation

public struct Day01 {

    public init() {}

    public func part1(input: Input) -> Int {

        return input
            .lines
            .map { $0.string }
            .first!
            .map(convert)
            .reduce(0, +)
    }

    public func part2(input: Input) -> Int {

        return input
            .lines
            .map { $0.string }
            .first!
            .map(convert)
            .accumulating(0, +)
            .enumerated()
            .first { $0.element == -1 }
            .map { $0.offset }!
    }

    private func convert(_ character: Character) -> Int {
        switch character {
        case "(": return 1
        case ")": return -1
        default: fatalError()
        }
    }
}
