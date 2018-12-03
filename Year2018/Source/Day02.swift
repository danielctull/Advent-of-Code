
import Advent
import Foundation

public struct Day02 {

    public init() {}

    public func part1(input: Input) -> Int {

        let result = input
            .lines
            .compactMap { $0.string }
            .map { string in

            let characterCounts = string.countByElements.values
            let twos = characterCounts.contains(2) ? 1 : 0
            let threes = characterCounts.contains(3) ? 1 : 0
            return Result(twos: twos, threes: threes)

        }.reduce(Result(twos: 0, threes: 0), +)

        return result.twos * result.threes
    }

    public func part2(input: Input) -> Int {
        return 0
    }
}


// MARK: -

struct Result {
    let twos: Int
    let threes: Int
}

extension Result {

    static func + (lhs: Result, rhs: Result) -> Result {
        return Result(twos: lhs.twos + rhs.twos, threes: lhs.threes + rhs.threes)
    }
}

extension Sequence where Element: Hashable {

    var countByElements: [Element: Int] {

        return reduce(into: [:]) { result, element in
            result[element, default: 0] += 1
        }
    }
}
