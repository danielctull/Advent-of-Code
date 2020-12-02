
import Foundation

public func greatestCommonDivisor(_ lhs: Int, _ rhs: Int) -> Int {
    var a = 0
    var b = max(lhs, rhs)
    var r = min(lhs, rhs)
    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    return b
}

public func lowestCommonMultiple(_ lhs: Int, _ rhs: Int) -> Int {
    abs(lhs * rhs) / greatestCommonDivisor(lhs, rhs)
}

extension Int {
    public func power(_ power: Int) -> Int {
        Int(pow(Double(self), Double(power)))
    }

    struct NotANumber: Error {}
    public init<S: StringProtocol>(_ string: S) throws {
        guard let int = Int(string) else { throw NotANumber() }
        self = int
    }
}
