
public struct Transform<Storage, Space, Scalar>
    where
    Storage: Dimension,
    Space: Dimension,
    Space.Scalar == Scalar,
    Storage.Scalar == Space,
    Storage.Parameter == Space.Parameter
{
    let storage: Storage
}

public typealias Transform2D<Scalar: Numeric> = Transform<Dimension2<Dimension2<Scalar>>, Dimension2<Scalar>, Scalar>

extension Transform2D where Scalar: Numeric, Storage == Dimension2<Dimension2<Scalar>> {

    public init(_ xx: Scalar, _ xy: Scalar, _ yx: Scalar, _ yy: Scalar) {
        storage = Storage {
            switch $0 {
            case .x:
                return Space {
                    switch $0 {
                    case .x: return xx
                    case .y: return xy
                    }
                }
            case .y:
                return Space { inner in
                    switch inner {
                    case .x: return yx
                    case .y: return yy
                    }
                }
            }
        }
    }

    public static var identity: Self { Self(1, 0, 0, 1) }
    public static var rotate90: Self { Self(0, 1, -1, 0) }
    public static var rotate270: Self { Self(0, -1, 1, 0) }
}
