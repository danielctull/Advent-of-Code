
import Advent
import Algorithms

public enum Day06: Day {

    public static let title = "Tuning Trouble"

    public static func part1(_ input: Input) throws -> Int {
        try input.characters
            .windows(ofCount: 4)
            .first(where: { Set($0).count == 4 })
            .unwrapped
            .endIndex
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.characters
            .windows(ofCount: 14)
            .first(where: { Set($0).count == 14 })
            .unwrapped
            .endIndex
    }
}
