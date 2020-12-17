
public struct Position2D<Scalar: Numeric> {
    public let x: Scalar
    public let y: Scalar

    public init(x: Scalar, y: Scalar) {
        self.x = x
        self.y = y
    }
}

extension Position2D: Equatable where Scalar: Equatable {}
extension Position2D: Hashable where Scalar: Hashable {}

extension Position2D {
    public static var origin: Position2D { Position2D(x: 0, y: 0) }
}

extension Position2D where Scalar: SignedNumeric {

    /// An array of positions orthogonally adjacent to the receiver.
    public var orthogonallyAdjacent: [Position2D] {
        Vector.orthogonal.map { self + $0 }
    }

    public var diagonallyAdjacent: [Position2D] {
        Vector.diagonal.map { self + $0 }
    }
}

extension Position2D where Scalar == Int {

    public func manhattenDistance(to other: Position2D) -> Int {
        return abs(other.x - x) + abs(other.y - y)
    }
}

extension Position2D where Scalar: SignedNumeric {

    public mutating func rotate(_ turn: Turn) {
        self = rotating(turn)
    }

    public func rotating(_ turn: Turn) -> Position2D {
        switch turn {
        case .left: return Position2D(x: -y, y: x)
        case .right: return Position2D(x: y, y: -x)
        }
    }
}

extension Position2D {

    public static func + (position: Position2D, vector: Vector<Scalar>) -> Position2D {
        Position2D(x: position.x + vector.dx, y: position.y + vector.dy)
    }

    public static func += (position: inout Position2D, vector: Vector<Scalar>) {
        position = position + vector
    }
}
