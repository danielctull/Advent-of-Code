
import Advent
import Foundation

public enum Day17: Day {

    public static let title = "Conway Cubes"

    public static func part1(_ input: Input) throws -> Int {

        var matrix: [Position3D: Cube] = try input
            .lines
            .enumerated()
            .flatMap { y, line in
                try line.enumerated().map { x, character in
                    try (Position(x: x, y: y, z: 0), Cube(character))
                }
            }
            .group(by: \.0)
            .mapValues { $0.first!.1 }

        matrix.step() * 6
        return matrix.count(where: { $0.value == .active })
    }

    public static func part2(_ input: Input) throws -> Int {

        var matrix: [Position4D: Cube] = try input
            .lines
            .enumerated()
            .flatMap { y, line in
                try line.enumerated().map { x, character in
                    try (Position(w: 0, x: x, y: y, z: 0), Cube(character))
                }
            }
            .group(by: \.0)
            .mapValues { $0.first!.1 }

        matrix.step() * 6
        return matrix.count(where: { $0.value == .active })

    }
}

extension Day17 {

    fileprivate enum Cube: Character, RawRepresentable {
        case active = "#"
        case inactive = "."
    }
}

extension Dictionary where Key == Position3D<Int>, Value == Day17.Cube {

    mutating func step() {

        let activePositions = self
            .filter { $0.value == .active }
            .map(\.key)

        let minX = (activePositions.map(\.x).min() ?? 0) - 1
        let minY = (activePositions.map(\.y).min() ?? 0) - 1
        let minZ = (activePositions.map(\.z).min() ?? 0) - 1
        let maxX = (activePositions.map(\.x).max() ?? 0) + 1
        let maxY = (activePositions.map(\.y).max() ?? 0) + 1
        let maxZ = (activePositions.map(\.z).max() ?? 0) + 1

        // Fill surrounding
        for x in (minX...maxX) {
            for y in (minY...maxY) {
                for z in (minZ...maxZ) {
                    let position = Position(x: x, y: y, z: z)
                    guard !keys.contains(position) else { continue }
                    self[position] = .inactive
                }
            }
        }

        self = self
            .map { position, cube -> (Position3D<Int>, Day17.Cube) in

                let neighbours = position.neighbours
                let count = neighbours.count(where: { self[$0] == .active })

                switch cube {
                case .active where count == 2 || count == 3: return (position, .active)
                case .active: return (position, .inactive)
                case .inactive where count == 3: return (position, .active)
                case .inactive: return (position, .inactive)
                }
            }
            .group(by: \.0)
            .mapValues { $0.first!.1 }
    }
}

extension Dictionary where Key == Position4D<Int>, Value == Day17.Cube {

    mutating func step() {

        let activePositions = self
            .filter { $0.value == .active }
            .map(\.key)

        let minW = (activePositions.map(\.w).min() ?? 0) - 1
        let minX = (activePositions.map(\.x).min() ?? 0) - 1
        let minY = (activePositions.map(\.y).min() ?? 0) - 1
        let minZ = (activePositions.map(\.z).min() ?? 0) - 1
        let maxW = (activePositions.map(\.w).max() ?? 0) + 1
        let maxX = (activePositions.map(\.x).max() ?? 0) + 1
        let maxY = (activePositions.map(\.y).max() ?? 0) + 1
        let maxZ = (activePositions.map(\.z).max() ?? 0) + 1

        // Fill surrounding
        for w in (minW...maxW) {
            for x in (minX...maxX) {
                for y in (minY...maxY) {
                    for z in (minZ...maxZ) {
                        let position = Position(w: w, x: x, y: y, z: z)
                        guard !keys.contains(position) else { continue }
                        self[position] = .inactive
                    }
                }
            }
        }

        self = self
            .map { position, cube -> (Position4D<Int>, Day17.Cube) in

                let neighbours = position.neighbours
                let count = neighbours.count(where: { self[$0] == .active })

                switch cube {
                case .active where count == 2 || count == 3: return (position, .active)
                case .active: return (position, .inactive)
                case .inactive where count == 3: return (position, .active)
                case .inactive: return (position, .inactive)
                }
            }
            .group(by: \.0)
            .mapValues { $0.first!.1 }
    }
}
