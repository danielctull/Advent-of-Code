
import Advent

public enum Day09: Day {

    public static let title = "Mirage Maintenance"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines.map {
            try $0.split(whereSeparator: \.isWhitespace).map(Int.init)
        }
        .map(nextNumber)
        .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }

    static func nextNumber(_ values: [Int]) throws -> Int {
        guard !values.allSatisfy({ $0 == 0 }) else { return 0 }
        let differences = values.adjacentPairs().map { $1 - $0 }
        return try values.last.unwrapped + nextNumber(differences)
    }
}
