
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
        var player1: [Int]
        var player2: [Int]
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
            .map { $0.compactMap(Int.init) }
        player1 = try decks.first.unwrapped
        player2 = try decks.last.unwrapped
    }

    mutating func combat() {
        while !player1.isEmpty && !player2.isEmpty {
            let card1 = player1.removeFirst()
            let card2 = player2.removeFirst()
            if card1 > card2 {
                player1.append(card1)
                player1.append(card2)
            } else {
                player2.append(card2)
                player2.append(card1)
            }
        }
    }

    @discardableResult
    mutating func recursiveCombat() -> Day22.Winner {
        var occuredGames: Set<Self> = []
        while !player1.isEmpty && !player2.isEmpty {

            guard !occuredGames.contains(self) else { return .player1 }
            occuredGames.insert(self)

            let card1 = player1.removeFirst()
            let card2 = player2.removeFirst()

            if card1 <= player1.count && card2 <= player2.count {

                var subgame = Self(
                    player1: player1.prefix(card1).map { $0 },
                    player2: player2.prefix(card2).map { $0 })

                switch subgame.recursiveCombat() {
                case .player1:
                    player1.append(card1)
                    player1.append(card2)
                case .player2:
                    player2.append(card2)
                    player2.append(card1)
                }

            } else if card1 > card2 {
                player1.append(card1)
                player1.append(card2)
            } else {
                player2.append(card2)
                player2.append(card1)
            }
        }
        return player2.isEmpty ? .player1 : .player2
    }

    var score: Int { max(player1.score, player2.score) }
}

extension Array where Element == Int {

    fileprivate var score: Int {
        reversed().indexed().reduce(0) { result, value in
            result + (value.index + 1) * value.element
        }
    }
}
