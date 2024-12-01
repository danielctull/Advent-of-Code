import Advent

public enum Day01: Day {

    public static let title = "Historian Hysteria"

    public static func part1(_ input: Input) throws -> Int {
        let rows = try input.lines
            .map {
                let values = $0.split(whereSeparator:(\.isWhitespace))
                return try (Int(values.first.unwrapped), Int(values.last.unwrapped))
            }
        let columns = rotate(rows)
        let lhs = columns.0.sorted()
        let rhs = columns.1.sorted()
        return zip(lhs, rhs)
            .map(-)
            .map(abs)
            .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

fileprivate func rotate<A, B>(_ tuples: [(A, B)]) -> ([A], [B]) {
    (tuples.map(\.0), tuples.map(\.1))
}
