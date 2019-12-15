
import Advent
import Foundation

public struct Day15 {

    public init() {}

    public func part1(input: Input) throws -> Int {
        var map = Map(tiles: [.origin: RepairDroid.Tile.start])
        let droid = RepairDroid(computer: IntcodeComputer(input: input))
        return try Direction
            .allCases
            .compactMap { try findOxygen(map: &map, droid: droid, direction: $0) }
            .min()!
    }

    @discardableResult
    fileprivate func findOxygen(
        map: inout Map<RepairDroid.Tile>,
        droid inDroid: RepairDroid,
        direction: Direction
    ) throws -> Int? {
        var droid = inDroid
        try droid.move(direction: direction)
        map.tiles.merge(droid.map.tiles) { lhs, rhs in lhs }
        switch droid.tile {
        case .wall: return nil
        case .start: return nil
        case .oxygen: return 1
        case .empty:
            return try direction
                .opposite
                .otherDirections
                .compactMap { try findOxygen(map: &map, droid: droid, direction: $0) }
                .min()
                .flatMap { $0 + 1 }
        }
    }

    public func part2(input: Input) throws -> Int {
        var map = Map(tiles: [.origin: RepairDroid.Tile.start])
        let droid = RepairDroid(computer: IntcodeComputer(input: input))
        try Direction
            .allCases
            .forEach { try findOxygen(map: &map, droid: droid, direction: $0) }

        let oxygen = map.tiles.first(where: { $0.value == .oxygen })!
        return Direction
            .allCases
            .map { spreadOxygen(map: &map, position: oxygen.key, direction: $0) }
            .max()!
    }

    fileprivate func spreadOxygen(
        map: inout Map<RepairDroid.Tile>,
        position: Position,
        direction: Direction
    ) -> Int {
        let new = position.move(in: direction)
        let tile = map.tiles[new]!
        switch tile {
        case .oxygen, .wall: return 0
        case .start, .empty:
            map.tiles[new] = .oxygen
            return direction
                .opposite
                .otherDirections
                .map { spreadOxygen(map: &map, position: new, direction: $0) }
                .max()! + 1
        }
    }
}

fileprivate struct RepairDroid {
    var computer: IntcodeComputer
    var position = Position.origin
    var tile = Tile.start
    var map = Map<RepairDroid.Tile>()
}

extension RepairDroid {

    mutating func move(direction: Direction) throws {
        let new = position.move(Move(direction: direction, amount: 1))
        computer.input(direction.code)
        try computer.run()
        tile = RepairDroid.Tile(value: computer.output.last!)
        map.tiles[new] = tile
        if tile != .wall { position = new }
    }
}

extension Direction {

    fileprivate var code: Int {
        switch self {
        case .up: return 1
        case .down: return 2
        case .left: return 3
        case .right: return 4
        }
    }
}

// MARK: - RepairDroid.Tile

extension RepairDroid {

    enum Tile {
        case empty
        case wall
        case oxygen
        case start
    }
}

extension RepairDroid.Tile {

    init(value: Int) {
        switch value {
        case 0: self = .wall
        case 1: self = .empty
        case 2: self = .oxygen
        default: fatalError()
        }
    }
}

extension RepairDroid.Tile: CustomStringConvertible {

    var description: String {
        switch self {
        case .empty: return "."
        case .wall: return "#"
        case .oxygen: return "o"
        case .start: return "s"
        }
    }
}
