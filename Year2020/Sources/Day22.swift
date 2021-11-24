
import Advent
import Foundation

public enum Day22: Day {

    public static let title = "Crab Combat"

    public static func part1(_ input: Input) throws -> Int {
        var (lhs, rhs) = try parse(input)
        combat(&lhs, &rhs)
        return max(lhs.score, rhs.score)
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }

    private static func parse(_ input: Input) throws -> (Deck, Deck) {
        let decks = input.lines
            .split(separator: "")
            .map { Deck(cards: $0.compactMap(Int.init)) }
        return try (decks.first.unwrapped(), decks.last.unwrapped())
    }

    private static func combat(_ lhs: inout Deck, _ rhs: inout Deck) {
        while !lhs.cards.isEmpty && !rhs.cards.isEmpty {
            let left = lhs.cards.removeFirst()
            let right = rhs.cards.removeFirst()
            if left > right {
                lhs.cards.append(left)
                lhs.cards.append(right)
            } else {
                rhs.cards.append(right)
                rhs.cards.append(left)
            }
        }
    }
}

extension Day22 {

    fileprivate struct Deck {
        var cards: [Int]
    }
}

extension Day22.Deck {

    var score: Int {
        cards.reversed().indexed().reduce(0) { result, value in
            result + (value.index + 1) * value.element
        }
    }
}
