
import Advent
import RegexBuilder

public enum Day04: Day {

    public static let title = "Scratchcards"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .map {
                let output = try regex.match(in: $0).output
                let winning: Set<Int> = Set(output.2.map(\.1))
                let mine: Set<Int> = Set(output.3.map(\.1))
                let amount = winning.intersection(mine).count
                return 2.power(amount - 1)
            }
            .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }

    public static let regex = Regex {
        "Card"
        OneOrMore(.whitespace)
        TryCapture.integer
        ":"
        OneOrMore(.whitespace)
        Capture {
            List {
                TryCapture.integer
                OneOrMore(.whitespace)
            }
        }
        "|"
        Capture {
            List {
                OneOrMore(.whitespace)
                TryCapture.integer
            }
        }
    }
}
