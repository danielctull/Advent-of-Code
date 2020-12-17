
import Advent
import Foundation

public struct Day15 {

    public init() {}

    public func part1(input: Input) throws -> Int {
        var grid = Grid(tiles: [Position2D<Int>.origin: Tile.start])
        let droid = RepairDroid(computer: IntcodeComputer(input: input))
        return try Vector2D
            .orthogonal
            .compactMap { try findOxygen(grid: &grid, droid: droid, direction: $0) }
            .min()!
    }

    @discardableResult
    fileprivate func findOxygen(
        grid: inout Grid<Position2D<Int>, Tile>,
        droid inDroid: RepairDroid,
        direction: Vector2D<Int>
    ) throws -> Int? {
        var droid = inDroid
        try droid.move(direction: direction)
        grid.tiles.merge(droid.grid.tiles) { lhs, rhs in lhs }
        switch droid.tile {
        case .wall: return nil
        case .start: return nil
        case .oxygen: return 1
        case .empty:
            return try direction
                .opposite
                .otherDirections
                .compactMap { try findOxygen(grid: &grid, droid: droid, direction: $0) }
                .min()
                .flatMap { $0 + 1 }
        }
    }

    public func part2(input: Input) throws -> Int {
        var grid = Grid(tiles: [Position2D<Int>.origin: Tile.start])
        let droid = RepairDroid(computer: IntcodeComputer(input: input))
        try Vector2D
            .orthogonal
            .forEach { try findOxygen(grid: &grid, droid: droid, direction: $0) }

        let oxygen = grid.tiles.first(where: { $0.value == .oxygen })!
        return Vector2D
            .orthogonal
            .map { spreadOxygen(grid: &grid, position: oxygen.key, direction: $0) }
            .max()!
    }

    fileprivate func spreadOxygen(
        grid: inout Grid<Position2D<Int>, Tile>,
        position: Position2D<Int>,
        direction: Vector2D<Int>
    ) -> Int {
        let new = position + direction
        let tile = grid.tiles[new]!
        switch tile {
        case .oxygen, .wall: return 0
        case .start, .empty:
            grid.tiles[new] = .oxygen
            return direction
                .opposite
                .otherDirections
                .map { spreadOxygen(grid: &grid, position: new, direction: $0) }
                .max()! + 1
        }
    }
}

fileprivate struct RepairDroid {
    var computer: IntcodeComputer
    var position = Position2D<Int>.origin
    var tile = Day15.Tile.start
    var grid = Grid<Position2D<Int>, Day15.Tile>()
}

extension RepairDroid {

    mutating func move(direction: Vector2D<Int>) throws {
        let new = position + direction
        computer.input(direction.code)
        try computer.run()
        tile = try Day15.Tile(computer.output.last!)
        grid.tiles[new] = tile
        if tile != .wall { position = new }
    }
}

extension Vector where Space == Dimension2<Int> {

    fileprivate var code: Int {
        switch self {
        case .up: return 1
        case .down: return 2
        case .left: return 3
        case .right: return 4
        default: fatalError()
        }
    }
}

// MARK: - Tile

extension Day15 {

    fileprivate enum Tile: Int {
        case wall = 0
        case empty = 1
        case oxygen = 2
        case start = -1
    }
}

extension Day15.Tile: RawRepresentable {}

extension Day15.Tile: CustomStringConvertible {

    var description: String {
        switch self {
        case .empty: return "."
        case .wall: return "#"
        case .oxygen: return "o"
        case .start: return "s"
        }
    }
}
