
@dynamicMemberLookup
public struct Validator<Value> {

    public init() {
        self.predicate = Predicate { _ in true }
    }

    init(predicate: Predicate<Value>) {
        self.predicate = predicate
    }

    let predicate: Predicate<Value>

    public func validate(_ value: Value) -> Bool {
        predicate(value)
    }

    public subscript<Property>(
        dynamicMember keyPath: KeyPath<Value, Property>
    ) -> Builder<Property> {
        Builder(base: self, keyPath: keyPath)
    }
}

extension Validator {

    public struct Builder<Property> {

        fileprivate let base: Validator<Value>
        fileprivate let keyPath: KeyPath<Value, Property>

        public func callAsFunction(
            _ predicate: Predicate<Property>
        ) -> Validator<Value> {
            let new = Predicate<Value> { predicate($0[keyPath: keyPath]) }
            return Validator(predicate: base.predicate && new)
        }
    }
}
