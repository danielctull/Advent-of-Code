
public struct Predicate<Value> {

    private let predicate: (Value) -> Bool
    public init(_ predicate: @escaping (Value) -> Bool) {
        self.predicate = predicate
    }

    public func callAsFunction(_ value: Value) -> Bool {
        predicate(value)
    }
}

public func ~= <T>(predicate: Predicate<T>, value: T) -> Bool {
    predicate(value)
}

public func && <T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
    Predicate { value in lhs(value) && rhs(value) }
}

extension Predicate where Value == String {

    public static func hasPrefix(_ prefix: String) -> Predicate {
        Predicate { $0.hasPrefix(prefix) }
    }

    public static func matches(_ pattern: RegularExpression.Pattern) -> Self {
        guard let regex = try? RegularExpression(pattern: pattern) else {
            return Predicate { _ in false }
        }
        return Predicate(regex.matches)
    }
}

extension Predicate {

    public static func within<Range: RangeExpression>(
        _ range: Range
    ) -> Self where Range.Bound == Value {
        Predicate(range.contains)
    }
}

extension Predicate where Value: Equatable {

    public static func within(_ values: Value...) -> Self {
        Predicate(values.contains)
    }
}
