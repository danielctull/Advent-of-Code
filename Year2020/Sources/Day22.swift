
import Advent
import Foundation

public enum Day22: Day {

    public static let title = "Crab Combat"

    public static func part1(_ input: Input) throws -> Int {
        var game = try Game(input)
        game.combat()
        return game.score
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day22 {

    fileprivate struct Game {
        var player1: Deck
        var player2: Deck
    }

    fileprivate struct Deck {
        var cards: [Int]
    }
}

extension Day22.Game {

    init(_ input: Input) throws {
        let decks = input.lines
            .split(separator: "")
            .map { Day22.Deck(cards: $0.compactMap(Int.init)) }
        player1 = try decks.first.unwrapped()
        player2 = try decks.last.unwrapped()
    }

    mutating func combat() {
        while !player1.cards.isEmpty && !player2.cards.isEmpty {
            let card1 = player1.cards.removeFirst()
            let card2 = player2.cards.removeFirst()
            if card1 > card2 {
                player1.cards.append(card1)
                player1.cards.append(card2)
            } else {
                player2.cards.append(card2)
                player2.cards.append(card1)
            }
        }
    }

    var score: Int { max(player1.score, player2.score) }
}

extension Day22.Deck {

    var score: Int {
        cards.reversed().indexed().reduce(0) { result, value in
            result + (value.index + 1) * value.element
        }
    }
}
