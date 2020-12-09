
import Advent
import Foundation

public enum Day09 {

    public static func part1(_ input: Input) throws -> Int {
        input.integers.invalidNumber(preamble: input.testing ? 5 : 25)
    }

    public static func part2(_ input: Input) throws -> Int {

        let numbers = input.integers
        let invalid = numbers.invalidNumber(preamble: input.testing ? 5 : 25)

        return (2...).lazy
            .compactMap { count in
                numbers.slidingWindows(ofCount: count)
                    .first(where: { $0.sum() == invalid })
            }
            .map { $0.min()! + $0.max()! }
            .first(where: { _ in true }) ?? 0
    }
}

extension Array where Element == Int {

    fileprivate func invalidNumber(preamble: Int) -> Int {

        slidingWindows(ofCount: preamble + 1)
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
}
