
import Advent
import Foundation

public struct Day24 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        var states = Set<Grid<Position<Int>, Tile>>()
        var current = try Grid<Position<Int>, Tile>(input: input)

        while true {
            let new = current.nextState { position in
                position.orthogonallyAdjacent.filter { current[$0] == .bug }.count
            }

            guard !states.contains(new) else {
                return new.biodiversityRating
            }

            states.insert(new)
            current = new
        }
    }

    public func part2(input: Input, count: Int = 200) throws -> Int {

        var level0 = try Grid<Position, Day24.Tile>(input: input)
        level0.tiles.removeValue(forKey: Position(x: 2, y: 2))

        var empty = Grid(width: 5, height: 5) { _ in Day24.Tile.empty }
        empty.tiles.removeValue(forKey: Position(x: 2, y: 2))

        let tiles = (-count...count)
            .flatMap { level -> [(Location, Tile)] in

                switch level {
                case 0:
                    return level0.tiles.map { (position: Position, tile: Day24.Tile) in
                        (Location(level: level, position: position), tile)
                    }
                default:
                    return empty.tiles.map { (position: Position, tile: Day24.Tile) in
                        (Location(level: level, position: position), .empty)
                    }
                }
            }
            .group(by: { $0.0 })
            .mapValues { $0[0].1 }

        let grid = (1...count).reduce(Grid(tiles: tiles)) { grid, phase in
            grid.nextState { location in
                location.adjacent.filter { grid[$0] == .bug }.count
            }
        }

        return grid
            .tiles
            .filter { $0.value == .bug }
            .count
    }
}

extension Grid where Location == Position<Int>, Tile == Day24.Tile {

    var biodiversityRating: Int {
        tiles
            .filter { $0.value == .bug }
            .map { 2.power($0.key.y * 5 + $0.key.x) }
            .sum()
    }
}

extension Grid where Tile == Day24.Tile {

    func nextState(adjacentBugCount: (Location) -> Int) -> Self {

        mapTiles { location, tile in
            switch (tile, adjacentBugCount(location)) {
            case (.bug, 1): return .bug
            case (.bug, _): return .empty
            case (.empty, 1...2): return .bug
            case (.empty, _): return .empty
            }
        }
    }
}

// MARK: - Location

extension Day24 {

    public struct Location {
        public let level: Int
        public let position: Position<Int>

        public init(level: Int, position: Position<Int>) {
            self.level = level
            self.position = position
        }
    }
}

extension Day24.Location: Equatable {}
extension Day24.Location: Hashable {}

extension Day24.Location {

    public var adjacent: [Day24.Location] {

        position.orthogonallyAdjacent.flatMap { adjacent -> [Day24.Location] in

            switch (position.x, position.y, adjacent.x, adjacent.y) {

            // Adjacent is middle
            case (2,1, 2,2):
                return (0...4).map { Self(level: level + 1, position: Position(x: $0, y: 0)) }

            case (2,3, 2,2):
                return (0...4).map { Self(level: level + 1, position: Position(x: $0, y: 4)) }

            case (1,2, 2,2):
                return (0...4).map { Self(level: level + 1, position: Position(x: 0, y: $0)) }

            case (3,2, 2,2):
                return (0...4).map { Self(level: level + 1, position: Position(x: 4, y: $0)) }

            // Adjacent is outside
            case (_,_, -1,_):
                return [ Self(level: level - 1, position: Position(x: 1, y: 2)) ]

            case (_,_, 5,_):
                return [ Self(level: level - 1, position: Position(x: 3, y: 2)) ]

            case (_,_, _,-1):
                return [ Self(level: level - 1, position: Position(x: 2, y: 1)) ]

            case (_,_, _,5):
                return [ Self(level: level - 1, position: Position(x: 2, y: 3)) ]

            // Adjacent is in this level

            default:
                return [ Self(level: level, position: adjacent) ]
            }
        }
    }
}

// MARK: - Tile

extension Day24 {

    fileprivate enum Tile: Character, RawRepresentable {
        case empty = "."
        case bug = "#"
    }
}

extension Day24.Tile: CustomStringConvertible {

    var description: String { String(rawValue) }
}
