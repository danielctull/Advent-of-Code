
import Advent
import Algorithms
import RegexBuilder

public enum Day04: Day {

    public static let title = "Camp Cleanup"

    private static let regex = Regex {
        TryCapture.integer
        "-"
        TryCapture.integer
        ","
        TryCapture.integer
        "-"
        TryCapture.integer
    }

    public static func part1(_ input: Input) throws -> Int {
        try input.lines.count(where: { line in
            let output = try regex.match(in: line).output
            let first = output.1...output.2
            let second = output.3...output.4
            return Set(first).isSuperset(of: Set(second))
                || Set(first).isSubset(of: Set(second))
        })
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines.count(where: { line in
            let output = try regex.match(in: line).output
            let first = output.1...output.2
            let second = output.3...output.4
            return !Set(first).isDisjoint(with: Set(second))
        })
    }
}
