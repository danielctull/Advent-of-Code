
import Foundation

public struct Map<Tile: CustomStringConvertible> {
    public var tiles: [Position: Tile]
    public init(tiles: [Position: Tile] = [:]) {
        self.tiles = tiles
    }
}

extension Map: CustomStringConvertible {

    public var description: String {
        let maxX = tiles.keys.map { $0.x }.max()!
        let maxY = tiles.keys.map { $0.y }.max()!
        let minX = tiles.keys.map { $0.x }.min()!
        let minY = tiles.keys.map { $0.y }.min()!
        let sizeX = maxX - minX + 1
        let sizeY = maxY - minY + 1

        var output = Array(repeating: Array(repeating: " ", count: sizeX), count: sizeY)
        for tile in tiles {
            output[tile.key.y - minY][tile.key.x - minX] = String(describing: tile.value)
        }

        return [
            output.reversed().map { $0.joined() }.joined(separator: "\n")
        ].joined(separator: "\n")
    }
}

extension Map {
    public subscript(position: Position) -> Tile? { tiles[position] }
}

// MARK: - Creating a Map from a Sequence of Sequences of Characters

public protocol ExpressibleByCharacter {
    init(_ character: Character) throws
}

extension Map where Tile: ExpressibleByCharacter {

    /// Takes a Sequence of Sequences of characters and makes a map of them.
    ///
    /// If you have an array of array of Characters this works.
    /// If you have an array of Strings this works. :)
    ///
    /// - Parameter characters: The 2D array of characters.
    public init<Rows, Columns>(characters: Rows) throws
        where
        Rows: Sequence,
        Rows.Element == Columns,
        Columns: Sequence,
        Columns.Element == Character
    {
        let tiles = try characters.enumerated().flatMap { y, line in
            try line.enumerated().map { x, character in
                try (Position(x: x, y: y), Tile(character))
            }
        }
        .group(by: { $0.0 })
        .mapValues { $0[0].1 }

        self.init(tiles: tiles)
    }
}
