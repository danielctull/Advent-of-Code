
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

        let joltages = ([0] + input.integers).sorted()

        func canReach(_ lower: Int, _ upper: Int) -> Bool {
            (0...3).contains(upper - lower)
        }

        // Seed the first three, then we can slide along to sum the different
        // paths to getting to the end.
        var reaches = Array(repeating: 1, count: joltages.count)
        reaches[2] = canReach(joltages[0], joltages[2]) ? 2 : 1

        for index in reaches.indices.dropFirst(3) {
            let joltage = joltages[index]
            var reach = 0
            if canReach(joltages[index - 1], joltage) { reach += reaches[index - 1] }
            if canReach(joltages[index - 2], joltage) { reach += reaches[index - 2] }
            if canReach(joltages[index - 3], joltage) { reach += reaches[index - 3] }
            reaches[index] = reach
        }
        return reaches.last!
    }
}
