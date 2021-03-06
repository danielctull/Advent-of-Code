
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

        let regex = try RegularExpression(pattern: "(ne|nw|se|sw|e|w)")
        let dictionary = try input.lines.map {

            try regex
                .matches(in: $0)
                .map { try $0.string(at: 0) }
                .map(Vector<HexagonalDimension, Int>.init)
                .reduce(Position.origin) { $0 + $1 }
        }
        .group(by: { $0 })
        .filter { !$0.value.count.isMultiple(of: 2) }

        return (1...100).reduce(Set(dictionary.keys)) { tiles, day in

            let existingBlackTiles = tiles.filter {
                let neighbours = $0.neighbours.intersection(tiles).count
                return neighbours == 1 || neighbours == 2
            }

            let newBlackTiles = Set(tiles.flatMap(\.neighbours)).filter {
                guard !tiles.contains($0) else { return false }
                let neighbours = $0.neighbours.intersection(tiles).count
                return neighbours == 2
            }

            return existingBlackTiles.union(newBlackTiles)
        }
        .count
    }
}

extension Vector where Space == HexagonalDimension<Int> {

    init(_ string: String) {
        switch string {
        case  "e": self = Vector(q:  0, r: -1)
        case  "w": self = Vector(q:  0, r:  1)
        case "ne": self = Vector(q:  1, r: -1)
        case "sw": self = Vector(q: -1, r:  1)
        case "se": self = Vector(q: -1, r:  0)
        case "nw": self = Vector(q:  1, r:  0)
        default: fatalError()
        }
    }
}

// MARK: - Hexagonal Dimension

extension Vector where Space == HexagonalDimension<Scalar> {

    /// Axial coordinate initialiser.
    ///
    /// https://www.redblobgames.com/grids/hexagons/
    public init(q: Scalar, r: Scalar) {
        self.init { parameter in
            switch parameter {
            case .q: return q
            case .r: return r
            case .s: return 0 - q - r
            }
        }
    }
}

extension Position where Space == HexagonalDimension<Scalar> {

    public init(q: Scalar, r: Scalar) {
        self.init { parameter in
            switch parameter {
            case .q: return q
            case .r: return r
            case .s: return 0 - q - r
            }
        }
    }
}

extension Position where Space == HexagonalDimension<Scalar>, Scalar: Hashable {

    public var neighbours: Set<Self> {
        Set([
            Self(q: self.q + 1, r: self.r + 0), // s - 1
            Self(q: self.q + 1, r: self.r - 1), // s + 0
            Self(q: self.q + 0, r: self.r + 1), // s - 1
            Self(q: self.q + 0, r: self.r - 1), // s + 1
            Self(q: self.q - 1, r: self.r + 0), // s + 1
            Self(q: self.q - 1, r: self.r + 1), // s + 0
        ])
    }
}

public struct HexagonalDimension<Scalar> {
    public let q, r, s: Scalar
}

extension HexagonalDimension: Advent.Dimension {
    public enum Parameter: CaseIterable {
        case q, r, s
    }
    public init(value: (Parameter) -> Scalar) {
        q = value(.q)
        r = value(.r)
        s = value(.s)
    }
    public subscript(parameter: Parameter) -> Scalar {
        switch parameter {
        case .q: return q
        case .r: return r
        case .s: return s
        }
    }
}

extension HexagonalDimension: Equatable where Scalar: Equatable {}
extension HexagonalDimension: Hashable where Scalar: Hashable {}
