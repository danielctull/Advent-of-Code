
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

        let integers = input.integers

        // Make a dictionary of visited numbers for all but the last value in
        // the input sequence.
        var sightings = try zip(1..., integers)
            .dropLast()
            .group(by: \.1)
            .mapValues { try $0.last.unwrapped.0 }

        // Seed last value of the input sequence.
        let last = try integers.last.unwrapped

        // Reduce until we hit our goal amount.
        return (integers.count..<goal).reduce(last) { value, turn in
            defer { sightings[value] = turn }
            guard let lastSeen = sightings[value] else { return 0 }
            return turn - lastSeen
        }
    }
}
