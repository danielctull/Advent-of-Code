
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
}
