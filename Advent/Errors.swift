
public struct UnexpectedValue<Value>: Error {
    public let value: Value
    public init(_ value: Value) {
        self.value = value
    }
}
