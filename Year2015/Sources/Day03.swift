
import Advent
import Foundation

public struct Day03 {

    public init() {}

    public func part1(input: Input) -> Int {

        return input
            .lines
            .flatMap { $0 }
            .map { Direction(rawValue: String($0))! }
            .reductions(Position(x: 0, y: 0)) { $0.move($1) }
            .countByElement
            .count
    }

    public func part2(input: Input) -> Int {

        let start = Position(x: 0, y: 0)

        return input
            .lines
            .flatMap { $0 }
            .map { Direction(rawValue: String($0))! }
            .reductions((start, start)) { ($0.1, $0.0.move($1)) } // Flip tuple
            .flatMap { [$0, $1] } // Works because we only care about more than one visit, not exact number
            .countByElement
            .count
    }
}

private enum Direction: String {
    case north = "^"
    case east = ">"
    case south = "v"
    case west = "<"
}

extension Position {

    fileprivate func move(_ direction: Direction) -> Position {

        switch direction {
        case .north: return Position(x: x, y: y + 1)
        case .south: return Position(x: x, y: y - 1)
        case .east: return Position(x: x + 1, y: y)
        case .west: return Position(x: x - 1, y: y)
        }
    }
}
