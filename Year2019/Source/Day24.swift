
import Advent
import Foundation

public struct Day24 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        var states = Set<Grid<Position, Day24.Tile>>()
        var current = try Grid<Position, Day24.Tile>(input: input)

        while true {
            let new = current.nextState()

            guard !states.contains(new) else {
                return new.biodiversityRating
            }

            states.insert(new)
            current = new
        }
    }
}

extension Grid where Location == Position, Tile == Day24.Tile {

    var biodiversityRating: Int {
        tiles
            .filter { $0.value == .bug }
            .map { 2.power($0.key.y * 5 + $0.key.x) }
            .reduce(0, +)
    }

    func nextState() -> Self {

        mapTiles { position, tile in

            let adjacentBugs = position.adjacent.filter { self[$0] == .bug }

            switch (tile, adjacentBugs.count) {
            case (.bug, 1): return .bug
            case (.bug, _): return .empty
            case (.empty, 1...2): return .bug
            case (.empty, _): return .empty
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
