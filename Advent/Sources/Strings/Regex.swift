
import RegexBuilder

public struct NoRegexMatch: Error {}

extension Regex {

    public func match(in string: String) throws -> Match {
        guard let match = try wholeMatch(in: string) else { throw NoRegexMatch() }
        return match
    }

    public func matches(in string: String) throws -> [Match] {
        let matches = string.matches(of: self)
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

extension TryCapture {

    public init<T>(_ type: T.Type) where T: RawRepresentable, T.RawValue == Character, Output == (Substring, T) {

        self.init {
            One(.any)
        } transform: {
            $0.first.flatMap(T.init(rawValue:))
        }
    }
}

extension Capture where Output == (Substring, String) {

    public static let string = Capture {
        OneOrMore(.any)
    } transform: {
        String($0)
    }

    public static let alpha = Capture {
        OneOrMore(.word)
    } transform: {
        String($0)
    }
}
