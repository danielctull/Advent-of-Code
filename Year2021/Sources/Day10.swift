
import Advent
import Algorithms
import Foundation

public enum Day10: Day {

    public static let title = "Syntax Scoring"

    public static func part1(_ input: Input) throws -> Int {

        try input.lines
            .catching(IllegalCharacter.self) { try $0.completion() }
            .compacted()
            .sum(of: { try $0.points })
    }

    public static func part2(_ input: Input) throws -> Int {

        try input.lines
            .compactMap { try? $0.completion() }
            .map { try $0.points }
            .sorted()
            .middle
    }
}

extension Sequence where Element == Character {

    fileprivate func completion() throws -> [Character] {
        var expecting: [Character] = []
        for character in self {
            switch character {
            case "{": expecting.append("}")
            case "(": expecting.append(")")
            case "[": expecting.append("]")
            case "<": expecting.append(">")
            case let character where expecting.last == character:
                _ = expecting.removeLast()
            case let character:
                throw Day10.IllegalCharacter(character: character)
            }
        }
        return expecting.reversed()
    }
}

extension Day10 {

    fileprivate struct IllegalCharacter: Error {
        let character: Character
    }
}

extension Day10.IllegalCharacter {

    var points: Int {
        get throws {
            switch character {
            case ")": return 3
            case "]": return 57
            case "}": return 1197
            case ">": return 25137
            default: throw UnexpectedRawValue(rawValue: character)
            }
        }
    }
}

extension Array where Element == Character {

    fileprivate var points: Int {
        get throws {
            try reduce(0) { result, character in
                switch character {
                case ")": return result * 5 + 1
                case "]": return result * 5 + 2
                case "}": return result * 5 + 3
                case ">": return result * 5 + 4
                default: throw UnexpectedRawValue(rawValue: character)
                }
            }
        }
    }
}
