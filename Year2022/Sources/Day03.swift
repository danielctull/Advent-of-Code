
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
                    .sum { try $0.priority }
            }
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Character {

    fileprivate var priority: Int {
        get throws {
            let ascii = try Int(ascii: self)
            switch ascii {
            case (65...90): return ascii - 38
            case (97...122): return ascii - 96
            default: throw UnexpectedRawValue(rawValue: self)
            }
        }
    }
}

extension Int {

    fileprivate init(ascii character: Character) throws {

        struct NotASCII: Error {
            let character: Character
        }

        guard let ascii = character.asciiValue else {
            throw NotASCII(character: character)
        }

        self = Int(ascii)
    }
}
