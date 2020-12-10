
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

        let adapters = ([0] + input.integers).sorted()

        func canReach(_ lower: Int, _ upper: Int) -> Bool {
            (0...3).contains(upper - lower)
        }

        // Seed the first three, then we can move along to sum the different
        // pathways to getting to the end adapter.
        var pathways = Array(repeating: 1, count: adapters.count)
        pathways[2] = canReach(adapters[0], adapters[2]) ? 2 : 1

        for index in pathways.indices.dropFirst(3) {
            let adapter = adapters[index]
            var pathway = 0
            if canReach(adapters[index - 1], adapter) { pathway += pathways[index - 1] }
            if canReach(adapters[index - 2], adapter) { pathway += pathways[index - 2] }
            if canReach(adapters[index - 3], adapter) { pathway += pathways[index - 3] }
            pathways[index] = pathway
        }
        return pathways.last!
    }
}
