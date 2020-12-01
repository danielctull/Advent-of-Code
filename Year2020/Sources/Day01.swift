
import Advent
import Algorithms
import Foundation

public enum Day01 {

    public static func part1(_ input: Input) -> Int {

        input.integers
            .combinations(ofCount: 2)
            .first(where: { $0.sum == 2020 })
            .map { $0.product } ?? 0
    }

    public static func part2(_ input: Input) -> Int {
        0
    }
}
