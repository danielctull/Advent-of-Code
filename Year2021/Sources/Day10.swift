
import Advent
import Algorithms
import Foundation

public enum Day10: Day {

    public static let title = "Syntax Scoring"

    public static func part1(_ input: Input) throws -> Int {

        try input.lines
            .map { try $0.map(Token.init(_:)) }
            .catching(IllegalToken.self) { try $0.completion() }
            .compacted()
            .sum(of: \.token.points)
    }

    public static func part2(_ input: Input) throws -> Int {

        try input.lines
            .map { try $0.map(Token.init(_:)) }
            .map { try? $0.completion() }
            .compacted()
            .map(\.points)
            .sorted()
            .middle
    }
}

extension Array where Element == Day10.Token {

    func completion() throws -> Day10.Completion {
        var expecting: [Day10.Token] = []
        for token in self {
            switch token.end {
            case .open:
                expecting.append(.init(kind: token.kind, end: .close))
            case .close where expecting.last == token:
                _ = expecting.removeLast()
            case .close:
                throw Day10.IllegalToken(token: token)
            }
        }
        return Day10.Completion(tokens: expecting.reversed())
    }
}

extension Day10 {

    struct Completion {
        let tokens: [Token]
    }

    struct IllegalToken: Error {
        let token: Token
    }

    enum Kind: Equatable {
        case round
        case square
        case curly
        case angle
    }

    enum End: Equatable {
        case open
        case close
    }

    struct Token: Equatable {
        let kind: Kind
        let end: End
    }
}

extension Day10.Token: RawRepresentable {

    init?(rawValue: Character) {
        switch rawValue {
        case "(": self.init(kind: .round,  end: .open)
        case ")": self.init(kind: .round,  end: .close)
        case "[": self.init(kind: .square, end: .open)
        case "]": self.init(kind: .square, end: .close)
        case "{": self.init(kind: .curly,  end: .open)
        case "}": self.init(kind: .curly,  end: .close)
        case "<": self.init(kind: .angle,  end: .open)
        case ">": self.init(kind: .angle,  end: .close)
        default: return nil
        }
    }

    var rawValue: Character {
        switch (kind, end) {
        case (.round,  .open ): return "("
        case (.round,  .close): return ")"
        case (.square, .open ): return "["
        case (.square, .close): return "]"
        case (.curly,  .open ): return "{"
        case (.curly,  .close): return "}"
        case (.angle,  .open ): return "<"
        case (.angle,  .close): return ">"
        }
    }

    var points: Int {
        switch kind {
        case .round: return 3
        case .square: return 57
        case .curly: return 1197
        case .angle: return 25137
        }
    }
}

extension Day10.Completion {

    var points: Int {

        func points(for token: Day10.Token) -> Int {
            switch token.kind {
            case .round: return 1
            case .square: return 2
            case .curly: return 3
            case .angle: return 4
            }
        }

        return tokens.reduce(0) { result, token in
            result * 5 + points(for: token)
        }
    }
}
