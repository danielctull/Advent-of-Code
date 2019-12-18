
import Advent
import Foundation

public struct Day18 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        let values = input
            .lines
            .map { $0.string.map { $0 } }

        let map = try Map<Day18.Tile>(characters: values)
        let allKeys = map.tiles.filter { $0.value.isKey }

        func findKeys(
            keys inKeys: Set<Character> = [],
            position: Position,
            direction: Direction
        ) -> Int? {

            let new = position.move(direction)
            guard let tile = map[new] else { return nil }

            var keys = inKeys
            var nextDirections: [Direction]

            switch tile {

            // Blocked path, stop exploring
            case .wall:
                return nil
            case .door(let door) where !keys.contains(door):
                return nil

            // Explore in all directions to locate newly accessible door.
            case .key(let key) where !keys.contains(key):
                keys.insert(key)
                nextDirections = Direction.allCases

            // Keep exploring forward, left and right.
            case .start, .passage, .key, .door:
                nextDirections = direction.opposite.otherDirections
            }

            guard keys.count < allKeys.count else { return 1 }

            return nextDirections
                .compactMap { findKeys(keys: keys, position: new, direction: $0) }
                .map { $0 + 1 }
                .min()
        }

        let start = map.firstPosition(of: .start)!

        return Direction
            .allCases
            .compactMap { findKeys(position: start, direction: $0) }
            .min()!
    }
}

extension Map where Tile: Equatable {

    func firstPosition(of tile: Tile) -> Position? {
        tiles.first(where: { $0.value == tile })?.key
    }
}

// MARK: - Tile

extension Day18 {

    fileprivate enum Tile {
        case wall
        case passage
        case start
        case key(Character)
        case door(Character)
    }
}

extension Day18.Tile {

    var isKey: Bool {
        guard case .key = self else { return false }
        return true
    }

    var isDoor: Bool {
        guard case .door = self else { return false }
        return true
    }
}

extension Day18.Tile: Equatable {}

extension Day18.Tile: ExpressibleByCharacter {

    init(_ character: Character) throws {
        switch character {
        case "#": self = .wall
        case ".": self = .passage
        case "@": self = .start
        case "a"..."z": self = .key(character)
        case "A"..."Z": self = .door(Character(character.lowercased()))
        default: throw UnexpectedValue(character)
        }
    }
}

extension Day18.Tile: CustomStringConvertible {

    var description: String {
        switch self {
        case .wall: return "#"
        case .passage: return "."
        case .door(let value): return String(value).uppercased()
        case .key(let value): return String(value)
        case .start: return "@"
        }
    }
}
