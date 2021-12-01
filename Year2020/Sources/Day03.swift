
import Advent
import Algorithms
import Foundation

public enum Day03: Day {

    public static let title = "Toboggan Trajectory"

    public static func part1(_ input: Input) throws -> Int {
        count(input: input, right: 3, down: 1)
    }

    public static func part2(_ input: Input) throws -> Int {
        [
            count(input: input, right: 1, down: 1),
            count(input: input, right: 3, down: 1),
            count(input: input, right: 5, down: 1),
            count(input: input, right: 7, down: 1),
            count(input: input, right: 1, down: 2)
        ].product
    }

    private static func count(input: Input, right: Int, down: Int) -> Int {
        let columns = stride(from: 0, to: .max, by: right)
        let rows = stride(from: 0, to: input.lines.count, by: down)
        let count = input.lines[0].count
        return zip(columns, rows).count(where: { column, row in
            let row = input.lines[row]
            let index = row.index(row.startIndex, offsetBy: column % count)
            return row[index] == "#"
        })
    }
}
