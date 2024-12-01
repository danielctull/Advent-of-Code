
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

    public static var integer: Self {
        TryCapture {
            OneOrMore(.digit)
        } transform: {
            Int($0)
        }
    }
}

extension TryCapture where Output == (Substring, Character) {

    public static var character: Self {
        TryCapture {
            One(.any)
        } transform: {
            $0.first
        }
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

    public static var string: Self {
        Capture {
           OneOrMore(.any)
       } transform: {
           String($0)
       }
    }

    public static var alpha: Self {
        Capture {
           OneOrMore(.word)
       } transform: {
           String($0)
       }
    }
}

/// A regex component that matches a list of items.
public struct List<Component: RegexComponent>: CustomConsumingRegexComponent {

    public typealias RegexOutput = [Component.RegexOutput]

    private let component: () -> Component

    public init(@RegexComponentBuilder _ component: @escaping () -> Component) {
        self.component = component
    }

    public func consuming(
        _ input: String,
        startingAt start: String.Index,
        in bounds: Range<String.Index>
    ) throws -> (upperBound: String.Index, output: RegexOutput)? {
        let regex = Regex(component)
        var index = start
        var list: [Component.RegexOutput] = []
        while
            index < input.endIndex,
            let match = input[index...].prefixMatch(of: regex)
        {
            list.append(match.output)
            index = match.range.upperBound
        }
        return (index, list)
    }
}

/// A regex component that matches a list of key/value pairs that have been
/// captured.
public struct Map<Key: Hashable, Value, Component: RegexComponent>: CustomConsumingRegexComponent where Component.RegexOutput == (Substring, Key, Value) {

    public typealias RegexOutput = [Key: Value]

    private let component: () -> Component

    public init(@RegexComponentBuilder _ component: @escaping () -> Component) {
        self.component = component
    }

    public func consuming(
        _ input: String,
        startingAt start: String.Index,
        in bounds: Range<String.Index>
    ) throws -> (upperBound: String.Index, output: RegexOutput)? {
        let regex = Regex(component)
        var index = start
        var result: [Key: Value] = [:]
        while
            index < input.endIndex,
            let match = input[index...].prefixMatch(of: regex)
        {
            result[match.output.1] = match.output.2
            index = match.range.upperBound
        }
        return (index, result)
    }
}

/// A regex component that reverses the first and second output values. This
/// can be useful when using the ``Map`` component but your key and value are
/// captured the wrong way around.
public struct Reverse<A, B, Component: RegexComponent>: CustomConsumingRegexComponent where Component.RegexOutput == (Substring, A, B) {

    public typealias RegexOutput = (Substring, B, A)

    private let component: () -> Component

    public init(@RegexComponentBuilder _ component: @escaping () -> Component) {
        self.component = component
    }

    public func consuming(
        _ input: String,
        startingAt start: String.Index,
        in bounds: Range<String.Index>
    ) throws -> (upperBound: String.Index, output: RegexOutput)? {

        let regex = Regex(component)
        guard let match = input[start...].prefixMatch(of: regex) else { return nil }
        let index = match.range.upperBound
        let output = match.output
        return (index, (output.0, output.2, output.1))
    }
}
