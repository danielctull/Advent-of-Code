
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
