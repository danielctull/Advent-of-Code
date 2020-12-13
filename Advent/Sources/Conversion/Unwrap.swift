
struct UnwrapError: Error {}

extension Optional {

    public func unwrapped() throws -> Wrapped {
        guard let value = self else { throw UnwrapError() }
        return value
    }
}
