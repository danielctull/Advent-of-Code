
import Advent

public enum Day18: Day {

    public static let title = "Operation Order"

    public static func part1(_ input: Input) throws -> Int {

        input.lines
            .map { string -> [Token] in
                var scanner = Scanner(string: string, scan: scan)
                return scanner.scan()
            }
            .map { tokens -> Expression in
                var parser = Parser(tokens: tokens.reversed(), parse: parse)
                return parser.parse()
            }
            .map { $0.evaluate() }
            .sum()
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }

    private static func scan(scanner: inout Scanner<Token>) -> Token? {

        func scanValue() -> Token {

            while let now = scanner.peek(), ("0"..."9").contains(now) {
                scanner.advance()
            }

            return .value(Int(scanner.current)!)
        }

        let character = scanner.advance()
        switch character {
        case "{": return .leftParenthesis
        case "}": return .rightParenthesis
        case "+": return .add
        case "*": return .multiply
        case "0"..."9": return scanValue()
        default: return nil
        }
    }

    private static func parse(parser: inout Parser<Token, Expression>) -> Expression {

        guard !parser.isAtEnd else { fatalError() }

        let token = parser.advance()

        switch token {

        case .leftParenthesis:
            let result = parse(parser: &parser)
            parser.consume(.rightParenthesis)
            return result

        case let .value(lhs):
            switch parser.peek() {
            case nil:
                return .value(lhs)
            case .add:
                parser.consume(.add)
                return .add(.value(lhs), parse(parser: &parser))
            case .multiply:
                parser.consume(.multiply)
                return .multiply(.value(lhs), parse(parser: &parser))
            default:
                fatalError()
            }

        default:
            fatalError()
        }
    }
}

public struct Parser<Token: Equatable, Output> {
    public typealias Parse = (inout Parser) -> Output

    private let tokens: [Token]
    private var current = 0
    private let _parse: Parse

    public init(tokens: [Token], parse: @escaping Parse) {
        self.tokens = tokens
        _parse = parse
    }

    mutating func parse() -> Output {
        _parse(&self)
    }

    public func check(_ token: Token) -> Bool {
        guard current < tokens.endIndex else { return false }
        return peek() == token
    }

    public func peek() -> Token? {
        guard current < tokens.endIndex else { return nil }
        return tokens[current]
    }

    public var isAtEnd: Bool { current == tokens.endIndex }

    @discardableResult
    public mutating func advance() -> Token {
        defer { current = tokens.index(after: current) }
        return tokens[current]
    }

    @discardableResult
    public mutating func consume(_ token: Token) -> Token {
        guard check(token) else { fatalError() }
        return advance()
    }

    public mutating func match(_ tokens: Token...) -> Bool {

        for token in tokens {
            if check(token) {
                advance()
                return true
            }
        }

        return false
    }
}

extension Day18 {

    enum Token: Equatable {
        case add
        case multiply
        case leftParenthesis
        case rightParenthesis
        case value(Int)
    }

    indirect enum Expression {
        case add(Expression, Expression)
        case multiply(Expression, Expression)
        case value(Int)
    }
}

extension Day18.Expression {

    func evaluate() -> Int {

        var result: Int
        switch self {
        case let .add(lhs, rhs): result = lhs.evaluate() + rhs.evaluate()
        case let .multiply(lhs, rhs): result = lhs.evaluate() * rhs.evaluate()
        case let .value(value): result = value
        }
        print("expression:", self, "result:", result)
        return result
    }
}

extension Day18.Expression: CustomStringConvertible {

    var description: String {
        switch self {
        case let .add(lhs, rhs): return "\(lhs) + \(rhs)"
        case let .multiply(lhs, rhs): return "\(lhs) * \(rhs)"
        case let .value(value): return value.description
        }
    }
}
