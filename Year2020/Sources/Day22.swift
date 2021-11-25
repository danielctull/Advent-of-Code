
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
        var game = try Game(input)
        game.recursiveCombat()
        return game.score
    }
}

extension Day22 {

    fileprivate struct Game: Equatable, Hashable {
        var player1: Deck
        var player2: Deck
    }

    fileprivate struct Deck: Equatable, Hashable {
        var cards: [Int]
    }

    fileprivate enum Winner {
        case player1
        case player2
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

    @discardableResult
    mutating func recursiveCombat() -> Day22.Winner {
        var occuredGames: Set<Self> = []
        while !player1.cards.isEmpty && !player2.cards.isEmpty {

            guard !occuredGames.contains(self) else { return .player1 }
            occuredGames.insert(self)

            let card1 = player1.cards.removeFirst()
            let card2 = player2.cards.removeFirst()

            if card1 <= player1.cards.count && card2 <= player2.cards.count {

                let new1 = player1.cards.dropLast(player1.cards.count - card1).map { $0 }
                let new2 = player2.cards.dropLast(player2.cards.count - card2).map { $0 }
                var subgame = Self(player1: Day22.Deck(cards: new1),
                                   player2: Day22.Deck(cards: new2))

                switch subgame.recursiveCombat() {
                case .player1:
                    player1.cards.append(card1)
                    player1.cards.append(card2)
                case .player2:
                    player2.cards.append(card2)
                    player2.cards.append(card1)
                }

            } else {
                if card1 > card2 {
                    player1.cards.append(card1)
                    player1.cards.append(card2)
                } else {
                    player2.cards.append(card2)
                    player2.cards.append(card1)
                }
            }
        }
        return player2.cards.isEmpty ? .player1 : .player2
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
