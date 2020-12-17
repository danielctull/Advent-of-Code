
@dynamicMemberLookup
public struct Position<Space, Scalar>
    where
    Space: Dimension,
    Space.Scalar == Scalar,
    Scalar: Numeric
{
    public typealias Parameter = Space.Parameter
    private let space: Space

    public subscript(
        dynamicMember keyPath: KeyPath<Space, Scalar>
    ) -> Scalar {
        space[keyPath: keyPath]
    }
}

extension Position: Equatable where Space: Equatable {}
extension Position: Hashable where Space: Hashable {}

extension Position {

    private init(value: (Parameter) -> Scalar) {
        self.init(space: Space(value: value))
    }

    subscript(parameter: Parameter) -> Scalar { space[parameter] }
}

extension Position {
    public static var origin: Position { Position { _ in 0 } }
}

extension Position where Scalar == Int {

    public func manhattenDistance(to other: Position) -> Int {
        Parameter.allCases.reduce(0) { $0 + abs(other.space[$1] - space[$1]) }
    }
}

extension Position {

    public static func + (position: Position, vector: Vector<Space, Scalar>) -> Position {
        Position { position[$0] + vector[$0] }
    }

    public static func += (position: inout Position, vector: Vector<Space, Scalar>) {
        position = position + vector
    }
}

// MARK: - 2D

public typealias Position2D<Scalar: Numeric> = Position<Dimension2<Scalar>, Scalar>

extension Position where Space == Dimension2<Scalar> {

    public init(x: Scalar, y: Scalar) {
        self.init { parameter in
            switch parameter {
            case .x: return x
            case .y: return y
            }
        }
    }
}

extension Position2D where Scalar: SignedNumeric, Space == Dimension2<Scalar> {

    /// An array of positions orthogonally adjacent to the receiver.
    public var orthogonallyAdjacent: [Position] {
        Vector.orthogonal.map { self + $0 }
    }

    public var diagonallyAdjacent: [Position] {
        Vector.diagonal.map { self + $0 }
    }
}

extension Position where Scalar: SignedNumeric, Space == Dimension2<Scalar> {

    public mutating func rotate(_ turn: Turn) {
        self = rotating(turn)
    }

    public func rotating(_ turn: Turn) -> Position {
        switch turn {
        case .left: return Position(x: -self.y, y: self.x)
        case .right: return Position(x: self.y, y: -self.x)
        }
    }
}

// MARK: - 3D

public typealias Position3D<Scalar: Numeric> = Position<Dimension3<Scalar>, Scalar>

extension Position where Space == Dimension3<Scalar> {

    public init(x: Scalar, y: Scalar, z: Scalar) {
        self.init { parameter in
            switch parameter {
            case .x: return x
            case .y: return y
            case .z: return z
            }
        }
    }
}

extension Position where Space == Dimension3<Scalar>, Scalar == Int {

    public var neighbours: [Position] {
        let range: ClosedRange<Scalar> = -1...1
        return range.flatMap { dx in
            range.flatMap { dy in
                range.compactMap { dz in
                    guard dx != 0 || dy != 0 || dz != 0 else { return nil }
                    return Position(x: self.x + dx, y: self.y + dy, z: self.z + dz)
                }
            }
        }
    }
}

// MARK: - 4D

extension Position where Space == Dimension4<Scalar> {

    public init(w: Scalar, x: Scalar, y: Scalar, z: Scalar) {
        self.init { parameter in
            switch parameter {
            case .w: return w
            case .x: return x
            case .y: return y
            case .z: return z
            }
        }
    }
}
