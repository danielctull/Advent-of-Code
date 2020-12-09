
import Advent
import Foundation

public enum Day09 {

    public static func part1(_ input: Input) throws -> Int {

        let preamble = input.testing ? 5 : 25

        return input.integers
            .slidingWindows(ofCount: preamble + 1)
            .compactMap { values in

                let value = values.last!
                let exists = values.dropLast()
                    .lazy
                    .combinations(ofCount: 2)
                    .map { $0[0] + $0[1] }
                    .first(where: { $0 == value })
                    != nil

                if exists {
                    return nil
                } else {
                    return value
                }
            }
            .first ?? 0
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}
