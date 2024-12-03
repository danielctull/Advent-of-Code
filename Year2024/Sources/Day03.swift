
import Advent
import RegexBuilder

public enum Day03: Day {

    public static let title = "Mull It Over"

    private static let regex = Regex {
        "mul("
        TryCapture.integer
        ","
        TryCapture.integer
        ")"
    }

    public static func part1(_ input: Input) throws -> Int {
        input.string.matches(of: regex).map { match in
            match.output.1 * match.output.2
        }
        .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}
