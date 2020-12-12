
public struct Vector<Value: Numeric> {
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

    public init(direction: Direction) {
        switch direction {
        case .up: self = Vector(x: 0, y: 1)
        case .down: self = Vector(x: 0, y: -1)
        case .left: self = Vector(x: -1, y: 0)
        case .right: self = Vector(x: 1, y: 0)
        }
    }
}

extension Vector {

    public static func * (lhs: Vector, rhs: Value) -> Vector {
        Self(x: lhs.x * rhs, y: lhs.y * rhs)
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
