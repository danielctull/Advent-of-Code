
import Advent
import Foundation

public enum Day10 {

    public static func part1(_ input: Input) throws -> Int {

        let differences = ([0] + input.integers)
            .sorted()
            .slidingWindows(ofCount: 2)
            .map { $0.last! - $0.first! }

        let ones = differences.count(where: { $0 == 1 })
        let threes = differences.count(where: { $0 == 3 }) + 1
        return ones * threes
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}
