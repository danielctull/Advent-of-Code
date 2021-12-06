
struct UnwrapError: Error {}

extension Optional {

    public var unwrapped: Wrapped {
        get throws {
            guard let value = self else { throw UnwrapError() }
            return value
        }
    }
}
