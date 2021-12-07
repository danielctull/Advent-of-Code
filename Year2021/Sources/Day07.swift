
import Advent
import Algorithms
import Foundation

public enum Day07: Day {

    public static let title = "The Treachery of Whales"

    public static func part1(_ input: Input) throws -> Int {

        let positions = try input.lines
            .first.unwrapped
            .split(separator: ",")
            .map(Int.init)

        let min = try positions.min().unwrapped
        let max = try positions.max().unwrapped
        let costs = positions.countByElement

        return try (min...max).map { proposed -> Int in
            costs.map { position, cost in
                abs(proposed - position) * cost
            }
            .sum
        }
        .min()
        .unwrapped
    }

    public static func part2(_ input: Input) throws -> Int {

        let positions = try input.lines
            .first.unwrapped
            .split(separator: ",")
            .map(Int.init)

        let min = try positions.min().unwrapped
        let max = try positions.max().unwrapped
        let costs = positions.countByElement

        return try (min...max).map { proposed -> Int in
            costs.map { position, cost in
                abs(proposed - position).triangle * cost
            }
            .sum
        }
        .min()
        .unwrapped
    }
}
