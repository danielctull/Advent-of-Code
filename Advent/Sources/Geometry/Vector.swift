
@dynamicMemberLookup
public struct Vector<Space, Scalar>
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

extension Vector: Equatable where Space: Equatable {}
extension Vector: Hashable where Space: Hashable {}

extension Vector {

    public init(value: (Parameter) -> Scalar) {
        self.init(space: Space(value: value))
    }

    subscript(parameter: Parameter) -> Scalar { space[parameter] }
}

extension Vector {

    public init(
        from start: Position<Space, Scalar> = .origin,
        to end: Position<Space, Scalar>
    ) {
        self.init { parameter in end[parameter] - start[parameter] }
    }
}

extension Vector {
    public static var zero: Vector { Vector { _ in 0 } }
}

extension Vector {

    public static func + (lhs: Vector, rhs: Vector) -> Vector {
        Vector { parameter in lhs[parameter] + rhs[parameter] }
    }

    public static func += (lhs: inout Vector, rhs: Vector) {
        lhs = lhs + rhs
    }

    public static func * (vector: Vector, value: Scalar) -> Vector {
        Vector { parameter in vector.space[parameter] * value }
    }
}

extension Vector where Scalar: SignedNumeric {
    public var opposite: Vector { self * -1 }
}

// MARK: - 2D

public typealias Vector2D<Scalar: Numeric> = Vector<Dimension2<Scalar>, Scalar>

extension Vector where Space == Dimension2<Scalar> {

    public init(x: Scalar, y: Scalar) {
        self.init { parameter in
            switch parameter {
            case .x: return x
            case .y: return y
            }
        }
    }
}

extension Vector where Scalar: SignedNumeric, Space == Dimension2<Scalar> {
    public static var up: Vector { Vector(x: 0, y: 1) }
    public static var down: Vector { Vector(x: 0, y: -1) }
    public static var left: Vector { Vector(x: -1, y: 0) }
    public static var right: Vector { Vector(x: 1, y: 0) }
}

extension Vector where Scalar: SignedNumeric, Space == Dimension2<Scalar> {
    public static var north: Vector { .up }
    public static var east: Vector { .right }
    public static var south: Vector { .down }
    public static var west: Vector { .left }
}

extension Vector where Scalar: SignedNumeric, Space == Dimension2<Scalar> {
    public var otherDirections: [Vector] {
        Vector.orthogonal.filter { $0 != self }
    }
}

extension Vector where Scalar: SignedNumeric, Space == Dimension2<Scalar> {

    public mutating func transform(_ transform: Transform2D<Scalar>) {
        self = transforming(transform)
    }

    public func transforming(_ transform: Transform2D<Scalar>) -> Vector2D<Scalar> {
        let x = self.x * transform.storage.x.x + self.y * transform.storage.x.y
        let y = self.x * transform.storage.y.x + self.y * transform.storage.y.y
        return Vector2D(x: x, y: y)
    }
}

extension Vector where Scalar: SignedNumeric, Space == Dimension2<Scalar> {

    public static var orthogonal: [Vector] {
        [.up, .down, .left, .right]
    }

    public static var diagonal: [Vector] {
        [
            Vector(x:  1, y:  1),
            Vector(x:  1, y: -1),
            Vector(x: -1, y: -1),
            Vector(x: -1, y:  1)
        ]
    }
}

// MARK: - 3D

public typealias Vector3D<Scalar: Numeric> = Vector<Dimension3<Scalar>, Scalar>

extension Vector where Space == Dimension3<Scalar> {

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

// MARK: - 4D

extension Vector where Space == Dimension4<Scalar> {

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
