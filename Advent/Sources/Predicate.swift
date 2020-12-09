
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

public func || <T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
    Predicate { value in lhs(value) || rhs(value) }
}

extension Predicate where Value == Int {

    public static func isGreaterThan(_ value: Int) -> Predicate {
        Predicate { $0 > value }
    }

    public static func isLessThan(_ value: Int) -> Predicate {
        Predicate { $0 < value }
    }
}

extension Predicate where Value == String {

    public static func hasPrefix(_ prefix: String) -> Predicate {
        Predicate { $0.hasPrefix(prefix) }
    }

    public static func matches(
        _ pattern: RegularExpression.Pattern
    ) -> Predicate {
        guard let regex = try? RegularExpression(pattern: pattern) else {
            return Predicate { _ in false }
        }
        return Predicate(regex.matches)
    }
}

extension Predicate {

    public static func isWithin<Range: RangeExpression>(
        _ range: Range
    ) -> Predicate where Range.Bound == Value {
        Predicate(range.contains)
    }
}

extension Predicate where Value: Equatable {

    public static func `is`(_ value: Value) -> Predicate {
        Predicate { $0 == value }
    }

    public static func isWithin(_ values: Value...) -> Predicate {
        Predicate(values.contains)
    }
}
