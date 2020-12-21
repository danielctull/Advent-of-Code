
public struct Transform<Space: Dimension, Scalar: Numeric> where Space.Scalar == Scalar {

    let storage: Dimension2<Space>
}

public typealias Transform2D<Scalar: Numeric> = Transform<Dimension2<Scalar>, Scalar>

extension Transform2D where Space == Dimension2<Scalar> {

    public init(_ xx: Scalar, _ xy: Scalar, _ yx: Scalar, _ yy: Scalar) {
        storage = Dimension2(
            x: Dimension2(x: xx, y: xy),
            y: Dimension2(x: yx, y: yy))
    }

    public static var identity: Self { Transform2D(1, 0, 0, 1) }
    public static var rotate90: Self { Transform2D(0, 1, -1, 0) }
    public static var rotate270: Self { Transform2D(0, -1, 1, 0) }
}
