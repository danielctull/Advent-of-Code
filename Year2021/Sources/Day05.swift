
import Advent
import Algorithms
import Foundation

public enum Day05: Day {

    public static let title = "Hydrothermal Venture"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .compactMap(Line.orthogonal)
            .flatMap(\.positions)
            .countByElement
            .count(where: { $0.value > 1 })
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines
            .map(Line.init)
            .flatMap(\.positions)
            .countByElement
            .count(where: { $0.value > 1 })
    }
}

extension Day05 {

    struct Line {
        let start: Position2D<Int>
        let end: Position2D<Int>
    }
}

extension Day05.Line {

    init(_ string: String) throws {
        let regex = try RegularExpression(pattern: #"([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)"#)
        let match = try regex.match(string)
        start = try Position2D(x: match.integer(at: 0), y: match.integer(at: 1))
        end = try Position2D(x: match.integer(at: 2), y: match.integer(at: 3))
    }

    static func orthogonal(_ string: String) throws -> Self? {
        let line = try Self(string)
        guard line.start.x == line.end.x || line.end.y == line.start.y else { return nil }
        return line
    }

    var positions: [Position2D<Int>] {

        var xs: [Int] {
            start.x < end.x
                ? Array(start.x...end.x)
                : Array(end.x...start.x).reversed()
        }

        var ys: [Int] {
            start.y < end.y
                ? Array(start.y...end.y)
                : Array(end.y...start.y).reversed()
        }

        if start.x == end.x {
            return ys.map { Position2D(x: start.x, y: $0) }
        } else if start.y == end.y {
            return xs.map { Position2D(x: $0, y: start.y) }
        } else {
            return zip(xs, ys).map { Position2D(x: $0, y: $1) }
        }
    }
}

extension Day05.Line: CustomStringConvertible {
    var description: String { "Line(start: \(start), end: \(end))" }
}
