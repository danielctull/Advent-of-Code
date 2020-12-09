
import Advent
import Foundation

public enum Day09 {

    public static func part1(_ input: Input) -> Int {
        input.integers.invalidNumber(preamble: input.testing ? 5 : 25)
    }

    public static func part2(_ input: Input) throws -> Int {
        let numbers = input.integers
        let invalid = numbers.invalidNumber(preamble: input.testing ? 5 : 25)
        let range = try numbers.range(summingTo: invalid)
        return range.min()! + range.max()!
    }
}

fileprivate struct NotFound: Error {}

extension Array where Element == Int {

    fileprivate func invalidNumber(preamble: Int) -> Int {

        slidingWindows(ofCount: preamble + 1)
            .map { ($0.dropLast(), $0.last!) }
            .first(where: hasSumCombination)
            .map(\.1) ?? 0
    }

    fileprivate func range(summingTo value: Int) throws -> [Int] {
        var result: [Int] = []
        for element in self {
            result.append(element)
            while result.sum() > value { result.removeFirst() }
            if result.sum() == value { return result }
        }
        throw NotFound()
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
