
import Advent
import Algorithms
import Foundation

public enum Day03 {

    public static func part1(_ input: Input) throws -> Int {
        let columns = (0...).lazy.map { $0 * 3 }
        let rows = input.lines.map { $0.cycled() }
        return zip(columns, rows).count(where: { column, row in
            var iterator = row.dropFirst(column).makeIterator()
            let character = iterator.next()!
            return character == "#"
        })
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}
