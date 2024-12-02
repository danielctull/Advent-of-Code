
import Foundation

public func greatestCommonDivisor<T: BinaryInteger>(_ lhs: T, _ rhs: T) -> T {
    var a = T(0)
    var b = max(lhs, rhs)
    var r = min(lhs, rhs)
    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    return b
}

public func lowestCommonMultiple<T: SignedInteger>(_ lhs: T, _ rhs: T) -> T {
    abs(lhs * rhs) / greatestCommonDivisor(lhs, rhs)
}

extension Int {

    public var triangle: Int {
        (self * (self + 1)) / 2
    }

    /// Returns `-1` if this value is negative and `1` if it's positive;
    /// otherwise, `0`.
    ///
    /// - Returns: The sign of this number, expressed as an integer of the same
    ///   type.
    public var signum: Int {
        signum()
    }

    public func power(_ power: Int) -> Int {
        Int(pow(Double(self), Double(power)))
    }

    struct NotANumber: Error {}
    public init<S: StringProtocol>(_ string: S) throws {
        guard let int = Int(string) else { throw NotANumber() }
        self = int
    }
}
