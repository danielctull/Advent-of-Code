
public struct Vector<Value: Numeric>: Equatable {
    public let x: Value
    public let y: Value

    public init(x: Value, y: Value) {
        self.x = x
        self.y = y
    }
}

extension Vector where Value == Int {

    public init(from start: Position = .origin, to end: Position) {
        x = end.x - start.x
        y = end.y - start.y
    }
}

extension Vector {
    public static var up: Vector { Vector(x: 0, y: 1) }
    public static var down: Vector { Vector(x: 0, y: -1) }
    public static var left: Vector { Vector(x: -1, y: 0) }
    public static var right: Vector { Vector(x: 1, y: 0) }
}

extension Vector {
    public static var north: Vector { Vector(x: 0, y: 1) }
    public static var east: Vector { Vector(x: 1, y: 0) }
    public static var south: Vector { Vector(x: 0, y: -1) }
    public static var west: Vector { Vector(x: -1, y: 0) }
}

extension Vector {

    public static func * (lhs: Vector, rhs: Value) -> Vector {
        Self(x: lhs.x * rhs, y: lhs.y * rhs)
    }
}

extension Vector {

    public func rotating(_ turn: Turn) -> Vector {
        switch turn {
        case .left: return Vector(x: -1 * y, y: x)
        case .right: return Vector(x: y, y: -1 * x)
        }
    }
}

extension Vector {

    public static var orthogonal: [Vector] {
        [
            Vector(x: .zero + 1, y: .zero),
            Vector(x: .zero - 1, y: .zero),
            Vector(x: .zero, y: .zero + 1),
            Vector(x: .zero, y: .zero - 1)
        ]
    }

    public static var diagonal: [Vector] {
        [
            Vector(x: .zero + 1, y: .zero + 1),
            Vector(x: .zero + 1, y: .zero - 1),
            Vector(x: .zero - 1, y: .zero - 1),
            Vector(x: .zero - 1, y: .zero + 1)
        ]
    }
}
