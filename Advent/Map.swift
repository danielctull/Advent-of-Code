
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
