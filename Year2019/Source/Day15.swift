
import Advent
import Foundation

public struct Day15 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        var map = Map<RepairDroid.Tile>()

        func wallHugging(turning turn: Turn) throws {
            let computer = IntcodeComputer(input: input)
            var droid = RepairDroid(computer: computer)
            var directions = [Direction.up]
            while droid.tile != .oxygen {
                let direction = directions.remove(at: 0)
                try droid.move(direction: direction)
                map.tiles.merge(droid.map.tiles) { lhs, rhs in lhs }
                print("----------")
                print(map)

                if droid.tile == .wall {
                    directions.insert(direction.perform(turn), at: 0)
                    directions.insert(direction, at: 1)
                } else {
                    directions.append(direction)
                }
            }
        }

        try wallHugging(turning: .right)
        try wallHugging(turning: .left)

        let removeWalls = map
        .tiles
        .filter { [RepairDroid.Tile.start, .empty, .oxygen].contains($0.value) }
        print(Map(tiles: removeWalls))

        return 0
    }
}

fileprivate struct RepairDroid {
    var computer: IntcodeComputer
    var position = Position.origin
    var tile = Tile.start
    var map = Map(tiles: [.origin: Tile.empty])
}

extension RepairDroid {

    mutating func move(direction: Direction) throws {
        let new = position.move(Move(direction: direction, amount: 1))
        computer.input(direction.code)
        try computer.run()
        tile = RepairDroid.Tile(value: computer.output.last!)
        map.tiles[new] = tile
        map.tiles[.origin] = .start
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
