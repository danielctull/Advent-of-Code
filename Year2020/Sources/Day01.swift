
import Advent
import Algorithms
import Foundation

public enum Day01 {

    public static func part1(_ input: Input) -> Int {
        let values = Set(input.integers)
        return input.integers
            .first(where: { values.contains(2020 - $0) })
            .map { $0 * (2020 - $0) } ?? 0
    }

    public static func part2(_ input: Input) -> Int {
        let values = Set(input.integers)
        return input.integers
            .combinations(ofCount: 2)
            .first(where: { values.contains(2020 - $0.sum()) })
            .map { $0.product() * (2020 - $0.sum()) } ?? 0
    }
}
