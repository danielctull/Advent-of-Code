
import Advent
import Foundation

public enum Day19: Day {

    public static let title = "Monster Messages"

    public static func part1(_ input: Input) throws -> Int {

        let sections = input.lines.split(whereSeparator: \.isEmpty)
        let messages = sections[1]
        let rules = try Array(lines: sections[0])
            .group(by: \.number)
            .mapValues { $0.first!.kind }

        let pattern = .start + rules.pattern(for: 0) + .end
        return messages.count(where: .matches(pattern))
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day19 {

    fileprivate struct Rule {

        indirect enum Kind {
            case character(Character)
            case reference1(Int)
            case reference2(Int, Int)
            case reference3(Int, Int, Int)
            case or1(Int, Int)
            case or2(Int, Int, Int, Int)
        }

        let number: Int
        let kind: Kind
    }
}

extension Dictionary where Key == Int, Value == Day19.Rule.Kind {

    func pattern(for index: Int) -> RegularExpression.Pattern {

        let kind = self[index]!
        switch kind {
        case let .character(character):
            return .character(character)
        case let .reference1(index):
            return pattern(for: index)
        case let .reference2(i1, i2):
            return pattern(for: i1) + pattern(for: i2)
        case let .reference3(i1, i2, i3):
            return pattern(for: i1) + pattern(for: i2) + pattern(for: i3)
        case let .or1(i1, i2):
            return pattern(for: i1) || pattern(for: i2)
        case let .or2(i1, i2, i3, i4):
            return pattern(for: i1) + pattern(for: i2) || pattern(for: i3) + pattern(for: i4)
        }
    }
}

extension Array where Element == Day19.Rule {

    init<Lines>(lines: Lines) throws where Lines: Sequence, Lines.Element == String {

        let character = try RegularExpression(pattern: #"^([0-9]+): "([a-z])"$"#)
        let or1 = try RegularExpression(pattern: #"^([0-9]+): ([0-9]+) \| ([0-9]+)$"#)
        let or2 = try RegularExpression(pattern: #"^([0-9]+): ([0-9]+) ([0-9]+) \| ([0-9]+) ([0-9]+)$"#)
        let reference1 = try RegularExpression(pattern: #"^([0-9]+): ([0-9]+)$"#)
        let reference2 = try RegularExpression(pattern: #"^([0-9]+): ([0-9]+) ([0-9]+)$"#)
        let reference3 = try RegularExpression(pattern: #"^([0-9]+): ([0-9]+) ([0-9]+) ([0-9]+)$"#)

        self = try lines.map {

            if let match = try? character.match($0) {
                return try Day19.Rule(
                    number: match.integer(at: 0),
                    kind: .character(match.character(at: 1)))
            }

            if let match = try? or1.match($0) {
                return try Day19.Rule(
                    number: match.integer(at: 0),
                    kind: .or1(
                        match.integer(at: 1),
                        match.integer(at: 2)
                    ))
            }

            if let match = try? or2.match($0) {
                return try Day19.Rule(
                    number: match.integer(at: 0),
                    kind: .or2(
                        match.integer(at: 1),
                        match.integer(at: 2),
                        match.integer(at: 3),
                        match.integer(at: 4)
                    ))
            }

            if let match = try? reference1.match($0) {
                return try Day19.Rule(
                    number: match.integer(at: 0),
                    kind: .reference1(
                        match.integer(at: 1)
                    ))
            }

            if let match = try? reference2.match($0) {
                return try Day19.Rule(
                    number: match.integer(at: 0),
                    kind: .reference2(
                        match.integer(at: 1),
                        match.integer(at: 2)
                    ))
            }

            if let match = try? reference3.match($0) {
                return try Day19.Rule(
                    number: match.integer(at: 0),
                    kind: .reference3(
                        match.integer(at: 1),
                        match.integer(at: 2),
                        match.integer(at: 3)
                    ))
            }

            fatalError("No match for \($0)")
        }
    }
}

