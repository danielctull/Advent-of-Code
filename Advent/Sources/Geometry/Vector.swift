
public struct Vector<Value: Numeric>: Equatable {
    public let dx: Value
    public let dy: Value

    public init(dx: Value, dy: Value) {
        self.dx = dx
        self.dy = dy
    }
}

extension Vector: Hashable where Value: Hashable {}

extension Vector where Value == Int {

    public init(from start: Position<Value> = .origin, to end: Position<Value>) {
        dx = end.x - start.x
        dy = end.y - start.y
    }
}

extension Vector where Value: SignedNumeric {
    public static var up: Vector { Vector(dx: 0, dy: 1) }
    public static var down: Vector { Vector(dx: 0, dy: -1) }
    public static var left: Vector { Vector(dx: -1, dy: 0) }
    public static var right: Vector { Vector(dx: 1, dy: 0) }
}

extension Vector where Value: SignedNumeric {
    public static var north: Vector { .up }
    public static var east: Vector { .right }
    public static var south: Vector { .down }
    public static var west: Vector { .left }
}

extension Vector {

    public static func * (vector: Vector, value: Value) -> Vector {
        Vector(dx: vector.dx * value, dy: vector.dy * value)
    }
}

extension Vector where Value: SignedNumeric {

    public var opposite: Vector { self * -1 }

    public var otherDirections: [Vector] {
        Vector.orthogonal.filter { $0 != self }
    }
}

extension Vector where Value: SignedNumeric {

    public mutating func rotate(_ turn: Turn) {
        self = rotating(turn)
    }

    public func rotating(_ turn: Turn) -> Vector {
        switch turn {
        case .left: return Vector(dx: -dy, dy: dx)
        case .right: return Vector(dx: dy, dy: -dx)
        }
    }
}

extension Vector where Value: SignedNumeric {

    public static var orthogonal: [Vector] {
        [.up, .down, .left, .right]
    }

    public static var diagonal: [Vector] {
        [
            Vector(dx:  1, dy:  1),
            Vector(dx:  1, dy: -1),
            Vector(dx: -1, dy: -1),
            Vector(dx: -1, dy:  1)
        ]
    }
}
