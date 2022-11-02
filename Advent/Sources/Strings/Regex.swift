
import RegexBuilder

public struct NoRegexMatch: Error {}

extension Regex {

    public func match(in string: String) throws -> Regex<Output>.Match {
        guard let match = try wholeMatch(in: string) else { throw NoRegexMatch() }
        return match
    }
}

extension TryCapture where Output == (Substring, Int) {

    public static let integer = TryCapture {
        OneOrMore(.digit)
    } transform: {
        Int($0)
    }
}
