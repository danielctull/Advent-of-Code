
import Advent
import Algorithms
import Foundation
import RegexBuilder

public enum Day07: Day {

    public static let title = "Camel Cards"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .map { try regex.match(in: $0).output }
            .sorted(by: \.1.strength, \.1.cards)
            .indexed()
            .map { $0.element.2 * ($0.index + 1) }
            .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines
            .map { try regex.match(in: $0).output }
            .sorted(by: \.1.strength2, \.1.cards2)
            .indexed()
            .map { $0.element.2 * ($0.index + 1) }
            .sum
    }

    fileprivate static let regex = Regex {
        TryCapture {
            OneOrMore(.word)
        } transform: {
            try Hand(String($0))
        }
        One(.whitespace)
        TryCapture.integer
    }
}

private enum Card: RawRepresentable, Hashable, Comparable {
    case one, two, three, four, five, six, seven, eight, nine, t, j, q, k, a

    init?(rawValue: Character) {
        switch rawValue {
        case "A": self = .a
        case "K": self = .k
        case "Q": self = .q
        case "J": self = .j
        case "T": self = .t
        case "9": self = .nine
        case "8": self = .eight
        case "7": self = .seven
        case "6": self = .six
        case "5": self = .five
        case "4": self = .four
        case "3": self = .three
        case "2": self = .two
        case "1": self = .one
        default: return nil
        }
    }

    var rawValue: Character {
        switch self {
        case .a: "A"
        case .k: "K"
        case .q: "Q"
        case .j: "J"
        case .t: "T"
        case .nine: "9"
        case .eight: "8"
        case .seven: "7"
        case .six: "6"
        case .five: "5"
        case .four: "4"
        case .three: "3"
        case .two: "2"
        case .one: "1"
        }
    }
}

private struct Hand {

    private let _cards: [Card]

    init(_ string: String) throws {
        _cards = try string.map(Card.init)
    }

    enum Strength: Comparable {
        case highCard
        case onePair
        case twoPair
        case threeOfAKind
        case fullHouse
        case fourOfAKind
        case fiveOfAKind
    }

    struct Cards: Comparable {
        let cards: [Card]

        static func < (lhs: Cards, rhs: Cards) -> Bool {
            (lhs.cards[0], lhs.cards[1], lhs.cards[2], lhs.cards[3], lhs.cards[4])
            <
            (rhs.cards[0], rhs.cards[1], rhs.cards[2], rhs.cards[3], rhs.cards[4])
        }
    }

    var cards: Cards { Cards(cards: _cards) }

    var strength: Strength {
        let group = _cards.group { $0 }
        return switch group.count {
        case 1: .fiveOfAKind
        case 2 where group.values.contains { $0.count == 4 }: .fourOfAKind
        case 2: .fullHouse
        case 3 where group.values.contains { $0.count == 3 }: .threeOfAKind
        case 3: .twoPair
        case 4: .onePair
        case 5: .highCard
        default: fatalError()
        }
    }

    struct Cards2: Comparable {
        let cards: [Card]

        static func < (lhs: Cards2, rhs: Cards2) -> Bool {
            let lhs: [Card] = lhs.cards.map {
                switch $0 {
                case .j: .one
                default: $0
                }
            }

            let rhs: [Card] = rhs.cards.map {
                switch $0 {
                case .j: .one
                default: $0
                }
            }

            return (lhs[0], lhs[1], lhs[2], lhs[3], lhs[4])
            <
            (rhs[0], rhs[1], rhs[2], rhs[3], rhs[4])
        }
    }

    var cards2: Cards2 { Cards2(cards: _cards) }

    var strength2: Strength {
        let jokers = _cards.filter { $0 == .j }
        let group = _cards
            .filter { $0 != .j }
            .group { $0 }
            .mapValues { $0 + jokers }

        return switch group.count {
        case 0: .fiveOfAKind
        case 1: .fiveOfAKind
        case 2 where group.values.contains { $0.count == 4 }: .fourOfAKind
        case 2: .fullHouse
        case 3 where group.values.contains { $0.count == 3 }: .threeOfAKind
        case 3: .twoPair
        case 4: .onePair
        case 5: .highCard
        default: fatalError()
        }
    }
}
