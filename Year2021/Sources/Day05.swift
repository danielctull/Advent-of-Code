
import Advent
import Algorithms
import Foundation
import RegexBuilder

public enum Day05: Day {

    public static let title = "Hydrothermal Venture"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .compactMap(Line2D.orthogonal)
            .flatMap(\.positions)
            .countByElement
            .count(where: { $0.value > 1 })
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines
            .map(Line2D.init)
            .flatMap(\.positions)
            .countByElement
            .count(where: { $0.value > 1 })
    }
}

extension Line where Space == Dimension2<Int> {

    fileprivate init(_ string: String) throws {
        let regex = Regex {
            TryCapture.integer
            ","
            TryCapture.integer
            " -> "
            TryCapture.integer
            ","
            TryCapture.integer
        }
        let match = try regex.match(in: string)
        self.init(
            start: Position2D(x: match.output.1, y: match.output.2),
            end: Position2D(x: match.output.3, y: match.output.4))
    }

    fileprivate static func orthogonal(_ string: String) throws -> Self? {
        let line = try Self(string)
        guard line.start.x == line.end.x || line.end.y == line.start.y else { return nil }
        return line
    }

    fileprivate var positions: [Position2D<Int>] {

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
            return zip(xs, ys).map(Position2D.init)
        }
    }
}
