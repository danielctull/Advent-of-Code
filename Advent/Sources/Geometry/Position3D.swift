
public struct Position3D: Equatable, Hashable {
    public let x: Int
    public let y: Int
    public let z: Int

    public init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
}

extension Position3D {
    public static let origin = Position3D(x: 0, y: 0, z: 0)
}

public func + (_ lhs: Position3D, rhs: Position3D) -> Position3D {
    Position3D(x: lhs.x + rhs.x,
               y: lhs.y + rhs.y,
               z: lhs.z + rhs.z)
}

public func += (_ lhs: inout Position3D, rhs: Position3D) {
    lhs = lhs + rhs
}

extension Position3D {

    public var neighbours: [Position3D] {
        let range = -1...1
        return range.flatMap { dx in
            range.flatMap { dy in
                range.compactMap { dz in
                    guard dx != 0 || dy != 0 || dz != 0 else { return nil }
                    return Position3D(x: x + dx, y: y + dy, z: z + dz)
                }
            }
        }
    }
}
