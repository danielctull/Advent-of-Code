
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
            .lazy
            .map { ($0.dropLast(), $0.last!) }
            .first(where: !hasSumCombination)
            .map(\.1) ?? 0
    }

    fileprivate func range(summingTo value: Int) throws -> SubSequence {
        var range = (0..<1)
        while range.upperBound < endIndex {
            switch self[range].sum() {
            case value: return self[range]
            case .isLessThan(value): range.incrementUpperBound()
            case .isGreaterThan(value): range.incrementLowerBound()
            default: fatalError()
            }
        }
        throw NotFound()
    }
}

fileprivate func hasSumCombination<C>(
    preamble: C,
    value: Int
) -> Bool where C: RandomAccessCollection, C.Element == Int, C.Index == Int {

    var slice = preamble.sorted()[...]
    while slice.count > 1 {
        switch slice.first! + slice.last! {
        case value: return true
        case .isGreaterThan(value): slice.removeLast()
        case .isLessThan(value): slice.removeFirst()
        default: fatalError()
        }
    }
    return false
}
