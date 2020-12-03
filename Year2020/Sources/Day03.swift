
import Advent
import Algorithms
import Foundation

public enum Day03 {

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
        ].product()
    }

    private static func count(input: Input, right: Int, down: Int) -> Int {
        let columns = (0...).lazy.map { $0 * right }
        let rows = input.lines
            .enumerated()
            .filter { index, _ in index.isMultiple(of: down) }
            .map { _, row in row.cycled() }
        return zip(columns, rows).count(where: { column, row in
            var iterator = row.dropFirst(column).makeIterator()
            let character = iterator.next()!
            return character == "#"
        })
    }
}
