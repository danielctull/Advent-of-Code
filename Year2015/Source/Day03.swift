
import Advent
import Foundation

public struct Day03 {

    public init() {}

    public func part1(input: Input) -> Int {

        func move(from position: Position, in direction: Direction) -> Position {

            switch direction {
            case .north: return Position(x: position.x, y: position.y + 1)
            case .south: return Position(x: position.x, y: position.y - 1)
            case .east: return Position(x: position.x + 1, y: position.y)
            case .west: return Position(x: position.x - 1, y: position.y)
            }
        }

        return input
            .lines
            .flatMap { $0.string }
            .map { Direction(rawValue: String($0))! }
            .accumulating(Position(x: 0, y: 0), move)
            .countByElement
            .count
    }

    public func part2(input: Input) -> Int {
        return 0
    }
}

extension Day03 {

    struct Position: Hashable {
        let x: Int
        let y: Int
    }

    enum Direction: String {
        case north = "^"
        case east = ">"
        case south = "v"
        case west = "<"
    }
}
