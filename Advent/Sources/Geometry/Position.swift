
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
    public var orthogonallyAdjacent: [Position] { Vector.orthogonal.map(moving) }

    public var diagonallyAdjacent: [Position] { Vector.diagonal.map(moving) }
}

extension Position {

    public func manhattenDistance(to other: Position) -> Int {
        return abs(other.x - x) + abs(other.y - y)
    }
}

extension Position {

    public mutating func rotate(_ turn: Turn) {
        self = rotating(turn)
    }

    public func rotating(_ turn: Turn) -> Position {
        switch turn {
        case .left: return Position(x: -y, y: x)
        case .right: return Position(x: y, y: -x)
        }
    }
}

extension Position {

    public mutating func move(_ vector: Vector<Int>) {
        self = moving(vector)
    }

    public func moving(_ vector: Vector<Int>) -> Position {
        Position(x: x + vector.x, y: y + vector.y)
    }
}
