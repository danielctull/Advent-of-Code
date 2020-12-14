
public struct Position<Scalar: Numeric> {
    public let x: Scalar
    public let y: Scalar

    public init(x: Scalar, y: Scalar) {
        self.x = x
        self.y = y
    }
}

extension Position: Equatable where Scalar: Equatable {}
extension Position: Hashable where Scalar: Hashable {}

extension Position {
    public static var origin: Position { Position(x: 0, y: 0) }
}

extension Position where Scalar: SignedNumeric {

    /// An array of positions orthogonally adjacent to the receiver.
    public var orthogonallyAdjacent: [Position] {
        Vector.orthogonal.map { self + $0 }
    }

    public var diagonallyAdjacent: [Position] {
        Vector.diagonal.map { self + $0 }
    }
}

extension Position where Scalar == Int {

    public func manhattenDistance(to other: Position) -> Int {
        return abs(other.x - x) + abs(other.y - y)
    }
}

extension Position where Scalar: SignedNumeric {

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

    public static func + (position: Position, vector: Vector<Scalar>) -> Position {
        Position(x: position.x + vector.dx, y: position.y + vector.dy)
    }

    public static func += (position: inout Position, vector: Vector<Scalar>) {
        position = position + vector
    }
}
