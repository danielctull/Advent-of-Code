
import Advent
import RegexBuilder

public enum Day03: Day {

    public static let title = "Mull It Over"

    private static let regex1 = Regex {
        "mul("
        TryCapture.integer
        ","
        TryCapture.integer
        ")"
    }

    private static let regex2 = Regex {
        ChoiceOf {
            regex1
            "do()"
            "don't()"
        }
    }

    public static func part1(_ input: Input) throws -> Int {
        input.string.matches(of: regex1).map { match in
            match.output.1 * match.output.2
        }
        .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        var active = true
        var total = 0
        for match in input.string.matches(of: regex2) {
            switch (match.output.0, active) {
            case ("do()", _): active = true
            case ("don't()", _): active = false
            case (_, false): continue
            default: total += match.output.1! * match.output.2!
            }
        }
        return total
    }
}
