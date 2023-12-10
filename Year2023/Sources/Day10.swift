
import Advent
import Algorithms
import Foundation

public enum Day10: Day {

    public static let title = "Pipe Maze"

    public static func part1(_ input: Input) throws -> Int {
        
        let grid = try Grid<Position2D<Int>, Tile>(rawValues: input.lines.reversed())
        var current = try [grid.firstPosition(of: .start).unwrapped]
        var covered: Set<Position2D<Int>> = []
        var steps = 0

        while Set(current).count == current.count {
            covered.formUnion(current)
            steps += 1
            current = current.flatMap { position -> [Position2D<Int>] in
                guard let tile = grid[position] else { return [] }
                return tile
                    .neighbours
                    .map { position + $0 }
                    .filter { !covered.contains($0) }
                    .filter { next in // Ensure next pipe leads back to us.
                        guard let tile = grid[next] else { return false}
                        return tile.neighbours.map { next + $0 }.contains(position)
                    }
            }
        }

        return steps
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

public struct Size<Space, Scalar>
    where
    Space: Advent.Dimension,
    Space.Scalar == Scalar,
    Scalar: Numeric
{
    public typealias Parameter = Space.Parameter
    private let space: Space

    public subscript(
        dynamicMember keyPath: KeyPath<Space, Scalar>
    ) -> Scalar {
        space[keyPath: keyPath]
    }
}

extension Size {

    public init(value: (Parameter) -> Scalar) {
        self.init(space: Space(value: value))
    }

    public subscript(parameter: Parameter) -> Scalar { space[parameter] }
}


public typealias Size2D<Scalar: Numeric> = Size<Dimension2<Scalar>, Scalar>

extension Size where Space == Dimension2<Scalar> {

    public init(width: Scalar, height: Scalar) {
        self.init { parameter in
            switch parameter {
            case .x: return width
            case .y: return height
            }
        }
    }
}

public struct Box<Space>
    where
    Space: Advent.Dimension,
    Space.Scalar: Numeric
{
    public var origin: Position<Space, Space.Scalar>
    public var size: Size<Space, Space.Scalar>
}

public struct Path<Space>
    where
    Space: Advent.Dimension,
    Space.Scalar: Numeric
{
    public typealias P = Position<Space, Space.Scalar>
    public private(set) var positions: [P]

    public mutating func append(_ position: P) {
        positions.append(position)
    }
}

extension Path<Dimension2<Int>> {

    public var bounds: Box<Dimension2<Int>>? {
        let xs = positions.map(\.x)
        let ys = positions.map(\.y)
        
        guard
            let minY = ys.min(),
            let maxY = ys.max(),
            let minX = xs.min(),
            let maxX = xs.max()
        else {
            return nil
        }

        return Box(
            origin: Position(x: minX, y: minY),
            size: Size(width: maxX - minX, height: maxY - minY))
    }

    public func contains(_ position: P) -> Bool {
        guard let x = positions.map(\.x).max() else { return false }
        let outside = position + Vector2D(x: x + 1, y: position.y)
        let line = Line(start: position, end: outside)
        line.
    }
}

private struct Tile: RawRepresentable, Equatable {

    static let start = try! Self("S")

    let rawValue: Character
    let neighbours: [Vector2D<Int>]

    init?(rawValue: Character) {
        self.rawValue = rawValue
        switch rawValue {
        case "|": neighbours = [.north, .south]
        case "-": neighbours = [.east, .west]
        case "L": neighbours = [.north, .east]
        case "J": neighbours = [.north, .west]
        case "7": neighbours = [.south, .west]
        case "F": neighbours = [.south, .east]
        case ".": neighbours = []
        case "S": neighbours = Vector2D<Int>.orthogonal
        default: return nil
        }
    }
}
