
public struct Scanner<Token> {
    public typealias Scan = (inout Scanner) -> Token?
    private var start: String.Index
    private var index: String.Index
    private var source: String
    private var _scan: Scan
    public init(string: String, scan: @escaping Scan) {
        source = string
        start = source.startIndex
        index = start
        _scan = scan
    }
}

extension Scanner {

    public mutating func scan() -> [Token] {
        var tokens: [Token] = []
        while index < source.endIndex {
            if let token = _scan(&self) { tokens.append(token) }
            start = index
        }
        return tokens
    }

    public var current: String { String(source[start..<index]) }

    @discardableResult
    public mutating func advance() -> Character {
        defer { index = source.index(after: index) }
        return source[index]
    }

    public func peek() -> Character? {
        guard index < source.endIndex else { return nil }
        return source[index]
    }
}
