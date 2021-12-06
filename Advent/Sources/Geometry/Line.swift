
public struct Line<Space, Scalar>
    where
    Space: Dimension,
    Space.Scalar == Scalar,
    Scalar: Numeric
{
    public let start: Position<Space, Scalar>
    public let end: Position<Space, Scalar>

    public init(
        start: Position<Space, Scalar>,
        end: Position<Space, Scalar>
    ) {
        self.start = start
        self.end = end
    }
}

// MARK: - 2D

public typealias Line2D<Scalar: Numeric> = Line<Dimension2<Scalar>, Scalar>

extension Line: CustomStringConvertible {
    public var description: String { "Line(start: \(start), end: \(end))" }
}
