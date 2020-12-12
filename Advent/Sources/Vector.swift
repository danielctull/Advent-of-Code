
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
