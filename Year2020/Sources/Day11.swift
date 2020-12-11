
import Advent
import Foundation

public enum Day11 {

    public static func part1(_ input: Input) throws -> Int {
        var grid = try Grid<Position, Tile>(rawValues: input.lines)
        var count = grid.positions(of: .occupied).count

        while true {
            grid = grid.musicalChairs()
            let newCount = grid.positions(of: .occupied).count
            guard newCount != count else { return count }
            count = newCount
        }

        return count
    }

    public static func part2(_ input: Input) throws -> Int {
        var grid = try Grid<Position, Tile>(rawValues: input.lines)
        var count = grid.positions(of: .occupied).count

        while true {
            grid = grid.musicalChairs2()
            let newCount = grid.positions(of: .occupied).count
            guard newCount != count else { return count }
            count = newCount
        }

        return count
    }
}

extension Day11 {

    enum Tile {
        case floor
        case empty
        case occupied
    }
}

extension Day11.Tile: RawRepresentable {

    var rawValue: Character {
        switch self {
        case .floor: return "."
        case .empty: return "L"
        case .occupied: return "#"
        }
    }

    init?(rawValue: Character) {
        switch rawValue {
        case ".": self = .floor
        case "L": self = .empty
        case "#": self = .occupied
        default: return nil
        }
    }
}

extension Day11.Tile: CustomStringConvertible {
    var description: String { String(rawValue) }
}

extension Grid where Tile == Day11.Tile, Location == Position {

    fileprivate func musicalChairs() -> Self {

        func adjacent(to position: Position) -> [Tile] {
            (position.adjacent + position.diagonallyAdjacent)
                .compactMap { self[$0] }
        }

        return mapTiles { position, tile -> Tile in
            switch tile {
            case .empty where adjacent(to: position).count(where: { $0 == .occupied }) == 0: return .occupied
            case .occupied where adjacent(to: position).count(where: { $0 == .occupied }) >= 4: return .empty
            default: return tile
            }
        }
    }

    fileprivate func musicalChairs2() -> Self {

        func firstSeat(from position: Position, in direction: Vector<Int>) -> Tile? {
            let new = position.move(direction)
            let tile = self[new]
            switch tile {
            case .none: return nil
            case .floor: return firstSeat(from: new, in: direction)
            case .occupied, .empty: return tile
            }
        }

        func adjacent(to position: Position) -> [Tile] {
            (Vector<Int>.diagonal + Vector<Int>.orthogonal)
                .compactMap { firstSeat(from: position, in: $0) }
        }

        return mapTiles { position, tile -> Tile in
            switch tile {
            case .empty where adjacent(to: position).count(where: { $0 == .occupied }) == 0: return .occupied
            case .occupied where adjacent(to: position).count(where: { $0 == .occupied }) >= 5: return .empty
            default: return tile
            }
        }
    }
}
