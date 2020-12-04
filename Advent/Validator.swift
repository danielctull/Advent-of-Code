
@dynamicMemberLookup
public struct Validator<Value> {

    typealias Validation = (Value) -> Bool

    public init() {
        self.validations = []
    }

    init(validations: [Validation]) {
        self.validations = validations
    }

    let validations: [Validation]

    public func validate(_ value: Value) -> Bool {
        for validation in validations {
            guard validation(value) else { return false }
        }
        return true
    }

    public subscript<Property>(
        dynamicMember keyPath: KeyPath<Value, Property>
    ) -> (@escaping (Property) -> Bool) -> Validator {

        { propertyValidator in

            Validator(validations: self.validations + [{ value in
                propertyValidator(value[keyPath: keyPath])
            }])
        }
    }
}
