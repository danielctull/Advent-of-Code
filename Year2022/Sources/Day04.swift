
import Advent
import RegexBuilder

public enum Day04: Day {

    public static let title = "Camp Cleanup"

    private static let regex = Regex {
        TryCapture.range
        ","
        TryCapture.range
    }

    public static func part1(_ input: Input) throws -> Int {
        try input.lines.count(where: { line in
            let output = try regex.match(in: line).output
            return output.1.isSuperset(of: output.2)
                || output.1.isSubset(of: output.2)
        })
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines.count(where: { line in
            let output = try regex.match(in: line).output
            return output.1.overlaps(output.2)
        })
    }
}
