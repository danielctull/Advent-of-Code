
import Advent
import Foundation

public enum Day09 {

    public static func part1(_ input: Input) -> Int {
        input.integers.invalidNumber(preamble: input.testing ? 5 : 25)
    }

    public static func part2(_ input: Input) -> Int {
        let numbers = input.integers
        let invalid = numbers.invalidNumber(preamble: input.testing ? 5 : 25)
        let range = numbers.range(summingTo: invalid)
        return range.min()! + range.max()!
    }
}

extension Array where Element == Int {

    fileprivate func invalidNumber(preamble: Int) -> Int {

        slidingWindows(ofCount: preamble + 1)
            .map { ($0.dropLast(), $0.last!) }
            .first(where: hasSumCombination)
            .map(\.1) ?? 0
    }

    fileprivate func range(summingTo value: Int) -> SubSequence {

        (2...).lazy
            .compactMap { count in
                slidingWindows(ofCount: count)
                    .first(where: { $0.sum() == value })
            }
            .first(where: { _ in true })!
    }
}

fileprivate func hasSumCombination<C>(
    preamble: C,
    value: Int
) -> Bool where C: Collection, C.Element == Int {

    preamble
        .filter { $0 < value }
        .combinations(ofCount: 2)
        .first(where: { $0.sum() == value })
        == nil
}
