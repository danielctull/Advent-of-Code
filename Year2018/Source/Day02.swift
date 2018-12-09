
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

    public func part2(input: Input) -> String {

        let strings = input
            .lines
            .compactMap { $0.string }

        let repeating = strings.enumerated().repeating
        let repeatingElements = strings.enumerated().repeatingElements(strings.count)
        return zip(repeating, repeatingElements).reduce("") { result, tuple in

            let (lhs, rhs) = tuple

            guard lhs.offset != rhs.offset else { return result }

            let sharedCharacters = zip(lhs.element, rhs.element).compactMap { tuple -> Character? in

                guard tuple.0 == tuple.1 else { return nil }

                return tuple.0
            }

            let sharedString = String(sharedCharacters)

            guard sharedString.count > result.count else { return result }

            return sharedString
        }
    }
}

// MARK: - Result

struct Result {
    let twos: Int
    let threes: Int
}

extension Result {

    static func + (lhs: Result, rhs: Result) -> Result {
        return Result(twos: lhs.twos + rhs.twos, threes: lhs.threes + rhs.threes)
    }
}

// MARK: - Count by Elements

extension Sequence where Element: Hashable {

    var countByElements: [Element: Int] {

        return reduce(into: [:]) { result, element in
            result[element, default: 0] += 1
        }
    }
}
