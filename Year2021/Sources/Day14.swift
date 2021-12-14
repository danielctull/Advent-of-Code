
import Advent
import Algorithms
import Foundation

public enum Day14: Day {

    public static let title = "Extended Polymerization"

    public static func part1(_ input: Input) throws -> Int {
        let segments = input.lines
            .split(separator: "")

        let rules = try segments
            .last.unwrapped
            .map(Day14.Rule.init)

        var template = try segments
            .first.unwrapped
            .first
            .map(Day14.Template.init)
            .unwrapped

        for _ in 1...10 {
            try template.apply(rules: rules)
        }

        let counts = template.characters
            .countByElement
            .values

        let min = try counts.min().unwrapped
        let max = try counts.max().unwrapped
        return max - min
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day14 {

    fileprivate struct Template {
        var characters: [Character]
    }

    fileprivate struct Rule {
        let pair: (Character, Character)
        let insert: Character
    }
}

extension Day14.Rule {

    init(string: String) throws {
        let regex = try RegularExpression(pattern: #"([A-Z])([A-Z]) -> ([A-Z])"#)
        let match = try regex.match(string)
        pair = try (match.character(at: 0), match.character(at: 1))
        insert = try match.character(at: 2)
    }
}

extension Day14.Template {

    init(string: String) throws {
        self.init(characters: Array(string))
    }

    mutating func apply(rules: [Day14.Rule]) throws {
        var new = try characters
            .adjacentPairs()
            .reduce(into: [Character]()) { result, pair in
                result.append(pair.0)
                let rule = try rules.first(where: { $0.pair == pair }).unwrapped
                result.append(rule.insert)
            }
        try new.append(characters.last.unwrapped)
        characters = new
    }
}
