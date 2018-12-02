
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
}
