

/// Allows easier inline testing of mutating functionality.
/// - Parameters:
///   - value: The value to mutate.
///   - modify: Function to allow the mutation.
/// - Returns: The mutated value.
func mutating<Value>(_ value: Value, _ mutate: (inout Value) -> ()) -> Value {
    var value = value
    mutate(&value)
    return value
}
