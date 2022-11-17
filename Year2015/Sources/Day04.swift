
import Advent
import Algorithms
import Foundation

public enum Day04: Day {

    public static let title = "The Ideal Stocking Stuffer"

    public static func part1(_ input: Input) throws -> Int {

        let input = try input.lines.first.unwrapped
        return try (1...)
            .first {
                Hash.md5(input + String($0))
                    .description
                    .hasPrefix("00000")
            }
            .unwrapped
    }

    public static func part2(_ input: Input) throws -> Int {

        let input = try input.lines.first.unwrapped
        return try (1...)
            .first {
                Hash.md5(input + String($0))
                    .description
                    .hasPrefix("000000")
            }
            .unwrapped
    }
}
