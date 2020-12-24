
import Advent
import Foundation

public enum Day24: Day {

    public static let title = "Lobby Layout"

    public static func part1(_ input: Input) throws -> Int {

        let regex = try RegularExpression(pattern: "(ne|nw|se|sw|e|w)")
        return try input.lines.map {

            try regex
                .matches(in: $0)
                .map { try $0.string(at: 0) }
                .map(Vector<HexagonalDimension, Int>.init)
                .reduce(Position.origin) { $0 + $1 }
        }
        .group(by: { $0 })
        .count(where: { !$0.value.count.isMultiple(of: 2) })
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Vector where Space == HexagonalDimension<Int> {

    init(_ string: String) {
        switch string {
        case "e": self = Vector(southEasting: 1, southWesting: -1)
        case "w": self = Vector(southEasting: -1, southWesting: 1)
        case "ne": self = Vector(northing: 1, southWesting: -1)
        case "sw": self = Vector(northing: -1, southWesting: 1)
        case "se": self = Vector(northing: -1, southEasting: 1)
        case "nw": self = Vector(northing: 1, southEasting: -1)
        default: fatalError()
        }
    }
}

// MARK: - Hexagonal Dimension

extension Vector where Space == HexagonalDimension<Scalar> {

    public init(northing: Scalar = 0, southEasting: Scalar = 0, southWesting: Scalar = 0) {
        self.init { parameter in
            switch parameter {
            case .northing: return northing
            case .southEasting: return southEasting
            case .southWesting: return southWesting
            }
        }
    }
}

public struct HexagonalDimension<Scalar> {
    public let northing, southEasting, southWesting: Scalar
}

extension HexagonalDimension: Advent.Dimension {
    public enum Parameter: CaseIterable {
        case northing, southEasting, southWesting
    }
    public init(value: (Parameter) -> Scalar) {
        northing = value(.northing)
        southEasting = value(.southEasting)
        southWesting = value(.southWesting)
    }
    public subscript(parameter: Parameter) -> Scalar {
        switch parameter {
        case .northing: return northing
        case .southEasting: return southEasting
        case .southWesting: return southWesting
        }
    }
}

extension HexagonalDimension: Equatable where Scalar: Equatable {}
extension HexagonalDimension: Hashable where Scalar: Hashable {}
