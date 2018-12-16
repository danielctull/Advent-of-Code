
import Advent
import Foundation

public struct Day12 {

    public init() {}

    public func part1(input: Input) -> Int {
        return count(input: input, generations: 20)
    }

    public func part2(input: Input) -> Int {
        return count(input: input, generations: 50000000000)
    }

    private func count(input: Input, generations: Int) -> Int {

        let lines = input.lines.map { $0.string }
        let empty = CharacterSet(charactersIn: ".")

        var result = lines[0].replacingOccurrences(of: "initial state: ", with: "")
        let rules: [String: String] = lines.dropFirst(2).reduce(into: [:]) { result, string in
            let components = string.components(separatedBy: " => ")
            result[components[0]] = components[1]
        }

        for generation in (1...generations) {

            let extended = "...." + result + "...."

            let next = extended.lookingAhead(5).map { chars -> String in
                let string = String(chars)
                let replacement = rules[string]
                return replacement ?? "."
            }.reduce("", +)

            if next.trimmingCharacters(in: empty) == result.trimmingCharacters(in: empty) {

                let previousSum = result.sumOfPots(offset: 2 * (generation - 1))
                let nextSum = next.sumOfPots(offset: 2 * generation)

                let difference = nextSum - previousSum
                let total = nextSum + difference * (generations - generation)

                return total
            }

            result = next
        }

        return result.sumOfPots(offset: 2 * generations)
    }
}

extension String {

    fileprivate func sumOfPots(offset: Int) -> Int {

        return indices(of: "#")
            .map { distance(from: startIndex, to: $0) - offset }
            .reduce(0, +)
    }
}
