
public struct Vector<Value: Numeric>: Equatable {
    public let x: Value
    public let y: Value

    public init(x: Value, y: Value) {
        self.x = x
        self.y = y
    }
}

extension Vector: Hashable where Value: Hashable {}

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
    public static var north: Vector { .up }
    public static var east: Vector { .right }
    public static var south: Vector { .down }
    public static var west: Vector { .left }
}

extension Vector {

    public static func * (lhs: Vector, rhs: Value) -> Vector {
        Self(x: lhs.x * rhs, y: lhs.y * rhs)
    }
}

extension Vector {

    public var opposite: Vector { self * -1 }

    public var otherDirections: [Vector] {
        Vector.orthogonal.filter { $0 != self }
    }
}

extension Vector {

    public mutating func rotate(_ turn: Turn) {
        self = rotating(turn)
    }

    public func rotating(_ turn: Turn) -> Vector {
        switch turn {
        case .left: return Vector(x: -1 * y, y: x)
        case .right: return Vector(x: y, y: -1 * x)
        }
    }
}

extension Vector {

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
