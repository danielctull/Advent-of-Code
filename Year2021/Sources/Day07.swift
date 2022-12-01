
import Advent
import Algorithms
import Foundation

public enum Day07: Day {

    public static let title = "The Treachery of Whales"

    public static func part1(_ input: Input) throws -> Int {
        try run(input, cost: { abs($0 - $1) })
    }

    public static func part2(_ input: Input) throws -> Int {
        try run(input, cost: { abs($0 - $1).triangle })
    }

    private static func run(
        _ input: Input,
        cost: (Int, Int) -> Int
    ) throws -> Int {

        let positions = try input.lines
            .first.unwrapped
            .split(separator: ",")
            .map(Int.init)

        let min = try positions.min
        let max = try positions.max
        let amounts = positions.countByElement

        return try (min...max).map { proposed -> Int in
            amounts.map { position, amount in
                cost(proposed, position) * amount
            }
            .sum
        }
        .min()
        .unwrapped
    }
}
