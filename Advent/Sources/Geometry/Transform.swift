
public struct Transform2D<Scalar: Numeric> {

    let storage: Dimension2<Dimension2<Scalar>>
}

extension Transform2D {

    public init(_ xx: Scalar, _ xy: Scalar, _ yx: Scalar, _ yy: Scalar) {
        storage = Dimension2(
            x: Dimension2(x: xx, y: xy),
            y: Dimension2(x: yx, y: yy))
    }

    public static var identity: Transform2D { Transform2D(1, 0, 0, 1) }
    public static var rotate90: Transform2D { Transform2D(0, 1, -1, 0) }
    public static var rotate270: Transform2D { Transform2D(0, -1, 1, 0) }
}
