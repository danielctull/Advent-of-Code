
import RegexBuilder

public struct NoRegexMatch: Error {}

extension Regex {

    public func match(in string: String) throws -> Match {
        guard let match = try wholeMatch(in: string) else { throw NoRegexMatch() }
        return match
    }

    public func matches(in string: String) throws -> [Match] {

        var matches: [Match] = []
        var string = string[...]

        while let match = try firstMatch(in: string) {
            let next = string.index(match.range.lowerBound, offsetBy: 1)
            string = string[next...]
            matches.append(match)
        }

        guard !matches.isEmpty else { throw NoRegexMatch() }
        return matches
    }
}

extension TryCapture where Output == (Substring, Int) {

    public static let integer = TryCapture {
        OneOrMore(.digit)
    } transform: {
        Int($0)
    }
}

extension TryCapture where Output == (Substring, Character) {

    public static let character = TryCapture {
        One(.any)
    } transform: {
        $0.first
    }
}

extension Capture where Output == (Substring, String) {

    public static let string = Capture {
        OneOrMore(.any)
    } transform: {
        String($0)
    }
}
