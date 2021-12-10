
import Advent
import Algorithms
import Foundation

public enum Day10: Day {

    public static let title = ""

    public static func part1(_ input: Input) throws -> Int {

        try input.lines
            .map { try $0.map(Token.init(_:)) }
            .catching(IllegalToken.self) { try $0.validate() }
            .compacted()
            .sum(of: \.token.points)
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Array where Element == Day10.Token {

    func validate() throws {
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
    }
}

extension Day10 {

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

    var opposite: Self {
        switch end {
        case .open: return Self(kind: kind, end: .close)
        case .close: return Self(kind: kind, end: .open)
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
