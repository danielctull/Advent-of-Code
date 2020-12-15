
import Advent
import Foundation

public enum Day15: Day {

    public static let title = "Rambunctious Recitation"

    public static func part1(_ input: Input) throws -> Int {
        try findNumber(2020, in: input)
    }

    public static func part2(_ input: Input) throws -> Int {
        try findNumber(30000000, in: input)
    }

    private static func findNumber(_ goal: Int, in input: Input) throws -> Int {

        var positions = try zip(1..., input.integers)
            .dropLast()
            .group(by: \.1)
            .mapValues { try $0.last.unwrapped().0 }

        let last = try input
            .integers
            .last
            .unwrapped()

        return (input.integers.count..<goal).reduce(last) { previous, turn in

            let next: Int
            if let previousTurn = positions[previous] {
                next = turn - previousTurn
            } else {
                next = 0
            }

            positions[previous] = turn
            return next
        }
    }
}
