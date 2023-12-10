
import Advent
import Algorithms
import Foundation

public enum Day10: Day {

    public static let title = "Pipe Maze"

    public static func part1(_ input: Input) throws -> Int {
        
        let grid = try Grid<Position2D<Int>, Tile>(rawValues: input.lines.reversed())
        var current = try [grid.firstPosition(of: .start).unwrapped]
        var covered: Set<Position2D<Int>> = []
        var steps = 0

        while Set(current).count == current.count {
            covered.formUnion(current)
            steps += 1
            current = current.flatMap { position -> [Position2D<Int>] in
                guard let tile = grid[position] else { return [] }
                return tile
                    .neighbours
                    .map { position + $0 }
                    .filter { !covered.contains($0) }
                    .filter { next in // Ensure next pipe leads back to us.
                        guard let tile = grid[next] else { return false}
                        return tile.neighbours.map { next + $0 }.contains(position)
                    }
            }
        }

        return steps
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

private struct Tile: RawRepresentable, Equatable {

    static let start = try! Self("S")

    let rawValue: Character
    let neighbours: [Vector2D<Int>]

    init?(rawValue: Character) {
        self.rawValue = rawValue
        switch rawValue {
        case "|": neighbours = [.north, .south]
        case "-": neighbours = [.east, .west]
        case "L": neighbours = [.north, .east]
        case "J": neighbours = [.north, .west]
        case "7": neighbours = [.south, .west]
        case "F": neighbours = [.south, .east]
        case ".": neighbours = []
        case "S": neighbours = Vector2D<Int>.orthogonal
        default: return nil
        }
    }
}
