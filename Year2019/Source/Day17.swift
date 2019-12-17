
import Advent
import Foundation

public struct Day17 {

    public init() {}

    public func part1(input: Input) throws -> Int {
        let robot = try VacuumRobot(computer: IntcodeComputer(input: input))
        return robot
            .map
            .tiles
            .keys
            .compactMap { robot.isScaffoldIntersection($0) ? $0.x * $0.y : nil }
            .reduce(0, +)
    }
}

fileprivate struct VacuumRobot {

    var computer: IntcodeComputer
    var map: Map<Tile>
    init(computer: IntcodeComputer) throws {
        self.computer = computer
        try self.computer.run()

        let characters = self.computer
            .output
            .compactMap(UnicodeScalar.init)
            .map(Character.init)

        let tiles = try String(characters)
            .split(separator: "\n")
            .enumerated()
            .flatMap { y, string in
                try string.enumerated().map { x, character in
                    try (Position(x: x, y: y), Tile(character))
                }
            }
            .group(by: { $0.0 })
            .mapValues { $0[0].1 }

        map = Map(tiles: tiles)
    }
}

extension VacuumRobot {

    func isScaffoldIntersection(_ position: Position) -> Bool {

        guard
            case .scaffold = map.tiles[position],
            case .scaffold = map.tiles[position.move(.up)],
            case .scaffold = map.tiles[position.move(.down)],
            case .scaffold = map.tiles[position.move(.left)],
            case .scaffold = map.tiles[position.move(.right)]
        else {
            return false
        }

        return true
    }
}

fileprivate enum Tile {
    case scaffold
    case robot(Direction?)
    case space
}


fileprivate struct UnknownTile: Error {
    let character: Character
}

extension Tile {

    fileprivate init(_ character: Character) throws {
        switch character {
        case "v": self = .robot(.down)
        case "^": self = .robot(.up)
        case "<": self = .robot(.left)
        case ">": self = .robot(.right)
        case "X": self = .robot(nil)
        case "#": self = .scaffold
        case ".": self = .space
        default: throw UnknownTile(character: character)
        }
    }
}

extension Tile: CustomStringConvertible {

    var description: String {
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
