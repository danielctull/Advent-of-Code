
import Advent
import Foundation

public struct Day18 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        let grid = try Grid<Position2D, Day18.Tile>(input: input)
        let allKeys = grid.tiles.filter { $0.value.isKey }

        struct State: Hashable {
            var keys = Set<Character>()
            var position: Position2D<Int>
            var direction: Vector<Int>
        }

        let start = grid.firstPosition(of: .start)!
        var queue = Vector.orthogonal.map { (0, State(position: start, direction: $0)) }
        var evaluated = Set<State>()

        while var (steps, state) = queue.first {
            queue.removeFirst()

            state.position += state.direction
            steps += 1

            guard !evaluated.contains(state) else { continue }
            evaluated.insert(state)

            guard let tile = grid[state.position] else { continue }

            var nextDirections: [Vector<Int>]

            switch tile {

            // Blocked path, stop exploring
            case .wall:
                continue
            case .door(let door) where !state.keys.contains(door):
                continue

            // Explore in all directions to locate newly accessible door.
            case .key(let key) where !state.keys.contains(key):
                state.keys.insert(key)
                nextDirections = Vector.orthogonal

            // Keep exploring forward, left and right.
            case .start, .passage, .key, .door:
                nextDirections = state.direction.opposite.otherDirections
            }

            guard state.keys.count < allKeys.count else { return steps }

            let next = nextDirections.map { direction -> (Int, State) in
                let state = State(keys: state.keys, position: state.position, direction: direction)
                return (steps, state)
            }

            queue.append(contentsOf: next)
        }

        return 0
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

extension Day18.Tile: RawRepresentable {

    init?(rawValue: Character) {
        switch rawValue {
        case "#": self = .wall
        case ".": self = .passage
        case "@": self = .start
        case "a"..."z": self = .key(rawValue)
        case "A"..."Z": self = .door(Character(rawValue.lowercased()))
        default: return nil
        }
    }

    var rawValue: Character {
        switch self {
        case .wall: return "#"
        case .passage: return "."
        case .door(let value): return Character(value.uppercased())
        case .key(let value): return value
        case .start: return "@"
        }
    }
}

extension Day18.Tile: CustomStringConvertible {

    var description: String { String(rawValue) }
}
