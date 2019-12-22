
public struct Pattern<Value> {
    public let predicate: (Value) -> Bool
}

public func ~= <T>(pattern: Pattern<T>, value: T) -> Bool {
    pattern.predicate(value)
}

extension Pattern where Value == String {

    public static func hasPrefix(_ prefix: String) -> Pattern {
        Pattern { $0.hasPrefix(prefix) }
    }
}
