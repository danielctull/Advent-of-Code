
import Advent
import Foundation

public enum Day16: Day {

    public static let title = "Ticket Translation"

    public static func part1(_ input: Input) throws -> Int {

        let split = input.lines
            .split(whereSeparator: \.isEmpty)

        let rules = try Array(rules: split[0])
            .joined(operator: ||)

        let values = try split[2]
            .dropFirst()
            .joined(separator: ",")
            .split(separator: ",")
            .map(Int.init)

        return values
            .filter(!rules)
            .sum()
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Array where Element == Predicate<Int> {

    fileprivate init<S>(rules: S) throws where S: Sequence, S.Element == String {
        let regex = try RegularExpression(pattern: "^[a-z ]+: ([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)")
        self = try rules.map { string in
            let match = try regex.match(string)
            let lower1 = try match.integer(at: 0)
            let upper1 = try match.integer(at: 1)
            let lower2 = try match.integer(at: 2)
            let upper2 = try match.integer(at: 3)
            return .isWithin(lower1...upper1) || .isWithin(lower2...upper2)
        }
    }
}
