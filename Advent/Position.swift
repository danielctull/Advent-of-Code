
public struct Position: Equatable, Hashable {
    public let x: Int
    public let y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

extension Position {

    public func manhattenDistance(to other: Position) -> Int {
        return abs(other.x - x) + abs(other.y - y)
    }
}

public struct Move {
    let direction: Direction
    let amount: Int
}

public enum Direction: Equatable, Hashable {
    case up
    case down
    case left
    case right
}

extension Position {

    public func move(_ move: Move) -> Position {

        switch move.direction {
        case .up: return Position(x: x, y: y + move.amount)
        case .down: return Position(x: x, y: y - move.amount)
        case .left: return Position(x: x - move.amount, y: y)
        case .right: return Position(x: x + move.amount, y: y)
        }
    }
}
