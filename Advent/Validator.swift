
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
    ) -> (@escaping (Property) -> Bool) -> Validator {

        { validation in
            let propertyPredicate = Predicate(keyPath: keyPath, predicate: validation)
            return Validator(predicate: predicate && propertyPredicate)
        }
    }
}

extension Predicate {

    init<Property>(
        keyPath: KeyPath<Value, Property>,
        predicate: @escaping (Property) -> Bool
    ) {
        self.init { value in predicate(value[keyPath: keyPath]) }
    }
}
