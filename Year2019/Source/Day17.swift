
import Advent
import Foundation

public struct Day17 {

    public init() {}

    public func part1(input: Input) throws -> Int {
        let grid = try Grid(computer: IntcodeComputer(input: input))
        return grid
            .tiles
            .keys
            .compactMap { grid.isScaffoldIntersection($0) ? $0.x * $0.y : nil }
            .reduce(0, +)
    }
}

extension Grid where Tile == Day17.Tile {

    fileprivate init(computer inComputer: IntcodeComputer) throws {

        var computer = inComputer
        try computer.run()

        let characters = computer
            .ascii
            .output
            .split(separator: "\n")

        try self.init(rawValues: characters)
    }

    func isScaffoldIntersection(_ position: Position) -> Bool {

        guard
            case .scaffold = tiles[position],
            case .scaffold = tiles[position.move(.up)],
            case .scaffold = tiles[position.move(.down)],
            case .scaffold = tiles[position.move(.left)],
            case .scaffold = tiles[position.move(.right)]
        else {
            return false
        }

        return true
    }
}

// MARK: - Tile

extension Day17 {

    fileprivate enum Tile {
        case scaffold
        case robot(Direction?)
        case space
    }

}

extension Day17.Tile: RawRepresentable {

    fileprivate init?(rawValue: Character) {
        switch rawValue {
        case "v": self = .robot(.down)
        case "^": self = .robot(.up)
        case "<": self = .robot(.left)
        case ">": self = .robot(.right)
        case "X": self = .robot(nil)
        case "#": self = .scaffold
        case ".": self = .space
        default: return nil
        }
    }

    var rawValue: Character {
        switch self {
        case .robot(.down): return "v"
        case .robot(.up): return "^"
        case .robot(.left): return "<"
        case .robot(.right): return ">"
        case .robot(nil): return "X"
        case .scaffold: return "#"
        case .space: return "."
        }
    }
}

extension Day17.Tile: CustomStringConvertible {

    var description: String { String(rawValue) }
}
