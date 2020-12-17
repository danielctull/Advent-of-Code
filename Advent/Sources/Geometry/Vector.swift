
public struct Vector2D<Value: Numeric>: Equatable {
    public let x: Value
    public let y: Value

    public init(x: Value, y: Value) {
        self.x = x
        self.y = y
    }
}

extension Vector2D: Hashable where Value: Hashable {}

extension Vector2D where Value == Int {

    public init(from start: Position2D<Value> = .origin, to end: Position2D<Value>) {
        x = end.x - start.x
        y = end.y - start.y
    }
}

extension Vector2D where Value: SignedNumeric {
    public static var up: Vector2D { Vector2D(x: 0, y: 1) }
    public static var down: Vector2D { Vector2D(x: 0, y: -1) }
    public static var left: Vector2D { Vector2D(x: -1, y: 0) }
    public static var right: Vector2D { Vector2D(x: 1, y: 0) }
}

extension Vector2D where Value: SignedNumeric {
    public static var north: Vector2D { .up }
    public static var east: Vector2D { .right }
    public static var south: Vector2D { .down }
    public static var west: Vector2D { .left }
}

extension Vector2D {

    public static func * (vector: Vector2D, value: Value) -> Vector2D {
        Vector2D(x: vector.x * value, y: vector.y * value)
    }
}

extension Vector2D where Value: SignedNumeric {

    public var opposite: Vector2D { self * -1 }

    public var otherDirections: [Vector2D] {
        Vector2D.orthogonal.filter { $0 != self }
    }
}

extension Vector2D where Value: SignedNumeric {

    public mutating func rotate(_ turn: Turn) {
        self = rotating(turn)
    }

    public func rotating(_ turn: Turn) -> Vector2D {
        switch turn {
        case .left: return Vector2D(x: -y, y: x)
        case .right: return Vector2D(x: y, y: -x)
        }
    }
}

extension Vector2D where Value: SignedNumeric {

    public static var orthogonal: [Vector2D] {
        [.up, .down, .left, .right]
    }

    public static var diagonal: [Vector2D] {
        [
            Vector2D(x:  1, y:  1),
            Vector2D(x:  1, y: -1),
            Vector2D(x: -1, y: -1),
            Vector2D(x: -1, y:  1)
        ]
    }
}
