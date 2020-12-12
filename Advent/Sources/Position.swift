
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

    /// An array of positions orthogonally adjacent to the receiver.
    public var adjacent: [Position] { Vector.orthogonal.map(move) }

    public var diagonallyAdjacent: [Position] { Vector.diagonal.map(move) }
}

extension Position {

    public func manhattenDistance(to other: Position) -> Int {
        return abs(other.x - x) + abs(other.y - y)
    }
}

extension Position {

    public func rotateAboutOrigin(_ turn: Turn) -> Position {
        switch turn {
        case .left: return Position(x: -y, y: x)
        case .right: return Position(x: y, y: -x)
        }
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

extension Position {

    public func move(_ vector: Vector<Int>) -> Position {
        Position(x: x + vector.x, y: y + vector.y)
    }

    public func move(_ move: Move) -> Position {

        switch move.direction {
        case .up: return Position(x: x, y: y + move.amount)
        case .down: return Position(x: x, y: y - move.amount)
        case .left: return Position(x: x - move.amount, y: y)
        case .right: return Position(x: x + move.amount, y: y)
        }
    }

    public func offsetting(x xOffset: Int, y yOffset: Int) -> Position {
        Position(x: x + xOffset, y: y + yOffset)
    }
}
