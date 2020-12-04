
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
    ) -> (Predicate<Property>) -> Validator {

        { propertyPredicate in
            let new = Predicate<Value> { propertyPredicate($0[keyPath: keyPath]) }
            return Validator(predicate: predicate && new)
        }
    }
}
