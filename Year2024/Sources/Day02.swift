
import Advent

public enum Day02: Day {

    public static let title = "Red-Nosed Reports"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines.count {
            let values = try $0
                .split(whereSeparator:(\.isWhitespace))
                .map(Int.init)

            let differences = zip(values, values.dropFirst())
                .map(-)

            return differences.map(abs).allSatisfy { $0 < 4 }
                && differences.map(\.signum).allSame
        }
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}
