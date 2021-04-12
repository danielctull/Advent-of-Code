
import Advent
import Algorithms
import Foundation

public enum Day09: Day {

    public static let title = "Encoding Error"

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

        windows(ofCount: preamble + 1)
            .lazy
            .map { ($0.dropLast(), $0.last!) }
            .first(where: !hasSumCombination)
            .map(\.1) ?? 0
    }

    fileprivate func range(summingTo value: Int) throws -> SubSequence {
        var range = (0..<2)
        var sum = self[0] + self[1]
        while range.upperBound < endIndex {
            switch sum {
            case value:
                return self[range]
            case .isLessThan(value):
                sum += self[range.upperBound]
                range.incrementUpperBound()
            case .isGreaterThan(value):
                sum -= self[range.lowerBound]
                range.incrementLowerBound()
            default: fatalError()
            }
        }
        throw NotFound()
    }
}

fileprivate func hasSumCombination<C>(
    preamble: C,
    value: Int
) -> Bool where C: Collection, C.Element == Int {

    let set = Set(preamble)
    for lhs in set {
        let rhs = value - lhs
        guard lhs != rhs else { continue }
        if set.contains(rhs) { return true }
    }
    return false
}
