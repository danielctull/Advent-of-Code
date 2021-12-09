
public struct Predicate<Value> {

    private let predicate: (Value) -> Bool
    public init(_ predicate: @escaping (Value) -> Bool) {
        self.predicate = predicate
    }

    public func callAsFunction(_ value: Value) -> Bool {
        predicate(value)
    }
}

// MARK: - Modifying Predicates

public func && <T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
    Predicate { value in lhs(value) && rhs(value) }
}

public func || <T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
    Predicate { value in lhs(value) || rhs(value) }
}

public prefix func ! <T>(predicate: Predicate<T>) -> Predicate<T> {
    Predicate { value in !predicate(value) }
}

extension Sequence {

    public func joined<T>(
        operator: (Predicate<T>, Predicate<T>) -> Predicate<T>
    ) -> Predicate<T> where Element == Predicate<T> {
        reduce(`operator`) ?? .true
    }
}

// MARK: - Creating Predicates

extension Predicate {

    /// A predicate that is always true.
    public static var `true`: Predicate { Predicate { _ in true } }

    /// A predicate that is always false.
    public static var `false`: Predicate { Predicate { _ in false } }
}

extension Predicate where Value == Int {

    /// Returns a predicate that checks that a value is greater than the given
    /// value.
    ///
    /// - Parameter value: The value to be greater than.
    /// - Returns: A predicate used to check an `Int`.
    public static func isGreaterThan(_ value: Int) -> Predicate {
        Predicate { $0 > value }
    }

    /// Returns a predicate that checks that a value is less than the given
    /// value.
    ///
    /// - Parameter value: The value to be less than.
    /// - Returns: A predicate used to check an `Int`.
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

extension Predicate where Value: Collection {

    /// Returns a predicate that accepts a collection which checks that the
    /// count is of the given length.
    ///
    /// - Parameter count: The count to check.
    /// - Returns: A predicate used to check a `Collection`.
    public static func count(is count: Int) -> Self {
        Predicate { $0.count == count }
    }
}

extension Predicate { // Set Predicates

    /// Returns a predicate that checks whether a set is a subset of the given
    /// set.
    /// - Parameter set: The set to check against.
    /// - Returns: A predicate used to check a `Set<Element>`.
    public static func isSubset<Element>(
        of set: Set<Element>
    ) -> Self where Value == Set<Element> {
        Predicate { $0.isSubset(of: set) }
    }

    /// Returns a predicate that checks whether a set is a superset of the given
    /// set.
    ///
    /// - Parameter set: The set to check against.
    /// - Returns: A predicate used to check a `Set<Element>`.
    public static func isSuperset<Element>(
        of set: Set<Element>
    ) -> Self where Value == Set<Element> {
        Predicate { $0.isSuperset(of: set) }
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

    public static func contained<Sequence>(in values: Sequence) -> Predicate where Sequence: Swift.Sequence, Sequence.Element == Value {
        Predicate(values.contains)
    }
}

// MARK: - Using Predicates

public func ~= <T>(predicate: Predicate<T>, value: T) -> Bool {
    predicate(value)
}

extension Sequence {

    public func allSatisfy(_ predicate: Predicate<Element>) -> Bool {
        allSatisfy { predicate($0) }
    }

    public func count(where predicate: Predicate<Element>) -> Int {
        count(where: { predicate($0) })
    }

    public func drop(while predicate: Predicate<Element>) -> DropWhileSequence<Self> {
        drop(while: { predicate($0) })
    }

    public func filter(_ isIncluded: Predicate<Element>) -> [Element] {
        filter { isIncluded($0) }
    }

    public func first(where predicate: Predicate<Element>) -> Element? {
        first(where: { predicate($0) })
    }
}

extension Collection {

    public subscript(predicate: Predicate<Self.Element>) -> Element {
        get throws { try first(where: predicate).unwrapped }
    }
}
