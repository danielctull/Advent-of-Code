
@dynamicMemberLookup
public struct Validator<Value> {

    public init() {
        self.predicate = Predicate { _ in true }
    }

    fileprivate let predicate: Predicate<Value>
    fileprivate init(predicate: Predicate<Value>) {
        self.predicate = predicate
    }

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

    @dynamicMemberLookup
    public struct Builder<Property> {

        fileprivate let base: Validator
        fileprivate let keyPath: KeyPath<Value, Property>

        public func callAsFunction(
            _ predicate: Predicate<Property>
        ) -> Validator {
            let new = Predicate<Value> { predicate($0[keyPath: keyPath]) }
            return Validator(predicate: base.predicate && new)
        }

        public func callAsFunction(
            _ predicate: @escaping (Property) -> Bool
        ) -> Validator {
            let new = Predicate<Value> { predicate($0[keyPath: keyPath]) }
            return Validator(predicate: base.predicate && new)
        }

        public subscript<Property2>(
            dynamicMember keyPath2: KeyPath<Property, Property2>
        ) -> Builder<Property2> {

            Builder<Property2>(
                base: base,
                keyPath: keyPath.appending(path: keyPath2))
        }
    }
}
