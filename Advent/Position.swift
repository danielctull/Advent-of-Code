
public struct Position: Equatable, Hashable {
    public let x: Int
    public let y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

extension Position {
    public static let origin = Position(x: 0, y: 0)
}

extension Position {

    public func manhattenDistance(to other: Position) -> Int {
        return abs(other.x - x) + abs(other.y - y)
    }
}

public struct Move {
    public let direction: Direction
    public let amount: Int
    public init(direction: Direction, amount: Int) {
        self.direction = direction
        self.amount = amount
    }
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
