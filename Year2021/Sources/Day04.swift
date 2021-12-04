
import Advent
import Algorithms
import Foundation

public enum Day04: Day {

    public static let title = "Giant Squid"

    public static func part1(_ input: Input) throws -> Int {
        let sections = input.lines.split(separator: "")

        let numbers = try sections
            .first.unwrapped()
            .first.unwrapped()
            .split(separator: ",")
            .map(Int.init)
            .reductions(into: []) { $0.append($1) }

        let boards = try sections
            .dropFirst()
            .map(Board.init)

        for values in numbers {
            for board in boards {
                if board.wins(Set(values)) {
                    return try values.last.unwrapped() * board.unmarked(Set(values)).sum
                }
            }
        }

        return 0
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day04 {

    struct Board {
        let values: Set<Int>
        let rows: [Set<Int>]
        let columns: [Set<Int>]

        init<Strings>(lines: Strings) throws where Strings: Sequence, Strings.Element == String {

            let rows = try lines
                .map {
                    try $0.split(whereSeparator: \.isWhitespace)
                        .map(Int.init)
                }

            self.rows = rows
                .map(Set.init)

            self.columns = rows
                .transpose()
                .map(Set.init)

            values = Set(rows.flatMap( { $0 }))
        }

        func wins(_ numbers: Set<Int>) -> Bool {
            return rows.contains(where: { $0.isSubset(of: numbers) })
                || columns.contains(where: { $0.isSubset(of: numbers) })
        }

        func unmarked(_ numbers: Set<Int>) -> Set<Int> {
            values.subtracting(numbers)
        }
    }
}
