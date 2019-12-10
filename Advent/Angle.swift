
import Foundation

extension Double {
    fileprivate static let tau = 2 * Double.pi
}

/// A "normalized" angle between 0 and 2π radians.
public struct Angle {
    public let radians: Double
    public init(radians: Double) {
        self.radians = (radians + .tau).truncatingRemainder(dividingBy: .tau)
    }
}

extension Angle {

    public static let zero = Angle(radians: 0)

    public init(degrees: Double) {
        self.init(radians: degrees/360 * .tau)
    }

    public init(start: Position, end: Position) {
        let radians = atan2(Double(end.y - start.y), Double(end.x - start.x))
        self.init(radians: radians)
    }
}

public func + (lhs: Angle, rhs: Angle) -> Angle {
    return Angle(radians: lhs.radians + rhs.radians)
}

extension Angle: Equatable {}

extension Angle: Comparable {
    public static func < (lhs: Angle, rhs: Angle) -> Bool {
        lhs.radians < rhs.radians
    }
}

extension Angle: CustomStringConvertible {
    public var description: String { radians.description }
}
