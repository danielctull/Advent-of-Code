
import Advent
import Foundation

public enum Day11 {

    public static func part1(_ input: Input) throws -> Int {
        var matrix = try Matrix<Tile>(input: input)
        var count = matrix.count(of: .occupied)
        while true {
            matrix = matrix.musicalChairs()
            let newCount = matrix.count(of: .occupied)
            guard newCount != count else { return count }
            count = newCount
        }

        return count
    }

    public static func part2(_ input: Input) throws -> Int {
        var matrix = try Matrix<Tile>(input: input)
        var count = matrix.count(of: .occupied)

        while true {
            matrix = matrix.musicalChairs2()
            let newCount = matrix.count(of: .occupied)
            guard newCount != count else { return count }
            count = newCount
        }

        return count
    }
}

extension Day11 {

    enum Tile: Character, RawRepresentable {
        case floor = "."
        case empty = "L"
        case occupied = "#"

        var isSeat: Bool { self == .empty || self == .occupied }
    }
}

extension Day11.Tile: CustomStringConvertible {
    var description: String { String(rawValue) }
}

extension Matrix where Element == Day11.Tile {

    fileprivate func musicalChairs() -> Self {

        func adjacent(to position: Position) -> [Day11.Tile] {
            neighbours(of: position, in: Vector.orthogonal + Vector.diagonal)
                .map { self[$0] }
        }

        return map { (position: Position, tile: Day11.Tile) -> Day11.Tile in
            switch tile {
            case .empty where adjacent(to: position).count(of: .occupied) == 0: return .occupied
            case .occupied where adjacent(to: position).count(of: .occupied) >= 4: return .empty
            default: return tile
            }
        }
    }
}

extension Matrix where Element == Day11.Tile {

    fileprivate func musicalChairs2() -> Self {

        func firstSeat(from position: Matrix<Day11.Tile>.Index, in direction: Vector<Int>) -> Element? {
            positions(from: position, in: direction).first(where: \.isSeat)
        }

        func adjacent(to position: Matrix<Day11.Tile>.Index) -> [Element] {
            (Vector<Int>.diagonal + Vector<Int>.orthogonal)
                .compactMap { firstSeat(from: position, in: $0) }
        }

        return map { (position: Matrix<Day11.Tile>.Index, tile: Day11.Tile) -> Element in
            switch tile {
            case .empty where adjacent(to: position).count(where: { $0 == .occupied }) == 0: return .occupied
            case .occupied where adjacent(to: position).count(where: { $0 == .occupied }) >= 5: return .empty
            default: return tile
            }
        }
    }
}
