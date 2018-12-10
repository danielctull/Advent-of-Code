
import Advent
import Foundation

public struct Day01 {

    public init() {}

    public func part1(input: Input) -> Int {

        func convert(_ character: Character) -> Int {
            switch character {
            case "(": return 1
            case ")": return -1
            default: fatalError()
            }
        }

        return input
            .lines
            .map { $0.string }
            .first!
            .map(convert)
            .reduce(0, +)
    }
}
