
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
    public var orthogonallyAdjacent: [Position] {
        Vector.orthogonal.map { self + $0 }
    }

    public var diagonallyAdjacent: [Position] {
        Vector.diagonal.map { self + $0 }
    }
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

    public static func + (position: Position, vector: Vector<Int>) -> Position {
        Position(x: position.x + vector.x, y: position.y + vector.y)
    }

    public static func += (position: inout Position, vector: Vector<Int>) {
        position = position + vector
    }
}
