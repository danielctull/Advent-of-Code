
import Foundation

public struct Grid<Tile> {
    public var origin: Origin
    public var tiles: [Position: Tile]
    public var empty: String
    public init(
        origin: Origin = .bottomLeft,
        tiles: [Position: Tile] = [:],
        empty: String = " "
    ) {
        self.origin = origin
        self.tiles = tiles
        self.empty = empty
    }
}

public enum Origin {
    case topLeft
    case bottomLeft
}

extension Origin: Equatable {}
extension Origin: Hashable {}

extension Grid: Equatable where Tile: Equatable {}
extension Grid: Hashable where Tile: Hashable {}

extension Grid: CustomStringConvertible where Tile: CustomStringConvertible {

    public var description: String {
        let maxX = tiles.keys.map { $0.x }.max()!
        let maxY = tiles.keys.map { $0.y }.max()!
        let minX = tiles.keys.map { $0.x }.min()!
        let minY = tiles.keys.map { $0.y }.min()!
        let sizeX = maxX - minX + 1
        let sizeY = maxY - minY + 1

        var output = Array(repeating: Array(repeating: empty, count: sizeX), count: sizeY)
        for tile in tiles {
            output[tile.key.y - minY][tile.key.x - minX] = String(describing: tile.value)
        }

        if origin == .bottomLeft {
            output = output.reversed()
        }

        return [
            output.map { $0.joined() }.joined(separator: "\n")
        ].joined(separator: "\n")
    }
}

extension Grid {

    public subscript(position: Position) -> Tile? {
        get { tiles[position] }
        set { tiles[position] = newValue }
    }
    
    public var maximum: Position {
        tiles.keys.max(by: { lhs, rhs in (lhs.y, lhs.x) < (rhs.y, rhs.x) })!
    }
}

extension Grid where Tile: Equatable {

    public func positions(of tile: Tile) -> [Position] {
        tiles.filter { $0.value == tile }.map { $0.key }
    }

    public func firstPosition(of tile: Tile) -> Position? {
        tiles.first(where: { $0.value == tile })?.key
    }
}

// MARK: - Finding the shortest distance

extension Grid {

    public func shortestDistance<Node>(
        from start: Node,
        to end: Node,
        move: (Node, Direction) -> (Node, Direction),
        tile: (Node) -> Tile?,
        isPath: (Tile) -> Bool
    ) -> Int? where Node: Hashable {

        var queue = Direction.allCases.map {
            (position: start, direction: $0, distance: 0)
        }
        var visited = Set<Node>()

        while let (position, direction, distance) = queue.first {
            queue.removeFirst()

            let (position, direction) = move(position, direction)
            let distance = distance + 1

            guard !visited.contains(position) else { continue }
            visited.insert(position)

            guard let t = tile(position) else { continue }
            guard isPath(t) else { continue }

            guard position != end else { return distance }

            let next = direction.opposite.otherDirections.map {
                (position: position, direction: $0, distance: distance)
            }

            queue.append(contentsOf: next)
        }

        return nil
    }
}

// MARK: - Converting a Grid

extension Grid {

    public func mapTiles<NewTile>(
        _ transform: (Position, Tile) throws -> NewTile
    ) rethrows -> Grid<NewTile> {

        var new: [Position: NewTile] = [:]
        new.reserveCapacity(tiles.count)

        for (position, tile) in tiles {
            let newTile = try transform(position, tile)
            new[position] = newTile
        }

        return Grid<NewTile>(origin: origin, tiles: new, empty: empty)
    }
}

// MARK: - Creating a Grid from a Sequence of Sequences of RawValues

extension Grid where Tile: RawRepresentable {

    /// Takes a Sequence of Sequences of RawValues and makes a map of them.
    ///
    /// If you have an array of array of Characters this works.
    /// If you have an array of Strings this works. :)
    /// If you have an array of array of Ints this works! :D
    ///
    /// - Parameter characters: The sequence of sequences of raw values.
    public init<Rows, Columns, RawValue>(
        origin: Origin = .bottomLeft,
        rawValues: Rows
    ) throws
        where
        Rows: Sequence,
        Rows.Element == Columns,
        Columns: Sequence,
        Columns.Element == RawValue,
        Tile.RawValue == RawValue
    {
        let tiles = try rawValues.enumerated().flatMap { y, line in
            try line.enumerated().map { x, rawValue in
                try (Position(x: x, y: y), Tile(rawValue))
            }
        }
        .group(by: { $0.0 })
        .mapValues { $0[0].1 }

        self.init(origin: origin, tiles: tiles)
    }
}

extension Grid where Tile: RawRepresentable, Tile.RawValue == Character {

    public init(input: Input) throws {
        let rawValues = input.lines.map { $0.string.map { $0 } }
        try self.init(origin: .topLeft, rawValues: rawValues)
    }
}

// MARK: - Creating a Grid using a closure

extension Grid {

    public init(
        origin: Origin = .bottomLeft,
        width: Int,
        height: Int,
        tile: (Position) throws -> Tile
    ) rethrows {

        var tiles: [Position: Tile] = [:]
        for x in (0..<width) {
            for y in (0..<height) {
                let position = Position(x: x, y: y)
                tiles[position] = try tile(position)
            }
        }

        self.init(origin: origin, tiles: tiles)
    }
}
