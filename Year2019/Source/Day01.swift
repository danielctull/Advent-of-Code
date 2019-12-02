
import Advent
import Foundation

public struct Day01 {

    public init() {}

    public func part1(input: Input) -> Int {

        input
            .lines
            .compactMap { Double($0.string) }
            .map { Int(floor($0 / 3)) - 2 }
            .reduce(0, +)
    }
}
