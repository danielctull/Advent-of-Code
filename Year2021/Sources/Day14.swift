
import Advent
import Algorithms
import Foundation
import RegexBuilder

public enum Day14: Day {

    public static let title = "Extended Polymerization"

    public static func part1(_ input: Input) throws -> Int {
        try run(input, amount: 10)
    }

    public static func part2(_ input: Input) throws -> Int {
        try run(input, amount: 40)
    }

    private static func run(_ input: Input, amount: Int) throws -> Int {

        let segments = input.lines
            .split(separator: "")

        let rules = try Dictionary(strings: segments.last.unwrapped)

        let template = try segments
            .first.unwrapped
            .first.unwrapped

        let counts = template
            .adjacentPairs()
            .map(Pair.init)
            .countByElement

        var output = try (1...amount)
            .reduce(counts) { counts, _ in
                var out: [Pair: Int] = [:]
                for (pair, count) in counts {
                    let result = try rules[pair].unwrapped
                    for pair in result {
                        out[pair, default: 0] += count
                    }
                }
                return out
            }
            .flatMap { [ ($0.key.lhs, $0.value), ($0.key.rhs, $0.value) ] }
            .group(by: \.0)
            .mapValues { $0.sum(of: \.1) }

        // Start and end aren't doubled.
        try output[template.first.unwrapped, default: 0] += 1
        try output[template.last.unwrapped, default: 0] += 1

        output = output.mapValues { $0 / 2 }

        let min = try output.values.min().unwrapped
        let max = try output.values.max().unwrapped
        return max - min
    }
}

extension Day14 {

    fileprivate struct Pair: Hashable {
        let lhs: Character
        let rhs: Character
    }

    fileprivate struct Rule {
        let pair: (Character, Character)
        let insert: Character
    }
}

extension Dictionary where Key == Day14.Pair, Value == [Day14.Pair] {

    init<Strings>(
        strings: Strings
    ) throws where Strings: Sequence, Strings.Element == String {

        let regex = Regex {
            TryCapture.character
            TryCapture.character
            " -> "
            TryCapture.character
        }
        self = try strings.map { (string: String) -> (Day14.Pair, [Day14.Pair]) in
            let match = try regex.match(in: string)
            let lhs = match.output.1
            let rhs = match.output.2
            let middle = match.output.3

            let pair = Day14.Pair(lhs: lhs, rhs: rhs)

            let result = [
                Day14.Pair(lhs: lhs, rhs: middle),
                Day14.Pair(lhs: middle, rhs: rhs)
            ]

            return (pair, result)
        }
        .group(by: \.0)
        .mapValues { try $0.first.unwrapped.1 }
    }
}
