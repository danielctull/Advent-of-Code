
public prefix func !<Input>(_ f: @escaping (Input) -> Bool) -> (Input) -> Bool {
    { input in !f(input) }
}

/// Performs the given function the given number of times.
///
/// - Parameters:
///   - function: The function.
///   - count: Number of times to repeat the function.
public func * (function: @autoclosure () -> Void, count: Int) {
    (0..<count).forEach { _ in function() }
}

/// Allows easier inline testing of mutating functionality.
/// - Parameters:
///   - value: The value to mutate.
///   - modify: Function to allow the mutation.
/// - Returns: The mutated value.
public func mutating<Value>(_ value: Value, _ mutate: (inout Value) -> ()) -> Value {
    var value = value
    mutate(&value)
    return value
}
