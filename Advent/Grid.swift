
import Foundation

public struct Grid<Tile: CustomStringConvertible> {
    public var origin: Origin
    public var tiles: [Position: Tile]
    public var empty: String = " "
    public init(origin: Origin = .topLeft, tiles: [Position: Tile] = [:]) {
        self.origin = origin
        self.tiles = tiles
    }
}

extension Grid {

    public enum Origin {
        case topLeft
        case bottomLeft
    }
}

extension Grid: CustomStringConvertible {

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

        if origin == .topLeft {
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
}

extension Grid where Tile: Equatable {

    public func positions(of tile: Tile) -> [Position] {
        tiles.filter { $0.value == tile }.map { $0.key }
    }

    public func firstPosition(of tile: Tile) -> Position? {
        tiles.first(where: { $0.value == tile })?.key
    }
}

// MARK: - Creating a Map from a Sequence of Sequences of RawValues

extension Grid where Tile: RawRepresentable {

    /// Takes a Sequence of Sequences of RawValues and makes a map of them.
    ///
    /// If you have an array of array of Characters this works.
    /// If you have an array of Strings this works. :)
    /// If you have an array of array of Ints this works! :D
    ///
    /// - Parameter characters: The sequence of sequences of raw values.
    public init<Rows, Columns, RawValue>(rawValues: Rows) throws
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

        self.init(tiles: tiles)
    }
}
