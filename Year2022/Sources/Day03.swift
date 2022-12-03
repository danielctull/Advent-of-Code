
import Advent
import Algorithms

public enum Day03: Day {

    public static let title = "Rucksack Reorganization"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .sum { line in
                let array = Array(line)
                let middle = array.count / 2
                let first = Set(array[..<middle])
                let last = Set(array[middle...])
                return try first.intersection(last)
                    .sum(of: Int.priority)
            }
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines
            .chunks(ofCount: 3)
            .sum { group in
                try group
                    .map(Set.init)
                    .reduce { $0.intersection($1) }
                    .unwrapped
                    .sum(of: Int.priority)
            }
    }
}

extension Int {

    fileprivate static func priority(_ character: Character) throws -> Int {
        let ascii = try Int.ascii(character)
        switch ascii {
        case (65...90): return ascii - 38
        case (97...122): return ascii - 96
        default: throw UnexpectedRawValue(rawValue: self)
        }
    }
}
