
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
        var cards: [Int: Int] = [:]
        for line in input.lines {
            
            let output = try regex.match(in: line).output
            let card = output.1
            let winning: Set<Int> = Set(output.2.map(\.1))
            let mine: Set<Int> = Set(output.3.map(\.1))
            let amount = winning.intersection(mine).count

            cards[card, default: 0] += 1

            guard amount > 0 else { continue }

            let count = cards[card, default: 0]
            for card in ((card+1)...(card+amount)) {
                cards[card, default: 0] += count
            }
        }
        return cards.map(\.value).sum
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
