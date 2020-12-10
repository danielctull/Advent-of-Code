
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

        let joltages = ([0] + input.integers)
            .sorted()
        var reaches = Array(repeating: 0, count: joltages.count)

        let windows = reaches.indices
            .slidingWindows(ofCount: 4)

        func canReach(_ lower: Int, _ upper: Int) -> Bool {
            (0...3).contains(upper - lower)
        }

        // Seed the first three, then we can slide along to sum the different
        // paths to getting to the end.
        
        reaches[0] = 1
        reaches[1] = 1
        reaches[2] = [canReach(joltages[0], joltages[2]), canReach(joltages[1], joltages[2])]
            .map { $0 ? 1 : 0 }
            .sum()

        for indices in windows {

            let index0 = indices.startIndex
            let index1 = indices.index(after: index0)
            let index2 = indices.index(after: index1)
            let index3 = indices.index(after: index2)

            let joltage0 = joltages[index0]
            let joltage1 = joltages[index1]
            let joltage2 = joltages[index2]
            let joltage3 = joltages[index3]

            var reach = 0
            if canReach(joltage0, joltage3) { reach += reaches[index0] }
            if canReach(joltage1, joltage3) { reach += reaches[index1] }
            if canReach(joltage2, joltage3) { reach += reaches[index2] }
            reaches[index3] = reach
        }
        return reaches.last!
    }
}
